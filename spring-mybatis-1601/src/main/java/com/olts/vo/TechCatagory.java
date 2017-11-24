package com.olts.vo;

public class TechCatagory {
	private Integer id;
	private String techCtgr;
	private OltsCatagory oltscatagory;
	public TechCatagory() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TechCatagory(Integer id, String techCtgr, OltsCatagory oltscatagory) {
		super();
		this.id = id;
		this.techCtgr = techCtgr;
		this.oltscatagory = oltscatagory;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTechCtgr() {
		return techCtgr;
	}
	public void setTechCtgr(String techCtgr) {
		this.techCtgr = techCtgr;
	}
	public OltsCatagory getOltscatagory() {
		return oltscatagory;
	}
	public void setOltscatagory(OltsCatagory oltscatagory) {
		this.oltscatagory = oltscatagory;
	}
	@Override
	public String toString() {
		return "知识点 [id=" + id + ", techCtgr=" + techCtgr + "]";
	}
}
