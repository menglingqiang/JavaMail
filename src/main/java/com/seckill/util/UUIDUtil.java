package main.java.com.seckill.util;

import java.util.UUID;

public class UUIDUtil {

	public static String getUUID()
	{
		return UUID.randomUUID().toString()+UUID.randomUUID().toString();
	}
}
