package com.project.gogi.order.service;

import java.util.List;

import com.project.gogi.vo.MemberVO;
import com.project.gogi.vo.OrderVO;

public interface OrderService {
	public void addNewOrder(List<OrderVO> myOrderList) throws Exception;
	public void updateMemPoint(MemberVO memberVO) throws Exception;
}
