package main.java.com.seckill.webcontroller;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.com.seckill.entity.User;
import main.java.com.seckill.service.UserService;
import main.java.com.seckill.util.SendUtil;
import main.java.com.seckill.util.UUIDUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
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
			SendUtil.send(email, code);
			return "register-precode";
		}
	}
	//进入注册状态页面
	@RequestMapping(value="/activation",method=RequestMethod.GET)
	public String activation(String  code)
	{
		if(code==null)
			return "activition-error";
		User user = userService.queryByCode(code);
		if(user==null)
			return "activition-error";
		else
		{
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
	//返回RequsetBody
//	@RequestMapping(value="/getPicCode",method=RequestMethod.GET)
//	public ResponseEntity<String> getPicCode(HttpServletRequest request)
//	{
//		String picCode = (String)request.getAttribute("picCode");
//		return new ResponseEntity<String>(picCode,HttpStatus.OK);
//	}
	@RequestMapping(value="/getPicCode",method=RequestMethod.GET)
	public  @ResponseBody String getPicCode(HttpServletRequest request)
	{
		String picCode = (String)request.getSession().getAttribute("picCode");
		return picCode;
	}
}



