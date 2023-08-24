package com.project.gogi.admin.order.dao;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.project.gogi.vo.MemberVO;
import com.project.gogi.vo.OrderVO;

public interface AdminOrderDAO {
	
	public ArrayList<OrderVO> selectNewOrderList(Map condMap) throws DataAccessException;
	public void  updateDeliveryState(Map deliveryMap) throws DataAccessException;
	public ArrayList<OrderVO> selectOrderDetail(int order_id) throws DataAccessException;
	public MemberVO selectOrderer(String mem_id) throws DataAccessException;
	int orderCount() throws Exception;
}