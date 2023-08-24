package com.project.gogi.mypage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.project.gogi.vo.MemberVO;
import com.project.gogi.vo.OrderVO;
import com.project.gogi.vo.ReviewVO;

@Repository("mypageDAO")
public class mypageDAOImpl implements mypageDAO{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void updateMyInfo(Map memberMap) throws DataAccessException {
		sqlSession.update("mapper.mypage.updateMyInfo",memberMap);
	}

	@Override
	public MemberVO selectMyDetailInfo(String mem_id) throws DataAccessException {
		MemberVO mypageVO=(MemberVO)sqlSession.selectOne("mapper.mypage.selectMyDetailInfo",mem_id);
		return mypageVO;
	}
	
	public List<OrderVO> selectMyOrderHistoryList(Map dateMap) throws DataAccessException{
		List<OrderVO> myOrderHistList=(List)sqlSession.selectList("mapper.mypage.selectMyOrderHistoryList",dateMap);
		return myOrderHistList;
	}
	
	public void updateMyOrderCancel(String order_id) throws DataAccessException{
		sqlSession.update("mapper.mypage.updateMyOrderCancel",order_id);
	}
	
	@Override
	public int deleteMember(String mem_id) throws DataAccessException {
		int result = sqlSession.delete("mapper.mypage.deleteMember", mem_id);
		return result;
	}

	@Override
	public List<ReviewVO> selectReviewList(String mem_id) throws Exception {	
		List<ReviewVO> reviewList = sqlSession.selectList("mapper.review.myReviewList", mem_id);
		return reviewList;
	}

	@Override
	public void reviewDelete(int rev_no) throws Exception {
		sqlSession.delete("mapper.review.reviewDelete", rev_no);
	}

}
