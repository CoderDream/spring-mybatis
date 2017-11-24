package com.olts.vo;

import java.util.List;

public class FspAnswer {
	/*
	 *  id integer not null primary key,
    answer clob,  --答案
    fsp_id not null references fsp_questions(id), 		--填空题，简答题，编程题的题号
    exam_no not null references examination(exam_no), 	--考试编号
    user_id not null references olts_users(id)   
	 */
	private Integer id;
	private String  answer;
	private FspQuestions fsp;
	private Examination exam;
	private OltsUsers user;
	
	public FspAnswer() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public FspAnswer(Integer ids, String answer, FspQuestions fsp,
			Examination exam) {
		super();
		this.id = id;
		this.answer = answer;
		this.fsp = fsp;
		this.exam = exam;
		
	}

	

	public OltsUsers getUser() {
		return user;
	}

	public void setUser(OltsUsers user) {
		this.user = user;
	}

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
	public FspQuestions getFsp() {
		return fsp;
	}

	public void setFsp(FspQuestions fsp) {
		this.fsp = fsp;
	}

	public Examination getExam() {
		return exam;
	}
	public void setExam(Examination exam) {
		this.exam = exam;
	}

	@Override
	public String toString() {
		return "FspAnswer [id=" + id + ", answer=" + answer + ", fsp=" + fsp
				+ ", exam=" + exam + "]";
	}
	
	
	
}
