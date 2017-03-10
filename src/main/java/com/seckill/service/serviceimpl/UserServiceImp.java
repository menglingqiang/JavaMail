package main.java.com.seckill.service.serviceimpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import main.java.com.seckill.dao.UserDao;
import main.java.com.seckill.entity.User;
import main.java.com.seckill.service.UserService;

@Service
public class UserServiceImp implements UserService{

	@Autowired
	UserDao userDao;
	
	@Override
	public int register(User user) {
		int temp = userDao.register(user);//1 插入成功，0插入失败
		return temp;
	}

	@Override
	public User queryByCode(String code) {
		User user = userDao.queryByCode(code);
		return user;
	}

	@Override
	public int UpdateUserCode(String code) {
		int temp = userDao.UpdateUserByCode(code);
		return temp;
	}

	@Override
	public User queryByPassword(User user) {
		
		return userDao.queryByPassword(user);
	}

	@Override
	public boolean isRegister(User user) {
		User userTemp = userDao.queryByEmail(user);
		if(userTemp==null)//数据库中没有查到数据
			return false;
		else
			return true;
	}

	@Override
	public User queryByEmail(User user) {
		
		return userDao.queryByEmail(user);
	}

	@Override
	public int updateUser(User user) {
		return userDao.updateUser(user);
	}
	
}
