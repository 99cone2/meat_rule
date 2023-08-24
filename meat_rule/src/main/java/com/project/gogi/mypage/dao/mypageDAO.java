package com.project.gogi.mypage.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.project.gogi.vo.MemberVO;
import com.project.gogi.vo.OrderVO;
import com.project.gogi.vo.ReviewVO;

public interface mypageDAO {
	public void updateMyInfo(Map memberMap) throws DataAccessException;
	public MemberVO selectMyDetailInfo(String mem_id) throws DataAccessException;
	public List<OrderVO> selectMyOrderHistoryList(Map dateMap) throws DataAccessException;
	public int deleteMember(String mem_id) throws DataAccessException;
	public void updateMyOrderCancel(String order_id) throws DataAccessException;
	public List<ReviewVO> selectReviewList(String mem_id) throws Exception;
	public void reviewDelete(int rev_no) throws Exception;
}
