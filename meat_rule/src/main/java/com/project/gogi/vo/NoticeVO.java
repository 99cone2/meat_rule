package com.project.gogi.vo;

import java.util.Date;

import org.springframework.stereotype.Component;
@Component
public class NoticeVO {

//	 NOTICE_NO 	NUMBER	PRIMARY KEY,   
//	    NOTICE_TITLE 	VARCHAR2(500)	NOT NULL,
//	    NOTICE_CONTENT 	VARCHAR2(2000)	NOT NULL,
//	    NOTICE_DATE 	date default sysdate null,
//	    NOTICE_HITS 	NUMBER 	default 0,
//	    MEM_ID 	VARCHAR2(20)	NOT NULL,
//
//	
 
	private int notice_no ;
	private String  notice_title;
	private String  notice_content; 	;
	private String  mem_id;
	private Date notice_date ;
	private int notice_hits ;
	
//	
//	
//	  NOTICE_NO_FAQ 	NUMBER	PRIMARY KEY,   
//	    NOTICE_TITLE 	VARCHAR2(500)	NOT NULL,
//	    NOTICE_CONTENT_FAQ 	VARCHAR2(2000)	NOT NULL,
//	    NOTICE_DATE 	date default sysdate null,
//	    NOTICE_HITS 	NUMBER 	default 0,
//	    MEM_ID 	VARCHAR2(20)	NOT NULL,

	private int notice_no_faq;
	private String notice_content_faq;
	private String  notice_title_faq;
	private Date notice_date_faq ;
	private int notice_hits_faq ;
	
	
	
	public int getNotice_no() {
		return notice_no;
	}
	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public Date getNotice_date() {
		return notice_date;
	}
	public void setNotice_date(Date notice_date) {
		this.notice_date = notice_date;
	}
	public int getNotice_hits() {
		return notice_hits;
	}
	public void setNotice_hits(int notice_hits) {
		this.notice_hits = notice_hits;
	}
	public int getNotice_no_faq() {
		return notice_no_faq;
	}
	public void setNotice_no_faq(int notice_no_faq) {
		this.notice_no_faq = notice_no_faq;
	}
	public String getNotice_content_faq() {
		return notice_content_faq;
	}
	public void setNotice_content_faq(String notice_content_faq) {
		this.notice_content_faq = notice_content_faq;
	}
	public String getNotice_title_faq() {
		return notice_title_faq;
	}
	public void setNotice_title_faq(String notice_title_faq) {
		this.notice_title_faq = notice_title_faq;
	}
	public Date getNotice_date_faq() {
		return notice_date_faq;
	}
	public void setNotice_date_faq(Date notice_date_faq) {
		this.notice_date_faq = notice_date_faq;
	}
	public int getNotice_hits_faq() {
		return notice_hits_faq;
	}
	public void setNotice_hits_faq(int notice_hits_faq) {
		this.notice_hits_faq = notice_hits_faq;
	}
	 
	
	
	
	
}
