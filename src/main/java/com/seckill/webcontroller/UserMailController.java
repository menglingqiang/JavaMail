package main.java.com.seckill.webcontroller;

import main.java.com.seckill.entity.User;
import main.java.com.seckill.service.UserService;
import main.java.com.seckill.util.SendUtil;
import main.java.com.seckill.util.UUIDUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/user")
public class UserMailController {

	@Autowired
	UserService userService;
	//欢迎页面
	@RequestMapping(value="/",method=RequestMethod.GET)
	public String welcome()
	{
		return "index";//欢迎界面
	}
	
	//进入注册页面
	@RequestMapping(value="/preRegister",method=RequestMethod.GET)
	public String preRegister()
	{
		return "preregister";
	}
	//进入注册状态页面
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
	public String logIn(User user,Model model)
	{
		User userTemp = userService.queryByPassword(user);//查询用户和密码是否正确，后期可以加密
		if(userTemp==null)
			return "login-error";//登录失败，后期可以显示是没有用户还是用户的密码错误
		else 
		{
//System.out.println(user.toString());
			model.addAttribute("user", userTemp);//传递用户的信息
			return "login-success";//TODO 判断是否激活，如果激活显示聊天的链接，否则提示激活，或者重新发送激活邮件
		}
	}
}
