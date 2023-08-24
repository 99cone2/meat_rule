package com.project.gogi.admin.goods.controller;

import java.io.File;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.project.gogi.admin.goods.service.AdminGoodsService;
import com.project.gogi.common.base.BaseController;
import com.project.gogi.vo.GoodsVO;
import com.project.gogi.vo.ImageFileVO;
import com.project.gogi.vo.MemberVO;


@Controller("adminGoodsController")
@RequestMapping(value="/admin/goods")
public class AdminGoodsControllerImpl extends BaseController implements AdminGoodsController{
	private static final String CURR_IMAGE_REPO_PATH = "C:\\meatrule\\file_repo\\goods";
	
	@Autowired
	private AdminGoodsService adminGoodsService;
	
	@RequestMapping(value="/adminGoodsMain.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView adminGoodsMain(@RequestParam Map<String, String> dateMap,
			                           HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		session=request.getSession();
		//session.setAttribute("side_menu", "admin_mode"); //마이페이지 사이드 메뉴로 설정한다.
		
		String fixedSearchPeriod = dateMap.get("fixedSearchPeriod");
		
		//페이징
		String sectionStr = dateMap.get("section");
		String pageNumStr = dateMap.get("pageNum");
		//section과 pageNum에 기본값 1 설정
		int section = (sectionStr != null && !sectionStr.isEmpty()) ? Integer.parseInt(sectionStr) : 1;
		int pageNum = (pageNumStr != null && !pageNumStr.isEmpty()) ? Integer.parseInt(pageNumStr) : 1;
		//한 페이지에 보여질 글 개수
		int pageSize = 10;
		// offset 계산
	    int offset = (pageNum - 1) * pageSize;
		int total=adminGoodsService.goodsCount();
		// totalPageCount 계산
		int totalPageCount = (int) Math.ceil((double) total / pageSize);
		System.out.println("#######totalPageCount:"+total+"#######totalPageCount:"+totalPageCount);
		String beginDate=null,endDate=null;
		
		String [] tempDate=calcSearchPeriod(fixedSearchPeriod).split(",");
		beginDate=tempDate[0];
		endDate=tempDate[1];
		
		dateMap.put("beginDate", beginDate);
		dateMap.put("endDate", endDate);
		
		Map<String,Object> condMap=new HashMap<String,Object>();
		System.out.println("페이징 section:"+section+" 페이징 pageNum:"+pageNum+" 페이징 offset:"+offset);
		
		
		condMap.put("section",section);
		condMap.put("pageNum",pageNum);
		condMap.put("offset",offset);
		condMap.put("pageSize",pageSize);
		condMap.put("beginDate",beginDate);
		condMap.put("endDate", endDate);
		List<GoodsVO> newGoodsList=adminGoodsService.listNewGoods(condMap);
		mav.addObject("newGoodsList", newGoodsList);
		String beginDate1[]=beginDate.split("-");
		String endDate2[]=endDate.split("-");
		mav.addObject("beginYear",beginDate1[0]);
		mav.addObject("beginMonth",beginDate1[1]);
		mav.addObject("beginDay",beginDate1[2]);
		mav.addObject("endYear",endDate2[0]);
		mav.addObject("endMonth",endDate2[1]);
		mav.addObject("endDay",endDate2[2]);
		mav.addObject("totalPageCount", totalPageCount);
		mav.addObject("section", section);
		mav.addObject("pageNum", pageNum);
		mav.addObject("total",total);
		return mav;
		
	}
	
