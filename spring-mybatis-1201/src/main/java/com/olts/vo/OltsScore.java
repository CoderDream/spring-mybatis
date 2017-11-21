package com.olts.vo;

import java.util.Date;

public class OltsScore {
	/*
	 *  id integer not null primary key,
    score number(4,1), --成绩
    test_date date default sysdate,--考试时间
    descrpt varchar(50), --说明信息
    user_id not null references olts_users(id), --学生ID
    exam_no not null references examination(exam_no), --考试编号
    fsp_score NUMBER(4,1)
	 */
	private Integer id;
	private Double score;
	private Date testDate;
	private String descrpt;
	private Integer userId;
	private String examNo;
	
	private OltsUsers user;
	private Examination exam;
	
	private Double fspScore;
	public OltsScore() {
		super();
		// TODO Auto-generated constructor stub
	}
	public OltsScore(Integer id, Double score, Date testDate, String descrpt,
			OltsUsers user, Examination exam, Double fspScore) {
		super();
		this.id = id;
		this.score = score;
		this.testDate = testDate;
		this.descrpt = descrpt;
		this.user = user;
		this.exam = exam;
		this.fspScore = fspScore;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getExamNo() {
		return examNo;
	}
	public void setExamNo(String examNo) {
		this.examNo = examNo;
	}
	public Double getScore() {
		return score;
	}
	public void setScore(Double score) {
		this.score = score;
	}
	public Date getTestDate() {
		return testDate;
	}
	public void setTestDate(Date testDate) {
		this.testDate = testDate;
	}
	public String getDescrpt() {
		return descrpt;
	}
	public void setDescrpt(String descrpt) {
		this.descrpt = descrpt;
	}
	public OltsUsers getUser() {
		return user;
	}
	public void setUser(OltsUsers user) {
		this.user = user;
	}
	public Examination getExam() {
		return exam;
	}
	public void setExam(Examination exam) {
		this.exam = exam;
	}
	public Double getFspScore() {
		return fspScore;
	}
	public void setFspScore(Double fspScore) {
		this.fspScore = fspScore;
	}
	@Override
	public String toString() {
		return "OltsScore [id=" + id + ", score=" + score + ", testDate="
				+ testDate + ", descrpt=" + descrpt + ", userId=" + userId
				+ ", examNo=" + examNo + ", fspScore=" + fspScore + "]";
	}
	
	
}
