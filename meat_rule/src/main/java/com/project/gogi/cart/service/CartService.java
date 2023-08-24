package com.project.gogi.cart.service;

import java.util.List;
import java.util.Map;

import com.project.gogi.vo.CartVO;

public interface CartService {
	public boolean findCartGoods(CartVO cartVO) throws Exception;
	public void addGoodsInCart(CartVO cartVO) throws Exception;
	public Map<String, List> myCartList(CartVO cartVO) throws Exception;
	public boolean updateGoodsCount(CartVO cartVO) throws Exception;
	public void deleteGoods(int cart_no) throws Exception;
}
