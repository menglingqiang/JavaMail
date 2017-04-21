package main.java.com.seckill.service;

import java.util.List;
import java.util.Map;

import main.java.com.seckill.entity.DetailProject;

public interface DetailProjectService {
	
	public int modifyDetailProject(DetailProject detailProject);
	public int deteleDetailProject(long projectDetailId);
	public int addDetailProject(DetailProject detailProject);
	public int modifyDetailProjectForDone(long projectDetailId);
	public List<DetailProject> queryAllDetailProject();
	public List<DetailProject> queryDetailProjectByNameOrTime(Map map);
}
