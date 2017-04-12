package main.java.com.seckill.service.serviceimpl;

import java.util.List;

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

	
	
}
