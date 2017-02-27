package main.java.com.seckill.service.serviceimpl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import main.java.com.seckill.dao.SeckillDao;
import main.java.com.seckill.dao.SuccessKilledDao;
import main.java.com.seckill.dao.cache.RedisDao;
import main.java.com.seckill.dto.Exposer;
import main.java.com.seckill.dto.SeckillExecution;
import main.java.com.seckill.entity.Seckill;
import main.java.com.seckill.entity.SuccessKilled;
import main.java.com.seckill.exception.CloseException;
import main.java.com.seckill.exception.RepeatException;
import main.java.com.seckill.exception.SeckillException;
import main.java.com.seckill.secenum.SeckillEnum;
import main.java.com.seckill.service.SeckillService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;

//秒杀服务类接口
@Service
public class SeckillServiceImpl implements SeckillService{

	@Autowired
	SeckillDao seckillDao;
	@Autowired
	SuccessKilledDao successKilledDao;
	@Autowired
	RedisDao redisDao;
	
	private String salt = "asdfasdfasdjlkfj*&^%^%^&^T%^||*&*(";
	//查询所有的秒杀项目
	@Override
	public List<Seckill> queryAll() {
		// TODO Auto-generated method stub
		return seckillDao.queryAll(0, 4);//TODO 4做一个查询接口
	}
	//查询特定的秒杀项目
	@Override
	public Seckill queryById(long seckillId) {
		
		//先从缓存中读取
		Seckill seckill = redisDao.getSeckill(seckillId);
		if(seckill==null)//缓存中没有数据
		{
			//向数据库中读取
			seckill = seckillDao.queryById(seckillId);
			if(seckill!=null)
			{
				redisDao.putSeckill(seckill);
				return seckill;
			}
			else
				return null;
		}
		return seckill;
	}

	@Override
	public Exposer exposeUrl(long seckillId) {
		
		Seckill seckill = queryById(seckillId);
		
		if(seckill==null)
			return new Exposer(seckillId, false);
		
		Date now = new Date();
		Date startTime = seckill.getStartTime();
		Date endTime = seckill.getEndTime();
		//没有开始秒杀，或者秒杀结束
		if(startTime.getTime()>now.getTime()
				||endTime.getTime()<now.getTime())
			return new Exposer(seckillId, false,now, startTime, endTime);
		//秒杀成功
		return new Exposer(seckillId, true, getMd5(seckillId), now, startTime, endTime);
		
	}

	public String getMd5(long  seckillId)
	{
		String md5 = seckillId+"/"+salt;
		return DigestUtils.md5DigestAsHex(md5.getBytes());
	}
	
	@Transactional
	public SeckillExecution executeSeckill(long seckillId, long userPhone,
			String md5) throws SeckillException, RepeatException,
			CloseException {
		//更新减库存，插入更新信息
		//更新失败代表
		if(md5==null||!md5.equals(getMd5(seckillId)))
			throw new SeckillException("数据被篡改");
		try {
			//先插入数据
			int insertRow = successKilledDao.insertSuccessKilled(seckillId, userPhone);
			if(insertRow<=0)
				throw new RepeatException("重复秒杀");
			else
			{
				//这里是高并发的地方，如果先执行这句话，那么会有两个时间堆积，后执行的话只有一个堆积
				int updateRow = seckillDao.reduceNumber(seckillId, new Date());
				if(updateRow<=0)
					throw new CloseException("秒杀失败");
				
				else
				{
					SuccessKilled successKilled
					= successKilledDao.queryByIdWithSeckill(seckillId, userPhone);
					return new SeckillExecution(seckillId, SeckillEnum.SUCCESS,successKilled);
				}
			}
			
		} 
		 catch (CloseException e) {
				// TODO Auto-generated catch block
				throw e;}
		 catch (RepeatException e) {
				// TODO Auto-generated catch block
			 throw e;
			}
		catch (Exception e){
            //所有编译期异常转换成运行期异常,这样在发生错误的时候，会进行回滚
            throw new SeckillException("seckill内部错误："+e.getMessage());
        }
	}
	@Override
	public SeckillExecution executeSeckillByPro(long seckillId, long userPhone,
			String md5) {
		if(!md5.equals(getMd5(seckillId)))
			return new SeckillExecution(seckillId, SeckillEnum.DATE_REWRITE);//数据被篡改
		Map<String ,Object> map = new HashMap<String,Object>();
		map.put("seckillId", seckillId);
		map.put("userPhone", userPhone);
		map.put("killTime", new Date());
		seckillDao.killByPro(map);
		int result = (int) map.get("result");
		System.out.println(result);
		if(result==1)
		{
			SuccessKilled successKilled= successKilledDao.queryByIdWithSeckill(seckillId, userPhone);
			return new SeckillExecution(seckillId, SeckillEnum.SUCCESS,successKilled);
		}
		else
			return new SeckillExecution(seckillId, SeckillEnum.getState(result));
	}
}
