package com.olts.vo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

public class Examination {
	
	
	private String examNo;
	
	private OltsUsers user;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date examDate;
//	private Integer userId;
	private String singleId;
	private String multpleId;
	private String trueFalseId;
	private String fillInGapsId;
	private String simpleAnwserId;
	private String programId;
	private String descrpt;
	private Integer validFlag;

    
   // private List<Integer> ids=new ArrayList<Integer>();
	public Examination() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Examination(String examNo, OltsUsers user, Date examDate,
			String singleId, String multpleId, String trueFalseId,
			String fillInGapsId, String simpleAnwserId, String programId,
			String descrpt, Integer validFlag) {
		super();
		this.examNo = examNo;
		this.user = user;
		this.examDate = examDate;
		this.singleId = singleId;
		this.multpleId = multpleId;
		this.trueFalseId = trueFalseId;
		this.fillInGapsId = fillInGapsId;
		this.simpleAnwserId = simpleAnwserId;
		this.programId = programId;
		this.descrpt = descrpt;
		this.validFlag = validFlag;
	}
	
	
	
	//public List<Integer> getIds() {
//		return ids;
//	}
//	public void setIds(List<Integer> ids) {
	//	this.ids = ids;
	//}
	public String getExamNo() {
		return examNo;
	}
	public void setExamNo(String examNo) {
		this.examNo = examNo;
	}
	public OltsUsers getUser() {
		return user;
	}
	public void setUser(OltsUsers user) {
		this.user = user;
	}
	public Date getExamDate() {
		return examDate;
	}
	public void setExamDate(Date examDate) {
		this.examDate = examDate;
	}
	public String getSingleId() {
		return singleId;
	}
	public void setSingleId(String singleId) {
		this.singleId = singleId;
	}
	public String getMultpleId() {
		return multpleId;
	}
	public void setMultpleId(String multpleId) {
		this.multpleId = multpleId;
	}
	public String getTrueFalseId() {
		return trueFalseId;
	}
	public void setTrueFalseId(String trueFalseId) {
		this.trueFalseId = trueFalseId;
	}
	public String getFillInGapsId() {
		return fillInGapsId;
	}
	public void setFillInGapsId(String fillInGapsId) {
		this.fillInGapsId = fillInGapsId;
	}
	public String getSimpleAnwserId() {
		return simpleAnwserId;
	}
	public void setSimpleAnwserId(String simpleAnwserId) {
		this.simpleAnwserId = simpleAnwserId;
	}
	public String getProgramId() {
		return programId;
	}
	public void setProgramId(String programId) {
		this.programId = programId;
	}
	public String getDescrpt() {
		return descrpt;
	}
	public void setDescrpt(String descrpt) {
		this.descrpt = descrpt;
	}
	public Integer getValidFlag() {
		return validFlag;
	}
	public void setValidFlag(Integer validFlag) {
		this.validFlag = validFlag;
	}
	@Override
	public String toString() {
		return "Examination [examNo=" + examNo + ", user=" + user
				+ ", examDate=" + examDate + ", singleId=" + singleId
				+ ", multpleId=" + multpleId + ", trueFalseId=" + trueFalseId
				+ ", fillInGapsId=" + fillInGapsId + ", simpleAnwserId="
				+ simpleAnwserId + ", programId=" + programId + ", descrpt="
				+ descrpt + ", validFlag=" + validFlag + "]";
	}
	
}
