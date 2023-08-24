package com.project.gogi.admin.goods.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.project.gogi.vo.GoodsVO;
import com.project.gogi.vo.ImageFileVO;
import com.project.gogi.vo.OrderVO;

@Repository("adminGoodsDAO")
public class AdminGoodsDAOImpl  implements AdminGoodsDAO{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insertNewGoods(Map newGoodsMap) throws DataAccessException {
		// 상품 정보를 추가합니다.
		sqlSession.insert("mapper.admin.goods.insertNewGoods",newGoodsMap);		
		return Integer.parseInt(newGoodsMap.get("goods_id").toString());
	}
	
	@Override
	public void insertGoodsImageFile(List<ImageFileVO> fileList)  throws DataAccessException {
		for(int i=0; i<fileList.size();i++){
			ImageFileVO imageFileVO=(ImageFileVO)fileList.get(i);
			System.out.println("관리자 상품등록:"+imageFileVO.toString());
			// 상품 이미지 정보를 추가합니다.
			sqlSession.insert("mapper.admin.goods.insertGoodsImageFile",imageFileVO);
		}
	}
		
	@Override
	public List<GoodsVO>selectNewGoodsList(Map condMap) throws DataAccessException {
		ArrayList<GoodsVO>  goodsList=(ArrayList)sqlSession.selectList("mapper.admin.goods.selectNewGoodsList",condMap);
		return goodsList;
	}
	
	@Override
	public GoodsVO selectGoodsDetail(int goods_id) throws DataAccessException{
		GoodsVO goodsBean = new GoodsVO();
		goodsBean=(GoodsVO)sqlSession.selectOne("mapper.admin.goods.selectGoodsDetail",goods_id);
		return goodsBean;
	}
	
	@Override
	public List selectGoodsImageFileList(int goods_id) throws DataAccessException {
		List imageList=new ArrayList();
		imageList=(List)sqlSession.selectList("mapper.admin.goods.selectGoodsImageFileList",goods_id);
		return imageList;
	}
	
	@Override
	public void updateGoodsInfo(Map goodsMap) throws DataAccessException{
		sqlSession.update("mapper.admin.goods.updateGoodsInfo",goodsMap);
	}
	
	@Override
	public void deleteGoodsImage(int goods_id) throws DataAccessException{
		sqlSession.delete("mapper.admin.goods.deleteGoodsImage",goods_id);
	}

	@Override
	public List<OrderVO> selectOrderGoodsList(Map condMap) throws DataAccessException{
		List<OrderVO> orderGoodsList=(ArrayList)sqlSession.selectList("mapper.admin.selectOrderGoodsList",condMap);
		return orderGoodsList;
	}	
	
	@Override
	public void updateOrderGoods(Map orderMap) throws DataAccessException{
		sqlSession.update("mapper.admin.goods.updateOrderGoods",orderMap);
	}

	@Override
	public void updateGoodsImage(List<ImageFileVO> imageFileList) throws DataAccessException {
		
		for(int i=0; i<imageFileList.size();i++){
			ImageFileVO imageFileVO = imageFileList.get(i);
			sqlSession.update("mapper.admin.goods.updateGoodsImage",imageFileVO);	
		}
	}

	//삭제
	@Override
	public void deleteGoods(int goods_id) throws DataAccessException{
		sqlSession.delete("mapper.admin.goods.deleteGoods",goods_id);
	}

	@Override
	public int goodsCount() throws Exception {
		return sqlSession.selectOne("mapper.admin.goods.goodsCount");
	}

}