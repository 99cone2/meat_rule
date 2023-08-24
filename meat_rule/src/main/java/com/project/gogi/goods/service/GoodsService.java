package com.project.gogi.goods.service;

import java.util.List;
import java.util.Map;

import com.project.gogi.vo.GoodsVO;
import com.project.gogi.vo.ReviewImageVO;
import com.project.gogi.vo.ReviewVO;

public interface GoodsService {
	public Map<String, List<GoodsVO>> listMainGoods() throws Exception;
	public Map<String, List<GoodsVO>> listShopGoods() throws Exception;
	public Map goodsDetail(int goods_id) throws Exception;
	public List<String> keywordSearch(String keyword) throws Exception;	
	public List<GoodsVO> searchGoods(String searchWord) throws Exception;
	
	//리뷰
    public int reviewWrite(ReviewVO reviewVO, List<ReviewImageVO> imageFileList) throws Exception;
    public List<ReviewVO> reviewList(int goods_id) throws Exception;
    //이미지 파일 조회
  	public List<ReviewImageVO> selectImageFile(int rev_no) throws Exception;	 
}
