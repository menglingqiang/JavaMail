package main.java.com.seckill.service.serviceimpl;

import java.util.List;
import java.util.Map;

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
		
		return projectDao.insertProjectByEmail(project);
	}

	@Override
	public List<DetailProject> queryDetailProjectById(long projectId) {
		Project project = projectDao.queryDetailProjectById(projectId);
		if(project==null)
			return null;
		return project.getDetailProjects();
	}

	@Override
	public List<Project> queryEverything(Map map) {
		
		return projectDao.queryEverything(map);
	}

	@Override
	public float haveDone(long projectId) {
		
		return projectDao.haveDone(projectId);
	}
	
}
