package main.java.com.seckill.dao;

import java.util.List;

import main.java.com.seckill.entity.DetailProject;
import main.java.com.seckill.entity.Project;
import main.java.com.seckill.entity.User;

import org.apache.ibatis.annotations.Param;

public interface ProjectDao {

	public int insertProjectByUser(@Param(value = "user") User user,@Param(value = "project")Project project);//给指定的用户，添加一条总任务
	public int insertProjectByEmail(@Param(value = "project")Project project);//给指定的邮箱，添加一条总任务
	public int insertDetailProject(@Param(value = "project")Project project,@Param(value = "detailProject")DetailProject detailProject);//给总任务添加一条分任务
	public List<Project> queryProjectByEmail(@Param(value="email")String email);//通过email查询，project方法
	public int modifyProject(Project project);
	public int deleteProject(long projectId);
}
