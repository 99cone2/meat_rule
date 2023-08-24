package com.project.gogi.notice.dao;

import java.util.List;
import java.util.Map;

import com.project.gogi.vo.Criteria;
import com.project.gogi.vo.NoticeVO;

public interface NoticeDAO {

	 //공지사항 ~
	   //게시물 목록 +페이징
	  public List<NoticeVO> NoticeList(Criteria cri) throws Exception;
	
	   // 작성
	   public void NoticeWrite(NoticeVO vo) throws Exception;
	   
	   // 조회
	   public NoticeVO NoticeRead(int notice_no) throws Exception;
	   
	   // 수정
	   public void NoticeUpdate(NoticeVO vo) throws Exception;
	   
	   // 삭제
	   public void NoticeDelete(int notice_no) throws Exception;
	   
	   
	   //게시물 총 갯수 확인
	    public int NoticeListCount() throws Exception;

	    
	    //조회수
	    public void updateNoticeViewCnt(int notice_no) throws Exception;
	    
	    //공지사항 끝
	    
	    //FAQ~

	    //게시물 목록 +페이징
		  public List<NoticeVO> NoticeFAQList(Criteria cri) throws Exception;
		
		   // 작성
		   public void NoticeFAQWrite(NoticeVO vo) throws Exception;
		
		   // 조회
		   public NoticeVO NoticeFAQRead(int notice_no_faq) throws Exception;
		   
		   // 수정
		   public void NoticeFAQUpdate(NoticeVO vo) throws Exception;
		   
		   // 삭제
		   public void NoticeFAQDelete(int notice_no_faq) throws Exception;
		   
		   
		   //게시물 총 갯수 확인
		    public int NoticeFAQListCount() throws Exception;

		    
		    //조회수
		    public void updateNoticeFAQViewCnt(int notice_no_faq) throws Exception;
		    

		    
		    
		    
		   //동림언니
			//게시글 목록조회(페이징)
			public List<NoticeVO> selectBoardList(Map<String, Object> paging) throws Exception;
			
			//게시물 카운트
			int boardCount() throws Exception;
			
			
		 
		    public boolean CheckAdmin(NoticeVO vo)  throws Exception;
			
		    
}
