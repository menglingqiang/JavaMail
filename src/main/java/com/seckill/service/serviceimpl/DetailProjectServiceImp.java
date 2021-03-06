package main.java.com.seckill.service.serviceimpl;

import java.util.List;
import java.util.Map;

import main.java.com.seckill.dao.DetailProjectDao;
import main.java.com.seckill.dao.ProjectDao;
import main.java.com.seckill.entity.DetailProject;
import main.java.com.seckill.entity.Project;
import main.java.com.seckill.entity.User;
import main.java.com.seckill.service.DetailProjectService;
import main.java.com.seckill.service.ProjectService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DetailProjectServiceImp implements DetailProjectService{

	@Autowired
	DetailProjectDao detailProjectDao;

	@Override
	public int modifyDetailProject(DetailProject detailProject) {
		
		return detailProjectDao.modifyDetailProject(detailProject);
	}

	@Override
	public int deteleDetailProject(long projectDetailId) {
		
		return detailProjectDao.deteleDetailProject(projectDetailId);
	}

	@Override
	public int addDetailProject(DetailProject detailProject) {
		
		return detailProjectDao.addDetailProject(detailProject);
	}

	@Override
	public int modifyDetailProjectForDone(long projectDetailId) {
		
		return detailProjectDao.modifyDetailProjectForDone(projectDetailId);
	}

	@Override
	public List<DetailProject> queryAllDetailProject() {
		
		return detailProjectDao.queryAllDetailProject();
	}

	@Override
	public List<DetailProject> queryDetailProjectByNameOrTime(Map map) {
		
		return detailProjectDao.queryDetailProjectByNameOrTime(map);
	}

	@Override
	public List<Project> queryPojectMessage(String email) {
		return detailProjectDao.queryPojectMessage(email);
	}

	@Override
	public List<DetailProject> queryDetailPojectMessage(String email) {
		// TODO Auto-generated method stub
		return detailProjectDao.queryDetailPojectMessage(email);
	}

	
	
}
