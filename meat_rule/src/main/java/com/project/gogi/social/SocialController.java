package com.project.gogi.social;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.gogi.vo.MemberVO;

@Controller("socialController")
@RequestMapping(value="/social")
public class SocialController {
	
	@Autowired
	private SocialService socialService;
	
	@RequestMapping(value="/kakao_login.do")
	public String kakaoLogin() {
		StringBuffer loginUrl = new StringBuffer();
		loginUrl.append("https://kauth.kakao.com/oauth/authorize?client_id=");
		loginUrl.append("4fb1697c90371b19154002a41beb7e3d");
		loginUrl.append("&redirect_uri=http://localhost:9091/social/kakao_callback");
		loginUrl.append("&response_type=code");
		
		return "redirect:"+loginUrl.toString();
	}
	
	@RequestMapping(value="/kakao_callback", method = RequestMethod.GET)
	public String redirectkakao(@RequestParam String code, HttpSession session) throws IOException {
		System.out.println(code);
		
		//접속토큰 get
		String kakaoToken = socialService.getReturnAccessToken(code);
		System.out.println(kakaoToken);
		//접속자 정보 get
		MemberVO result = socialService.getUserInfo(kakaoToken);

		session.setAttribute("memberInfo", result);
		//로그아웃 처리 시, 사용할 토큰 값
		session.setAttribute("kakaoToken", kakaoToken);
		session.setAttribute("isLogon", true);
		
		return "redirect:/main/main.do";
	}
	
	@RequestMapping(value="/kakao_logout.do" ,method = RequestMethod.GET)
	public ModelAndView kakaologout(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    ModelAndView mav = new ModelAndView();
	    HttpSession session = request.getSession(false); // 기존 세션을 가져옴

	    if (session != null) {
	        session.invalidate(); // 세션 무효화

	        // 새로운 세션 생성
	        session = request.getSession(true);
	        session.setAttribute("isLogOn", false);
	    }
	    mav.setViewName("redirect:/main/main.do");
	    return mav;
	}
}
