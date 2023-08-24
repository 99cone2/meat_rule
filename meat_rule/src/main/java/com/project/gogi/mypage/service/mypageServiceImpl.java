package com.project.gogi.mypage.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.gogi.mypage.dao.mypageDAO;
import com.project.gogi.vo.MemberVO;
import com.project.gogi.vo.OrderVO;
import com.project.gogi.vo.ReviewVO;

@Service("mypageService")
@Transactional(propagation = Propagation.REQUIRED)
public class mypageServiceImpl implements mypageService{

	@Autowired
	mypageDAO mypageDAO;
	
	@Override
	public MemberVO modifyMyInfo(Map memberMap) throws Exception {
		 String mem_id=(String)memberMap.get("mem_id");
		 mypageDAO.updateMyInfo(memberMap);
		 return mypageDAO.selectMyDetailInfo(mem_id);
	}

	@Override
	public MemberVO myDetailInfo(String mem_id) throws Exception{
		return mypageDAO.selectMyDetailInfo(mem_id);
	}
	
	public List<OrderVO> listMyOrderHistory(Map dateMap) throws Exception{
		return mypageDAO.selectMyOrderHistoryList(dateMap);
	}
	
	public void cancelOrder(String order_id) throws Exception{
		mypageDAO.updateMyOrderCancel(order_id);
	}
	
	@Override
	public int deleteMember(String mem_id) throws Exception {
		return mypageDAO.deleteMember(mem_id);
	}

	@Override
	public List<ReviewVO> reviewList(String mem_id) throws Exception {
		List reviewList = mypageDAO.selectReviewList(mem_id);
		return reviewList;
	}

	@Override
	public void reviewDelete(int rev_no) throws Exception {
		mypageDAO.reviewDelete(rev_no);
	}
}
