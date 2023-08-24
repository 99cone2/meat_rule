package com.project.gogi.goods.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.gogi.goods.dao.GoodsDAO;
import com.project.gogi.vo.GoodsVO;
import com.project.gogi.vo.ReviewImageVO;
import com.project.gogi.vo.ReviewVO;

@Service("goodsServiceImpl")
public class GoodsServiceImpl implements GoodsService{
	@Autowired
	private GoodsDAO dao;

	@Override
	public Map<String, List<GoodsVO>> listMainGoods() throws Exception {
		Map<String, List<GoodsVO>> goodsMap=new HashMap<String, List<GoodsVO>>();
		
		//베스트상품
		List<GoodsVO> goodsList=dao.selectGoodsMainList("B");
		goodsMap.put("best", goodsList);
		System.out.println("service best"+goodsMap);
		
		//세일상품
		goodsList=dao.selectGoodsMainList("S");
		goodsMap.put("sale", goodsList);
		System.out.println("service sale"+goodsMap);
		
		
		return goodsMap;
	}

	@Override
	public Map<String, List<GoodsVO>> listShopGoods() throws Exception {
		Map<String, List<GoodsVO>> goodsMap=new HashMap<String, List<GoodsVO>>();
		List<GoodsVO> goodsList=dao.selectGoodsShopList("PIG");
		goodsMap.put("pig", goodsList);
		
		goodsList=dao.selectGoodsShopList("COW");
		goodsMap.put("cow", goodsList);
		
		goodsList=dao.selectGoodsShopList("CHICKEN");
		goodsMap.put("chicken", goodsList);
		
		goodsList=dao.selectGoodsShopList("MEALKIT");
		goodsMap.put("mealkit", goodsList);
		
		return goodsMap;
	}

	@Override
	public Map goodsDetail(int goods_id) throws Exception {
		//상품정보와 이미지 정보 조회한 후 HashMap에 저장
		Map goodsMap=new HashMap();
		GoodsVO goodsVO=dao.selectGoodsDetail(goods_id);
		System.out.println("detail: "+goods_id);
		goodsMap.put("goodsVO", goodsVO);
//		List imageList=dao.selectGoodsDetailImage(goods_id);
//		goodsMap.put("imageList", imageList);
		
		return goodsMap;
	}

	@Override

	public int reviewWrite(ReviewVO reviewVO, List<ReviewImageVO> imageFileList) throws Exception {
		System.out.println("리뷰등록 서비스?");
		dao.reviewWrite(reviewVO);
		int rev_no=reviewVO.getRev_no();
		
		System.out.println("서비스 : " + rev_no);
  
	    for (ReviewImageVO reviewImageVO : imageFileList) {
	    	reviewImageVO.setRev_no(rev_no);	       
	    }
	  
	   dao.insertReviewImageFile(imageFileList);
	    
	    return rev_no;
	}

	@Override
	public List<ReviewVO> reviewList(int goods_id) throws Exception {
		List reviewList = dao.selectReviewList(goods_id);
		return reviewList;
	}

	@Override
	public List<ReviewImageVO> selectImageFile(int rev_no) throws Exception {
		Map reviewImageMap=new HashMap();
		
		// 상품 정보와 이미지 정보를 조회한 후 HashMap에 저장합니다.
		
		List<ReviewImageVO> imageList =dao.selectImageFile(rev_no);
		reviewImageMap.put("imageList", imageList);
		
		return imageList;
	}

	@Override
	public List<String> keywordSearch(String keyword) throws Exception {
		List<String> list=dao.selectKeywordSearch(keyword);
		return list;
	}

	@Override
	public List<GoodsVO> searchGoods(String searchWord) throws Exception {
		List goodsList=dao.selectGoodsBySearchWord(searchWord);
		return goodsList;
	}

}
