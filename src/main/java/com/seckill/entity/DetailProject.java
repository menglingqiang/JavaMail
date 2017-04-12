package main.java.com.seckill.entity;

import java.util.Date;

public class DetailProject {

	
	private long projectDetailId;
	private String projectDetailName;
	private Date detailStartTime;
	private Date detailEndTime;
	private int detailModify;
	private long projectId;
	private Project project;//分项目所述的总项目
	private int done; //是否完成
	public long getProjectId() {
		return projectId;
	}
	public void setProjectId(long projectId) {
		this.projectId = projectId;
	}
	public Project getProject() {
		return project;
	}
	public void setProject(Project project) {
		this.project = project;
	}
	public long getProjectDetailId() {
		return projectDetailId;
	}
	public void setProjectDetailId(long projectDetailId) {
		this.projectDetailId = projectDetailId;
	}
	public String getProjectDetailName() {
		return projectDetailName;
	}
	public void setProjectDetailName(String projectDetailName) {
		this.projectDetailName = projectDetailName;
	}
	
	public Date getDetailStartTime() {
		return detailStartTime;
	}
	public void setDetailStartTime(Date detailStartTime) {
		this.detailStartTime = detailStartTime;
	}
	public Date getDetailEndTime() {
		return detailEndTime;
	}
	public void setDetailEndTime(Date detailEndTime) {
		this.detailEndTime = detailEndTime;
	}
	public int getDetailModify() {
		return detailModify;
	}
	public void setDetailModify(int detailModify) {
		this.detailModify = detailModify;
	}
	
	public int getDone() {
		return done;
	}
	public void setDone(int done) {
		this.done = done;
	}
	@Override
	public String toString() {
		return "DetailProject [projectDetailId=" + projectDetailId
				+ ", projectDetailName=" + projectDetailName
				+ ", detailStartTime=" + detailStartTime + ", detailEndTime="
				+ detailEndTime + ", detailModify=" + detailModify
				+ ", projectId=" + projectId + ", project=" + project + "]";
	}
	
	
}
