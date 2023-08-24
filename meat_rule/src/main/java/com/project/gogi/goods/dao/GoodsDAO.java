package com.project.gogi.goods.dao;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

import com.project.gogi.vo.GoodsVO;
import com.project.gogi.vo.ReviewImageVO;
import com.project.gogi.vo.ReviewVO;

@MapperScan
public interface GoodsDAO {
	public List<GoodsVO> selectGoodsMainList(String goods_status) throws Exception;
	public List<GoodsVO> selectGoodsShopList(String goods_sort) throws Exception;
	public GoodsVO selectGoodsDetail(int goods_id) throws Exception;
	public List<GoodsVO> selectGoodsBySearchWord(String searchWord) throws Exception;
	public List<String> selectKeywordSearch(String keyword) throws Exception;
	//리뷰작성
	public int reviewWrite(ReviewVO reviewVO) throws Exception;	   
	//리뷰이미지 파일 저장
	public void insertReviewImageFile(List<ReviewImageVO> fileList) throws Exception;	   
	//리뷰이미지 파일 조회
	public List<ReviewImageVO> selectImageFile(int rev_no) throws Exception;	   
	public List selectReviewList(int goods_id) throws Exception;
}
