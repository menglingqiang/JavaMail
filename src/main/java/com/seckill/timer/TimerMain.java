package main.java.com.seckill.timer;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
  
  
public class TimerMain {  
    public static void main(String[] args) {  
        ApplicationContext ctx = new ClassPathXmlApplicationContext("classpath:main/resources/spring/spring-timer.xml");
        //String paydatetime  =new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
    }  
}  
