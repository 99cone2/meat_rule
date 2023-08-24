package com.project.gogi.admin.member.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.gogi.admin.member.dao.AdminMemberDAO;
import com.project.gogi.vo.MemberVO;

@Service("adminMemberService")
@Transactional(propagation=Propagation.REQUIRED)
public class AdminMemberServiceImpl implements AdminMemberService {
	
	@Autowired
	private AdminMemberDAO adminMemberDAO;
	
	public ArrayList<MemberVO> listMember(HashMap condMap) throws Exception{
		return adminMemberDAO.listMember(condMap);
	}

	public MemberVO memberDetail(String mem_id) throws Exception{
		 return adminMemberDAO.memberDetail(mem_id);
	}
	
	public void  modifyMemberInfo(HashMap memberMap) throws Exception{
		 adminMemberDAO.modifyMemberInfo(memberMap);
	}

	public void removeMember(String mem_id) throws Exception {
		adminMemberDAO.deleteMember(mem_id);
	}
	public void updateStatus(MemberVO memberVO) throws Exception{
		adminMemberDAO.updateStatus(memberVO);
	}

	@Override
	public int memberCount() throws Exception {
		return adminMemberDAO.memberCount();
	}
}