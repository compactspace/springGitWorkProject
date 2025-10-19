package com.spring.finall.view.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.finall.AuthVO;
import com.spring.finall.service.MemberService;
import com.spring.finall.service.SendMessageApiService;
import com.spring.finall.user.CartVO;
import com.spring.finall.user.UserVO;

@Controller
public class AuthnumController {

	public static final String IMPKEY = "imp77544746";
	@Autowired
	private SendMessageApiService sendmessageservice;

	@Autowired
	private MemberService memberService;

	@RequestMapping(value = "sendMessage.do", method = { RequestMethod.GET })
	@ResponseBody
	public void send(HttpServletRequest req, AuthVO vo) {

		int randomNumber = (int) (Math.random() * 899999) + 100000; // 100000 ~ 999999까지의 무작위 수
		vo.setAuthNumber(randomNumber); // 나중의 인증코드 검증을 위해 세팅해놓음
		System.out.println("서버측에서 클라이언트에게 보낼 만든 랜덤수->>" + vo.getAuthNumber()); // (개발자)확인용
		req.getSession().setAttribute("AuthNumber", vo.getAuthNumber());
		boolean check = sendmessageservice.sendMessage(Integer.toString(randomNumber), vo); // 휴대폰으로 인증코드 발송
		if (check) {
			System.out.println("인증번호 발송에 실패했습니다.");

		} else {

			System.out.println("인증번호를 드렸습니다.");

		}

	}

	@RequestMapping(value = "/authsignup.do")
	public String authsignup(UserVO vos, HttpServletRequest req, AuthVO vo, HttpSession session,
			HttpServletResponse res, Model model) throws Exception {
		System.err.println("/authsignup.do 매핑확인");
		vo.setAuthNumber(Integer.parseInt(req.getParameter("authnumber")));
		boolean check = sendmessageservice.deleteAuthnum(vo);
		if (check) {
			
			session.removeAttribute("AuthNumber");			
			String id = req.getParameter("user_tell");	
			vos.setId(id);

			model.addAttribute("user_tell", req.getParameter("user_tell"));
			model.addAttribute("user_name", req.getParameter("user_name"));
//		    	String yes="yes";
//		    	req.setAttribute("wannamember",yes);
			return "signup.jsp";

		} else {
			System.out.println("인증번호틀림");
			return "phonesms.jsp";

		}

	}

	
	
	
	@RequestMapping(value = "/securityauthsignup.do")
	public String securityauthsignup(UserVO vos, HttpServletRequest req, AuthVO vo, HttpSession session,
			HttpServletResponse res, Model model) throws Exception {
		System.err.println("/securityauthsignup.do 매핑확인");
		vo.setAuthNumber(Integer.parseInt(req.getParameter("authnumber")));
		boolean check = sendmessageservice.deleteAuthnum(vo);
		if (check) {
			
			session.removeAttribute("AuthNumber");			
			String id = req.getParameter("user_tell");	
			vos.setId(id);

			model.addAttribute("user_tell", req.getParameter("user_tell"));
			model.addAttribute("user_name", req.getParameter("user_name"));

			return "signupsecurity.jsp";

		} else {
			System.out.println("인증번호틀림");
			return "securityphonesms.jsp";

		}

	}

	
	
	
	
	
	
	//밑에있는 코드들은  보지마라!! 
	
	
	
	@RequestMapping(value = "/isauthnum.do")
	public String authnumCHECK(UserVO vos, HttpServletRequest req, AuthVO vo, HttpSession session,
			HttpServletResponse res, Model model) throws Exception {
		vo.setAuthNumber(Integer.parseInt(req.getParameter("authnumber")));
		boolean check = sendmessageservice.deleteAuthnum(vo);
		if (check) {

			session.removeAttribute("AuthNumber");

			System.out.println("폰번호는->>>" + req.getParameter("user_tell"));
			System.out.println("이름은->>>" + req.getParameter("user_name"));
			String id = req.getParameter("user_tell");
			vos.setId(id);
			System.out.println("id는->>>" + req.getParameter("user_tell"));
			model.addAttribute("user_tell", req.getParameter("user_tell"));
			model.addAttribute("user_name", req.getParameter("user_name"));

			// 여긴 바로 핸드폰번호로 로그인시도 하는 if문
			boolean alreadymember = alreadymemberCheck(vos, req, vo, session, res, model);
			if (alreadymember == false) {

				return "/phonelogin.do?id=" + req.getParameter("user_tell");
			}

			return "signup.jsp";

		} else {
			System.out.println("인증번호틀림");
			return "phonesms.jsp";

		}

	}

