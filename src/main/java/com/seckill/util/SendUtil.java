package main.java.com.seckill.util;

import java.security.GeneralSecurityException;
import java.security.Security;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import com.sun.mail.util.MailSSLSocketFactory;
import com.sun.net.ssl.internal.ssl.Provider;

//发送邮件工具类
public class SendUtil {

	public static void send(String to,String code)
	{
//		
		Properties pro = new Properties();
		// 发送服务器需要身份验证  
		pro.setProperty("mail.smtp.auth", "true");  
        // 设置邮件服务器主机名  
		pro.setProperty("mail.host", "smtp.qq.com");  
        // 发送邮件协议名称  
		pro.setProperty("mail.transport.protocol", "smtp");
		pro.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		pro.setProperty("mail.smtp.port", "465");
		pro.setProperty("mail.smtp.ssl.enable", "true");
		 // 设置环境信息  
        Session session = Session.getInstance(pro,new Authenticator() {
        	@Override
        	protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
        		
        		return new javax.mail.PasswordAuthentication(
        				"1820026438@qq.com", "poqxcwrvpterchad");
        	}
        	
		});  
          
        Transport transport=null;
		try {
			// 创建邮件对象  
			Message msg = new MimeMessage(session);  
			msg.setSubject("JavaMail测试");  
			// 设置邮件内容  
			msg.setContent("<h1>点击链接激活邮箱</h1><h3><a href='http://localhost:8080/JavaMail/user/activation?code="+code+"'>http://localhost:8080/JavaMail/user/activation?code="+code+"</a></h3>", 
					"text/html;charset=UTF-8");
			// 设置发件人  
			msg.setFrom(new InternetAddress("1820026438@qq.com"));//从我的邮箱  ,服务器邮箱
			msg.setRecipient(RecipientType.TO, new InternetAddress(to));//目的邮箱
			Transport.send(msg);
			// 关闭连接  
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchProviderException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally
		{
			try {
				if(transport!=null)
					transport.close();
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}  
		}
		
	}
	public static void main(String[] args)
	{
		send("1820026438@qq.com", "aasdfdsff");
	}
}
