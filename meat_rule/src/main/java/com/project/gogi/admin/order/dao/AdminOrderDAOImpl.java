package com.project.gogi.admin.order.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.project.gogi.vo.MemberVO;
import com.project.gogi.vo.OrderVO;

@Repository("adminOrderDAO")
public class AdminOrderDAOImpl implements AdminOrderDAO{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<OrderVO>selectNewOrderList(Map condMap) throws DataAccessException{
		ArrayList<OrderVO> orderList=(ArrayList)sqlSession.selectList("mapper.admin.order.selectNewOrderList",condMap);
		System.out.println("dao :"+orderList.toString());
		return orderList;
	}
	public void  updateDeliveryState(Map deliveryMap) throws DataAccessException{
		sqlSession.update("mapper.admin.order.updateDeliveryState",deliveryMap);
	}
	
	public ArrayList<OrderVO> selectOrderDetail(int order_id) throws DataAccessException{
		ArrayList<OrderVO> orderList=(ArrayList)sqlSession.selectList("mapper.admin.order.selectOrderDetail",order_id);
		return orderList;
	}


	public MemberVO selectOrderer(String mem_id) throws DataAccessException{
		MemberVO orderer=(MemberVO)sqlSession.selectOne("mapper.admin.order.selectOrderer",mem_id);
		return orderer;
		
	}
	@Override
	public int orderCount() throws Exception {
		return sqlSession.selectOne("mapper.admin.order.orderCount");
	}

}