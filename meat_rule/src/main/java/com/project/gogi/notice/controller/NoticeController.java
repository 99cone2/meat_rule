package com.project.gogi.notice.controller;


import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.gogi.notice.service.NoticeService;
import com.project.gogi.vo.Criteria;
import com.project.gogi.vo.MemberVO;
import com.project.gogi.vo.NoticeVO;
import com.project.gogi.vo.PageMaker;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	private static final Logger logger =  LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	NoticeService service;
	
	@Autowired
	private HttpSession httpSession;
	@Autowired
	private NoticeVO noticeVO;
	@Autowired
	private MemberVO memberVO;


	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public String getNoticeList(Model model, Criteria cri, HttpServletRequest request, 
	                            HttpServletResponse response) throws Exception {
	    
	    List<NoticeVO> noticeList=service.NoticeList(cri);
	    
	    List<NoticeVO> noticeFAQList=service.NoticeFAQList(cri);
	    
	    model.addAttribute("noticeList", noticeList);
	    model.addAttribute("noticeFAQList", noticeFAQList);
	    

	    //게시판 페이징 가져오기.
	    PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    pageMaker.setTotalCount(service.NoticeListCount());
	    model.addAttribute("pageMaker", pageMaker);

	    
	    
	    Boolean isLogOn = (Boolean) httpSession.getAttribute("isLogon"); //로그인 여부

	    if (isLogOn != null && isLogOn) { //로그인 상태 아니여도 공지사항 읽기 가능
	        memberVO = (MemberVO) httpSession.getAttribute("memberInfo");
	        System.out.println("세션:" + memberVO);
	        String mem_id = memberVO.getMem_id();
	        System.out.println("멤버아이디" + mem_id);
	        System.out.println("로그인 여부: "+isLogOn);
	        model.addAttribute("mem_id",mem_id);
	        model.addAttribute("isLogOn", isLogOn);
	    }

	    return "notice/noticeList";
	}

		
	
	  // 게시물 작성 get
	  @RequestMapping(value = "/write.do", method = RequestMethod.GET) 
	  public String   getNoticeWrite(Model model) throws Exception {
		  Boolean isLogOn = (Boolean) httpSession.getAttribute("isLogon"); //로그인 여부

		    if (isLogOn != null && isLogOn) { //로그인 상태 아니여도 공지사항 읽기 가능
		        memberVO = (MemberVO) httpSession.getAttribute("memberInfo");
		        System.out.println("세션:" + memberVO);
		        String mem_id = memberVO.getMem_id();
		        System.out.println("멤버아이디" + mem_id);
		        System.out.println("로그인 여부: "+isLogOn);
		        model.addAttribute("mem_id",mem_id);
		        model.addAttribute("isLogOn", isLogOn);
		    }
	  return "notice/noticeWrite";
	  }
	  
	  
	  // 게시물 작성 post
	  @RequestMapping(value = "/write.do", method = RequestMethod.POST)
	  public String  postNoticeWrite(Model model,NoticeVO vo) throws Exception {
		  
		  service.NoticeWrite(vo);
	  //모든 작업을 마치고 목록 화면으로 이동하겠다는 뜻
	  return "redirect:/notice/list.do"; }
	  
	  
		//게시물 조회 + 조회수 중복방지
		@RequestMapping(value = "/read.do", method = RequestMethod.GET)
		public String getView(@RequestParam("notice_no")int notice_no, Model model, NoticeVO vo ) throws Exception {
		 	
			//구분 객체 생성, 세션 값 가져오기 (getAttribute : 세션에서 대이터 가져올때 사용), 저장
			//set : 객체 중복 x
			Set<Integer>  notice_noViewHits=(Set<Integer>) httpSession.getAttribute("notice_noViewHits");

			//초기 notice_noViewHits null일 때 처리 / 값 만들기...
			// hashSet 데이터 중복x , 순서 상관 없음 (하나라 괜츈)
			if (notice_noViewHits == null) {
				notice_noViewHits = new HashSet<>();
				httpSession.setAttribute("notice_noViewHits",notice_noViewHits);
				}
				

			// notice_noViewHits에 들어있지 않은 값일 때 처리하는 로직-최조 클릭 게시물 조회수 +1 증가 후 notice_noViewHits에 해당 notice_no 저장
					if(!notice_noViewHits.contains(notice_no))	{
						service.updateNoticeViewCnt(notice_no);	
						notice_noViewHits.add(notice_no);
					}
			
			//게시물 조회
			vo= service.NoticeRead(notice_no);
			model.addAttribute("noticeRead", vo);
			
			//0730 오동림 추가 start
			Boolean isLogOn = (Boolean) httpSession.getAttribute("isLogon"); //로그인 여부

		    if (isLogOn != null && isLogOn) { //로그인 상태 아니여도 공지사항 읽기 가능
		        memberVO = (MemberVO) httpSession.getAttribute("memberInfo");
		        String mem_id = memberVO.getMem_id();			       
		        model.addAttribute("mem_id",mem_id);
		        model.addAttribute("isLogOn", isLogOn);
		    }  // 추가 end
		
			 return "notice/noticeRead";
		}
		
	  
		//게시물 수정
		@RequestMapping(value = "/modify.do", method = RequestMethod.GET)
		public String getModify(@RequestParam("notice_no")int notice_no, Model model) throws Exception{
			NoticeVO vo= service.NoticeRead(notice_no);
			model.addAttribute("noticeRead", vo);
		
			return "notice/noticeModify";
		}
		

		// 게시물 수정
		@RequestMapping(value = "/modify.do", method = RequestMethod.POST)
		public String postModify(NoticeVO vo) throws Exception {

		service.NoticeUpdate(vo);
	
			//redirect는 value 경로 넣어주기..꼭!!!!!!
		 return "redirect:/notice/read.do?notice_no=" + vo.getNotice_no();
		}
		  
	  
		// 게시물 삭제
		@RequestMapping(value = "/delete.do", method = RequestMethod.GET)
		public String getDelete(@RequestParam("notice_no") int notice_no) throws Exception {
		  
		 service.NoticeDelete(notice_no);  
		 return "redirect:/notice/list.do";
		}
		
		
	  //FAQ~
	
			
			//String void 다시 확인해보기
			
			  // 게시물 작성 get
			  @RequestMapping(value = "/faqwrite.do", method = RequestMethod.GET) 
			  public String   getNoticeFAQWrite(Model model) throws Exception {
				  Boolean isLogOn = (Boolean) httpSession.getAttribute("isLogon"); //로그인 여부

				    if (isLogOn != null && isLogOn) { //로그인 상태 아니여도 공지사항 읽기 가능
				        memberVO = (MemberVO) httpSession.getAttribute("memberInfo");
				        System.out.println("세션:" + memberVO);
				        String mem_id = memberVO.getMem_id();
				        System.out.println("멤버아이디" + mem_id);
				        System.out.println("로그인 여부: "+isLogOn);
				        model.addAttribute("mem_id",mem_id);
				        model.addAttribute("isLogOn", isLogOn);
				    }
			  return "notice/noticeFAQWrite";
			  }
			  
			  
			  // 게시물 작성 post
			  @RequestMapping(value = "/faqwrite.do", method = RequestMethod.POST)
			  public String  postNoticeFAQWrite(Model model,NoticeVO vo) throws Exception {
				 
				  service.NoticeFAQWrite(vo);
			  //모든 작업을 마치고 목록 화면으로 이동하겠다는 뜻
			  return "redirect:/notice/list.do"; }
			  
			  
				//게시물 조회 + 조회수 중복방지
				@RequestMapping(value = "/faqread.do", method = RequestMethod.GET)
				public String getFAQView(@RequestParam("notice_no_faq")int notice_no_faq, Model model, NoticeVO vo ) throws Exception {
				 	
					//구분 객체 생성, 세션 값 가져오기 (getAttribute : 세션에서 대이터 가져올때 사용), 저장
					//set : 객체 중복 x
					Set<Integer>  notice_no_faqViewHits=(Set<Integer>) httpSession.getAttribute("notice_no_faqViewHits");

					//초기 notice_noViewHits null일 때 처리 / 값 만들기...
					// hashSet 데이터 중복x , 순서 상관 없음 (하나라 괜츈)
					if (notice_no_faqViewHits == null) {
						notice_no_faqViewHits = new HashSet<>();
						httpSession.setAttribute("notice_no_faqViewHits",notice_no_faqViewHits);
						}
						

					// notice_noViewHits에 들어있지 않은 값일 때 처리하는 로직-최조 클릭 게시물 조회수 +1 증가 후 notice_noViewHits에 해당 notice_no 저장
							if(!notice_no_faqViewHits.contains(notice_no_faq))	{
								service.updateNoticeFAQViewCnt(notice_no_faq);	
								notice_no_faqViewHits.add(notice_no_faq);
							}
					
					//게시물 조회
					vo= service.NoticeFAQRead(notice_no_faq);
					model.addAttribute("noticeFAQRead", vo);
					
					 
				    Boolean isLogOn = (Boolean) httpSession.getAttribute("isLogon"); //로그인 여부

				    if (isLogOn != null && isLogOn) { //로그인 상태 아니여도 공지사항 읽기 가능
				        memberVO = (MemberVO) httpSession.getAttribute("memberInfo");
				        System.out.println("세션:" + memberVO);
				        String mem_id = memberVO.getMem_id();
				        System.out.println("멤버아이디" + mem_id);
				        System.out.println("로그인 여부: "+isLogOn);
				        model.addAttribute("mem_id",mem_id);
				        model.addAttribute("isLogOn", isLogOn);
				    }
					
				
					 return "notice/noticeFAQRead";
				}
				
			  
				//게시물 수정
				@RequestMapping(value = "/faqmodify.do", method = RequestMethod.GET)
				public String getFAQModify(@RequestParam("notice_no_faq")int notice_no_faq, Model model) throws Exception{
					NoticeVO vo= service.NoticeFAQRead(notice_no_faq);
					model.addAttribute("noticeFAQRead", vo);
				
					return "notice/noticeFAQModify";
				}
				

				// 게시물 수정
				@RequestMapping(value = "/faqmodify.do", method = RequestMethod.POST)
				public String postFAQModify(NoticeVO vo,@RequestParam("notice_no_faq")int notice_no_faq) throws Exception {
 
					service.NoticeFAQUpdate(vo);
			
					//redirect는 value 경로 넣어주기..꼭!!!!!!
				 return "redirect:/notice/faqread.do?notice_no_faq=" + vo.getNotice_no_faq();
				}
				  
			  
				// 게시물 삭제
				@RequestMapping(value = "/faqdelete.do", method = RequestMethod.GET)
				public String getFAQDelete(@RequestParam("notice_no_faq") int notice_no_faq) throws Exception {
				  
				 service.NoticeFAQDelete(notice_no_faq);  
				 return "redirect:/notice/list.do";
				}
		
}	 
