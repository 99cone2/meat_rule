package com.project.gogi.admin.member.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.project.gogi.vo.MemberVO;

public interface AdminMemberService {
	public ArrayList<MemberVO> listMember(HashMap condMap) throws Exception;
	public MemberVO memberDetail(String mem_id) throws Exception;
	public void  modifyMemberInfo(HashMap memberMap) throws Exception;
	public void removeMember(String mem_id) throws Exception;
	public void updateStatus(MemberVO memberVO) throws Exception;
	public int memberCount() throws Exception;
}
