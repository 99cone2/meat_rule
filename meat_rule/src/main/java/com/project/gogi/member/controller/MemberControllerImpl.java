package com.project.gogi.member.controller;

import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.gogi.common.base.BaseController;
import com.project.gogi.member.service.MemberService;
import com.project.gogi.vo.MemberVO;

@Controller("memberController")
@RequestMapping(value="/member")
public class MemberControllerImpl extends BaseController implements MemberController{
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MemberVO memberVO;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Override
	@RequestMapping(value = "/loginForm.do", method = RequestMethod.POST)
	public ModelAndView loginForm(@RequestParam Map<String, String> loginMap, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		memberVO = memberService.loginForm(loginMap);
		if(memberVO!= null && memberVO.getMem_id()!=null) {
			if(memberVO.getMem_del_yn().equals("Y")){
				String message = "탈퇴한 회원입니다.";
				mav.addObject("message", message);
				mav.setViewName("/member/loginForm");
			} else if(memberVO.getMem_del_yn().equals("B")) {
				String message = "비활성화된 회원입니다";
				mav.addObject("message", message);
				mav.setViewName("/member/loginForm");
			} else {
			HttpSession session = request.getSession();
			session.setAttribute("isLogon", true);
			session.setAttribute("memberInfo", memberVO);
			System.out.println("로그인"+memberVO.getMem_id());
			
	        // 관리자 계정 확인: memberVO에서 관리자 이메일 또는 ID를 확인하고 세션에 isAdmin 값을 설정.
	        if (memberVO.getMem_id().equals("admin")) {
	            session.setAttribute("isAdmin", true);
	        } else {
	            session.setAttribute("isAdmin", false);
	        }
	        System.out.println(memberVO.getMem_id()+ " 로그인 완료");
			session = request.getSession(true);	     
	        mav.setViewName("redirect:/main/main.do");
			}
		}else{
			String message="아이디나 비밀번호가 틀립니다. 다시 로그인해주세요";
			mav.addObject("message", message);
			mav.setViewName("/member/loginForm");
		}
		return mav;
	}
	
	// 로그아웃 사용 시 컨트롤러
	@Override
	@RequestMapping(value="/logout.do" ,method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    ModelAndView mav = new ModelAndView();
	    HttpSession session = request.getSession(false); // 기존 세션을 가져옴

	    if (session != null) {
	        session.invalidate(); // 세션 무효화

	        // 새로운 세션 생성
	        session = request.getSession(true);
	        session.setAttribute("isLogOn", false);
	        System.out.println(memberVO.getMem_id()+ " 로그아웃 완료");
	    }

	    mav.setViewName("redirect:/main/main.do");
	    return mav;
	}
	
	// 회원가입 사용 시 컨트롤러
	@Override
	@RequestMapping(value="/memberForm.do" ,method = RequestMethod.POST)
									// 회원 가입 창에서 전송된 회원 정보를 _memberVO에 설정합니다.
	public ResponseEntity addMember(@ModelAttribute("memberVO") MemberVO _memberVO,
			                		HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			// 회원 정보를 SQL문으로 전달합니다.
		    memberService.insertNewMember(_memberVO);
		    
		    message  = "<script>";
		    message +=" alert('회원 가입이 완료됐습니다! 로그인창으로 이동합니다.');";
		    message += " location.href='"+request.getContextPath()+"/member/loginForm.do';";
		    message += " </script>";
		    
		}catch(Exception e) {
			message  = "<script>";
		    message +=" alert('작업 중 오류가 발생했습니다. 다시 시도해 주세요.');";
		    message += " location.href='"+request.getContextPath()+"/member/memberForm.do';";
		    message += " </script>";
			e.printStackTrace();
		}
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	// 아이디 중복 검사 시 실행
	@Override
	@RequestMapping(value="/checkId.do", method = RequestMethod.POST)
	public ResponseEntity checkId(@RequestParam("mem_id") String id,
									 HttpServletRequest request, HttpServletResponse response) throws Exception{
		ResponseEntity resEntity = null;
		String result = memberService.checkId(id); // ID 중복 검사를 합니다.
		resEntity = new ResponseEntity(result, HttpStatus.OK);
		return resEntity;
	}

	// mailSending 코드
	@RequestMapping(value ="emailConfirm.do", method = RequestMethod.POST)
	@ResponseBody
	public String mailSending(@RequestParam("mem_email") String email) throws Exception{

		//뷰에서 넘어왔는지 확인
	    System.out.println("이메일 전송");
		//난수 생성(인증번호)
		Random r = new Random();
		int num = r.nextInt(888888) + 111111;  //111111 ~ 999999
		System.out.println("인증번호:" + num);
		
		/* 이메일 보내기 */
        String setFrom = "rmsi5@naver.com";
        String toMail = email;
        String title = "회원가입 인증 이메일 입니다.";
        String content = 
                "육룰 홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + num + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
              
        }catch(Exception e) {
            e.printStackTrace();
        }
        // 위 try catch 문은 이메일 전송 프로세스 중에 발생하는 예외 포착 
        String rnum = Integer.toString(num);  //view로 다시 반환할 때 String만 가능
        
        return rnum;
	}
	
	// member/*Form.do 일괄처리 메서드 
	@RequestMapping(value = "/*Form.do", method = RequestMethod.GET)
	public ModelAndView form(@RequestParam(value = "result", required = false) String result,
							 @RequestParam(value = "action", required = false) String action,
							 @RequestParam(value = "goods_id", required = false) String goods_id,
							 HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		HttpSession session = request.getSession();
		session.setAttribute("action", action);
		if(goods_id != null) {
			session.setAttribute("goods_id", goods_id);
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName(viewName);
		return mav;
	}
	
}