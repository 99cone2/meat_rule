package com.project.gogi.cart.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.project.gogi.vo.CartVO;
import com.project.gogi.vo.GoodsVO;

@Repository("cartDAO")
public class CartDAOImpl implements CartDAO{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public boolean selectCountInCart(CartVO cartVO) throws DataAccessException {
		String result=sqlSession.selectOne("mapper.cart.selectCountInCart", cartVO);	
		return Boolean.parseBoolean(result);
	}

	@Override
	public void insertGoodsInCart(CartVO cartVO) throws DataAccessException {
		int cart_no=selectMaxCartNo();
		cartVO.setCart_no(cart_no);
		sqlSession.insert("mapper.cart.insertGoodsInCart", cartVO);
	}
	
	private int selectMaxCartNo() throws DataAccessException{
		int cart_no = sqlSession.selectOne("mapper.cart.selectMaxCartNo");
		return cart_no;
	}

	@Override
	public List<CartVO> selectCartList(CartVO cartVO) throws DataAccessException {		
		List<CartVO> cartList=sqlSession.selectList("mapper.cart.selectCartList", cartVO);
		//cartList -> mapper의 foreach 구문에 collection에서 참조함 
		System.out.println("dao cartlist"+cartList);
		return cartList;
	}

	@Override
	public List<GoodsVO> selectGoodsList(List<CartVO> cartList, String mem_id) throws DataAccessException {
		
		List<GoodsVO> myGoodsList;
		Map<String, Object> myGoodsMap=new HashMap();
		
		myGoodsMap.put("cartList", cartList);
		myGoodsMap.put("mem_id", mem_id);
		
		myGoodsList=sqlSession.selectList("mapper.cart.selectGoodsList", myGoodsMap);
		System.out.println("dao goodslist:"+myGoodsList);
		return myGoodsList;
	}

	@Override
	public void updateGoodsCount(CartVO cartVO) throws DataAccessException {
		sqlSession.insert("mapper.cart.updateGoodsCount", cartVO);
	}

	@Override
	public void deleteGoods(int cart_no) throws DataAccessException {
		sqlSession.delete("mapper.cart.deleteCartGoods", cart_no);
	}
	

}
