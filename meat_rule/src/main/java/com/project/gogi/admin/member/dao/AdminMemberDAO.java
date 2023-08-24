package com.project.gogi.admin.member.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.dao.DataAccessException;

import com.project.gogi.vo.MemberVO;

public interface AdminMemberDAO {
	public ArrayList<MemberVO> listMember(HashMap condMap) throws DataAccessException;
	public MemberVO memberDetail(String mem_id) throws DataAccessException;
	public void modifyMemberInfo(HashMap memberMap) throws DataAccessException;
	public void deleteMember(String mem_id) throws DataAccessException;
	public void updateStatus(MemberVO memberVO) throws DataAccessException;
	int memberCount() throws Exception;
}