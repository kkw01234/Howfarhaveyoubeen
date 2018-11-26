package kr.co.howfarhaveyoubeen.www.handler.vo;

import java.sql.Date;

public class Diarydbbean {
	private int diaryID;
	private String userID;
	private String diaryTitle;
	private String diaryContent;
	private Date diaryDate;
	private String startPoint;
	private String endPoint;
	public int getDiaryID() {
		return diaryID;
	}
	public void setDiaryID(int diaryID) {
		this.diaryID = diaryID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getDiaryTitle() {
		return diaryTitle;
	}
	public void setDiaryTitle(String diaryTitle) {
		this.diaryTitle = diaryTitle;
	}
	public String getDiaryContent() {
		return diaryContent;
	}
	public void setDiaryContent(String diaryContent) {
		this.diaryContent = diaryContent;
	}
	public Date getDiaryDate() {
		return diaryDate;
	}
	public void setDiaryDate(Date diaryDate) {
		this.diaryDate = diaryDate;
	}
	public String getStartPoint() {
		return startPoint;
	}
	public void setStartPoint(String startPoint) {
		this.startPoint = startPoint;
	}
	public String getEndPoint() {
		return endPoint;
	}
	public void setEndPoint(String endPoint) {
		this.endPoint = endPoint;
	}
}
