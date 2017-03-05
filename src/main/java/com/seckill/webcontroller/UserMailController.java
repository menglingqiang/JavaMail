package main.java.com.seckill.webcontroller;

import main.java.com.seckill.entity.User;
import main.java.com.seckill.service.UserService;
import main.java.com.seckill.util.SendUtil;
import main.java.com.seckill.util.UUIDUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/user")
public class UserMailController {

	@Autowired
	UserService userService;
	
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
		User user = userService.queryByCode(code);
		if(user==null)
			return "activition-error";
		else
		{
			userService.UpdateUserCode(code);
			return "activition-success";
		}
	}
}
