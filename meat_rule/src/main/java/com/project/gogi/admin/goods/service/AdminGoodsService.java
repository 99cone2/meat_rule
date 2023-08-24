package com.project.gogi.admin.goods.service;

import java.util.List;
import java.util.Map;

import com.project.gogi.vo.GoodsVO;
import com.project.gogi.vo.ImageFileVO;
import com.project.gogi.vo.OrderVO;


public interface AdminGoodsService {
	public int addNewGoods(Map newGoodsMap) throws Exception;
	public List<GoodsVO> listNewGoods(Map condMap) throws Exception;
	public Map goodsDetail(int goods_id) throws Exception;
	public List goodsImageFile(int goods_id) throws Exception;
	
	public void modifyGoodsInfo(Map goodsMap) throws Exception;
	public void modifyGoodsImage(List<ImageFileVO> imageFileList) throws Exception;
	public List<OrderVO> listOrderGoods(Map condMap) throws Exception;
	public void modifyOrderGoods(Map orderMap) throws Exception;
	
	public void removeGoodsImage(int goods_id) throws Exception;
	public void addNewGoodsImage(List imageFileList) throws Exception;
	public void removeGoods(int goods_id) throws Exception;
	int goodsCount() throws Exception;
}