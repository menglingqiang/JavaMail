package main.java.com.seckill.service;

import java.util.List;

import main.java.com.seckill.entity.DetailProject;
import main.java.com.seckill.entity.Project;
import main.java.com.seckill.entity.User;

public interface DetailProjectService {
	
	public int modifyDetailProject(DetailProject detailProject);
	public int deteleDetailProject(long projectDetailId);
	public int addDetailProject(DetailProject detailProject);
	public int modifyDetailProjectForDone(long projectDetailId);
}
