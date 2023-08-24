package com.project.gogi.member.service;

import java.util.Map;

import com.project.gogi.vo.MemberVO;

public interface MemberService {
	
	//회원가입
	public void insertNewMember(MemberVO memberVO) throws Exception;
	
	//로그인
	public MemberVO loginForm(Map loginMap) throws Exception;
	
	//아이디 중복검사
	public String checkId(String id) throws Exception;
}
