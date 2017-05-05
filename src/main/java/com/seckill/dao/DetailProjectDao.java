package main.java.com.seckill.dao;

import java.util.List;
import java.util.Map;

import main.java.com.seckill.entity.DetailProject;
import main.java.com.seckill.entity.Project;

import org.springframework.stereotype.Repository;

@Repository
public interface DetailProjectDao {

	public int modifyDetailProject(DetailProject detailProject);
	public int deteleDetailProject(long projectDetailId);
	public int addDetailProject(DetailProject detailProject);
	public int modifyDetailProjectForDone(long projectDetailId);
	public List<DetailProject> queryAllDetailProject();
	public List<DetailProject> queryDetailProjectByNameOrTime(Map map);
	public List<Project> queryPojectMessage(String email);
	public List<DetailProject> queryDetailPojectMessage(String email);
	
}
