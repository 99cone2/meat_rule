package com.project.gogi.mypage.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface mypageController {
	
	//로그인 정보 확인
	public ModelAndView myDetailInfo(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	//개인정보 수정
	public ResponseEntity modifyMyInfo(@RequestParam("value")  String value,
     	   HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	//주문 내역
	public ModelAndView listMyOrderHistory(@RequestParam Map<String, String> dateMap,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	//주문 취소
	public ModelAndView cancelMyOrder(@RequestParam("order_id")  String order_id,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	//회원 삭제
	public ModelAndView deleteMember(@RequestParam("mem_id") String mem_id, HttpServletRequest request,
			HttpServletResponse response) throws Exception;
	
	//폼 처리
	public  ModelAndView form(@RequestParam(value = "result", required = false) String result,
			@RequestParam(value = "goods_id", required = false) String goods_id,
			@RequestParam(value = "action", required = false) String action, HttpServletRequest request,
			HttpServletResponse response) throws Exception;
	
	//마이 리뷰, 1:1문의
	public ModelAndView myWrite( HttpServletRequest request, HttpServletResponse response) throws Exception;
		
	//마이 리뷰 삭제
	public ModelAndView myReviewDelete(@RequestParam("rev_no") int rev_no, HttpServletRequest request, HttpServletResponse response) throws Exception;
}
