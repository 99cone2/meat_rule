package com.project.gogi.notice.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.project.gogi.notice.dao.NoticeDAO;
import com.project.gogi.vo.Criteria;
import com.project.gogi.vo.NoticeVO;

@Repository
@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDAO dao;

	@Autowired
	private HttpSession httpSession;
	@Autowired
	private NoticeVO noticeVO;
	
	//게시물 목록 +페이징
	@Override
	public List<NoticeVO> NoticeList(Criteria cri) throws Exception{
		return dao.NoticeList(cri);
	}
	
	//작성
	@Override
	public void NoticeWrite(NoticeVO vo) throws Exception {
		dao.NoticeWrite(vo);
		
	}

	//조회
	@Override
	public NoticeVO NoticeRead(int notice_no) throws Exception {
		return dao.NoticeRead(notice_no);
	}

	//수정
	@Override
	public void NoticeUpdate(NoticeVO vo) throws Exception {
		dao.NoticeUpdate(vo);
	}

	
	//삭제
	@Override
	public void NoticeDelete(int notice_no) throws Exception {
		dao.NoticeDelete(notice_no);
	}
	
	// 게시물 총 갯수
	@Override
	public int NoticeListCount() throws Exception {
	 return dao.NoticeListCount();
	}
	
	 //조회수
	 @Override	    
	 public void updateNoticeViewCnt(int notice_no) throws Exception {	      
	 	dao. updateNoticeViewCnt(notice_no);	   
	 }
	 
	 
	 //FAQ~
		//게시물 목록 +페이징
		@Override
		public List<NoticeVO> NoticeFAQList(Criteria cri) throws Exception{
			return dao.NoticeFAQList(cri);
		}
		
		//작성
		@Override
		public void NoticeFAQWrite(NoticeVO vo) throws Exception {
			dao.NoticeFAQWrite(vo);
			
		}

		//조회
		@Override
		public NoticeVO NoticeFAQRead(int notice_no_faq) throws Exception {
			return dao.NoticeFAQRead(notice_no_faq);
		}

		//수정
		@Override
		public void NoticeFAQUpdate(NoticeVO vo) throws Exception {
			dao.NoticeFAQUpdate(vo);
		}

		
		//삭제
		@Override
		public void NoticeFAQDelete(int notice_no_faq) throws Exception {
			dao.NoticeFAQDelete(notice_no_faq);
		}
		
		// 게시물 총 갯수
		@Override
		public int NoticeFAQListCount() throws Exception {
		 return dao.NoticeFAQListCount();
		}
		
		 //조회수
		 @Override	    
		 public void updateNoticeFAQViewCnt(int notice_no_faq) throws Exception {	      
		 	dao. updateNoticeFAQViewCnt(notice_no_faq);	   
		 }
	 
		 
		 
		 
		 
		 
		 

			@Override
			public List<NoticeVO> listBoard(Map<String, Object> paging) throws Exception {
				int section = (int) paging.get("section");
				int pageNum = (int) paging.get("pageNum");
				
				paging.put("section", section);
				paging.put("pageNum", pageNum);
				
				return dao.selectBoardList(paging);		
			}
			
			
			@Override
			public int boardCount() throws Exception {
				return dao.boardCount();
			}
			
			
			
			
			@Override
			 // admin 확인 메서드 추가
		    public boolean CheckAdmin(NoticeVO vo) {
		        // vo를 사용하여 "mem_id"를 가져오거나 필요한 로직을 추가합니다.
		        String mem_id = vo.getMem_id();

		        // mem_id가 "admin"인지 확인하여 true 또는 false를 반환합니다.
		        return "admin".equals(mem_id);
		    }
			
			
			
			
			
	
}
