package com.project.gogi.social;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.gogi.vo.KakaoDTO;
import com.project.gogi.vo.MemberVO;

@Repository
public class MemberRepository {

	@Autowired
	private SqlSessionTemplate sql;
	
	//정보 저장
	public void kakaoinsert(HashMap<String, Object> userInfo) {
		sql.insert("Social.kakaoInsert", userInfo);
	}
	
	//정보 확인
	public KakaoDTO findkakao(HashMap<String, Object> userInfo) {
		System.out.println("RN:"+userInfo.get("nickname"));
		System.out.println("RN:"+userInfo.get("email"));
		return sql.selectOne("Social.findKakao",userInfo);
	}
	
	public MemberVO findmember(KakaoDTO userInfo) {
	
	MemberVO memberInfo = sql.selectOne("Social.findMember",userInfo);
	return memberInfo;
	}
	
}
