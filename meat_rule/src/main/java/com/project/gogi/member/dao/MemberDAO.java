package com.project.gogi.member.dao;

import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.project.gogi.vo.MemberVO;

public interface MemberDAO {
	
	//로그인
	public MemberVO loginForm(Map loginMap) throws DataAccessException;
	//회원가입
	public void insertNewMember(MemberVO memberVO) throws DataAccessException;
	//아이디 중복검사
	public String checkId(String id) throws DataAccessException;
}
