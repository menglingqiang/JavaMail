package main.java.com.seckill.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

import main.java.com.seckill.entity.Project;
public class UUIDUtil {

	public static String getUUID()
	{
		return UUID.randomUUID().toString()+UUID.randomUUID().toString();
	}
	//激活之后系统默认随机赠送的任务，后期可以变成指导教程
	public static Project genProject(String email)
	{
		Project p = new Project();
		p.setProjectName("随机赠送项目，做完送888现金大奖");
	    p.setEndTime(new Date());
		Calendar curr = Calendar.getInstance();
		curr.set(Calendar.DAY_OF_MONTH,curr.get(Calendar.DAY_OF_MONTH)+7);
		Date endDate=curr.getTime();
		
		p.setEndTime(endDate);
		p.setModify(0);
		p.setEmail(email);
		return p;
	}
	//将2014-02-03 转换成Date格式
	public static Date string2Date(String str)
	{
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");//小写的mm表示的是分钟  
		Date date=null;
		try {
			date=sdf.parse(str.trim());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return date;
	}
}
