package com.project.gogi.mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.gogi.common.base.BaseController;
import com.project.gogi.mypage.service.mypageService;
import com.project.gogi.serv.service.ServService;
import com.project.gogi.vo.MemberVO;
import com.project.gogi.vo.OrderVO;
import com.project.gogi.vo.ReviewVO;
import com.project.gogi.vo.ServVO;

@Controller("mypageController")
@RequestMapping(value = "/mypage")
public class mypageControllerImpl extends BaseController implements mypageController {

	@Autowired
	private MemberVO memberVO;
	@Autowired
	private mypageService mypageService;
	@Autowired
	private ServService servService;

	// 회원 정보
	@Override
	@RequestMapping(value = "/myDetailInfo.do", method = RequestMethod.GET)
	public ModelAndView myDetailInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}

	// 회원 정보 수정
	// 수정할 회원 정보 속성을 저장합니다.
	@Override
	@RequestMapping(value = "/modifyMyInfo.do", method = RequestMethod.POST)
	public ResponseEntity modifyMyInfo(@RequestParam("value") String value, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map<String, String> memberMap = new HashMap<String, String>();
		String val[] = null;
		HttpSession session = request.getSession();
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		String mem_id = memberVO.getMem_id();
		System.out.println(value);

		val = value.split(",");

		memberMap.put("mem_pw", val[0]);
		memberMap.put("mem_tel1", val[1]);
		memberMap.put("mem_tel2", val[2]);
		memberMap.put("mem_tel3", val[3]);
		memberMap.put("zipcode", val[4]);
		memberMap.put("roadAddress", val[5]);
		memberMap.put("jibunAddress", val[6]);
		memberMap.put("namujiAddress", val[7]);
		memberMap.put("mem_email", val[8]);
		
		memberMap.put("mem_id", mem_id);

		// 회원 정보 수정 후 다시 갱신된 회원 정보를 조회합니다.
		memberVO = (MemberVO) mypageService.modifyMyInfo(memberMap);

		// 세션에 저장된 기존 회원 정보를 삭제한 후 갱신된 회원 정보를 저장합니다.
		session.removeAttribute("memberInfo");
		session.setAttribute("memberInfo", memberVO);

		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		message = "mod_success";
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	//주문 내역
	@Override
	@RequestMapping(value="/listMyOrderHistory.do" ,method = RequestMethod.GET)
	public ModelAndView listMyOrderHistory(@RequestParam Map<String, String> dateMap,
			                               HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		String mem_id=memberVO.getMem_id();
		
		String fixedSearchPeriod = dateMap.get("fixedSearchPeriod");
		String beginDate=null,endDate=null;
		
		String [] tempDate = calcSearchPeriod(fixedSearchPeriod).split(",");
		beginDate=tempDate[0];
		endDate=tempDate[1];
		dateMap.put("beginDate", beginDate);
		dateMap.put("endDate", endDate);
		dateMap.put("mem_id", mem_id);
		List<OrderVO> myOrderHistList=mypageService.listMyOrderHistory(dateMap);
		
		String beginDate1[]=beginDate.split("-"); //검색일자를 년,월,일로 분리해서 화면에 전달합니다.
		String endDate1[]=endDate.split("-");
		mav.addObject("beginYear",beginDate1[0]);
		mav.addObject("beginMonth",beginDate1[1]);
		mav.addObject("beginDay",beginDate1[2]);
		mav.addObject("endYear",endDate1[0]);
		mav.addObject("endMonth",endDate1[1]);
		mav.addObject("endDay",endDate1[2]);
		mav.addObject("myOrderHistList", myOrderHistList);
		mav.addObject("mem_id", mem_id);
		return mav;
	}	
	
	//주문 삭제
	@Override
	// '주문 취소' 클릭 시 수행합니다.
	@RequestMapping(value="/cancelMyOrder.do" ,method = RequestMethod.POST)							
	public ModelAndView cancelMyOrder(@RequestParam("order_id")  String order_id,
			                          HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		// 주문을 취소합니다.
		mypageService.cancelOrder(order_id);
		
		// 주문 메시지를 다시 마이페이지 최초 화면으로 전달합니다.
		mav.addObject("message", "cancel_order");
		
		mav.setViewName("redirect:/mypage/listMyOrderHistory.do");
		
		return mav;
	}
	
	//회원 삭제
	@Override
	@RequestMapping(value="/deleteMember.do", method = RequestMethod.POST)
	public ModelAndView deleteMember(@RequestParam("mem_id") String mem_id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession();
		session.setAttribute("isLogon", true);
		session.setAttribute("memberInfo", memberVO);
		mypageService.deleteMember(mem_id);
		ModelAndView mav = new ModelAndView("redirect:/main/main.do");
		return mav;
	}
	
	//내가 쓴글 확인 
	@Override
	@RequestMapping(value="/myWriteList.do")
	public ModelAndView myWrite(HttpServletRequest request, HttpServletResponse response)throws Exception {
		ModelAndView mav = new ModelAndView("/mypage/myWriteList");
		
		HttpSession session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		String mem_id=memberVO.getMem_id();
		
		List<ReviewVO> reviewVO= mypageService.reviewList(mem_id);
		mav.addObject("reviewVO", reviewVO);
		
		List<ServVO> servVO=servService.reviewList(mem_id);
		mav.addObject("servVO", servVO);
		return mav;
	}
	
	//마이 리뷰 삭제
	@Override
	@RequestMapping(value="/myReivewDelete.do")
	public ModelAndView myReviewDelete(@RequestParam("rev_no") int rev_no, HttpServletRequest request, HttpServletResponse response) throws Exception {		
		mypageService.reviewDelete(rev_no);
		return new ModelAndView("redirect:/mypage/myWriteList.do");
	}
	
	
	// /mypage/*Form.do 처리
	@RequestMapping(value = "/*Form.do", method = RequestMethod.GET)
	public ModelAndView form(@RequestParam(value = "result", required = false) String result,
			@RequestParam(value = "action", required = false) String action,
			@RequestParam(value = "goods_id", required = false) String goods_id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		HttpSession session = request.getSession();
		session.setAttribute("action", action);
		if (goods_id != null) {
			session.setAttribute("goods_id", goods_id);
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName(viewName);
		return mav;
	}

	



}
