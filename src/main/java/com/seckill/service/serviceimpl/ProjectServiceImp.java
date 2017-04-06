package main.java.com.seckill.service.serviceimpl;

import java.util.List;

import main.java.com.seckill.dao.ProjectDao;
import main.java.com.seckill.entity.DetailProject;
import main.java.com.seckill.entity.Project;
import main.java.com.seckill.entity.User;
import main.java.com.seckill.service.ProjectService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProjectServiceImp implements ProjectService{

	@Autowired
	ProjectDao projectDao;

	@Override
	public int insertProjectByUser(User user, Project project) {
		
		return projectDao.insertProjectByUser(user, project);
	}

	@Override
	public int insertDetailProject(Project project, DetailProject detailProject) {
		return projectDao.insertDetailProject(project, detailProject);
	}

	public List<Project> queryProjectByEmail(String email) {
		
		return projectDao.queryProjectByEmail(email);
	}

	@Override
	public int modifyProject(Project project) {
		return projectDao.modifyProject(project);
	}

	@Override
	public int deleteProject(long id) {
		return projectDao.deleteProject(id);
	}

	@Override
	public int insertProjectByEmail(Project project) {
		projectDao.insertProjectByEmail(project);
		return 0;
	}
	
	
}
