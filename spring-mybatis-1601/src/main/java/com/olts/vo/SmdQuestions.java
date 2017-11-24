package com.olts.vo;

import java.util.Date;

public class SmdQuestions {
	/* id integer not null primary key,  --主键
	    question varchar2(2000) not null,  --题干 
	    correct VARCHAR2(5) not null,  --考题答案
	    question_type integer not null check(question_type in(1,2,3)), --考题类型：1.单选  2.多选  3.判断
	    tech_cate_id references tech_category(id), --考题知识点分类
	    descrpt varchar(100),  --考题说明信息
	    pubdate date default sysdate --出题时间
	*/
	private Integer id; // 主键
	private String question; // 题干
	private String correct;
	private Integer questionType; // 考题类型：4.填空 5.简答 6.编程题
	private Integer techCateId; // 考题知识点分类
	private String descrpt;
	private Date pubdate; // 出题时间
	public SmdQuestions() {
		super();
		// TODO Auto-generated constructor stub
	}
	public SmdQuestions(Integer id, String question, String correct,
			Integer questionType, Integer techCateId, String descrpt,
			Date pubdate) {
		super();
		this.id = id;
		this.question = question;
		this.correct = correct;
		this.questionType = questionType;
		this.techCateId = techCateId;
		this.descrpt = descrpt;
		this.pubdate = pubdate;
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
	public String getCorrect() {
		return correct;
	}
	public void setCorrect(String correct) {
		this.correct = correct;
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
	public String getDescrpt() {
		return descrpt;
	}
	public void setDescrpt(String descrpt) {
		this.descrpt = descrpt;
	}
	public Date getPubdate() {
		return pubdate;
	}
	public void setPubdate(Date pubdate) {
		this.pubdate = pubdate;
	}
	@Override
	public String toString() {
		return "SmdQuestions [id=" + id + ", question=" + question
				+ ", correct=" + correct + ", questionType=" + questionType
				+ ", techCateId=" + techCateId + ", descrpt=" + descrpt
				+ ", pubdate=" + pubdate + "]";
	}
	
}
