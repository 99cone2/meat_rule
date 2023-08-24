package com.project.gogi.vo;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component("commentVO")
public class CommentVO {
	private int lvl;
	private String mem_id;
	private int cmt_number;
	private String cmt_content;
	private int cmt_parent_num;
	private Date cmt_date;
	private int cust_serv_no;
	private int group_number;

	
	
	public int getLvl() {
		return lvl;
	}
	public void setLvl(int lvl) {
		this.lvl = lvl;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public int getCmt_number() {
		return cmt_number;
	}
	public void setCmt_number(int cmt_number) {
		this.cmt_number = cmt_number;
	}
	public String getCmt_content() {
		return cmt_content;
	}
	public void setCmt_content(String cmt_content) {
		this.cmt_content = cmt_content;
	}
	public int getCmt_parent_num() {
		return cmt_parent_num;
	}
	public void setCmt_parent_num(int cmt_parent_num) {
		this.cmt_parent_num = cmt_parent_num;
	}
	public Date getCmt_date() {
		return cmt_date;
	}
	public void setCmt_date(Date cmt_date) {
		this.cmt_date = cmt_date;
	}
	public int getCust_serv_no() {
		return cust_serv_no;
	}
	public void setCust_serv_no(int cust_serv_no) {
		this.cust_serv_no = cust_serv_no;
	}
	public int getGroup_number() {
		return group_number;
	}
	public void setGroup_number(int group_number) {
		this.group_number = group_number;
	}
	@Override
	public String toString() {
		return "CommentVO [lvl=" + lvl + ", mem_id=" + mem_id + ", cmt_number=" + cmt_number + ", cmt_content="
				+ cmt_content + ", cmt_parent_num=" + cmt_parent_num + ", cmt_date=" + cmt_date + ", cust_serv_no="
				+ cust_serv_no + ", group_number=" + group_number + "]";
	}
	
	
	
	
}
