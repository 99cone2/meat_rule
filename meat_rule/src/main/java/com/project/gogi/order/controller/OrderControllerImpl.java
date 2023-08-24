package com.project.gogi.order.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.gogi.cart.service.CartService;
import com.project.gogi.common.base.BaseController;
import com.project.gogi.order.service.OrderService;
import com.project.gogi.vo.CartVO;
import com.project.gogi.vo.GoodsVO;
import com.project.gogi.vo.MemberVO;
import com.project.gogi.vo.OrderVO;



@Controller
@RequestMapping(value="/order")
public class OrderControllerImpl extends BaseController implements OrderController{
	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderVO orderVO;
	@Autowired
	private CartService cartService; //장바구니 삭제하기 위함

	@Override
	@RequestMapping(value="/orderEachGoods.do", method=RequestMethod.POST)
	public ModelAndView orderEachGoods(@ModelAttribute("orderVO") OrderVO _orderVO, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("orderEachGoods method called!");
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		Boolean isLogOn=(Boolean) session.getAttribute("isLogon"); //로그인 여부
		
		String action=(String) session.getAttribute("action");
		
		//로그인 상태가 아니라면 먼저 로그인후 주문을 처리하도록 주문정보와 주문페이지 요청 URL을 세션에 저장
		if(isLogOn==null || isLogOn==false) {
			session.setAttribute("orderInfo", _orderVO);
			session.setAttribute("action", "/order/orderEachGoods.do");
			return new ModelAndView("redirect:/member/loginForm.do");
		}else {//로그인 후 세션에서 주문정보 가져와 주문창으로 이동
			if(action!=null && action.equals("/order/orderEachGoods.do")) {
				orderVO=(OrderVO) session.getAttribute("orderInfo");
				session.removeAttribute("action");
			}else { //미리 로그인 했다면 바로 주문 처리
				orderVO=_orderVO;
			}
		}
		
		String viewName=(String) request.getAttribute("viewName");
		ModelAndView mav=new ModelAndView(viewName);
		List myOrderList=new ArrayList<OrderVO>(); //주문정보 저장할 ArrayList 생성
		myOrderList.add(orderVO);//주문정보 저장
		MemberVO memberInfo=(MemberVO) session.getAttribute("memberInfo");
		session.setAttribute("myOrderList", myOrderList); //주문정보 세션에 바인딩
		session.setAttribute("orderer", memberInfo);//주문자정보 세션에 바인딩
		//로그인 여부 
		mav.addObject("isLogOn", isLogOn);
		
		return mav;
	}
	
	
	@RequestMapping(value = "/orderCartGoods.do", method = RequestMethod.POST)
	public ModelAndView orderAllCartGoods(@RequestParam("cart_qty") String[] cart_qty,
	HttpServletRequest request, HttpServletResponse response) throws Exception {	
		ModelAndView mav = new ModelAndView("orderCartGoods");
		HttpSession session = request.getSession();

		Map cartMap = (Map) session.getAttribute("cartMap");
		
		List myOrderList = new ArrayList<OrderVO>();
		List<GoodsVO> myGoodsList = (List<GoodsVO>) cartMap.get("myGoodsList");
		
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		System.out.println("myGoodsList:"+myGoodsList.toString()+"myGoodsList size:"+myGoodsList.size());
		for (int i = 0; i < cart_qty.length; i++) {
			String[] cart_goods = cart_qty[i].split(":");
			for (int j = 0; j < myGoodsList.size(); j++) {
				GoodsVO goodsVO = myGoodsList.get(j);
				int goods_id = goodsVO.getGoods_id();
				if (goods_id == Integer.parseInt(cart_goods[0])) {
					OrderVO _orderVO = new OrderVO();
					String goods_name = goodsVO.getGoods_name();
					int goods_sales_price = goodsVO.getGoods_price();
					System.out.println("가격:"+goods_sales_price);
					String file_name = goodsVO.getFile_name();
					
					int goods_point = goodsVO.getGoods_point();
					_orderVO.setGoods_id(goods_id);
					_orderVO.setGoods_name(goods_name);
					_orderVO.setGoods_sales_price(goods_sales_price);
					//_orderVO.setGoods_delivery_price(goods_delivery_price);
					_orderVO.setFile_name(file_name);
					_orderVO.setOrder_quantity(Integer.parseInt(cart_goods[1]));
					myOrderList.add(_orderVO);
					break;
				}
			}
		}
		session.setAttribute("myOrderList", myOrderList);
		session.setAttribute("orderer", memberVO);
		
		return mav;
	}

	
	//상품 결제
	@Override
	@RequestMapping(value="/payToOrderGoods.do", method=RequestMethod.POST)
	public ModelAndView payToOrderGoods(@RequestParam Map<String, String> receiverMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName=(String) request.getAttribute("viewName");
		ModelAndView mav=new ModelAndView(viewName);
		
		HttpSession session=request.getSession();
		MemberVO memberVO=(MemberVO) session.getAttribute("orderer");
		
		String mem_id=memberVO.getMem_id();
		String orderer_name=memberVO.getMem_name();
		String ordere_hp=memberVO.getMem_tel1()+"-"+memberVO.getMem_tel2()+"-"+memberVO.getMem_tel3();		
		List<OrderVO> myOrderList=(List<OrderVO>) session.getAttribute("myOrderList");	
	
		for(int i=0; i<myOrderList.size();i++) {
			OrderVO orderVO=(OrderVO)myOrderList.get(i);
			orderVO.setMem_id(mem_id);
			orderVO.setMem_name(orderer_name);
			orderVO.setPay_orderer_hp_num(ordere_hp);
			orderVO.setOrder_rec_name(receiverMap.get("order_rec_name"));
			orderVO.setOrder_rec_hp1(receiverMap.get("order_rec_hp1"));
			orderVO.setOrder_rec_hp2(receiverMap.get("order_rec_hp2"));
			orderVO.setOrder_rec_hp3(receiverMap.get("order_rec_hp3"));
			orderVO.setOrder_delivery_address(receiverMap.get("order_delivery_address"));
			orderVO.setOrder_delivery_message(receiverMap.get("order_delivery_message"));
			orderVO.setOrder_deli_hope_date(receiverMap.get("order_deli_hope_date"));
			orderVO.setOrder_pay_method(receiverMap.get("order_pay_method"));
			//orderVO.setOrder_delivery_option(receiverMap.get("order_delivery_option"));
			orderVO.setCard_company_name(receiverMap.get("card_company_name"));
			orderVO.setCard_pay_month(receiverMap.get("card_pay_month"));
			orderVO.setPay_orderer_hp_num(receiverMap.get("pay_orderer_hp_num"));
			// final_total_price를 숫자로 변환하여 저장합니다.
				    try {
				        int finalTotalPrice = Integer.parseInt(receiverMap.get("final_total_price"));
				        orderVO.setFinal_total_price(finalTotalPrice);
				    } catch (NumberFormatException e) {
				        // 숫자로 변환할 수 없는 경우에 대한 예외 처리
				        orderVO.setFinal_total_price(0);
				    }		   
				    try {
				    	int use_point = Integer.parseInt(receiverMap.get("use_point"));
				    	orderVO.setUse_point(use_point);
				    	
				    	//현재 보유 포인트
				        int mypoint=memberVO.getMem_point();
				        //System.out.println("보유한 포인트:"+mypoint);
					 	
				        //사용하고 난 다음 포인트
				        int mem_point=mypoint-use_point;  
				        //System.out.println("남은 포인트:"+mem_point);
				        memberVO.setMem_point(mem_point);
				        orderService.updateMemPoint(memberVO);
				    } catch (NumberFormatException e) {
				    	// 숫자로 변환할 수 없는 경우에 대한 예외 처리
				    	orderVO.setUse_point(0);
				    }
		    
			orderVO.setOrder_delivery_status("delivery_prepared");
			myOrderList.set(i, orderVO);
		}
		
		
		orderService.addNewOrder(myOrderList);
		System.out.println("add pay:" +myOrderList.toString());
		mav.addObject("myOrderInfo", receiverMap);
		mav.addObject("myOrderList", myOrderList);
		
		System.out.println("receiverMap : " + receiverMap.toString());
		System.out.println("myOrderList : " + myOrderList.toString());
		
		//주문 후 장바구니 내역 삭제
		Map cartMap = (Map) session.getAttribute("cartMap"); //cartMap 세션	
		
		if(cartMap != null) {//장바구니 거치지않고 상품상세페이지에서 바로 주문하는 경우와 구분하기 위해 if문 사용
		    List<CartVO> myCartList = (List<CartVO>) cartMap.get("myCartList");//cartMap 세션에서 myCartList 가져옴
		    System.out.println("장바구니삭제:"+myCartList.containsAll(myCartList)+" : "+myCartList.get(0));
		    if (myCartList != null && !myCartList.isEmpty()) {
		        for (CartVO cartVO : myCartList) {
		            int cart_no = cartVO.getCart_no();
		            cartService.deleteGoods(cart_no); //해당 cart_no 삭제
		        }
		    }
		}
		
		//session.removeAttribute("myOrderList");
		
		return mav;
	}
}