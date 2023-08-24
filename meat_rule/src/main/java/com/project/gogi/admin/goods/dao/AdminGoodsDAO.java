package com.project.gogi.admin.goods.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.project.gogi.vo.GoodsVO;
import com.project.gogi.vo.ImageFileVO;
import com.project.gogi.vo.OrderVO;


public interface AdminGoodsDAO {
	public int insertNewGoods(Map newGoodsMap) throws DataAccessException;
	public List<GoodsVO>selectNewGoodsList(Map condMap) throws DataAccessException;
	public GoodsVO selectGoodsDetail(int goods_id) throws DataAccessException;
	public List selectGoodsImageFileList(int goods_id) throws DataAccessException;
	public void insertGoodsImageFile(List<ImageFileVO> fileList)  throws DataAccessException;
	public void updateGoodsInfo(Map goodsMap) throws DataAccessException;
	public void updateGoodsImage(List<ImageFileVO> imageFileList) throws DataAccessException;
	public void deleteGoodsImage(int goods_id) throws DataAccessException;
	
	public List<OrderVO> selectOrderGoodsList(Map condMap) throws DataAccessException;
	public void updateOrderGoods(Map orderMap) throws DataAccessException;
	public void deleteGoods(int goods_id) throws DataAccessException;
	int goodsCount() throws Exception;
}