package com.project.gogi.serv.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.project.gogi.serv.dao.ServDAO;
import com.project.gogi.vo.CommentVO;
import com.project.gogi.vo.Criteria;
import com.project.gogi.vo.ServImageFileVO;
import com.project.gogi.vo.ServVO;

@Service("servService")
public class ServServiceImpl implements ServService {

	@Autowired
	private ServDAO dao;
	@Autowired
	private HttpSession httpSession;
	@Autowired
	private ServVO ServVO;

	//게시물 목록 +페이징
	@Override
	public List<ServVO> ServList(Criteria cri) throws Exception {
		return dao.ServList(cri);
	}

	//작성
	@Override
	public int ServWrite(Map servMap) throws Exception {
		int cust_serv_no = dao.ServWrite(servMap);

		List<ServImageFileVO> imageFileList = (List<ServImageFileVO>) servMap.get("imageFileList");

		for (ServImageFileVO servImageFileVO : imageFileList) {
			servImageFileVO.setCust_serv_no(cust_serv_no);
		}
		dao.insertServImageFile(imageFileList);

		return cust_serv_no;
	}

	//조회
	@Override
	public Map<String, Object> ServRead(int cust_serv_no) throws Exception {
		Map<String, Object> servMap = new HashMap<>();
		ServVO servVO = dao.ServRead(cust_serv_no);
		
		List<ServImageFileVO> imageFileList = dao.selectImageFile(cust_serv_no);

		servMap.put("servVO", servVO);
		servMap.put("imageFileList", imageFileList);

		return servMap;
	}

	//수정
	@Override
	public void ServUpdate(ServVO vo) throws Exception {
		dao.ServUpdate(vo);
	}

	//이미지 파일 수정
	@Override
	public void updateImage(Map<String, Object> imageMap) throws Exception {
		dao.servImageUpdete(imageMap);
		System.out.println("이미지 업데이트 service");
	}

	//삭제
	@Override
	public void ServDelete(int cust_serv_no) throws Exception {
		dao.ServDelete(cust_serv_no);
	}

	//게시물 총 개수
	@Override
	public int ServListCount() throws Exception {
		return dao.ServListCount();
	}

	//조회수
	@Override
	public void updateServViewCnt(int cust_serv_no) throws Exception {
		dao.updateServViewCnt(cust_serv_no);
	}

	@Override
	//admin 확인 메서드 추가
	public boolean CheckAdmin(ServVO vo) {
		//vo를 사용하여 "mem_id"를 가져오거나 필요한 로직을 추가합니다.
		String mem_id = vo.getMem_id();

		//mem_id가 "admin"인지 확인하여 true 또는 false를 반환합니다.
		return "admin".equals(mem_id);
	}

	@Override
	public String getServPw(int cust_serv_no) throws Exception {
		return dao.getServPw(cust_serv_no);
	}

	//1:1문의내역 조회
	@Override
	public List<ServVO> reviewList(String mem_id) throws Exception {
		List reviewList = dao.selectReviewList(mem_id);
		return reviewList;
	}

	//댓글 작성
	@Override
	public int addComment(CommentVO commentVO) throws Exception {
		return dao.addComment(commentVO);
	}

	//대댓글 작성
	@Override
	public void addReply(CommentVO commentVO) throws Exception {
		dao.addComment(commentVO);
	}

	//댓글,대댓글 조회
	@Override
	public List<CommentVO> selectBoardCommentByCode(CommentVO commentVO) throws Exception {
		List<CommentVO> comment = dao.selectBoardCommentByCode(commentVO);
		return comment;
	}

	//댓글,대댓글 계층형 위한 lvl값 조회
	@Override
	public int getCmtLvl(int parent_cmt_number) throws Exception {
		return dao.getCmtLvl(parent_cmt_number);
	}

	//댓글,대댓글 계층형 위한 group_number값 조회
	@Override
	public int getGroupNumber(int group_number) throws Exception {
		return dao.getGroupNumber(group_number);
	}

	@Override
	public int getParentGroupNumeber(int cmt_parent_num) throws Exception {
		return dao.getParentGroupNumeber(cmt_parent_num);
	}

}
