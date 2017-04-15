package main.java.com.seckill.timer;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import main.java.com.seckill.dao.DetailProjectDao;
import main.java.com.seckill.dao.ProjectDao;
import main.java.com.seckill.entity.DetailProject;
import main.java.com.seckill.entity.Project;
import main.java.com.seckill.service.DetailProjectService;
import main.java.com.seckill.service.ProjectService;
import main.java.com.seckill.service.serviceimpl.DetailProjectServiceImp;
import main.java.com.seckill.service.serviceimpl.ProjectServiceImp;
import main.java.com.seckill.util.SendUtil;
import main.java.com.seckill.util.UUIDUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
  
@Component
//@Lazy(false) 
public class TaskJob { 
	@Autowired
	ProjectService projectService;
	
	@Autowired
	DetailProjectService detailProjectService;
	
	//总项目定时任务（九点半）
	@Scheduled(cron="0 23 20  * * ? ") 
	//@Scheduled(cron="0/5 * *  * * ? ")
    public void projectJob() {  
		//得到所有user的email
		//判断哪些已经超时了，今天的日期和得到的结束日期进行比较
		//今天的日期大，发送邮件
		List<Project> projectList = projectService.queryAllProject();
		Date today = new Date();
		for(int i=0;i<projectList.size();i++)
		{
			Project project = projectList.get(i);
			if(UUIDUtil.compareDate(today, project.getEndTime()))//今天的日期大于结束日期
			{
				String str = "你的项目："+project.getProjectName()+",今天到期，你这个态度药丸！";
				SendUtil.send(project.getEmail(),str);
				System.out.println(today+"总项目已经发送邮件");
			}
		}
    }
	//分项目定时任务(九点半)
	@Scheduled(cron="0 23 20  * * ? ")
	//@Scheduled(cron="0/5 * *  * * ? ")
	public void detailProjectJob() {  
		//得到所有user的email
		//判断哪些已经超时了，今天的日期和得到的结束日期进行比较
		//今天的日期大，发送邮件
		List<DetailProject> detailProjectList = detailProjectService.queryAllDetailProject();
		
		Date today = new Date();
		for(int i=0;i<detailProjectList.size();i++)
		{
			DetailProject detailProject = detailProjectList.get(i);
			long projectId = detailProject.getProjectId();
			Map<String,Object> temp = new HashMap<String,Object>();
			temp.put("projectId", projectId);
			String email = projectService.queryEverything(temp).get(0).getEmail();
			if(UUIDUtil.compareDate(today, detailProject.getDetailEndTime()))//今天的日期大于结束日期
			{
				String str = "你的项目："+detailProject.getProjectDetailName()+",今天到期，你这个态度药丸！";
				SendUtil.send(email,str);
				System.out.println(today+"分项目已经发送邮件");
			}
		}
    } 
}  