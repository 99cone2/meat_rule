package com.project.gogi.vo;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {// 페이지 번호 만들고 출력하는 기능 관련 vo =게시판 페이징 처리
	
	 private int totalCount;//게시물 총 갯수
	 private int startPage;	//현제 페이지의 시작 번호 (1, 11, 21 등등)
	 private int endPage; 	//현제 페이지의 끝 번호 (10, 20, 30 등등)
	 private boolean prev; 	//이전 페이지로 이동하는 링크의 존재 여부
	 private boolean next;	//다음 페이지로 이동하는 링크의 존재 여부
	 private Criteria cri;

	 private int displayPageNum = 10;

	
	 
	 public void setCri(Criteria cri) {
	  this.cri = cri;
	 }

	 public void setTotalCount(int totalCount) {
	  this.totalCount = totalCount;
	  calcData();
	 }

	 public int getTotalCount() {
	  return totalCount;
	 }

	 public int getStartPage() {
	  return startPage;
	 }

	 public int getEndPage() {
	  return endPage;
	 }

	 public boolean isPrev() {
	  return prev;
	 }

	 public boolean isNext() {
	  return next;
	 }

	 public int getDisplayPageNum() {
	  return displayPageNum;
	 }

	 public Criteria getCri() {
	  return cri;
	 }
	 
	 private void calcData() {
	  //끝 페이지 번호 = (현재 페이지 번호 / 화면에 보여질 페이지 번호의 갯수) * 화면에 보여질 페이지 번호의 갯수
	  endPage = (int) (Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum);
	  startPage = (endPage - displayPageNum) + 1;
	  
	  //마지막 페이지 번호 = 총 게시글 수 / 한 페이지당 보여줄 게시글의 갯수
	  int tempEndPage = (int) (Math.ceil(totalCount / (double)cri.getPerPageNum()));
	  
	 
	  if (endPage > tempEndPage)
	  {
	   endPage = tempEndPage;
	  }
	  //시작 페이지 번호는 -1이 된다. 따라서, 구한 시작페이지 번호가 0보다 작으면(음수) 시작 페이지를 1로 해주는 로직을 추가.
	  prev = startPage == 1 ? false : true;
	//다음 버튼 생성 여부 = 끝 페이지 번호 * 한 페이지당 보여줄 게시글의 갯수 < 총 게시글의 수 ? true: false
	  next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
	 }
	 
	 //perPageNum파라미터와 추가될 파라미터를 위한 코드 추가
	 //UriComponents는 URI를 생성해주는 클래스
	 public String makeQuery(int page)
	 {
	  UriComponents uriComponents =
	    UriComponentsBuilder.newInstance()
	    .queryParam("page", page)
	    .queryParam("perPageNum", cri.getPerPageNum())
	    .build();
	    
	  return uriComponents.toUriString();
	 }

	@Override
	public String toString() {
		return "PageMaker [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage + ", prev="
				+ prev + ", next=" + next + ", cri=" + cri + ", displayPageNum=" + displayPageNum + "]";
	}
	 
	 
	 
	 
}
