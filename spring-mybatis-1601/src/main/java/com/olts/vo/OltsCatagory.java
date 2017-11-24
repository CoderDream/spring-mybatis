package com.olts.vo;

public class OltsCatagory {
	private Integer id;
	private String courseName;
	public OltsCatagory() {
		super();
		// TODO Auto-generated constructor stub
	}
	public OltsCatagory(Integer id, String courseName) {
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
		return "OltsCatagory [id=" + id + ", courseName=" + courseName + "]";
	}
}
