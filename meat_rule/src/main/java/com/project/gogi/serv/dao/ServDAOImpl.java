package com.project.gogi.serv.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.project.gogi.vo.CommentVO;
import com.project.gogi.vo.Criteria;
import com.project.gogi.vo.ServImageFileVO;
import com.project.gogi.vo.ServVO;

@Repository
public class ServDAOImpl implements ServDAO {

	@Autowired
	private SqlSession sql;

	private static String namespace = "mapper.serv";

	//게시물 목록 +페이징
	@Override
	public List<ServVO> ServList(Criteria cri) throws Exception {

		return sql.selectList(namespace + ".servList", cri);
	}

	//작성
	@Override
	public int ServWrite(Map servMap) throws Exception {
		sql.insert(namespace + ".servWrite", servMap);
		int cust_serv_no = Integer.parseInt(servMap.get("cust_serv_no").toString()); // 생성된 값 가져오기
		// System.out.println("고객센터 글쓰기 dao:"+cust_serv_no);
		return cust_serv_no;
	}

	//이미지 파일 추가
	@Override
	public void insertServImageFile(List<ServImageFileVO> fileList) throws DataAccessException {
		for (int i = 0; i < fileList.size(); i++) {
			ServImageFileVO servImageFileVO = (ServImageFileVO) fileList.get(i);
			sql.insert(namespace + ".insertServImageFile", servImageFileVO);
		}
	}

	//이미지 파일 조회
	@Override
	public List<ServImageFileVO> selectImageFile(int cust_serv_no) throws Exception {
		return sql.selectList(namespace + ".selectImageFile", cust_serv_no);
	}

	//조회
	@Override
	public ServVO ServRead(int cust_serv_no) throws Exception {
		return sql.selectOne(namespace + ".servRead", cust_serv_no);
	}

	//수정
	@Override
	public void ServUpdate(ServVO vo) throws Exception {
		sql.update(namespace + ".servUpdate", vo);
	}

	//이미지 수정
	@Override
	public void servImageUpdete(Map<String, Object> imageMap) throws Exception {
		sql.update(namespace + ".servImageUpdate", imageMap);
	}

	//삭제
	@Override
	public void ServDelete(int cust_serv_no) throws Exception {
		sql.delete(namespace + ".servDelete", cust_serv_no);

	}

	//게시글 총 개수 확인
	@Override
	public int ServListCount() throws Exception {
		return sql.selectOne(namespace + ".servListCount");
	}

	//조회수
	@Override
	public void updateServViewCnt(int cust_serv_no) throws Exception {
		sql.update(namespace + ".updateServViewCnt", cust_serv_no);
	}

	@Override
	//admin 확인 메서드 추가
	public boolean CheckAdmin(ServVO vo) {
		//vo를 사용하여 "mem_id"를 가져오거나 필요한 로직을 추가
		String mem_id = vo.getMem_id();
		// mem_id가 "admin"인지 확인하여 true 또는 false를 반환
		return "admin".equals(mem_id);
	}

	@Override
	public String getServPw(int cust_serv_no) throws Exception {
		return sql.selectOne(namespace + ".servGetPw", cust_serv_no);
	}

	//1:1문의 내역 조회
	@Override
	public List<ServVO> selectReviewList(String mem_id) throws Exception {
		List<ServVO> reviewList = sql.selectList("mapper.serv.myServList", mem_id);
		return reviewList;
	}

	//댓글,대댓글 작성
	@Override
	public int addComment(CommentVO commentVO) throws DataAccessException {
		return sql.insert("mapper.serv.addComment", commentVO);
	}

	//댓글,대댓글 조회
	@Override
	public List<CommentVO> selectBoardCommentByCode(CommentVO commentVO) throws DataAccessException {
		List<CommentVO> commentList = sql.selectList("mapper.serv.CommentList", commentVO);
		return commentList;
	}

	//댓글,대댓글 계층형 위한 lvl값 조회
	@Override
	public int getCmtLvl(int cmt_parent_num) throws DataAccessException {
		return sql.selectOne("mapper.serv.getCmtNumber", cmt_parent_num);
	}

	//댓글,대댓글 계층형 위한 group_number값 조회
	@Override
	public int getGroupNumber(int group_number) throws DataAccessException {
		return sql.selectOne("mapper.serv.getGroupNumber", group_number);
	}

	//댓글,대댓글 계층형 위한 부모댓글의 group_number값 조회
	@Override
	public int getParentGroupNumeber(int parent_group_number) throws DataAccessException {
		return sql.selectOne("mapper.serv.getParentGroupNumber", parent_group_number);
	}

}
