package main.java.com.seckill.dao;

import main.java.com.seckill.entity.DetailProject;

public interface DetailProjectDao {

	public int modifyDetailProject(DetailProject detailProject);
	public int deteleDetailProject(long projectDetailId);
	public int addDetailProject(DetailProject detailProject);
	
}
