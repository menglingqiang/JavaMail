package test.java;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import main.java.com.seckill.dao.SeckillDao;
import main.java.com.seckill.dao.cache.RedisDao;
import main.java.com.seckill.entity.Seckill;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
//配置spring和junit的整合
@RunWith(SpringJUnit4ClassRunner.class)
//告诉junit的配置文件
@ContextConfiguration({"classpath:main/resources/spring/spring-dao.xml"})

//三个方法测试成功
public class RedisDaoTest {

	//注入到实现类依赖
	@Resource
	private SeckillDao seckillDao;
	
	@Autowired
	private RedisDao redisDao;
	@Test
	public void testQueryAll() throws Exception
	{
		Seckill seckill = redisDao.getSeckill(1000);
		if(seckill==null)
		{
			seckill = seckillDao.queryById(1000);
			String result = redisDao.putSeckill(seckill);
			System.out.println("是否缓存成功"+result);
			System.out.println("缓存中的"+redisDao.getSeckill(1000));
		}
	}
	
	
}
