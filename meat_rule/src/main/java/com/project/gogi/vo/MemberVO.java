package com.project.gogi.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("memberVO")
public class MemberVO {
	private String mem_id; // 회원 이름
	private String mem_pw; // 회원 비번
	private String mem_name; // 회원 이름
	private String mem_birth_y; // 회원 생일-년도
	private String mem_birth_m; // 회원 생일-월
	private String mem_birth_d; // 회원 생일-일
	private String mem_tel1; // 회원 폰 번호 - 통신사
	private String mem_tel2; // 회원 폰 번호 - 중간 번호
	private String mem_tel3; // 회원 폰 번호 - 마지막 번호
	private String zipcode;  		// 회원 주소
	private String roadAddress;  	// 도로 주소
	private String jibunAddress; 	// 지번 주소
	private String namujiAddress;	// 나머지 주소
	private String mem_email; // 회원 이메일 주소
	private Date mem_reg_date;	//회원 가입 날짜
	private String mem_del_yn; // 회원 탈퇴 여부
	private int mem_point;//멤버 포인트
	private String del_note;
	
	public String getDel_note() {
		return del_note;
	}

	public void setDel_note(String del_note) {
		this.del_note = del_note;
	}

	public MemberVO() {
		// TODO Auto-generated constructor stub
	}

	public MemberVO(String mem_id, String mem_pw, String mem_name, String mem_birth_y, String mem_birth_m,
			String mem_birth_d, String mem_tel1, String mem_tel2, String mem_tel3, String zipcode, String roadAddress,
			String jibunAddress, String namujiAddress, String mem_email, Date mem_reg_date, String mem_del_yn, int mem_point) {
		
		this.mem_id = mem_id;
		this.mem_pw = mem_pw;
		this.mem_name = mem_name;
		this.mem_birth_y = mem_birth_y;
		this.mem_birth_m = mem_birth_m;
		this.mem_birth_d = mem_birth_d;
		this.mem_tel1 = mem_tel1;
		this.mem_tel2 = mem_tel2;
		this.mem_tel3 = mem_tel3;
		this.zipcode = zipcode;
		this.roadAddress = roadAddress;
		this.jibunAddress = jibunAddress;
		this.namujiAddress = namujiAddress;
		this.mem_email = mem_email;
		this.mem_reg_date = mem_reg_date;
		this.mem_del_yn = mem_del_yn;
		this.mem_point=mem_point;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getRoadAddress() {
		return roadAddress;
	}

	public void setRoadAddress(String roadAddress) {
		this.roadAddress = roadAddress;
	}

	public String getJibunAddress() {
		return jibunAddress;
	}

	public void setJibunAddress(String jibunAddress) {
		this.jibunAddress = jibunAddress;
	}

	public String getNamujiAddress() {
		return namujiAddress;
	}

	public void setNamujiAddress(String namujiAddress) {
		this.namujiAddress = namujiAddress;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getMem_pw() {
		return mem_pw;
	}

	public void setMem_pw(String mem_pw) {
		this.mem_pw = mem_pw;
	}

	public String getMem_name() {
		return mem_name;
	}

	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}

	public String getMem_birth_y() {
		return mem_birth_y;
	}

	public void setMem_birth_y(String mem_birth_y) {
		this.mem_birth_y = mem_birth_y;
	}

	public String getMem_birth_m() {
		return mem_birth_m;
	}

	public void setMem_birth_m(String mem_birth_m) {
		this.mem_birth_m = mem_birth_m;
	}

	public String getMem_birth_d() {
		return mem_birth_d;
	}

	public void setMem_birth_d(String mem_birth_d) {
		this.mem_birth_d = mem_birth_d;
	}

	public String getMem_tel1() {
		return mem_tel1;
	}

	public void setMem_tel1(String mem_tel1) {
		this.mem_tel1 = mem_tel1;
	}

	public String getMem_tel2() {
		return mem_tel2;
	}

	public void setMem_tel2(String mem_tel2) {
		this.mem_tel2 = mem_tel2;
	}

	public String getMem_tel3() {
		return mem_tel3;
	}

	public void setMem_tel3(String mem_tel3) {
		this.mem_tel3 = mem_tel3;
	}

	public String getMem_email() {
		return mem_email;
	}

	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}

	public Date getMem_reg_date() {
		return mem_reg_date;
	}

	public void setMem_reg_date(Date mem_reg_date) {
		this.mem_reg_date = mem_reg_date;
	}

	public String getMem_del_yn() {
		return mem_del_yn;
	}

	public void setMem_del_yn(String mem_del_yn) {
		this.mem_del_yn = mem_del_yn;
	}

	public int getMem_point() {
		return mem_point;
	}

	public void setMem_point(int mem_point) {
		this.mem_point = mem_point;
	}

	@Override
	public String toString() {
		return "MemberVO [mem_id=" + mem_id + ", mem_pw=" + mem_pw + ", mem_name=" + mem_name + ", mem_birth_y="
				+ mem_birth_y + ", mem_birth_m=" + mem_birth_m + ", mem_birth_d=" + mem_birth_d + ", mem_tel1="
				+ mem_tel1 + ", mem_tel2=" + mem_tel2 + ", mem_tel3=" + mem_tel3 + ", zipcode=" + zipcode
				+ ", roadAddress=" + roadAddress + ", jibunAddress=" + jibunAddress + ", namujiAddress=" + namujiAddress
				+ ", mem_email=" + mem_email + ", mem_reg_date=" + mem_reg_date + ", mem_del_yn=" + mem_del_yn
				+ ", mem_point=" + mem_point + ", del_note=" + del_note + "]";
	}
		

}
