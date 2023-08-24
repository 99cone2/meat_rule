package com.project.gogi.admin.member.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.gogi.admin.member.service.AdminMemberService;
import com.project.gogi.common.base.BaseController;
import com.project.gogi.vo.MemberVO;

@Controller("adminMemberController")
@RequestMapping(value="/admin/member")
public class AdminMemberControllerImpl extends BaseController implements AdminMemberController{
	@Autowired
	private AdminMemberService adminMemberService;
	
	@RequestMapping(value="/adminMemberMain.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView adminGoodsMain(@RequestParam Map<String, String> dateMap,
			                           HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		session=request.getSession();
		
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
		int total=adminMemberService.memberCount();
		// totalPageCount 계산
		int totalPageCount = (int) Math.ceil((double) total / pageSize);
		System.out.println("#######totalPageCount:"+total+"#######totalPageCount:"+totalPageCount);
		
		String beginDate=null,endDate=null;
		
		String [] tempDate=calcSearchPeriod(fixedSearchPeriod).split(",");
		beginDate=tempDate[0];
		endDate=tempDate[1];
		dateMap.put("beginDate", beginDate);
		dateMap.put("endDate", endDate);
		
		HashMap<String,Object> condMap=new HashMap<String,Object>();
		
		condMap.put("section",section);
		condMap.put("pageNum",pageNum);
		condMap.put("offset",offset);
		condMap.put("pageSize",pageSize);
		condMap.put("beginDate",beginDate);
		condMap.put("endDate", endDate);
		
		ArrayList<MemberVO> listMember = adminMemberService.listMember(condMap);
		mav.addObject("listMember", listMember);
		System.out.println("회원정보"+listMember);
		
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
	
	@RequestMapping(value="/memberDetail.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView memberDetail(HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		String mem_id = request.getParameter("mem_id");
		MemberVO member_info = adminMemberService.memberDetail(mem_id);
		mav.addObject("member_info",member_info);
		System.out.println("==========회원정보=========="+member_info);
		return mav;
	}
	
	@RequestMapping(value="/modifyMemberInfo.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public void modifyMemberInfo(HttpServletRequest request, HttpServletResponse response)  throws Exception{
		HashMap<String,String> memberMap=new HashMap<String,String>();
		String val[]=null;
		PrintWriter pw=response.getWriter();
		String mem_id=request.getParameter("mem_id");
		String mod_type=request.getParameter("mod_type");
		String value =request.getParameter("value");
		System.out.println("수정할 회원 "+ mem_id);
		System.out.println("수정되는 내용 "+mod_type);
		System.out.println("밸류값 "+value);
		
		if(mod_type.equals("member_birth")){
			val=value.split(",");
			memberMap.put("mem_birth_y",val[0]);
			memberMap.put("mem_birth_m",val[1]);
			memberMap.put("mem_birth_d",val[2]);
			
		}else if(mod_type.equals("mem_tel")){
			val=value.split(",");
			memberMap.put("mem_tel1",val[0]);
			memberMap.put("mem_tel2",val[1]);
			memberMap.put("mem_tel3",val[2]);
			
		}else if(mod_type.equals("mem_email")){
			/* val=value.split(","); */
			memberMap.put("mem_email",value);
			
		}else if(mod_type.equals("address")){
			val=value.split(",");
			memberMap.put("zipcode",val[0]);
			memberMap.put("roadAddress",val[1]);
			memberMap.put("jibunAddress", val[2]);
			memberMap.put("namujiAddress", val[3]);
		}
		
		memberMap.put("mem_id", mem_id);
		adminMemberService.modifyMemberInfo(memberMap);
		pw.print("mod_success");
		pw.close();		
	}
	
	@RequestMapping(value="/deleteMember.do" ,method={RequestMethod.POST})
	public ModelAndView deleteMember(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		ModelAndView mav = new ModelAndView();
		HashMap<String,String> memberMap=new HashMap<String,String>();
		String mem_id=request.getParameter("mem_id");
		String mem_del_yn=request.getParameter("mem_del_yn");
		memberMap.put("mem_del_yn", mem_del_yn);
		memberMap.put("mem_id", mem_id);
		
		adminMemberService.removeMember(mem_id);
		mav.setViewName("redirect:/admin/member/adminMemberMain.do");
		return mav;
	}
	@RequestMapping(value = "/updateStatus.do", method = RequestMethod.POST)
	public void updateStatus(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    try {
	        // AJAX 요청으로부터 전달받은 데이터 추출
	        MemberVO memberVO = new MemberVO();
	        memberVO.setMem_id(request.getParameter("memberId"));
	        memberVO.setMem_del_yn(request.getParameter("status"));
	        memberVO.setDel_note(request.getParameter("delNote"));
	        adminMemberService.updateStatus(memberVO);
	        // 예시로는 아래와 같이 상태와 메모를 콘솔에 출력하는 것으로 대체하였습니다.
	        System.out.println("회원 아이디: " + memberVO.getMem_id());
	        System.out.println("변경된 상태: " + memberVO.getMem_del_yn());
	        System.out.println("메모: " + memberVO.getDel_note());
	        
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        // 클라이언트에게 오류 응답 전송 (실패했을 경우)
	        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "상태 변경 중 오류가 발생하였습니다.");
	    }
	}
}