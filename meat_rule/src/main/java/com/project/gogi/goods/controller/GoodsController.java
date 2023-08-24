package com.project.gogi.goods.controller;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.project.gogi.vo.ReviewVO;

public interface GoodsController {
	public ModelAndView shop(HttpServletRequest request, HttpServletResponse response, @RequestParam(required = false) String category) throws Exception;
	public ModelAndView goodsDetail(@RequestParam("goods_id") int goods_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public @ResponseBody String  keywordSearch(@RequestParam("keyword") String keyword, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView searchGoods(@RequestParam("searchWord") String searchWord, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity addReview(ReviewVO reviewVO, MultipartHttpServletRequest multipartRequest,  HttpSession session, HttpServletRequest request, HttpServletResponse response,Model model ) throws Exception;
}
