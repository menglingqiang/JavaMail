package main.java.com.seckill.dao;

import java.util.HashMap;
import java.util.Map;

import main.java.com.seckill.entity.User;

import org.springframework.stereotype.Repository;
@Repository
public interface UserDao {

	public int register(User user);//注册邮箱用户
	public User queryByCode(String code);//通过注册码查找用户
	public int UpdateUserByCode(String code);//更新用户信息
	public User queryByPassword(User user);//通过用户名和密码，查询用户信息
	public User queryByEmail(User user);//通过email查询用户
	public int updateUser(User user);//更新用户信息
	public int registerByThree(Map map);//通过第三方注册用户
	public int updateUserByUserIdForThree(Map map);//通过第三方更新用户
	public User queryUserByThree(Map map);//查询第三方用户数据
}
