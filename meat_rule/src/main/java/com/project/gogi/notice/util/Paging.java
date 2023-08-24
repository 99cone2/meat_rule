package com.project.gogi.notice.util;

import com.project.gogi.vo.PageVO;

public class Paging {
	private int startPage, endPage;
	private boolean prev, next;
	private int total;
	private PageVO page;
	
	public Paging(PageVO page, int total) {
		this.page=page;
		this.total=total;

		//화면에 보여주는 페이지 개수
		this.endPage= (int) Math.ceil(page.getPageNum()/10.0) *10;
		
		this.startPage = endPage-9;
		
		this.prev=this.startPage>1;
		
	}
}
