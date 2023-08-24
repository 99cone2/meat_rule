package com.project.gogi.social;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.project.gogi.vo.KakaoDTO;
import com.project.gogi.vo.MemberVO;

@Service("socialService")
public class SocialService {

	@Autowired
	private MemberRepository mr;
	
	public String getReturnAccessToken(String code) {
		String access_token = "";
		String refresh_token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";
		
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			//HttpURLConnection 설정 값 세팅
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			//buffer 스트림 객체 값 세팅 후 요청
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=4fb1697c90371b19154002a41beb7e3d");//앱 KEY VALUE
			sb.append("&redirect_uri=http://localhost:9091/social/kakao_callback");//앱 callback 경로
			sb.append("&code="+code);
			bw.write(sb.toString());
			bw.flush();
			
			//RETURN 값 result 변수에 저장
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String br_line = "";
			String result = "";
			
			while((br_line = br.readLine()) != null) {
				result += br_line;
			}
			
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			
			//토큰 값 저장 및 리턴
			access_token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_token = element.getAsJsonObject().get("refresh_token").getAsString();
			
			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return access_token;
	}
	
	public MemberVO getUserInfo(String access_token){
		HashMap<String, Object> userInfo = new HashMap();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			
			//요청에 필요한 Header에 포함 될 내용
			conn.setRequestProperty("Authorization", "Bearer " + access_token);
			
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			
			String br_line = "";
			String result = "";
			
			while((br_line = br.readLine()) != null) {
				result += br_line;
			}
			System.out.println("response: " + result);
			
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			
			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			String email = kakao_account.getAsJsonObject().get("email").getAsString();
			
			KakaoDTO kDTO = new KakaoDTO();
			userInfo.put("nickname", nickname);
			userInfo.put("email", email);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		KakaoDTO result = mr.findkakao(userInfo);
		// 위 코드는 먼저 정보가 저장되있는지 확인하는 코드.
		System.out.println("S:" + result);
		if(result==null) {
		// result가 null이면 정보가 저장이 안되있는거므로 정보를 저장.
			mr.kakaoinsert(userInfo);
			// 위 코드가 정보를 저장하기 위해 Repository로 보내는 코드임.
			KakaoDTO kDTO = mr.findkakao(userInfo);
			MemberVO resultMember = mr.findmember(kDTO);
			return resultMember;
			// 위 코드는 정보 저장 후 컨트롤러에 정보를 보내는 코드임.
			//  result를 리턴으로 보내면 null이 리턴되므로 위 코드를 사용.
		} else {
			MemberVO resultMember = mr.findmember(result);
			return resultMember;
			// 정보가 이미 있기 때문에 result를 리턴함.
		}
	}
	
}
