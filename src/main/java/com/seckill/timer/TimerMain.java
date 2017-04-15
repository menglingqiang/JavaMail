package main.java.com.seckill.timer;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import main.java.com.seckill.entity.DetailProject;
import main.java.com.seckill.service.DetailProjectService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
  
  
public class TimerMain { 
	
    public static void main(String[] args) {  
        ApplicationContext ctx = new ClassPathXmlApplicationContext("classpath:main/resources/spring/spring-timer.xml");
    } 
 
}  
