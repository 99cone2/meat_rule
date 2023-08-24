package com.project.gogi.serv.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.project.gogi.vo.CommentVO;
import com.project.gogi.vo.Criteria;
import com.project.gogi.vo.ServImageFileVO;
import com.project.gogi.vo.ServVO;

public interface ServDAO {

	//게시물 목록+페이징
	public List<ServVO> ServList(Criteria cri) throws Exception;

	//작성
	public int ServWrite(Map servMap) throws Exception;

	//이미지 파일 저장
	public void insertServImageFile(List<ServImageFileVO> fileList) throws DataAccessException;

	//이미지 파일 조회
	public List<ServImageFileVO> selectImageFile(int cust_serv_no) throws Exception;

	//조회
	public ServVO ServRead(int cust_serv_no) throws Exception;

	//수정
	public void ServUpdate(ServVO vo) throws Exception;

	//이미지 수정
	public void servImageUpdete(Map<String, Object> imageMap) throws Exception;

	//삭제
	public void ServDelete(int cust_serv_no) throws Exception;

	//게시물 총 갯수 확인
	public int ServListCount() throws Exception;

	//조회수
	public void updateServViewCnt(int cust_serv_no) throws Exception;

	//관리자인지 체크	
	public boolean CheckAdmin(ServVO vo) throws Exception;

	//비밀글
	public String getServPw(int cust_serv_no) throws Exception;

	//1:1문의 내역 조회
	public List<ServVO> selectReviewList(String mem_id) throws Exception;

	//댓글,대댓글 작성
	public int addComment(CommentVO commentVO) throws DataAccessException;

	//댓글,대댓글 조회
	public List<CommentVO> selectBoardCommentByCode(CommentVO commentVO) throws DataAccessException;

	//댓글,대댓글 계층형 위한 lvl값 조회
	public int getCmtLvl(int parent_cmt_number) throws DataAccessException;
	
	//댓글,대댓글 계층형 위한 부모댓글의 group_number값 조회
	public int getParentGroupNumeber(int cmt_parent_num) throws DataAccessException;
	
	//댓글,대댓글 계층형 위한 group_number값 조회
	public int getGroupNumber(int group_number) throws DataAccessException;

}
