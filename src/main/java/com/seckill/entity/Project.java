package main.java.com.seckill.entity;

import java.util.Date;
import java.util.List;

public class Project {

	
	private long projectId; //总项目id
	private String projectName;//总项目名称
	private String email;//用户的email
	private Date startTime;//总项目开始时间
	private Date endTime;//总项目结束时间
	private int modify;//项目修改次数
	private List<DetailProject> detailProjects;//总项目下的小项目
	
	public List<DetailProject> getDetailProjects() {
		return detailProjects;
	}
	public void setDetailProjects(List<DetailProject> detailProjects) {
		this.detailProjects = detailProjects;
	}
	public long getProjectId() {
		return projectId;
	}
	public void setProjectId(long projectId) {
		this.projectId = projectId;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public int getModify() {
		return modify;
	}
	public void setModify(int modify) {
		this.modify = modify;
	}
	@Override
	public String toString() {
		return "Project [projectId=" + projectId + ", projectName="
				+ projectName + ", email=" + email + ", startTime=" + startTime
				+ ", endTime=" + endTime + ", modify=" + modify
				+ ", detailProjects=" + detailProjects + "]";
	}
	
}
