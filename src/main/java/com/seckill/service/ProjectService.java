package main.java.com.seckill.service;

import java.util.List;

import main.java.com.seckill.entity.DetailProject;
import main.java.com.seckill.entity.Project;
import main.java.com.seckill.entity.User;

public interface ProjectService {
	
	//给指定的用户，添加一条总任务
	public int insertProjectByUser(User user,Project project);
	//给定email，添加一条总任务
	public int insertProjectByEmail(Project project);
	//给总任务添加一条分任务
	public int insertDetailProject(Project project,DetailProject detailProject);
	public List<Project> queryProjectByEmail(String email);
	public int modifyProject(Project project);
	public int deleteProject(long id);
	public List<DetailProject> queryDetailProjectById (long projectId);
}
