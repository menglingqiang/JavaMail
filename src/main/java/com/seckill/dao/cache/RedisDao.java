package main.java.com.seckill.dao.cache;

import java.io.Serializable;

import com.dyuproject.protostuff.LinkedBuffer;
import com.dyuproject.protostuff.ProtobufIOUtil;
import com.dyuproject.protostuff.runtime.RuntimeSchema;

import main.java.com.seckill.entity.Seckill;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class RedisDao {
	
	JedisPool jedisPool;
	RuntimeSchema schema = RuntimeSchema.createFrom(Seckill.class);
	
	RedisDao(String ip ,int port)
	{
		jedisPool = new JedisPool(ip,port);
	}
	
	public Seckill getSeckill(long seckillId)
	{
		Jedis jedis = jedisPool.getResource();
		String key ="seckill:"+seckillId;
		try {
			byte[] bytes = jedis.get(key.getBytes());
			if(bytes!=null)
			{
				Seckill seckill = new Seckill();
				ProtobufIOUtil.mergeFrom(bytes,seckill, schema);
				return seckill;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	//POJO 
	public String putSeckill(Seckill seckill)
	{
		String key = "seckill:"+seckill.getSeckillId();
		String result;
		try {
			Jedis jedis  =  jedisPool.getResource();
			byte[] bytes = ProtobufIOUtil.toByteArray(seckill, schema, 
					LinkedBuffer.allocate(LinkedBuffer.DEFAULT_BUFFER_SIZE));
			int time = 60*60;
			result = jedis.setex(key.getBytes(), time, bytes);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
