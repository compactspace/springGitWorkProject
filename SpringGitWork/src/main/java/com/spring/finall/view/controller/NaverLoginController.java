//package com.spring.finall.view.controller;
//
//import java.io.BufferedReader;
//
//import java.io.IOException;
//import java.io.InputStream;
//import java.io.InputStreamReader;
//import java.math.BigInteger;
//import java.net.HttpURLConnection;
//import java.net.MalformedURLException;
//import java.net.URL;
//import java.net.URLEncoder;
//import java.security.SecureRandom;
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//import java.util.Map.Entry;
//import java.util.Set;
//
//import javax.servlet.RequestDispatcher;
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.apache.http.HttpResponse;
//import org.apache.http.NameValuePair;
//import org.apache.http.client.HttpClient;
//import org.apache.http.client.entity.UrlEncodedFormEntity;
//import org.apache.http.client.methods.HttpPost;
//import org.apache.http.impl.client.HttpClientBuilder;
//import org.apache.http.message.BasicNameValuePair;
//import org.apache.http.util.EntityUtils;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import com.fasterxml.jackson.databind.JsonNode;
//import com.fasterxml.jackson.databind.ObjectMapper;
//import com.spring.finall.user.MemberService;
//import com.spring.finall.user.UserVO;
//
//@Controller
//public class NaverLoginController {
//
//	@Autowired
//	private MemberService memberService;
//
//	private String clientId = "oIB_pADeJKcErdJaXoqA";// 애플리케이션 클라이언트 아이디값";
//	private String ClientSecret = "xhm_mwBHDx";
//	@SuppressWarnings("deprecation")
//	//네이버 로그인후 바로 회원정보 조회 API를 호출하게 되는 콜백URI
//	private String redirectURI = URLEncoder.encode("http://localhost:8090/finall/isExistId.do");
//	SecureRandom random = new SecureRandom();
//	private String state = new BigInteger(130, random).toString();
//	//네이버 로그인창이 뜬뒤  헤더속 redirectURI 을 본다. 그다음 개발자가 정한 콜백유알엘과 일치 하는지 보고 콜백유알앨로 응답을 준다잉
//	private String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code" + "&client_id=" + clientId
//			+ "&redirect_uri=" + redirectURI + "&state=" + state;
//	//사용자 정보를 주는 네이버 api url 이다.
//	private String infoURL = "https://openapi.naver.com/v1/nid/me";
//
//	// 팩트 체그 리스펀스 바디 지우면 오류남, 그런데
//	@RequestMapping(value = "/naverloginform.do")
//	@ResponseBody
//	public void isalreadyid(UserVO vo, HttpServletRequest req, HttpServletResponse res, HttpSession session)
//			throws IOException {
//		/* Session session= req.getSession() */
//		/* session.setAttribute("state", state); */
//
//		res.sendRedirect(apiURL);
//		// return "location.href="+naverloginform;
//
//	}
//
//	//네이버 로그인후 api 에서 주는 url에 담긴 파라미터도 req.getParameter("code") 로 가져올 수있다! 제일중요
//	@RequestMapping(value = "/isExistId.do")
//	public void isExistId(UserVO vo, HttpServletRequest req, HttpServletResponse response, String str)
//			throws IOException {
//		// System.out.println("코드값은->>>>>>"+req.getParameter("code"));
//		// System.out.println("state값은->>>>>>"+req.getParameter("state"));
//
//		//네이버 로그인후 얻은 코드로 토큰을 발급는 url				    
//		String gettokenapiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&" + "client_id="
//				+ clientId + "&client_secret=" + ClientSecret + "&code=" + req.getParameter("code") + "&state="
//				+ req.getParameter("state");
//
//		// System.out.println("gettokenapiURL 유알엘 조합이 잘 되었을까?"+gettokenapiURL);
//		/* res.sendRedirect(gettokenapiURL); */
//
//		String result = "";
//		HttpClient client = HttpClientBuilder.create().build();
//		HttpPost post = new HttpPost(gettokenapiURL);
//		Map<String, String> m = new HashMap<String, String>();
//
//		try {
//
//			//이제 서버에 보낼 데이터를 세팅한다.
//			// 물론 api서버에서 form 으로보내라 json으로 보내라는 해당 제공 api서버를 봐야한다.
//			//단 지금은 필요 없어서 주석 처리한다.
//			//post.setEntity(new UrlEncodedFormEntity(convertParameter(m)));
//			
//			// client.excute(POST) 가 외부로 전송 하는건데
//			HttpResponse res = client.execute(post);
//			
//			ObjectMapper mapper = new ObjectMapper();
//
//			String infoheader = EntityUtils.toString(res.getEntity());	
//			
//			
//			JsonNode rootNode = mapper.readTree(infoheader);
//			String INFOHEADER = mapper.writeValueAsString(rootNode);
//		
//			JsonNode resNode = rootNode.get("access_token");
//			String token = mapper.writeValueAsString(resNode);
//			System.out.println("네이버의 응답 토큰->>"+token);
//			
//			isExistInfo(vo, token, response, req);
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		// 오류일시 어짜피 네이버측에서 메세지에 인증 실패라 떠서
//		// 문자열 "error" 를 준뒤
//		// 호출한 함수에서 조건문 분기로 처리하는 용도이다.
//
//	}
//
//	//네이버회원 정보 조회 API를 받아오는 일반 메소드
//	public void isExistInfo(UserVO vo, String token, HttpServletResponse res, HttpServletRequest req)
//			throws IOException {
//
//		// 아오 "Bearer " 이렇게 공백=스페이스바 한칸 추가 해야 인식하네
//		String header = "Bearer " + token;
//		// System.out.println("header 가 널이 아니길->>"+header);
//		
//		Map<String, String> requestHeaders = new HashMap<>();
//		requestHeaders.put("Authorization", header);
//
//		String responseBody = get(infoURL, requestHeaders);
//
//		// System.out.println("리스펀스바디 타입:->>"+responseBody);
//
//		ObjectMapper mapper = new ObjectMapper();
//
//		//readTree: 문자열을 자바가 알아쳐먹는 JSON형태로 바꿔준다.
//		JsonNode clientinfo = mapper.readTree(responseBody);
//
////{"resultcode":"00","message":"success","response":{"id":"rQE_RsS0i5F8jxIgoh88swhDV1UZerijF96octiN2aM","nickname":"입실론극혐","profile_image":"https://ssl.pstatic.net/static/pwe/address/img_profile.png","age":"30-39","gender":"M","email":"younggoo7000@naver.com","mobile":"010-9313-0686","mobile_e164":"+821093130686","name":"신원찬","birthday":"11-05","birthyear":"1991"}}	
//		//System.out.println(clientinfo);		
//		
//		JsonNode response = clientinfo.get("response");		
//		JsonNode responseid = response.get("id");
//		JsonNode responsemobile = response.get("mobile");
//		JsonNode responsemoname = response.get("name");
//
//
//		// 설명하기 어려운데
//		// 제이슨이 문자열을 "" 로 감싸서 가져와
//		// 나중 제이에스티엘에서 인식을 못해 쌍따옴표 제거해둠 이것때문에 1시간 날림 ㅠ
//		
//		String str1 = mapper.writeValueAsString(responseid);
//		String str2 = mapper.writeValueAsString(responsemobile);
//		String str3 = mapper.writeValueAsString(responsemoname);
//		System.out.println("str1: "+str1);
//		System.out.println("str2: "+str2);
//		System.out.println("str3: "+str3);
//		
//		
//		String id = str1.replaceAll("\"", "");
//		String mobile = str2.replaceAll("\"", "");
//		String name = str3.replaceAll("\"", "");
//
//		vo.setId(id);
//		vo.setUser_tell(mobile);
//		vo.setUser_name(name);
//		vo.setPassword("불필요");
//		vo.setUser_where("naveruser");
//		// vo 완벽히 수정후 에트리뷰트는 주석처리한다.
//		req.setAttribute("naver_id", "yes");
//		req.setAttribute("id", id);
//		req.setAttribute("mobile", mobile);
//		req.setAttribute("name", name);
//		req.setAttribute("UserVO", vo);
//		RequestDispatcher rds = req.getRequestDispatcher("/navercheckid.do");
//		try {
//			rds.forward(req, res);
//		} catch (ServletException | IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//
//	}
//
//	private static String get(String infoURL, Map<String, String> requestHeaders) {
////		HttpURLConnection은 ?
////		URL 내용을 읽어오거나 , URL에 GET,POST 방식으로 데이터를 전달할 때 사용한다.
//		HttpURLConnection con = connect(infoURL);
//		System.out.println("get 메소드속 requestHeaders");
//		System.out.println(requestHeaders);
//		try {
//			con.setRequestMethod("GET");
//			for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
//				con.setRequestProperty(header.getKey(), header.getValue());
//			}
//
//			int responseCode = con.getResponseCode();
//			System.out.println("responseCode 는 연결상태로 뭐가 찍히려나->>" + responseCode);
//			System.out.println("HttpURLConnection.HTTP_OK->>>" + HttpURLConnection.HTTP_OK);
//
//			if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
//				System.out.println("con.getInputStream()는????");
//				System.out.println(con.getInputStream());
//				
//				//변수수정을 위해 잠시 메서드 readBody 복사함 메서드 이름은 readBody를 복사한 readBody2로 복사함
//				// 따라서 return readBody(con.getInputStream()); 는 잠시 주석처리함
//				return readBody2(con);
//				//return readBody(con.getInputStream());
//			} else { // 에러 발생
//				return readBody(con.getErrorStream());
//			}
//		} catch (IOException e) {
//			throw new RuntimeException("API 요청과 응답 실패", e);
//		} finally {
//			con.disconnect();
//		}
//	}
//
//	
//	private static HttpURLConnection connect(String apiUrl) {
//		try {
//			URL url = new URL(apiUrl);
//			return (HttpURLConnection) url.openConnection();
//		} catch (MalformedURLException e) {
//			throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
//		} catch (IOException e) {
//			throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
//		}
//	}
//
//	//변수수정을 위해 잠시 메서드 readBody 복사함 메서드 이름은 readBody를 복사한 readBody2로 복사함
//	private static String readBody2(HttpURLConnection con) throws IOException {
//		
//		InputStream in =con.getInputStream();		
//		//InputStream 는 아스키코드(바이트)를 번역해야 하는데
//		//InputStreamReader InputStream를 인수로 받아 바이트를 문자단위로 변환해준다..!! 
//		InputStreamReader ins = new InputStreamReader(in);
//		
//		try (BufferedReader buffer = new BufferedReader(ins)) {
//			StringBuilder responseBody = new StringBuilder();			
//			String bodydata;
//			while ((bodydata = buffer.readLine()) != null) {				
//				responseBody.append(bodydata);
//			}		
//			return responseBody.toString();
//		} catch (IOException e) {
//			throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
//		}
//	}
//	
//	
//	
//	
//	
//	
//	private static String readBody(InputStream body) {
//		InputStreamReader streamReader = new InputStreamReader(body);
//		System.out.println("body 값은?");
//		System.out.println(body);
//		System.out.println("streamReader 값은?");
//		System.out.println(streamReader);
//
//		try (BufferedReader lineReader = new BufferedReader(streamReader)) {
//			StringBuilder responseBody = new StringBuilder();
//			System.out.println("lineReader눈?");
//			System.out.println(lineReader);
//			String line;
//			while ((line = lineReader.readLine()) != null) {
//				System.out.println("lineReader.readLine()는???");
//				System.out.println(line);
//				responseBody.append(line);
//			}
//			System.out.println("리턴직전 responseBody");
//			System.out.println(responseBody);
//			return responseBody.toString();
//		} catch (IOException e) {
//			throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
//		}
//	}
//
//	// 네이버 회원 API호출후 이미 가입된 회원이면 로그인 아니라면 회원가입 시키는 메소드
//	@RequestMapping(value = "/navercheckid.do")
//	public String naverMembershipCheck(UserVO vo, HttpSession session, HttpServletRequest req) throws Exception {
//
//		System.out.println("디스페쳐로 UserVO오 넘어온거 확인" + req.getAttribute("UserVO"));
//		vo = (UserVO) req.getAttribute("UserVO");
//		System.out.println("아이디는?" + vo.getId());
//		System.out.println("핸드폰번호는?" + vo.getUser_tell());
//		System.out.println("이름은?" + vo.getUser_name());
////		System.out.println("네이버컨트롤로에서 디스페쳐로  일로 발급받은 아이디가  와졌니?" + req.getAttribute("id"));
////		System.out.println("네이버컨트롤로에서 디스페쳐로  일로 발급받은 핸드폰  와졌니?" + req.getAttribute("mobile"));
////		System.out.println("네이버컨트롤로에서 디스페쳐로  일로 발급받은 이  와졌니?" + req.getAttribute("name"));
//		String id = vo.getId();
//
//
//		boolean check = memberService.checkidMembership(vo);
//		System.out.println("투르 뜨면 회원 가입시킴" + check);
//		if (check) {
//			try {
//				memberService.insertMembership(vo);
//				 Integer user_code= memberService.selectusercode(vo);
//				session.setAttribute("userId", id);
//				session.setAttribute("user_code",user_code);
//				return "/mainhome.jsp";
//
//			} catch (Exception e) {
//				e.printStackTrace();
//				System.out.println("내가 뜨면 프라이머리키 위배로 데이터삽입 오류");
//				req.setAttribute("err","err");
//				return "/login.jsp";			}
//
//
//		} else {
//			System.out.println("펠스뜨면 바로 로그인처리" + check);
//			 Integer user_code= memberService.selectusercode(vo);
//			session.setAttribute("userId", vo.getId());
//			session.setAttribute("user_code", user_code);			
//			return "/mainhome.jsp";
//		}
//
//	} // 네이버로그인 후 이미 가입된 회원인지 함수 종료
//
//	
//		// Map의 중첩  스테틱 인터페이스 인 interface Entry<K, V> {각종 필드 key value 등등}
//		// 을 entrySet() 으로  타입 Set<Entry<String, String>> 를 가져온뒤
//		List<NameValuePair> convertParameter(Map<String, String> paramMap) {
//			
//			System.out.println("paramMap: "+paramMap.toString());
//			
//			
//			List<NameValuePair> paramList = new ArrayList<NameValuePair>();
//			Set<Entry<String, String>> entries = paramMap.entrySet();
//			/*
//			 * Set Interface -> 순서X 중복X     Set 인터페이스는 중복 요소를 포함할 수 없으며 랜덤 액세스를 허용하지않아
//			 * iterator 또는 foreach를 이용하여 요소를 탐색할 수 있다. 현재 내용이 어렵지
//			 * 
//			 */
//			for (Entry<String, String> entry : entries) {
//				paramList.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
//			}
//			System.out.println("paramList: "+paramList);
//			return paramList;
//		}
//	
//	
//	
//	
//	
//	
//	
////	// 네이버로그인후 자동 회원가입시도함수
////	@RequestMapping(value = "/insertNaverMembership.do")
////	public String insertNaverMembership(UserVO vo, HttpSession session, HttpServletRequest req) throws Exception {
////		// 네이버 가입자는 패스워드 필요없어서 지움
//////		System.out.println("req id->>" + req.getParameter("id"));
////		String id = req.getParameter("id");
//////		System.out.println("id를 못가져오나" + vo.getId());
////		vo.setUser_where("naveruser");
//////		vo.setNaver_id("네이버이용자");
////		vo.setUser_name("미기입");
////		vo.setPassword("불필요");
////		try {
////			memberService.insertMembership(vo);
////			session.setAttribute("userId", id);
////			return "/mainhome.jsp";
////
////		} catch (Exception e) {
////			e.printStackTrace();
////			System.out.println("내가 뜨면 프라이머리키 위배로 데이터삽입 오류");
////		}
////
////		return "/naverlogin.do";
////
////	}// 네이버로그인후 회원가입 종료
//
//	// 네이버가입자 로그인시도시작
////	@RequestMapping(value = "/naverlogin.do")
////	public String naverlogin(UserVO vo, HttpSession session, HttpServletRequest req) throws Exception {
////
////		session.setAttribute("userId", vo.getId());
////		System.out.println("네이버로그인자는 세션어트리뷰트가지금 널임?" + vo.getId());
////		return "worklist.jsp";
////
////	}// 네이버가입자 로그인시도 종료
//
//	
//
//}
