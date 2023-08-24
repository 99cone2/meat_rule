package com.project.gogi.vo;

import java.util.Date;

public class ReviewImageVO {
	private int img_no;
	private Date img_date;
	private String img_name;
	private int rev_no;
	private String mem_id;
	
	public ReviewImageVO() {
		// TODO Auto-generated constructor stub
	}

	public ReviewImageVO(int img_no, Date img_date, String img_name, int rev_no, String mem_id) {
		super();
		this.img_no = img_no;
		this.img_date = img_date;
		this.img_name = img_name;
		this.rev_no = rev_no;
		this.mem_id = mem_id;
	}

	public int getImg_no() {
		return img_no;
	}

	public void setImg_no(int img_no) {
		this.img_no = img_no;
	}

	public Date getImg_date() {
		return img_date;
	}

	public void setImg_date(Date img_date) {
		this.img_date = img_date;
	}

	public String getImg_name() {
		return img_name;
	}

	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}

	public int getRev_no() {
		return rev_no;
	}

	public void setRev_no(int rev_no) {
		this.rev_no = rev_no;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	@Override
	public String toString() {
		return "ReviewImageVO [img_no=" + img_no + ", img_date=" + img_date + ", img_name=" + img_name + ", rev_no="
				+ rev_no + ", mem_id=" + mem_id + "]";
	}
	
	
}
