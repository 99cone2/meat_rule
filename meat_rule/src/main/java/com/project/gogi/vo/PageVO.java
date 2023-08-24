package com.project.gogi.vo;

import org.springframework.stereotype.Component;

@Component
public class PageVO {
	int pageNum;
	int amount;
	
	public PageVO() {
		this(1,10);
	}

	public PageVO(int pageNum, int amount) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
	}

	@Override
	public String toString() {
		return "PageVO [pageNum=" + pageNum + ", amount=" + amount + "]";
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}	
	
	
}
