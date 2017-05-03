package main.java.com.seckill.util;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

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
	//两个日期的比较,前面的大返回true
	public static boolean compareDate(Date date1,Date date2)
	{
		Calendar cal1 = Calendar.getInstance();
		cal1.setTime(date1);
		
		Calendar cal2 = Calendar.getInstance();
		cal2.setTime(date2);
		
		int day1 = cal1.get(Calendar.DATE);
		int month1 = cal1.get(Calendar.MONTH) + 1;
		int year1 = cal1.get(Calendar.YEAR);
		
		int day2 = cal2.get(Calendar.DATE);
		int month2 = cal2.get(Calendar.MONTH) + 1;
		int year2 = cal2.get(Calendar.YEAR);
		
		if(year1>year2)
			return true;
		else if(month1>month2)
			return true;
		else if(day1>=day2)
			return true;
		return false;
	}
	public static void main(String[] str)
	{
		String fileName = "safde4.jpj";
		String prefix=fileName.substring(fileName.lastIndexOf(".")+1,fileName.length());
		System.out.print(prefix);
	}
	public static String getFileType(MultipartFile file)
	{
		String fileName = file.getOriginalFilename();
		String prefix=fileName.substring(fileName.lastIndexOf(".")+1,fileName.length());
	    return prefix;
	}
}




