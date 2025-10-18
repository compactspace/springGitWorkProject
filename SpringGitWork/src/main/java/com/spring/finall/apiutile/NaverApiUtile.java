package com.spring.finall.apiutile;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Repository;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Repository("HttpClientUtile")
public class NaverApiUtile {

	// 톰캣이 손님으로써 네이버로 부터 토큰을 발급받는 메서드
	public String getNaverApiToken(String apiURI) {
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(apiURI);
		try {
			HttpResponse res = client.execute(post);
			ObjectMapper mapper = new ObjectMapper();

			// 이제 외부 서버로 받은 데이터를 스트링으로 받는다.
			String data = EntityUtils.toString(res.getEntity());

			// 외부 서버로부터 받은 json꼴의 스트링을 이제 자바가 알아 쳐먹는 자바의 json꼴로 변경한다.
			JsonNode node = mapper.readTree(data);

			// String INFOHEADER = mapper.writeValueAsString(rootNode);

			// readTree로 자바 스타일의 json형식으로 변형되었으니 key값으로 데이터를 빼온다.
			// 네이버가 주는 키명이 access_token 인 토큰이다.
			JsonNode keynode = node.get("access_token");

			String token = mapper.writeValueAsString(keynode);

			return token;
		} catch (ClientProtocolException e) {
			System.out.println("첫 켓치: " + e);
			return "faile";

		} catch (IOException e) {
			System.out.println("두번째 켓치: " + e);
			return "faile";
		}

	}

	// 톰캣이 손님으로써 네이버로 부터 발급받은 토큰으로 네이버에게 해당 유저의 정보를 요청하는 메서드
	public String getNaverMemberInfo(String infoURL, Map<String, String> requestHeaders) {

		StringBuilder builder = new StringBuilder();

		try {
			URL url = new URL(infoURL);

			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			// 쫄지마라 그냥 네이버 api에서 그냥 데이터를 아래처럼 주세요 하니 이렇게 하는거다
			for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
				System.out.println("header.getKey(), header.getValue()"+header.getKey()+header.getValue());
				con.setRequestProperty(header.getKey(), header.getValue());
			}

			con.setRequestMethod("GET");
			//여기서 실질적으로 세팅된 것을 요청하고 응답코드를 받아온다.
			int responseCode = con.getResponseCode();

			//System.out.println("responseCode : " + responseCode);

			if (responseCode == HttpURLConnection.HTTP_OK) {
				InputStream in = con.getInputStream();
				InputStreamReader ins = new InputStreamReader(in);
				BufferedReader buffer = new BufferedReader(ins);

				while (true) {

					String data;
					if ((data = buffer.readLine()) != null) {
						builder.append(data);
					}
					break;
				}

			}
			con.disconnect();
			//System.out.println("유틸속 네이버의 정보 builder: " + builder);
			return builder.toString();
		} catch (IOException e) {
			throw new RuntimeException("회원정보를 가져오는데 실패: ", e);

		}
	}

}
