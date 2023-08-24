package com.project.gogi.admin.member.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.project.gogi.vo.MemberVO;

@Repository("adminMemberDao")
public class AdminMemberDAOImpl  implements AdminMemberDAO{
	@Autowired
	private SqlSession sqlSession;
	
	
	public ArrayList<MemberVO> listMember(HashMap condMap) throws DataAccessException{
		ArrayList<MemberVO> listMember=(ArrayList)sqlSession.selectList("mapper.admin.member.listMember",condMap);
		return listMember;
	}
	
	public MemberVO memberDetail(String mem_id) throws DataAccessException{
		MemberVO memberDetail=(MemberVO)sqlSession.selectOne("mapper.admin.member.memberDetail",mem_id);
		return memberDetail;
	}
	
	public void modifyMemberInfo(HashMap memberMap) throws DataAccessException{
		sqlSession.update("mapper.admin.member.modifyMemberInfo",memberMap);
	}
	
	public void deleteMember(String mem_id) throws DataAccessException {
		sqlSession.delete("mapper.admin.member.deleteMember" ,mem_id);
	}
	public void updateStatus(MemberVO memberVO) throws DataAccessException{
		sqlSession.update("mapper.admin.member.updateStatus",memberVO);
	}

	@Override
	public int memberCount() throws Exception {
		return sqlSession.selectOne("mapper.admin.member.memberCount");
	}
	
}