	// 다이렉트로 핸드폰 로그인시도
	@RequestMapping(value = "/imPhone.do")
	public String imPhone(UserVO vos, HttpServletRequest req, AuthVO vo, HttpSession session, HttpServletResponse res,
			Model model) throws Exception {
		vo.setAuthNumber(Integer.parseInt(req.getParameter("authnumber")));
		boolean check = sendmessageservice.deleteAuthnum(vo);
		if (check) {

			session.removeAttribute("AuthNumber");
			String id = req.getParameter("user_tell");
			vos.setId(id);
			model.addAttribute("user_tell", req.getParameter("user_tell"));
			model.addAttribute("user_name", req.getParameter("user_name"));
			// 여긴 바로 핸드폰번호로 로그인시도 하는 if문
			boolean alreadymember = alreadymemberCheck(vos, req, vo, session, res, model);
			if (alreadymember == false) {

				session.removeAttribute("loginphone");
				return "/phonelogin.do?id=" + req.getParameter("user_tell");
			} else {

				System.out.println("귀하폰으로 가입한 적이 없습니다.");
				String yes = "yes";
				req.setAttribute("wannamember", yes);
				return "signup.jsp";
			}

		} else {
			System.out.println("인증번호틀림");
			return "phonesms.jsp";

		}

	}

	// 여기서 부터는 그냥 핸드폰번호로 가입자.

	@RequestMapping(value = "/idIsphone.do")
	public String insertphonMembership(UserVO vo, HttpSession session, HttpServletRequest req) throws Exception {
		String id = req.getParameter("id");
		String user_name = req.getParameter("user_name");
		System.out.println("user_name->>>" + user_name);
		vo.setId(id);
		vo.setUser_name(user_name);
		System.out.println(vo.getUser_name());
		vo.setUser_where("phone");
//			vo.setNaver_id("네이버가입자아님");
		boolean check = PhoneMembershipCheck(vo, session, req);
		if (check) {

			try {
				memberService.insertPhone(vo);
				return "/phonelogin.do?id=" + id;

			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("내가 뜨면 프라이머리키 위배로 데이터삽입 오류");
			}

		} else {

			return "/phonelogin.do?id=" + id;
		}
		// 리턴값 우찌 처리
		return "/phonelogin.do?id=" + id;

	}

	// 핸드폰 가입 시도시 이미 있는 번호인지 체크
	// 단 통신사는 다르지만 번호가 같을수 있어 여기서는 user_code 와 id 이렇게 두개의 복합키로 셀렉트문으로 검사할 거임

	public boolean PhoneMembershipCheck(UserVO vo, HttpSession session, HttpServletRequest req) throws Exception {

		boolean check = memberService.checkPhoneMembership(vo);
		System.out.println("check가 트루이면 신규가입자로 가입시키고 로그인시키고, 펠스이면 기가입자로 바로 로그인시키고" + check);
		if (check) {
			return true;

		} else {
			System.out.println("사전검사 아이디가 팰스라면 바로 로그인시켜버려" + check);

			return false;
		}

	}

	// 바로 문자인증후 폰으로 로그인 시도시
	public boolean alreadymemberCheck(UserVO vo, HttpServletRequest req, AuthVO vos, HttpSession session,
			HttpServletResponse res, Model model) throws Exception {

		boolean check = memberService.checkPhoneMembership(vo);
		System.out.println("check가 트루이면 신규가입자로 가입시키고 로그인시키고, 펠스이면 기가입자로 바로 로그인시키고" + check);
		if (check) {
			return true;

		} else {
			System.out.println("사전검사 아이디가 팰스라면 바로 로그인시켜버려" + check);

			return false;
		}

	}



	// 단순 결제 인증
	@RequestMapping(value = "/payforauthnum.do")

	public String payforauthnumCHECK(@RequestParam(value = "finallsum", required = false) String finallsum, CartVO vos,
			Model model, HttpServletRequest req, AuthVO vo, HttpSession session) throws Exception {
		vo.setAuthNumber(Integer.parseInt(req.getParameter("authnumber")));
		boolean check = sendmessageservice.deleteAuthnum(vo);
		if (check) {
			System.out.println("인증번호일치");
			session.removeAttribute("AuthNumber");

			model.addAttribute("pay", finallsum);
			model.addAttribute("id", req.getParameter("id"));
			model.addAttribute("salequantity", vos.getproduct_quantity());
			model.addAttribute("impKey", IMPKEY);
			model.addAttribute("authnum", "authnum");
			// 여긴 바로 핸드폰번호로 로그인시도 하는 if문
			return "pay.jsp";

		} else {
			System.out.println("인증번호틀림");
			return "phonesms.jsp";

		}

	}

}
