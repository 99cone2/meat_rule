package com.project.gogi.notice.service;

import java.util.List;
import java.util.Map;

import com.project.gogi.vo.Criteria;
import com.project.gogi.vo.NoticeVO;

public interface NoticeService {

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
	   
	// 게시물 총 갯수
		public int NoticeListCount() throws Exception;
		
		 //조회수
		 public void updateNoticeViewCnt(int notice_no) throws Exception;



		 
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
		 
			    
			    
				List<NoticeVO> listBoard(Map<String, Object> paging) throws Exception;
				
				int boardCount() throws Exception;


				 public boolean CheckAdmin(NoticeVO vo) throws Exception;
}
