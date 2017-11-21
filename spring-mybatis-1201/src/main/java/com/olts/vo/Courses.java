package com.olts.vo;

import java.util.List;

public class Courses {
	private Integer id;
	private String courseName;
	

	public Courses() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Courses(Integer id, String courseName) {
		super();
		this.id = id;
		this.courseName = courseName;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}


	@Override
	public String toString() {
		return "Courses [id=" + id + ", courseName=" + courseName + "]";
	}

}
