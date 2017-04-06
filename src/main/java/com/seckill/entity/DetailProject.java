package main.java.com.seckill.entity;

import java.util.Date;

public class DetailProject {

	private long projectDetailId;
	private long projectId;
	private String projectDetailName;
	private Date startTime;
	private Date endTime;
	private int modify;
	
	public long getProjectDetailId() {
		return projectDetailId;
	}
	public void setProjectDetailId(long projectDetailId) {
		this.projectDetailId = projectDetailId;
	}
	public long getProjectId() {
		return projectId;
	}
	public void setProjectId(long projectId) {
		this.projectId = projectId;
	}
	public String getProjectDetailName() {
		return projectDetailName;
	}
	public void setProjectDetailName(String projectDetailName) {
		this.projectDetailName = projectDetailName;
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
	
}
