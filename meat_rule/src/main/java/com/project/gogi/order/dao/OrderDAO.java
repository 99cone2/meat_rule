package com.project.gogi.order.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.project.gogi.vo.MemberVO;
import com.project.gogi.vo.OrderVO;

public interface OrderDAO {
	public void insertNewOrder(List<OrderVO> myOrderList) throws DataAccessException;
	public void removeGoodsFromCart(List<OrderVO> myOrderList) throws DataAccessException;
	public void updatePoint(MemberVO memberVO) throws DataAccessException;
}
