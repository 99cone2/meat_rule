package com.project.gogi.vo;

import java.util.Date;

import org.springframework.stereotype.Component;
@Component
public class ServVO {
 
	private int cust_serv_no;
	private String cust_serv_title;
	private String cust_serv_content;
	private String mem_id;
	private Date cust_serv_date;
	private int cust_serv_hits;
	private String cust_serv_pw;
	private int cust_serv_notice;	
	private String imageFileName;
	private String originalFileName;
	private int cust_serv_secret;
	private String cust_serv_dateStr;

	public ServVO() {
		// TODO Auto-generated constructor stub
	}
	
	
	
	public ServVO(int cust_serv_no, String cust_serv_title, String cust_serv_content, String mem_id,
			Date cust_serv_date, int cust_serv_hits, String cust_serv_pw, int cust_serv_notice, String imageFileName,
			String originalFileName,int cust_serv_secret) {
		super();
		this.cust_serv_no = cust_serv_no;
		this.cust_serv_title = cust_serv_title;
		this.cust_serv_content = cust_serv_content;
		this.mem_id = mem_id;
		this.cust_serv_date = cust_serv_date;
		this.cust_serv_hits = cust_serv_hits;
		this.cust_serv_pw = cust_serv_pw;
		this.cust_serv_notice = cust_serv_notice;
		this.imageFileName = imageFileName;
		this.originalFileName = originalFileName;
		this.cust_serv_secret=cust_serv_secret;
	}


	


	public int getCust_serv_no() {
		return cust_serv_no;
	}
	public void setCust_serv_no(int cust_serv_no) {
		this.cust_serv_no = cust_serv_no;
	}
	public String getCust_serv_title() {
		return cust_serv_title;
	}
	public void setCust_serv_title(String cust_serv_title) {
		this.cust_serv_title = cust_serv_title;
	}
	public String getCust_serv_content() {
		return cust_serv_content;
	}
	public void setCust_serv_content(String cust_serv_content) {
		this.cust_serv_content = cust_serv_content;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public Date getCust_serv_date() {
		return cust_serv_date;
	}
	public void setCust_serv_date(Date cust_serv_date) {
		this.cust_serv_date = cust_serv_date;
	}
	public int getCust_serv_hits() {
		return cust_serv_hits;
	}
	public void setCust_serv_hits(int cust_serv_hits) {
		this.cust_serv_hits = cust_serv_hits;
	}
	public String getCust_serv_pw() {
		return cust_serv_pw;
	}
	public void setCust_serv_pw(String cust_serv_pw) {
		this.cust_serv_pw = cust_serv_pw;
	}
	public int getCust_serv_notice() {
		return cust_serv_notice;
	}
	public void setCust_serv_notice(int cust_serv_notice) {
		this.cust_serv_notice = cust_serv_notice;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	public String getOriginalFileName() {
		return originalFileName;
	}
	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	public int getCust_serv_secret() {
		return cust_serv_secret;
	}
	public void setCust_serv_secret(int cust_serv_secret) {
		this.cust_serv_secret = cust_serv_secret;
	}



	public String getCust_serv_dateStr() {
		return cust_serv_dateStr;
	}



	public void setCust_serv_dateStr(String cust_serv_dateStr) {
		this.cust_serv_dateStr = cust_serv_dateStr;
	}



	 
	
	 
}
