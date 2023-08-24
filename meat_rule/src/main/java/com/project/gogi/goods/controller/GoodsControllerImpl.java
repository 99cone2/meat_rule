package com.project.gogi.goods.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.project.gogi.common.base.BaseController;
import com.project.gogi.goods.service.GoodsService;
import com.project.gogi.vo.GoodsVO;
import com.project.gogi.vo.MemberVO;
import com.project.gogi.vo.ReviewImageVO;
import com.project.gogi.vo.ReviewVO;

@Controller("goodsControllerImpl")
@RequestMapping(value="/goods")
public class GoodsControllerImpl extends BaseController implements GoodsController{
	
	//리뷰 상품 이미지 파일 저장 위치
	private static final String GOGI_IMAGE_REPO_PATH2 = "C:\\meatrule\\file_repo\\reviewBoard";
		
	@Autowired
	GoodsService goodsService;
	
	@Override
	@RequestMapping(value = "/shop.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView shop(HttpServletRequest request, HttpServletResponse response, @RequestParam(required = false) String category) throws Exception {
	    HttpSession session= request.getSession();
	    session.getAttribute("memberInfo");
	    
	    ModelAndView mav = new ModelAndView();
	    String viewName = (String) request.getAttribute("viewName");
	    mav.setViewName(viewName);
	    
	    Map<String, List<GoodsVO>> goodsMap = goodsService.listShopGoods();

	    // 카테고리에 따라 상품 목록 필터링
	    if (category != null) {
	        goodsMap.keySet().removeIf(key -> !key.equalsIgnoreCase(category));
	    }

	    //System.out.println("shop 컨트롤러 " + goodsMap);
	    mav.addObject("goodsMap", goodsMap);
	    return mav;
	}

	@Override
	@RequestMapping(value="/goodsDetail.do", method=RequestMethod.GET)
	public ModelAndView goodsDetail(@RequestParam("goods_id") int goods_id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		//System.out.println("디테일"+goods_id);
		
		String viewName = (String) request.getAttribute("viewName"); 		
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session= request.getSession();
		
		//System.out.println(session.getAttribute("memberInfo"));

		Boolean isLogOn=(Boolean) session.getAttribute("isLogon"); //로그인 여부
		
		if (isLogOn == null) {
	        isLogOn = false; // 로그인 상태가 null인 경우 false로 설정
	    }
		
		if(isLogOn) {
			//로그인 아이디 보내기
			MemberVO memberVO = (MemberVO)session.getAttribute("memberInfo");
		    String mem_id = memberVO.getMem_id();
		    mav.addObject("mem_id", mem_id);		  
		}
		
		mav.addObject("isLogOn", isLogOn);
		
		Map goodsMap=goodsService.goodsDetail(goods_id);
		//System.out.println("상품디테일 컨트롤러: "+goodsMap);
		
		mav.addObject("goodsMap", goodsMap);
		GoodsVO goodsVO=(GoodsVO) goodsMap.get("goodsVO");
		//System.out.println("상품 디테일 컨트롤러 goodsVO: "+goodsVO);
		
		//리뷰 목록 가져오기
		List<ReviewVO> review = goodsService.reviewList(goods_id);
		//해당 상품의 리뷰 개수 
		int reviewListSize=review.size();
		//System.out.println(reviewListSize+"개");
		mav.addObject("reviewListSize", reviewListSize);
		mav.addObject("review", review);
		
		// 리뷰 이미지 가져오기
	    List<ReviewImageVO> reviewImageList = new ArrayList<>();
	    for (ReviewVO reviewVO : review) {
	        int rev_no = reviewVO.getRev_no();
	        List<ReviewImageVO> reviewImages = goodsService.selectImageFile(rev_no);
	        reviewImageList.addAll(reviewImages);
	    }
	    
	    mav.addObject("imageFileList", reviewImageList);	    
		return mav;
	}
	
	
	@RequestMapping(value="/keywordSearch.do",method = RequestMethod.GET,produces = "application/text; charset=utf8")
	public @ResponseBody String  keywordSearch(@RequestParam("keyword") String keyword,
			                                  HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		System.out.println(keyword);
		if(keyword == null || keyword.equals(""))
		   return null ;
	
		keyword = keyword.toUpperCase();
	    List<String> keywordList =goodsService.keywordSearch(keyword);
	    
	 // ���� �ϼ��� JSONObject ����(��ü)
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("keyword", keywordList);
		 		
	    String jsonInfo = jsonObject.toString();
	   // System.out.println(jsonInfo);
	    return jsonInfo ;
	}
	
