package com.olts.vo;

import java.util.Date;

public class FspQuestions {

	private Integer id; // 主键
	private String question; // 题干
	private String stdAnswer; // 标准答案
	private Integer questionType; // 考题类型：4.填空 5.简答 6.编程题
	private Integer techCateId; // 考题知识点分类
	private Date pubdate; // 出题时间
	private String descrpt; // 考题说明信息

	public FspQuestions() {
		super();
		// TODO Auto-generated constructor stub
	}

	public FspQuestions(Integer id, String question, String stdAnswer,
			Integer questionType, Integer techCateId, Date pubdate,
			String descrpt) {
		super();
		this.id = id;
		this.question = question;
		this.stdAnswer = stdAnswer;
		this.questionType = questionType;
		this.techCateId = techCateId;
		this.pubdate = pubdate;
		this.descrpt = descrpt;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getStdAnswer() {
		return stdAnswer;
	}

	public void setStdAnswer(String stdAnswer) {
		this.stdAnswer = stdAnswer;
	}

	public Integer getQuestionType() {
		return questionType;
	}

	public void setQuestionType(Integer questionType) {
		this.questionType = questionType;
	}

	public Integer getTechCateId() {
		return techCateId;
	}

	public void setTechCateId(Integer techCateId) {
		this.techCateId = techCateId;
	}

	public Date getPubdate() {
		return pubdate;
	}

	public void setPubdate(Date pubdate) {
		this.pubdate = pubdate;
	}

	public String getDescrpt() {
		return descrpt;
	}

	public void setDescrpt(String descrpt) {
		this.descrpt = descrpt;
	}

	@Override
	public String toString() {
		return "fspQuestions [id=" + id + ", question=" + question
				+ ", stdAnswer=" + stdAnswer + ", questionType=" + questionType
				+ ", techCateId=" + techCateId + ", pubdate=" + pubdate
				+ ", descrpt=" + descrpt + "]";
	}

}
