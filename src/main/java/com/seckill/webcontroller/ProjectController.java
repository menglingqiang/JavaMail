package main.java.com.seckill.webcontroller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import main.java.com.seckill.entity.Project;
import main.java.com.seckill.entity.User;
import main.java.com.seckill.service.ProjectService;
import main.java.com.seckill.service.UserService;
import main.java.com.seckill.util.UUIDUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.Module;


@Controller
@RequestMapping("/project")
public class ProjectController {

	@Autowired
	UserService userService;
	@Autowired
	ProjectService projectService;
	
    @RequestMapping(value="operation",method=RequestMethod.POST)
	public String operation(HttpServletRequest request,Model model)
	{
    	String type = request.getParameter("type").trim();
    	String email = request.getParameter("email");
    	if(type.equals("modify"))//需要projectId
    	{
    		String projectId = request.getParameter("projectId");
    		String projectName = request.getParameter("projectName");
    		String startTime = request.getParameter("startTime");
    		String endTime = request.getParameter("endTime");
    		
    		Project project = new Project();
    		project.setProjectId(Integer.parseInt(projectId));
    		project.setProjectName(projectName);
    		project.setStartTime(UUIDUtil.string2Date(startTime));
    		project.setEndTime(UUIDUtil.string2Date(endTime));
    		projectService.modifyProject(project);
    	}
    		
    	else if(type.equals("add"))//需要email
		{
    		String projectName = request.getParameter("projectName");
    		String startTime = request.getParameter("startTime");
    		String endTime = request.getParameter("endTime");
    		
    		Project project = new Project();
    		
    		project.setProjectName(projectName);
    		project.setEmail(email);
    		project.setStartTime(UUIDUtil.string2Date(startTime));
    		project.setEndTime(UUIDUtil.string2Date(endTime));
    		projectService.insertProjectByEmail(project);
		}
    	else if(type.equals("delete"))//
		{
    		String id = request.getParameter("projectId");
        	projectService.deleteProject(Integer.parseInt(id));
		}
    	List<Project> projectList = projectService.queryProjectByEmail(email); 
    	model.addAttribute("projectList", projectList);//重新查询list
    	//重新查一次数据放入页面中
    	return "fucktime/projectList";
	}
   
}



