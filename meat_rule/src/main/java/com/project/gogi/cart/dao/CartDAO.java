package com.project.gogi.cart.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.project.gogi.vo.CartVO;
import com.project.gogi.vo.GoodsVO;

public interface CartDAO {
	public boolean selectCountInCart(CartVO cartVO) throws DataAccessException;
	public void insertGoodsInCart(CartVO cartVO) throws DataAccessException;
	public List<CartVO> selectCartList(CartVO cartVO) throws DataAccessException;
	public List<GoodsVO> selectGoodsList(List<CartVO> cartList, String mem_id) throws DataAccessException;	
	public void updateGoodsCount(CartVO cartVO) throws DataAccessException;
	public void deleteGoods(int cart_no) throws DataAccessException;
}
