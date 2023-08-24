package com.project.gogi.vo;

import java.util.Date;

public class ReviewVO {
	private int rev_no;
	private String rev_title;
	private String rev_content;
	private Date rev_date;
	private String mem_id;
	private int goods_id;
	
	public ReviewVO() {
		// TODO Auto-generated constructor stub
	}

	
	
	public ReviewVO(int rev_no, String rev_title, String rev_content, Date rev_date, String mem_id, int goods_id) {
		super();
		this.rev_no = rev_no;
		this.rev_title = rev_title;
		this.rev_content = rev_content;
		this.rev_date = rev_date;
		this.mem_id = mem_id;
		this.goods_id = goods_id;
	}



	public int getRev_no() {
		return rev_no;
	}

	public void setRev_no(int rev_no) {
		this.rev_no = rev_no;
	}

	public String getRev_title() {
		return rev_title;
	}

	public void setRev_title(String rev_title) {
		this.rev_title = rev_title;
	}

	public String getRev_content() {
		return rev_content;
	}

	public void setRev_content(String rev_content) {
		this.rev_content = rev_content;
	}

	public Date getRev_date() {
		return rev_date;
	}

	public void setRev_date(Date rev_date) {
		this.rev_date = rev_date;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public int getGoods_id() {
		return goods_id;
	}

	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}



	@Override
	public String toString() {
		return "ReviewVO [rev_no=" + rev_no + ", rev_title=" + rev_title + ", rev_content=" + rev_content + ", rev_date=" + rev_date
				+ ", mem_id=" + mem_id + ", goods_id=" + goods_id + "]";
	}
	
	
	
}
