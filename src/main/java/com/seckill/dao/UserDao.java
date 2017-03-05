package main.java.com.seckill.dao;

import main.java.com.seckill.entity.User;

public interface UserDao {

	public int register(User user);//注册用户
	public User queryByCode(String code);//通过注册码查找用户
	public int UpdateUserByCode(String code);//更新用户信息
}