	@RequestMapping(value="/searchResult.do" ,method = RequestMethod.GET)
	public ModelAndView searchGoods(@RequestParam("searchWord") String searchWord,
			                       HttpServletRequest request, HttpServletResponse response) throws Exception{
		//System.out.println("검색결과 컨트롤러");
		String viewName=(String)request.getAttribute("viewName");
		List<GoodsVO> goodsList=goodsService.searchGoods(searchWord);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("goodsList", goodsList);
		mav.addObject("searchWord",searchWord);
		return mav;
		
	}
	
	@ResponseBody
    @RequestMapping(value = "/addReview.do", method = RequestMethod.POST)
     public ResponseEntity addReview(ReviewVO reviewVO, MultipartHttpServletRequest multipartRequest, 
    		 HttpSession session, HttpServletRequest request, HttpServletResponse response,Model model ) throws Exception {
      response.setContentType("text/html; charset=UTF-8");
      request.setCharacterEncoding("utf-8");
      String message = null;
      ResponseEntity resEntity = null;
      HttpHeaders responseHeaders = new HttpHeaders();
      responseHeaders.add("Content-Type", "text/html; charset=utf-8");
      
      Map<String, Object> reviewMap = new HashMap<String, Object>();
      MemberVO memberVO = (MemberVO)session.getAttribute("memberInfo");
      String mem_id = memberVO.getMem_id();
      
      if(memberVO != null) {      
         reviewVO.setMem_id(mem_id);
      } 
      
      List<ReviewImageVO> imageFileList = upload2(multipartRequest);
		
      if(imageFileList!=null && imageFileList.size()!=0) {    	  
      	for(ReviewImageVO reviewImageVO:imageFileList) {
      		reviewImageVO.setMem_id(mem_id);    
      	}
      }
      
      String imageFileName=null;
      try {
      	// 리뷰추가
      	int rev_no=goodsService.reviewWrite(reviewVO, imageFileList);
      	 model.addAttribute("imageFileList", imageFileList);
      	 // 업로드한 이미지를 상품번호 폴더에 저장합니다.
			if(imageFileList!=null && imageFileList.size()!=0) {
				for(ReviewImageVO reviewImageVO:imageFileList) {
					imageFileName = reviewImageVO.getImg_name();
					File srcFile = new File(GOGI_IMAGE_REPO_PATH2+"\\"+imageFileName);
					File destDir = new File(GOGI_IMAGE_REPO_PATH2+"\\"+rev_no);
					FileUtils.moveFileToDirectory(srcFile, destDir,true);
				}
			}
      }catch(Exception e) {
			if(imageFileList!=null && imageFileList.size()!=0) {
				for(ReviewImageVO  reviewImageVO:imageFileList) {
					imageFileName = reviewImageVO.getImg_name();
					File srcFile = new File(GOGI_IMAGE_REPO_PATH2+"\\"+imageFileName);
					srcFile.delete();
				}
			}
      }

      message  = "<script>";
      message +=" alert('리뷰 등록이 완료되었습니다');";
      message += " location.href='"+request.getContextPath()+"/goods/goodsDetail.do?goods_id=" + reviewVO.getGoods_id() + "';";
      message += " </script>";
      resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
      
      return resEntity;
   }

}
