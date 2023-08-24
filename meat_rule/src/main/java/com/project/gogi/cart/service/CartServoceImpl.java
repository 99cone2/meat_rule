package com.project.gogi.cart.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.gogi.cart.dao.CartDAO;
import com.project.gogi.vo.CartVO;
import com.project.gogi.vo.GoodsVO;

@Service("cartService")
@Transactional(propagation=Propagation.REQUIRED)
public class CartServoceImpl implements CartService{
	@Autowired
	CartDAO dao;
	
	@Override
	public boolean findCartGoods(CartVO cartVO) throws Exception {		
		return dao.selectCountInCart(cartVO);
	}

	@Override	
	public void addGoodsInCart(CartVO cartVO) throws Exception {
		dao.insertGoodsInCart(cartVO);
	}

	@Override
	public Map<String, List> myCartList(CartVO cartVO) throws Exception {
		Map<String, List> cartMap=new HashMap<String, List>();
		
		List<CartVO> myCartList=dao.selectCartList(cartVO);
		System.out.println("service-myCartList:"+myCartList);
		if(myCartList.size()==0) {
			return null;
		}
		
		String mem_id=cartVO.getMem_id();
		System.out.println("service:"+ mem_id);
		
		System.out.println("service: mycart"+myCartList.toString());
		List<GoodsVO> myGoodsList=dao.selectGoodsList(myCartList, mem_id);
		
		//cartMap에 myCartList, myGoodsList 저장
		cartMap.put("myCartList", myCartList);
		cartMap.put("myGoodsList",myGoodsList);
		
		return cartMap;
	}

	@Override
	public boolean updateGoodsCount(CartVO cartVO) throws Exception {
		boolean result=true;
		dao.updateGoodsCount(cartVO);
		return result;
	}

	@Override
	public void deleteGoods(int cart_no) throws Exception {
		dao.deleteGoods(cart_no);
	}

}
