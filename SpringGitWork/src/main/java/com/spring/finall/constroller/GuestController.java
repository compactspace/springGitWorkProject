package com.spring.finall.constroller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.finall.WorkImgVO;
import com.spring.finall.apiResponseController.ApiResponse;
import com.spring.finall.businessresult.SignUpSmsSendResult;
import com.spring.finall.businessresult.SmsSendResult;
import com.spring.finall.security.UserDetailsVO2;
import com.spring.finall.service.MemberService;
import com.spring.finall.service.OneDayClassService;
import com.spring.finall.service.SignUpSmsSendService;
import com.spring.finall.service.WorkService;
import com.spring.finall.user.OneDayClassVO;
import com.spring.finall.user.ProductService;
import com.spring.finall.user.ProductVO;
import com.spring.finall.user.UserVO;

@Controller
@RequestMapping("/api/guest")
public class GuestController {

	@Autowired
	private ProductService protService;

	@Autowired
	private OneDayClassService oneDayClassService;

	@Autowired
	private WorkService workService;
	
	@Autowired
	private MemberService memberService;
	
	
	@Autowired
	private SignUpSmsSendService signUpSmsSendService;
	

	@RequestMapping(value = "/productGroupList")
	public String ajaxProductGroupList(ProductVO vo,
			@RequestParam(value = "product_group", required = false, defaultValue = "pencile") String product_group,
			Model model) {

		if ("groupdetermined".equals(product_group)) {
			product_group = "제품군미정";
		}

		vo.setProduct_group(product_group);
		List<Map<String, Object>> grouplist = protService.productGroupLlist(vo);
		model.addAttribute("productService", grouplist);

		System.out.println(grouplist);
		// ✅ 이 JSP는 #content2 부분만 포함한 "조각 페이지"여야 함
		return "compoents/productGroupList";
	}

	@RequestMapping(value = "/get-motre-reviews")
	public String getdynamicworkimg(@RequestParam(defaultValue = "취미만화반") String onedayclass_name,
			@RequestParam(defaultValue = "0") int nextpage, WorkImgVO vo, OneDayClassVO ovo, Model model,
			HttpServletRequest req) {

		ovo.setOnedayclass_name(onedayclass_name);
		ovo.setNextpage(nextpage);

		HashMap<String, Object> map = oneDayClassService.getReview2(ovo);

		List<Object> reviewList = (List<Object>) map.get("joinToReview");
		boolean endPageFlag = (reviewList != null && reviewList.isEmpty());
		model.addAttribute("endPageFlag", map.get("endPageFlag"));
		model.addAttribute("joinToReview", map.get("joinToReview"));
		return "compoents/onedayclassinfopage/reviewFragment";
	}


	@RequestMapping(value = "/get-more-work-comments")
	@ResponseBody
	public List<Map<String, Object>>  getMoreWorkComments(@RequestParam("work_id") int work_id,
			
			@RequestParam(defaultValue = "10") int limit,
			@RequestParam(defaultValue = "0") int offset,
			

			Model model, HttpServletRequest req) {

		List<Map<String, Object>>  treeCommentList=	workService.getMoreWorkComments(work_id, limit,offset);
		model.addAttribute("treeCommentList", treeCommentList);

		return treeCommentList;
	}
	
	
	
	@PostMapping("/request-signup-sms-code")
	@ResponseBody
	public ApiResponse<SignUpSmsSendResult> requestSignUPSmsCode(HttpServletRequest req, @RequestParam("phone") String phone, Model model) {
	
	
		   // 1. 현재 사용자의 HttpSession 객체 획득
	    HttpSession session = req.getSession();

	    // 2. 이 사용자의 고유 세션 ID 확인
	    String sessionId = session.getId();

	    System.out.println("비로그인 사용자의 세션 ID: " + sessionId);

	    SignUpSmsSendResult result = signUpSmsSendService.requestSmsCode(sessionId, phone, req.getSession(), model);

		// 결과에 따라 반환 (문자 발송 성공시 token 반환, 아니면 상태 문자열)
		if (result.isSuccess()) {
			return ApiResponse.<SignUpSmsSendResult>builder().code(201).success(true).message("인증번호가 발송되었습니다.").data(result)
					.build();
		} else {
			return ApiResponse.<SignUpSmsSendResult>builder().code(201).success(true).message(result.getStatus()).data(result)
					.build();
		}
	
	}
	
	
	@PostMapping("/signup-verify-sms-code")
	@ResponseBody
	public ApiResponse<SignUpSmsSendResult> verifySmsCode(
			HttpServletRequest req, @RequestParam("code") String inputCode, @RequestParam("token") String token,Model model) {
		   // 1. 현재 사용자의 HttpSession 객체 획득
	    HttpSession session = req.getSession();

	    // 2. 이 사용자의 고유 세션 ID 확인
	    String sessionId = session.getId();

	    System.out.println("비로그인 사용자의 세션 ID: " + sessionId);
		SignUpSmsSendResult smsSendResult = signUpSmsSendService.verifySmsCode(sessionId, session, inputCode, token);

		
		// 결과에 따라 반환 (문자 발송 성공시 token 반환, 아니면 상태 문자열)
		if (smsSendResult.isSuccess()) {
			model.addAttribute("smsVerified", true);
			return ApiResponse.<SignUpSmsSendResult>builder().code(201).success(true).message("인증이 완료되었습니다.").data(smsSendResult)
					.build();
		} else {
			return ApiResponse.<SignUpSmsSendResult>builder().code(201).success(true).message("인증 실패").data(smsSendResult)
					.build();
		}
	}
	
	
	