	//새로운 상품 추가(제품정보 + 이미지 저장)
	@RequestMapping(value="/addNewGoods.do" ,method={RequestMethod.POST})
	public ResponseEntity addNewGoods(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		String imageFileName=null;
		
		// 매개변수 정보와 파일 정보를 저장할 Map 생성
		Map newGoodsMap = new HashMap();
		Enumeration enu=multipartRequest.getParameterNames();
		
		// 상품 정보를 가져와 Map에 저장합니다.
		while(enu.hasMoreElements()){
			String name=(String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			newGoodsMap.put(name,value);
		}
		
		HttpSession session = multipartRequest.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		
		// 로그인 ID를 가져옵니다.
		String reg_id = memberVO.getMem_id();
		
		// 첨부한 이미지 정보를 가져옵니다.
		List<ImageFileVO> imageFileList =upload(multipartRequest);
		
		// 이미지 정보에 상품 관리자 ID를 속성으로 추가합니다.
		if(imageFileList!= null && imageFileList.size()!=0) {
			for(ImageFileVO imageFileVO : imageFileList) {
				imageFileVO.setReg_id(reg_id);
			}
			newGoodsMap.put("imageFileList", imageFileList);
		}
		
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		try {
			// 상품 정보와 이미지 정보를 각 테이블에 추가합니다.
			int goods_id = adminGoodsService.addNewGoods(newGoodsMap);
			
			// 업로드한 이미지를 상품번호 폴더에 저장합니다.
			if(imageFileList!=null && imageFileList.size()!=0) {
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFile_name();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+imageFileName);
					File destDir = new File(CURR_IMAGE_REPO_PATH+"\\"+goods_id);
					FileUtils.moveFileToDirectory(srcFile, destDir,true);
				}
			}
			
			message= "<script>";
			message += " alert('새상품을 추가했습니다.');";
			message +=" location.href='"+multipartRequest.getContextPath()+"/admin/goods/addNewGoodsForm.do';";
			message +=("</script>");
		}catch(Exception e) {
			if(imageFileList!=null && imageFileList.size()!=0) {
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFile_name();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+imageFileName);
					srcFile.delete();
				}
			}
			
			message= "<script>";
			message += " alert('오류가 발생했습니다. 다시 시도해 주세요');";
			message +=" location.href='"+multipartRequest.getContextPath()+"/admin/goods/addNewGoodsForm.do';";
			message +=("</script>");
			e.printStackTrace();
		}
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	// 상품 정보 수정창을 나타냅니다.
	@RequestMapping(value="/modifyGoodsForm.do" ,method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView modifyGoodsForm(@RequestParam("goods_id") int goods_id,
			                            HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		Map goodsMap=adminGoodsService.goodsDetail(goods_id);
		mav.addObject("goodsMap",goodsMap);
		
		return mav;
	}
	
	//상품정보 수정 요청 처리
	@RequestMapping(value="/modifyGoodsInfo.do" ,method={RequestMethod.POST})
	public ResponseEntity modifyGoodsInfo(@RequestParam("goods_id") String goods_id, @RequestParam("attribute") String attribute,
			                     		  @RequestParam("value") String value,
			                     		  HttpServletRequest request, HttpServletResponse response)  throws Exception {
		//System.out.println("modifyGoodsInfo");
		
		Map<String,String> goodsMap=new HashMap<String,String>();
		
		// Map에 상품 번호와 key/value로 전송된 attribute/value를 저장합니다.
		goodsMap.put("goods_id", goods_id);
		goodsMap.put(attribute, value);
		
		// 상품 정보를 수정합니다.
		adminGoodsService.modifyGoodsInfo(goodsMap);
		
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		message  = "mod_success";
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	//상품 이미지 정보 수정 
	@RequestMapping(value="/modifyGoodsImageInfo.do" ,method={RequestMethod.POST})
	public void modifyGoodsImageInfo(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)  throws Exception {
		System.out.println("modifyGoodsImageInfo");
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String imageFileName=null;
		
		Map goodsMap = new HashMap();
		Enumeration enu=multipartRequest.getParameterNames();
		
		// 수정 이미지 파일 전송 시 함께 전송된 상품 번호와 이미지 번호를 가져옵니다.
		while(enu.hasMoreElements()){
			String name=(String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			goodsMap.put(name,value);
		}
		
		HttpSession session = multipartRequest.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		String reg_id = memberVO.getMem_id();
		
		List<ImageFileVO> imageFileList=null;
		int goods_id=0;
		int image_id=0;
		try {
			// 첨부한 이미지 파일 정보를 가져옵니다.
			imageFileList = upload(multipartRequest);
			
			if(imageFileList!= null && imageFileList.size()!=0) {
				for(ImageFileVO imageFileVO : imageFileList) {
					
					// 이미지 파일 정보에 상품 번호와 이미지 번호를 설정합니다.
					goods_id = Integer.parseInt((String)goodsMap.get("goods_id"));
					image_id = Integer.parseInt((String)goodsMap.get("image_id"));
					
					imageFileVO.setGoods_id(goods_id);
					imageFileVO.setImage_id(image_id);
					imageFileVO.setReg_id(reg_id);
				}
				
				// 이미지 파일 정보를 수정합니다.
			    adminGoodsService.modifyGoodsImage(imageFileList);
			    
			    // 새로 첨부한 이미지 파일을 업로드합니다.
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFile_name();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+imageFileName);
					File destDir = new File(CURR_IMAGE_REPO_PATH+"\\"+goods_id);
					FileUtils.moveFileToDirectory(srcFile, destDir,true);
				}
				
			}
		}catch(Exception e) {
			if(imageFileList!=null && imageFileList.size()!=0) {
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFile_name();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+imageFileName);
					srcFile.delete();
				}
			}
			e.printStackTrace();
		}
		
	}
	
	//기존 상품에 새 이미지 추가 요청
	@Override
	@RequestMapping(value="/addNewGoodsImage.do" ,method={RequestMethod.POST})
	public void addNewGoodsImage(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {
		System.out.println("addNewGoodsImage");
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String imageFileName=null;
		
		Map goodsMap = new HashMap();
		Enumeration enu=multipartRequest.getParameterNames();
		while(enu.hasMoreElements()){
			String name=(String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			goodsMap.put(name,value);
		}
		
		HttpSession session = multipartRequest.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		String reg_id = memberVO.getMem_id();
		
		List<ImageFileVO> imageFileList=null;
		int goods_id=0;
		try {
			imageFileList =upload(multipartRequest);
			if(imageFileList!= null && imageFileList.size()!=0) {
				for(ImageFileVO imageFileVO : imageFileList) {
					goods_id = Integer.parseInt((String)goodsMap.get("goods_id"));
					imageFileVO.setGoods_id(goods_id);
					imageFileVO.setReg_id(reg_id);
				}
				
			    adminGoodsService.addNewGoodsImage(imageFileList);
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFile_name();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+imageFileName);
					File destDir = new File(CURR_IMAGE_REPO_PATH+"\\"+goods_id);
					FileUtils.moveFileToDirectory(srcFile, destDir,true);
				}
			}
		}catch(Exception e) {
			if(imageFileList!=null && imageFileList.size()!=0) {
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFile_name();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+imageFileName);
					srcFile.delete();
				}
			}
			e.printStackTrace();
		}
	}

	////상품 이미지 삭제
	@Override
	@RequestMapping(value="/removeGoodsImage.do" ,method={RequestMethod.POST})
	public void  removeGoodsImage(@RequestParam("goods_id") int goods_id,
			                      @RequestParam("image_id") int image_id,
			                      @RequestParam("imageFileName") String imageFileName,
			                      HttpServletRequest request, HttpServletResponse response)  throws Exception {
		
		adminGoodsService.removeGoodsImage(image_id);
		try{
			File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+goods_id+"\\"+imageFileName);
			srcFile.delete();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//상품 전체 삭제
	@Override
	@RequestMapping(value="/removeGoods.do", method={RequestMethod.POST})
	public void removeGoodsImage(@RequestParam("goods_id") int goods_id,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		adminGoodsService.removeGoods(goods_id);
		
		try{
			File srcFile = new File(CURR_IMAGE_REPO_PATH + "\\" + goods_id);
			
			File[] fileList = srcFile.listFiles();
			
			for(int i = 0; i < fileList.length; i++) {
				fileList[i].delete();
			}
			
			srcFile.delete();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}