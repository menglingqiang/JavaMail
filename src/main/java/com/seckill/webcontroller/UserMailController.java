package main.java.com.seckill.webcontroller;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Date;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.com.seckill.entity.User;
import main.java.com.seckill.service.UserService;
import main.java.com.seckill.util.SendUtil;
import main.java.com.seckill.util.UUIDUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/user")
public class UserMailController {

	@Autowired
	UserService userService;
//	
//    @Autowired  
//     HttpServletRequest request;  
//    
//    @Autowired  
//    HttpServletResponse response;  
    
	//欢迎页面
	@RequestMapping(value="/",method=RequestMethod.GET)
	public String welcome()
	{
		return "prelogin";//欢迎界面
	}
	
	//进入注册页面
	@RequestMapping(value="/preRegister",method=RequestMethod.GET)
	public String preRegister()
	{
		return "preregister";
	}
	//进入注册状态页面
	@Transactional
	@RequestMapping(value="/register",method=RequestMethod.POST)
	public String register(User user)
	{
		if(userService.isRegister(user))//判断是否已经有注册信息
			return "prelogin";//用户已经注册成功，返回登录界面
		String code = UUIDUtil.getUUID();
		user.setCode(code);//生成动态激活码
		String email = user.getEmail();//得到用户的email地址
		int temp = userService.register(user);
		//0 注册失败
		if(temp==0)
			return "register-error"; 
		else
		//1 注册成功，等待验证
		{
			//发送激活邮件给用户
			SendUtil.send(email, 
			"<h1>点击链接激活邮箱</h1><h3><a href='http://localhost:8080/JavaMail/user/activation?flag=true&code="+code+"'>http://localhost:8080/JavaMail/user/activation?code="+code+"</a></h3>");
			return "register-precode";
		}
	}
	//进入激活状态页面
	@RequestMapping(value="/activation",method=RequestMethod.GET)
	public String activation(String  code,boolean flag)//true表示第一次注册
	{
		if(code==null)
			return "activition-error";
		User user = userService.queryByCode(code);
		if(user==null)
			return "activition-error";
		else
		{
			if(!flag)//不是第一次注册，激活
				SendUtil.send(user.getEmail(), 
						"<h1>点击链接激活邮箱</h1><h3><a href='http://localhost:8080/JavaMail/user/activation?flag=false&code="+code+"'>http://localhost:8080/JavaMail/user/activation?code="+code+"</a></h3>");
			userService.UpdateUserCode(code);
			return "activition-success";
		}
	}
	//进入登录界面
	@RequestMapping(value="/preLogin",method=RequestMethod.GET)
	public String preLogIn()
	{
		return "prelogin";//登录界面
	}
	//执行登录逻辑
	@RequestMapping(value="/login",method=RequestMethod.POST)
	public String logIn(User user,Model model,HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		//验证验证码是否输入正确
		boolean codeFlag = validateCode(request, response);
		
		if(codeFlag)
		{
			//查询用户和密码是否正确，后期可以加密
			User userTemp = userService.queryByPassword(user);
			if(userTemp==null)
				return "login-error";//登录失败，后期可以显示是没有用户还是用户的密码错误
			else 
			{
	//System.out.println(user.toString());
				model.addAttribute("user", userTemp);//传递用户的信息
				return "login-success";//TODO 判断是否激活，如果激活显示聊天的链接，否则提示激活，或者重新发送激活邮件
			}
		}
		return "login-error";
	}
	//生成验证码
	@RequestMapping(value="/validate",method=RequestMethod.GET)
	public void gerValidate(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		//画验证码的框
		BufferedImage bi = new BufferedImage(100, 30, BufferedImage.TYPE_3BYTE_BGR);
		Graphics g = bi.getGraphics();
		Color c = new Color(200,156,255);
		g.setColor(c);
		g.fillRect(0, 0, 100, 30);
		//验证码里面的信息
		char[] ch = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890".toCharArray();//全是大写
		Random random = new Random();
		StringBuffer sb = new StringBuffer();
		
		for(int i=0;i<4;i++)
		{
			int index = random.nextInt(ch.length);
			char indexChar = ch[index];
			g.setColor(new Color(random.nextInt(88),random.nextInt(188),random.nextInt(255)));
			g.drawString(indexChar+"",i*22+5 , 25);
			sb.append(indexChar+"");
		}
		request.getSession().setAttribute("picCode", sb.toString());//将界面的piccode存入界面中
		ImageIO.write(bi, "JPG", response.getOutputStream());
	}
	//验证，验证码是否输入正确
	public boolean validateCode(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		String picCode = (String)request.getSession().getAttribute("picCode");
		picCode = picCode.trim();//去空格
		
		String inputCode = request.getParameter("inputCode").toUpperCase().trim();//不区分大小写
		response.setContentType("text/html;charset=utf8");
		boolean flag = picCode.equals(inputCode);
		return flag;
	}

	@RequestMapping(value="/getPicCode",method=RequestMethod.GET)
	public  @ResponseBody String getPicCode(HttpServletRequest request)
	{
		String picCode = (String)request.getSession().getAttribute("picCode");
		return picCode;
	}
	//进入忘记密码界面
	@RequestMapping(value="/preForgetPassword",method=RequestMethod.GET)
	public String preForgetPassword()
	{
		return "preForgetPassword";
	}
	
	//忘记密码逻辑,通过邮箱查找用户
	@RequestMapping(value="/forgetPassword",method=RequestMethod.POST)
	public void forgetPassword(User user)//前台会自动的将email注入到user中
	{
		//先判断这个用户是否已经注册，注册了再发邮件如果没有注册的话，提示进入注册界面
		
		if(userService.isRegister(user))
		{
			User temp = userService.queryByEmail(user);
			//TODO 修改信息，进入修改界面
			String msg = "<h1>点击链接修改密码</h1><h3><a href='http://localhost:8080/JavaMail/user/preModifyPassword?email="+temp.getEmail()+"'>http://localhost:8080/JavaMail/user/preModifyPassword?email="+temp.getEmail()+"</a></h3>";
			//发送邮件
			SendUtil.send(user.getEmail(),msg);//点击连接，进入修改界面传入邮箱
		}
		else
		{
			//应该返回一个信息给前台，当前用户没有注册，
		}
	}
	//进入用户信息修改界面
	@RequestMapping(value="/preModifyPassword",method=RequestMethod.GET)
	public String preModifyPassword(HttpServletRequest request,String email)//修改用户的信息
	{
		request.getSession().setAttribute("email", email);
		return "preModifyPassword";
	}
	//进入用户信息修改界面
	@RequestMapping(value="/modifyPassword",method=RequestMethod.GET)
	public String modifyPassword(Model model,User user)//修改用户的信息,就不用激活了，保持原来账户的信息
	{
		user.setCreateTime(new Date());//更新更改时间
		int flag = userService.updateUser(user);
		//TODO  动态sql写的有问题
		if(flag!=1)
			return "login-error";//界面直接登录
		else 
		{
			user = userService.queryByEmail(user);
			//request.getSession().setAttribute("user",user); 是历史记录中的数据？
			model.addAttribute("user", user);
			return "login-success";
		}
	}
	
}



