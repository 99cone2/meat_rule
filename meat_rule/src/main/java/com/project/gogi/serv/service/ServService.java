package com.project.gogi.serv.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.project.gogi.vo.CommentVO;
import com.project.gogi.vo.Criteria;
import com.project.gogi.vo.ServImageFileVO;
import com.project.gogi.vo.ServVO;

public interface ServService {

	//게시물 목록+페이징
	public List<ServVO> ServList(Criteria cri) throws Exception;

	//작성
	public int ServWrite(Map servMap) throws Exception;

	//조회
	public Map<String, Object> ServRead(int cust_serv_no) throws Exception;

	//수정
	public void ServUpdate(ServVO vo) throws Exception;

	//이미지 수정
	public void updateImage(Map<String, Object> imageMap) throws Exception;

	//삭제
	public void ServDelete(int cust_serv_no) throws Exception;

	//게시물 총 개수
	public int ServListCount() throws Exception;

	//조회수
	public void updateServViewCnt(int cust_serv_no) throws Exception;

	public boolean CheckAdmin(ServVO vo) throws Exception;

	public String getServPw(int cust_serv_no) throws Exception;

	//1:1문의내역 조회
	public List<ServVO> reviewList(String mem_id) throws Exception;

	//댓글 작성
	public int addComment(CommentVO commentVO) throws Exception;

	//댓글,대댓글 조회
	public List<CommentVO> selectBoardCommentByCode(CommentVO commentVO) throws Exception;

	//대댓글 작성
	public void addReply(CommentVO commentVO) throws Exception;

	//댓글,대댓글 계층형 위한 lvl값 조회
	public int getCmtLvl(int parent_cmt_number) throws Exception;
	
	//댓글,대댓글 계층형 위한 부모댓글의 group_number값 조회
	public int getParentGroupNumeber(int cmt_parent_num) throws Exception;
	
	//댓글,대댓글 계층형 위한 group_number값 조회
	public int getGroupNumber(int group_number) throws Exception;

}
