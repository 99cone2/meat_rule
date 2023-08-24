package com.project.gogi.main.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.project.gogi.goods.service.GoodsService;
import com.project.gogi.vo.GoodsVO;

@Controller("mainController")
@RequestMapping(value = "/main")
public class MainController {
	@Autowired
	private GoodsService goodsService;

	@RequestMapping(value = "/main.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session;
		ModelAndView mav = new ModelAndView();
		String viewName = (String) request.getAttribute("viewName");
		mav.setViewName(viewName);
		session = request.getSession();
	
		Map<String, List<GoodsVO>> goodsMap = goodsService.listMainGoods();
		mav.addObject("goodsMap", goodsMap);
		//System.out.println("controller" + goodsMap);
		return mav;
	}

	// 배송안내 페이지
	@RequestMapping(value = "/delivery.do", method = RequestMethod.GET)
	public String deliveryPage() {
		return "delivery/delivery";
	}

	// 공지사항 페이지
	@RequestMapping(value = "/notice.do", method = RequestMethod.GET)
	private String noticePage() {
		return "notice/notice";

	}

}
