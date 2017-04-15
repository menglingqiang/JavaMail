package main.java.com.seckill.timer;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
  
@Component("taskJob")  
@Lazy(false) 
public class TaskJob {  
	@Scheduled(cron="0/5 * *  * * ? ")  
    public void job1() {  
        System.out.println("任务进行中cecece。。。");  
    }  
}  