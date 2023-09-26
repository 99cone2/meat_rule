package com.project.gogi.serv.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.gogi.common.base.BaseController;
import com.project.gogi.serv.service.ServService;
import com.project.gogi.vo.CommentVO;
import com.project.gogi.vo.Criteria;
import com.project.gogi.vo.MemberVO;
import com.project.gogi.vo.PageMaker;
import com.project.gogi.vo.ServImageFileVO;
import com.project.gogi.vo.ServVO;

@Controller //컨트롤러 선언
@RequestMapping("/serv") // 요청주소와 실제주소 매팽하는 어노테이션 = 이곳으로 들어오는  api  주소를 mapping, / serv 주소로 받겠다.
public class ServController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(ServController.class); //private static final 선언변수 사용시 재할당 x, 메모리에 한번 올라가면 같은 값은 클래스 내부의 전체 필드, 메서드에서 공유한다.

	@Autowired // 빈에 DI(의존성 주입)를 도와주는 어노테이션 
	ServService servService;
	@Autowired
	private HttpSession httpSession;
	@Autowired
	private ServVO servVO;
	@Autowired
	private MemberVO memberVO;

	// 고객센터 게시판 이미지 파일 저장 위치
	private static final String GOGI_IMAGE_REPO_PATH1 = "C:\\meatrule\\file_repo\\servBoard";

	// 게시물 목록+페이징
	@GetMapping(value = "/list.do")//
	public String getServList(Model model, Criteria cri, HttpServletRequest request, HttpServletResponse response, ServVO vo) throws Exception {

		List<ServVO> servList = servService.ServList(cri);
		model.addAttribute("servList", servList); //view로 데이터 전달(servList.jsp)  키 값

		// 게시판 페이징 가져오기
		PageMaker pageMaker = new PageMaker();
		//cri로 총 게시글 수, 현재 페이지, 페이지 당 게시글 수 값 가져오기
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(servService.ServListCount());
		model.addAttribute("pageMaker", pageMaker);
		 

		// 8.1 추가 로그인 확인
		Boolean isLogOn = (Boolean) httpSession.getAttribute("isLogon");
		// 로그인 상태만 읽기 가능하게 하기
		if (isLogOn != null && isLogOn) {
			memberVO = (MemberVO) httpSession.getAttribute("memberInfo");
			String mem_id = memberVO.getMem_id();
			model.addAttribute("mem_id", mem_id);
			model.addAttribute("isLogOn", isLogOn);
		}
		System.out.print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@데이터 확인"+servList);

		return "serv/servList";

	}

	//게시물 작성 get
	@GetMapping(value = "/write.do")
	public String getServWrite(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		//세션에서 "memberInfo"라는 이름의 MemberVO 객체를 가져오려 시도
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");

		// 8.1 구태선 추가 /로그인 여부
		Boolean isLogOn = (Boolean) httpSession.getAttribute("isLogon"); 

		if (isLogOn != null && isLogOn) { // 로그인 상태 아니여도 공지사항 읽기 가능
			memberVO = (MemberVO) httpSession.getAttribute("memberInfo");
			String mem_id = memberVO.getMem_id();
			model.addAttribute("mem_id", mem_id);
			model.addAttribute("isLogOn", isLogOn);
			System.out.println("고객센터 글작성 아이디 확인" + mem_id);
		} // 추가 end

		// 메서드는 "serv/servWrite"라는 문자열을 반환. 화면 띄우기 용 
		return "serv/servWrite";
	}

	//게시물 작성 + 이미지 post
	@PostMapping(value = "/write.do")
	public String postServWrite(ServVO vo, MultipartHttpServletRequest multipartRequest, HttpServletResponse response,
			RedirectAttributes redirectAttrs) throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		String imageFileName = null;

		// 매개변수 정보와 파일 정보를 저장할 Map 생성
		Map<String, Object> servMap = new HashMap<String, Object>();
		//인터페이스                        //클래스 > 메소드 사용가능
		Enumeration enu = multipartRequest.getParameterNames();

		// 전송된 매개변수 값 key/value로 map에 저장
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			servMap.put(name, value);
			System.out.println("name: " + name + " / value: " + value);
		}
		
		HttpSession session = multipartRequest.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");

		//세션에 저장된 로그인 ID를 가져옴
		String reg_id = memberVO.getMem_id();

		// 첨부한 이미지 정보를 가져옴
		List<ServImageFileVO> imageFileList = upload1(multipartRequest);

		// 이미지 정보 관련 
		if (imageFileList != null && imageFileList.size() != 0) {
			for (ServImageFileVO servImageFileVO : imageFileList) {
				servImageFileVO.setReg_id(reg_id);
			}
			servMap.put("imageFileList", imageFileList);
		}

		try {
			// 상품 정보와 이미지 정보를 각 테이블에 추가
			int cust_serv_no = servService.ServWrite(servMap);
			
			// 업로드한 이미지를 고객센터 번호 폴더에 저장
			if (imageFileList != null && imageFileList.size() != 0) {
				for (ServImageFileVO servImageFileVO : imageFileList) {
					imageFileName = servImageFileVO.getImg_name();
					//System.out.println("컨트롤러 이미지 파일네임: " + imageFileName);
					File srcFile = new File(GOGI_IMAGE_REPO_PATH1 + "\\" + imageFileName);
					File destDir = new File(GOGI_IMAGE_REPO_PATH1 + "\\" + cust_serv_no);
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				}
			}
		} catch (Exception e) {
			if (imageFileList != null && imageFileList.size() != 0) {
				for (ServImageFileVO servImageFileVO : imageFileList) {
					imageFileName = servImageFileVO.getImg_name();
					File srcFile = new File(GOGI_IMAGE_REPO_PATH1 + "\\" + imageFileName);
					srcFile.delete();
				}
			}
		}

		redirectAttrs.addFlashAttribute("message", "글 작성이 완료되었습니다.");

		return "redirect:/serv/list.do";
	}

	
	//게시물 조회 + 조회수 중복방지
	@GetMapping(value = "/read.do")
	public String getServView(@RequestParam("cust_serv_no") int cust_serv_no, Model model, ServVO vo) throws Exception {
		Boolean isLogOn = (Boolean) httpSession.getAttribute("isLogon"); // 로그인 여부
		//로그인 상태 아니여도 공지사항 읽기 가능
		if (isLogOn != null && isLogOn) {
			memberVO = (MemberVO) httpSession.getAttribute("memberInfo");
			String mem_id = memberVO.getMem_id();
			System.out.println("멤버아이디" + mem_id);
			model.addAttribute("mem_id", mem_id);
		}

		// 구분 객체 생성, 세션 값 가져오기 (getAttribute : 세션에서 대이터 가져올때 사용), 저장
		//set: 객체 중복 x
		Set<Integer> serv_noViewHits = (Set<Integer>) httpSession.getAttribute("serv_noViewHits");

		//초기 notice_noViewHits null일 때 처리 / 값 만들기...
		//hashSet 데이터 중복x , 순서 상관 없음
		if (serv_noViewHits == null) {
			serv_noViewHits = new HashSet<>();
			httpSession.setAttribute("serv_noViewHits", serv_noViewHits);
		}

		// notice_noViewHits에 들어있지 않은 값일 때 처리하는 로직-최조 클릭 게시물 조회수 +1 증가 후
		// notice_noViewHits에 해당 notice_no 저장
		if (!serv_noViewHits.contains(cust_serv_no)) {
			servService.updateServViewCnt(cust_serv_no);
			serv_noViewHits.add(cust_serv_no);
		}

		// 게시물 조회
		Map<String, Object> servMap = servService.ServRead(cust_serv_no);
		model.addAttribute("servMap", servMap);

		return "serv/servRead";
	}

	
	//게시물 삭제
	@GetMapping(value = "/delete.do")
	public String getServDelete(@RequestParam("cust_serv_no") int cust_serv_no) throws Exception {
		servService.ServDelete(cust_serv_no);
		
		return "redirect:/serv/list.do";
	}

	//8.24 추가
	//게시물 수정 get
	@GetMapping(value = "/modify.do")
	public String getServModify(@RequestParam("cust_serv_no") int cust_serv_no, Model model) throws Exception {
		Map<String, Object> servMap = servService.ServRead(cust_serv_no);
		model.addAttribute("servMap", servMap);

		return "serv/servModify";
	}

	
	//게시물 수정 처리 post
	@PostMapping(value = "/modify.do")
	public String postServModify(ServVO vo) throws Exception {
		servService.ServUpdate(vo);		
		return "redirect:/serv/read.do?cust_serv_no=" + vo.getCust_serv_no();
	}
	

	//게시판 댓글 작성
	@PostMapping(value = "/addComment.do")
	@ResponseBody
	public String addComment(@ModelAttribute("CommentVO") CommentVO commentVO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		
		try {
			if (memberVO != null) {
				commentVO.setMem_id(memberVO.getMem_id());
				commentVO.setLvl(1);// 기본 lvl값 설정
				int group_number=servService.getGroupNumber(0);//제일 마지막에 생성된 부모댓글의 group_number max값 가져옴
				commentVO.setGroup_number(group_number+1);//부모댓글의 group_number 설정
				servService.addComment(commentVO);// 댓글 등록 처리 (이후 등록된 댓글의 글번호를 받아옴)
				//System.out.println("댓글추가:" + commentVO.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	
	//대댓글 등록
	@PostMapping(value = "/addReply.do")
	@ResponseBody
	public String addReply(@RequestParam int cmt_parent_num, @ModelAttribute("CommentVO") CommentVO commentVO,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");

		try {
			if (memberVO != null) {
				commentVO.setMem_id(memberVO.getMem_id());
				if (cmt_parent_num != 0) {// 계층형 댓글을 위한 lvl 추가
					int parentLvl = servService.getCmtLvl(cmt_parent_num);
					int parentGroupNumber=servService.getParentGroupNumeber(cmt_parent_num);
					System.out.println("부모댓글넘버:"+cmt_parent_num);
					System.out.println("부모댓글의 그룹넘버:"+parentGroupNumber);
					
					commentVO.setLvl(parentLvl + 1);
					commentVO.setGroup_number(parentGroupNumber);
				}
				servService.addReply(commentVO);
				//System.out.println("@@@@@@@@@@@대댓글 commentVO:" + commentVO.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	
	//댓글 조회
	@RequestMapping(value = "/commentList.do", produces = "application/json; charset=utf8", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity commentList(@ModelAttribute("CommentVO") CommentVO commentVO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HttpHeaders responseHeaders = new HttpHeaders();
		ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
		List<CommentVO> commentList = servService.selectBoardCommentByCode(commentVO);

		if (commentList.size() > 0) {
			for (int i = 0; i < commentList.size(); i++) {
				HashMap hm = new HashMap();
				hm.put("cust_serv_no", commentList.get(i).getCust_serv_no());
				hm.put("cmt_number", commentList.get(i).getCmt_number());
				hm.put("cmt_content", commentList.get(i).getCmt_content());
				hm.put("cmt_date", commentList.get(i).getCmt_date());
				hm.put("mem_id", commentList.get(i).getMem_id());
				hm.put("lvl", commentList.get(i).getLvl());
				hmlist.add(hm);
			}
		}
		JSONArray json = new JSONArray(hmlist);
		return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
	}

}
