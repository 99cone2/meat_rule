package com.project.gogi.vo;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component("servImageFileVO")
public class ServImageFileVO {
	
	private int img_no;
	private String img_name;
	private Date img_date;
	private int cust_serv_no;
	private String reg_id;

	
	public ServImageFileVO() {
		// TODO Auto-generated constructor stub
	}


	public int getImg_no() {
		return img_no;
	}


	public void setImg_no(int img_no) {
		this.img_no = img_no;
	}


	public String getImg_name() {
		return img_name;
	}


	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}


	public Date getImg_date() {
		return img_date;
	}


	public void setImg_date(Date img_date) {
		this.img_date = img_date;
	}


	public int getCust_serv_no() {
		return cust_serv_no;
	}


	public void setCust_serv_no(int cust_serv_no) {
		this.cust_serv_no = cust_serv_no;
	}
	
	


	public String getReg_id() {
		return reg_id;
	}


	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}


	public ServImageFileVO(int img_no, String img_name, Date img_date, int cust_serv_no,String reg_id) {
		super();
		this.img_no = img_no;
		this.img_name = img_name;
		this.img_date = img_date;
		this.cust_serv_no = cust_serv_no;
		this.reg_id=reg_id;
	}


	@Override
	public String toString() {
		return "ServImageFileVO [img_no=" + img_no + ", img_name=" + img_name + ", img_date=" + img_date
				+ ", cust_serv_no=" + cust_serv_no + ", reg_id=" + reg_id + "]";
	}
	
	



	
	
	

	
}
