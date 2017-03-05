package main.java.com.seckill.service;

import org.springframework.stereotype.Service;

import main.java.com.seckill.entity.User;

public interface UserService {

	//注册用户
	public int register(User user);
	//根据注册码查找用户
	public User queryByCode(String code);
	//更新注册码信息
	public int UpdateUserCode(String code);
}
