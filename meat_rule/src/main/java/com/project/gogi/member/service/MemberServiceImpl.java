package com.project.gogi.member.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.gogi.member.dao.MemberDAO;
import com.project.gogi.vo.MemberVO;

@Service("memberService")
@Transactional(propagation=Propagation.REQUIRED)
public class MemberServiceImpl implements MemberService{
	
	//의존성
	@Autowired
	private MemberDAO memberDAO;
	
	//로그인
	@Override
	public MemberVO loginForm(Map loginMap) throws Exception{
		return memberDAO.loginForm(loginMap);
	}
	
	//회원가입
	@Override
	public void insertNewMember(MemberVO memberVO) throws Exception{
		memberDAO.insertNewMember(memberVO);
	}
	
	//아이디 중복검사
	@Override
	public String checkId(String id) throws Exception{
		return memberDAO.checkId(id);
	}
}
