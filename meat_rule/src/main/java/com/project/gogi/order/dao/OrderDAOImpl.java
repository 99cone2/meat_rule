package com.project.gogi.order.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.project.gogi.vo.MemberVO;
import com.project.gogi.vo.OrderVO;

@Repository("orderDAO")
public class OrderDAOImpl implements OrderDAO{
	@Autowired
	SqlSession sqlSession;
	
	
	@Override
	public void insertNewOrder(List<OrderVO> myOrderList) throws DataAccessException {
		//각 orderVO에 설정할 주문번호 가져옴
		int order_id=selectOrderID();
		
		for(int i=0;i<myOrderList.size();i++) {
			OrderVO orderVO=myOrderList.get(i);
			orderVO.setOrder_id(order_id);
			sqlSession.insert("mapper.order.insertNewOrder", orderVO);
		}
	}

	@Override
	public void removeGoodsFromCart(List<OrderVO> myOrderList) throws DataAccessException {
		// TODO Auto-generated method stub
		
	}
	
	private int selectOrderID() throws DataAccessException {
		return sqlSession.selectOne("mapper.order.selectOrderID");
	}

	@Override
	public void updatePoint(MemberVO memberVO) throws DataAccessException {
		sqlSession.update("mapper.order.updatePoint", memberVO);
	}

}
