package main.java.com.seckill.webcontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.com.seckill.entity.DetailProject;
import main.java.com.seckill.entity.Project;
import main.java.com.seckill.entity.User;
import main.java.com.seckill.service.DetailProjectService;
import main.java.com.seckill.service.ProjectService;
import main.java.com.seckill.service.UserService;
import main.java.com.seckill.util.UUIDUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/project")
public class ProjectController {

	@Autowired
	UserService userService;
	
	@Autowired
	ProjectService projectService;
	
	@Autowired
	DetailProjectService detailProjectService;
	
    @RequestMapping(value="/operation",method=RequestMethod.POST)
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
    		
    	else if(type.equals("/add"))//需要email
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
    	else if(type.equals("/delete"))//
		{
    		String id = request.getParameter("projectId");
        	projectService.deleteProject(Integer.parseInt(id));
		}
    	List<Project> projectList = projectService.queryProjectByEmail(email); 
    	model.addAttribute("projectList", projectList);//重新查询list
    	//重新查一次数据放入页面中
    	return "fucktime/projectList";
	}
    @RequestMapping(value="/showDetail",method=RequestMethod.POST)//可以将里面的内容抽象为函数
    public String showDetail(HttpServletRequest request,Model model)
    {
    	String projectId = request.getParameter("projectId");
    	String projectName = request.getParameter("projectName");
    	return showInfo(projectId,projectName,model);
    }
    @RequestMapping(value="/detailOperation",method=RequestMethod.POST)
	public String detailOperation(HttpServletRequest request,Model model)
	{
    	String type = request.getParameter("type").trim();
    	String projectId = request.getParameter("projectId");
    	String name = request.getParameter("name");
    	if(type.equals("modify"))//分项目id
    	{
    		String projectDetailId = request.getParameter("projectDetailId");
    		String projectDetailName = request.getParameter("projectDetailName");
    		String detailStartTime = request.getParameter("detailStartTime");
    		String detailEndTime = request.getParameter("detailEndTime");
    		
    		DetailProject detailProject = new DetailProject();
    		detailProject.setProjectDetailId(Long.parseLong(projectDetailId));
    		detailProject.setProjectDetailName(projectDetailName);
    		detailProject.setDetailStartTime(UUIDUtil.string2Date(detailStartTime));
    		detailProject.setDetailEndTime(UUIDUtil.string2Date(detailEndTime));
    		detailProjectService.modifyDetailProject(detailProject);
    	}
    		
    	else if(type.equals("add"))//总项目id
		{
    		String projectDetailName = request.getParameter("projectDetailName");
    		String detailStartTime = request.getParameter("detailStartTime");
    		String detailEndTime = request.getParameter("detailEndTime");
    		
    		DetailProject detailProject = new DetailProject();
    		detailProject.setProjectId(Long.parseLong(projectId));
    		detailProject.setProjectDetailName(projectDetailName);
    		detailProject.setDetailStartTime(UUIDUtil.string2Date(detailStartTime));
    		detailProject.setDetailEndTime(UUIDUtil.string2Date(detailEndTime));
    		detailProjectService.addDetailProject(detailProject);
		}
    	else if(type.equals("delete"))//
		{
    		String id = request.getParameter("projectDetailId");
        	detailProjectService.deteleDetailProject(Long.parseLong(id));
		}
    	return showInfo(projectId,name,model);
	}
    @RequestMapping(value="/doneDetailProject",method=RequestMethod.POST)
    public String doneDetailProject(HttpServletRequest request,Model model)
    {
    	String detailProjectId = request.getParameter("detailProjectId");
    	String projectId = request.getParameter("projectId");
    	String name = request.getParameter("name");
    	detailProjectService.modifyDetailProjectForDone(Long.parseLong(detailProjectId));//更新数据库
    	return showInfo(projectId,name,model);
    }
    //通过总任务id得到每一个分任务,并跳转到明细页面
    public String showInfo(String projectId,String projectName,Model model)
    {
    	List <DetailProject> detailProjectList = 
    			projectService.queryDetailProjectById(Long.parseLong(projectId));
    	model.addAttribute("detailProjectList",detailProjectList);
    	model.addAttribute("projectId",projectId);
    	model.addAttribute("projectName",projectName);
    	return "fucktime/detailProjectList";
    }
    @RequestMapping(value="/getProjectByEmail",method=RequestMethod.POST)
    public String getDetailProject(HttpServletRequest request,Model model)
    {
    	String projectId = request.getParameter("projectId");
    	Map map = new HashMap();
    	map.put("projectId", projectId);
    	List<Project> temp = projectService.queryEverything(map);
    	String email = null;
    	if(temp.size()>0)
    		email = temp.get(0).getEmail();
    	List<Project> projectList = projectService.queryProjectByEmail(email);
    	//为了和前面的页面获取额email一致
    	User user = new User();
    	user.setEmail(email);
    	model.addAttribute("user", user);
    	model.addAttribute("projectList", projectList);//重新查询list
    	//重新查一次数据放入页面中
    	return "fucktime/projectList";
    }
    //得到完成的百分比
    @RequestMapping(value="/getHaveDone",method=RequestMethod.GET)
    public  @ResponseBody HashMap<String,Float> getHaveDone(HttpServletRequest request,HttpServletResponse response)
    {
    	HashMap<String,Float> map = new HashMap<String,Float>();//key是项目的id,value是项目的完成百分比
    	String email = request.getParameter("email");
    	List<Project> projectList = projectService.queryProjectByEmail(email);//通过我email查到用户的所有总任务
    	
    	for(int i=0;i<projectList.size();i++)
		{
    		long tempProjectId = projectList.get(i).getProjectId();
    		float f = projectService.haveDone(tempProjectId);
    		map.put(String.valueOf(tempProjectId), f);//没有子项目会报异常
		}
    	request.getSession().setAttribute("percentMap", map); 
    	return map;
    	//return "success";
    }
}



