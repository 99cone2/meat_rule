package com.project.gogi.vo;

public class Criteria {
// Criteria는 Limit 현재 페이지,페이지에 출력되는 게시물 숫자를 제어
	//시작값과 끝값을 다루는 클래스
	
	 private int page;  //페이지 //페이지 번호
	 private int perPageNum; //한 화면에 출력되는 게시물의 숫자 //페이지당 게시글 갯수
	 private int rowStart; //페이지 한 행의 첫번째 게시물 rowNum
	 private int rowEnd;	//페이지 한 행의 마지막 게시물 rowNum
	 
	 public Criteria()// 기본 생성자
	 {
	  this.page = 1; //페이지 1로 초기화
	  this.perPageNum = 10; //페이지당 게시글 10개
	 }

	 
	 public void setPage(int page)// 페이지 번호 set
	 {
	  if (page <= 0)
	  {
	   this.page = 1;
	   return;
	  }
	  this.page = page;
	 }

	 // 한 화면에 출력되는 게시물의 숫자/ 관련 메서드 // 페이지당 게시물 개수 set
	 public void setPerPageNum(int perPageNum)
	 {
	  if (perPageNum <= 0 || perPageNum > 100)
	  {
	   this.perPageNum = 10;
	   return;
	  }
	  this.perPageNum = perPageNum;
	 }

	 //현재 페이지
	 public int getPage()
	 {
	  return page;
	 }

	 //특정 페이지의 게시글 시작 번호, 게시글 시작 행 번호
	 //현재 페이지의 게시글 시작 번호 = (현재 페이지 번호 - 1) * 페이지당 보여줄 게시글 갯수
	 //현재 페이지의 페이지당 게시글 수를 곱하여 현재 페이지의 시작 게시글 limit 수를 구하는것(Mysql) 
	 public int getPageStart()
	 {
	  return (this.page - 1) * perPageNum;
	 }

	 
	 public int getPerPageNum()
	 {
	  return this.perPageNum;
	 }

	 @Override
	 public String toString() {
	  return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ""
	    + ", rowStart=" +  getRowStart() + ", rowEnd=" + getRowEnd()
	    + "]";
	 }

	 public int getRowStart() {
	  rowStart = ((page - 1) * perPageNum) + 1;
	  return rowStart;
	 }

	 public int getRowEnd() {
	  rowEnd = rowStart + perPageNum - 1;
	  return rowEnd;
	 }
}