	@PostMapping("/alive-verify-sms-code")
	@ResponseBody
	public ApiResponse<SignUpSmsSendResult> aliveVerifySmsCode(
			HttpServletRequest req, @RequestParam("token") String token,Model model) {
		   // 1. 현재 사용자의 HttpSession 객체 획득
	    HttpSession session = req.getSession();

	    // 2. 이 사용자의 고유 세션 ID 확인
	    String sessionId = session.getId();

	    System.out.println("비로그인 사용자의 세션 ID: " + sessionId);
		SignUpSmsSendResult smsSendResult = signUpSmsSendService.aliveverifySmsCode(sessionId, session, token);

		
		// 결과에 따라 반환 (문자 발송 성공시 token 반환, 아니면 상태 문자열)
		if (smsSendResult.isSuccess()) {
			model.addAttribute("smsVerified", true);
			return ApiResponse.<SignUpSmsSendResult>builder().code(201).success(true).message("인증이 완료되었습니다.").data(smsSendResult)
					.build();
		} else {
			return ApiResponse.<SignUpSmsSendResult>builder().code(201).success(true).message("인증 실패").data(smsSendResult)
					.build();
		}
	}
	
	
	
	
	
	
	@PostMapping("/signup-remove-smsCoolDown")
	@ResponseBody
	public ApiResponse<String> removeSmsCooldown(HttpServletRequest req) {
		HttpSession session = req.getSession();
		ApiResponse<String> response = null;
		try {
			signUpSmsSendService.removeSmsCooldown(session);
			response = ApiResponse.<String>builder().code(201).success(true).message("쿨다운 세션제거").data(null).build();
		} catch (Exception e) {
			System.out.println(e);
			response = ApiResponse.<String>builder().code(500) // 실패이므로 201 보단 500같은 에러 코드가 맞겠네요.
					.success(false).message("쿨다운 세션제거 실패").data(null).build();
		} finally {
			return response;
		}
	}
	
	
	@RequestMapping(value = "/action-signup")
	@ResponseBody
	public String insertMembership(UserVO vo, HttpSession session) throws Exception {

		String password = BCrypt.hashpw(vo.getPassword(), BCrypt.gensalt());
		vo.setPassword(password);

		

		try {
			memberService.insertMembership(vo);
			return "signupsuccess";

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("내가뜨면 아이디 유니크제약조건위배");
			return "signupfalse";
		}
	}// 회원가입 종료
	

	
	//문자인증
	@RequestMapping(value = "/signup-page4")
	public String getMoreWorkComments4() {

		return "securityphonesms";
	}
	
	// 회원가입전 이미 있는 아이디 인지 체그하는 아작스 호출
	@RequestMapping(value = "/checkout-signup-id")
	@ResponseBody
	public boolean checkOutPossibleSignUpId(UserVO vo, HttpSession session, HttpServletRequest req) throws Exception {

	
		boolean check = memberService.checkidMembership(vo);

		if (check) {
		
			return check;
		} else {
			return check;
		}

	} 
	

	@GetMapping("/get-artwork-image")
	public ResponseEntity<Resource> servePrivateDraftImage(@RequestParam(defaultValue = "/userArtwork/") String folder, // ex: /userArtwork/
			@RequestParam("name") String fileName) {
		try {
			// ✅ 보안 상 폴더 경로 정규화 방어
			if (folder.contains("..") || folder.contains("\\") || !folder.startsWith("/")) {
				return ResponseEntity.badRequest().build();
			}

			// ✅ 서버 내부 절대 경로 설정
			String rootBaseDir = "C:/"; // 또는 환경변수로 뺄 수도 있음
			String fullPath = rootBaseDir + folder + fileName;
			Path filePath = Paths.get(fullPath).normalize();			

			if (!Files.exists(filePath)) {
				return ResponseEntity.notFound().build();
			}

			// 이 시점까지는 파일 스트림이 열리지 않은 상태입니다.
			// 아래 UrlResource 객체 생성은 단순히 파일 위치 정보를 갖는 객체를 만드는 것일 뿐, 스트림을 열지 않습니다.
			Resource resource = new UrlResource(filePath.toUri());

			// 파일의 MIME 타입을 검사합니다.
			String contentType = Files.probeContentType(filePath);
			if (contentType == null)
				contentType = "application/octet-stream";

			// 아래 ResponseEntity를 반환하는 순간,
			// Spring 내부에서 HTTP 응답을 처리할 때 resource.getInputStream()이 호출되어
			// **여기서부터 파일 스트림이 열리고, 클라이언트로 데이터 전송이 시작됩니다.**
			// public class ResourceHttpMessageConverter 클래스의 protected void writeContent
			// 메서드에서 톰캣 응답스트림과, 파일객체의 스트림을 적절히 결합한다.
			// 전송이 완료되면 스트림은 자동으로 닫힙니다.
			return ResponseEntity.ok().contentType(MediaType.parseMediaType(contentType)).body(resource);

		} catch (IOException e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

}
