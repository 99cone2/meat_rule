package com.project.gogi.vo;

public class Criteria {
// Criteria는 rNum의 제한값과  현재 페이지,페이지에 출력되는 게시물 숫자를 제어
	//시작값과 끝값을 다루는 클래스
	
	 private int page;  //페이지 
	 private int perPageNum; //한 화면에 출력되는 게시물의 숫자
	 private int rowStart; //rNum 제한값중 시작값
	 private int rowEnd;	////rNum 제한값중 끝값
	 
	 public Criteria()
	 {
	  this.page = 1;
	  this.perPageNum = 10;
	 }

	 
	 public void setPage(int page)
	 {
	  if (page <= 0)
	  {
	   this.page = 1;
	   return;
	  }
	  this.page = page;
	 }

	 // 한 화면에 출력되는 게시물의 숫자/ 관련 메서드
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
	 //getPerPageNum = (this.page - 1) * perPageNum
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
