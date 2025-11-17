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
import org.springframework.web.multipart.MultipartFile;

import com.spring.finall.WorkImgVO;
import com.spring.finall.apiResponseController.ApiResponse;
import com.spring.finall.businessresult.DuplicateCheckResult;
import com.spring.finall.businessresult.SignUpSmsSendResult;
import com.spring.finall.businessresult.TeacherInsertResult;
import com.spring.finall.exception.teacherMemberShip.TeacherDocumentException;
import com.spring.finall.security.UserDetailsVO2;
import com.spring.finall.service.ArtworkService;
import com.spring.finall.service.MemberService;
import com.spring.finall.service.OneDayClassService;
import com.spring.finall.service.SignUpSmsSendService;
import com.spring.finall.service.TeacherMemberService;
import com.spring.finall.service.WorkService;
import com.spring.finall.user.ArtworkVO;
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
	private ArtworkService artWorkService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private SignUpSmsSendService signUpSmsSendService;

	@Autowired
	private TeacherMemberService teacherMemberService;
	
	
	@PostMapping("/test")
	@ResponseBody
	public ResponseEntity<ApiResponse<Boolean>>  testFNC(){
		  ApiResponse<Boolean> response = ApiResponse.<Boolean>builder()
	                .code(502)
	                .success(false)
	                .message("커스텀코드는 502 이고 그냥 문자열 커스텀데이터")
	                .data(false)
	                .build();
		  
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		
	}
	
	

	@RequestMapping(value = "/productGroupList")
	public String ajaxProductGroupList(ProductVO vo,
	        @RequestParam(value = "product_group", required = false, defaultValue = "pencile") String product_group,
	        @AuthenticationPrincipal UserDetailsVO2 user,
	        Model model) {

	    // 제품군 미정 처리
	    if ("groupdetermined".equals(product_group)) {
	        product_group = "제품군미정";
	    }

	    vo.setProduct_group(product_group);
	    List<Map<String, Object>> grouplist = protService.productGroupLlist(vo);

	    // 안전하게 새 컬럼만 별도 모델로 추가
	    for (Map<String, Object> item : grouplist) {
	        // file_category와 file_name이 존재하고 널이 아닐 때만
	        if (item.containsKey("file_category") && item.get("file_category") != null &&
	            item.containsKey("file_name") && item.get("file_name") != null) {

	            // MVC리솔스 처리경로 /images/
	            item.put("imagePath", "/images/" + item.get("file_category") + "/" + item.get("file_name"));
	        }
	    }

	    model.addAttribute("productService", grouplist);

	    // 로그인 여부
	    Boolean isAuthenticated = user != null;
	    model.addAttribute("isAuthenticated", isAuthenticated);

	    // JSP는 #content2 부분만 포함한 조각 페이지
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
	public List<Map<String, Object>> getMoreWorkComments(@RequestParam("work_id") int work_id,

			@RequestParam(defaultValue = "10") int limit, @RequestParam(defaultValue = "0") int offset,

			Model model, HttpServletRequest req) {

		List<Map<String, Object>> treeCommentList = workService.getMoreWorkComments(work_id, limit, offset);
		model.addAttribute("treeCommentList", treeCommentList);

		return treeCommentList;
	}

	@PostMapping("/request-signup-sms-code")
	@ResponseBody
	public ApiResponse<SignUpSmsSendResult> requestSignUPSmsCode(HttpServletRequest req,
			@RequestParam("phone") String phone, Model model) {

		// 1. 현재 사용자의 HttpSession 객체 획득
		HttpSession session = req.getSession();

		// 2. 이 사용자의 고유 세션 ID 확인
		String sessionId = session.getId();

		System.out.println("비로그인 사용자의 세션 ID: " + sessionId);

		SignUpSmsSendResult result = signUpSmsSendService.requestSmsCode(sessionId, phone, req.getSession(), model);

		// 결과에 따라 반환 (문자 발송 성공시 token 반환, 아니면 상태 문자열)
		if (result.isSuccess()) {
			return ApiResponse.<SignUpSmsSendResult>builder().code(201).success(true).message("인증번호가 발송되었습니다.")
					.data(result).build();
		} else {
			return ApiResponse.<SignUpSmsSendResult>builder().code(201).success(true).message(result.getStatus())
					.data(result).build();
		}

	}

	@PostMapping("/signup-verify-sms-code")
	@ResponseBody
	public ApiResponse<SignUpSmsSendResult> verifySmsCode(HttpServletRequest req,
			@RequestParam("code") String inputCode, @RequestParam("token") String token, Model model) {
		// 1. 현재 사용자의 HttpSession 객체 획득
		HttpSession session = req.getSession();

		// 2. 이 사용자의 고유 세션 ID 확인
		String sessionId = session.getId();

		System.out.println("비로그인 사용자의 세션 ID: " + sessionId);
		SignUpSmsSendResult smsSendResult = signUpSmsSendService.verifySmsCode(sessionId, session, inputCode, token);

		// 결과에 따라 반환 (문자 발송 성공시 token 반환, 아니면 상태 문자열)
		if (smsSendResult.isSuccess()) {
			model.addAttribute("smsVerified", true);
			return ApiResponse.<SignUpSmsSendResult>builder().code(201).success(true).message("인증이 완료되었습니다.")
					.data(smsSendResult).build();
		} else {
			return ApiResponse.<SignUpSmsSendResult>builder().code(201).success(true).message("인증 실패")
					.data(smsSendResult).build();
		}
	}

	@PostMapping("/alive-verify-sms-code")
	@ResponseBody
	public ApiResponse<SignUpSmsSendResult> aliveVerifySmsCode(HttpServletRequest req,
			@RequestParam("token") String token, Model model) {
		// 1. 현재 사용자의 HttpSession 객체 획득
		HttpSession session = req.getSession();

		// 2. 이 사용자의 고유 세션 ID 확인
		String sessionId = session.getId();

		System.out.println("비로그인 사용자의 세션 ID: " + sessionId);
		SignUpSmsSendResult smsSendResult = signUpSmsSendService.aliveverifySmsCode(sessionId, session, token);

		// 결과에 따라 반환 (문자 발송 성공시 token 반환, 아니면 상태 문자열)
		if (smsSendResult.isSuccess()) {
			model.addAttribute("smsVerified", true);
			return ApiResponse.<SignUpSmsSendResult>builder().code(201).success(true).message("인증이 완료되었습니다.")
					.data(smsSendResult).build();
		} else {
			return ApiResponse.<SignUpSmsSendResult>builder().code(201).success(true).message("인증 실패")
					.data(smsSendResult).build();
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

	// 일반유저 회원가입
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
	}

	// 선생님 회원가입
	@RequestMapping(value = "/teacher-action-signup")
	@ResponseBody
	public ApiResponse<TeacherInsertResult> insertTeacher(
	        @RequestParam Map<String, Object> allParams,
	        @RequestParam("businessCertificate") MultipartFile file
	) throws Exception {

	    // Map에서 id, password 추출
	    String id = String.valueOf(allParams.get("id"));
	    String password = String.valueOf(allParams.get("password"));
	    String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

	    // Map에서 id, password 제거하고 나머지를 회사 정보로 사용
	    allParams.remove("id");
	    allParams.remove("password");
	    Map<String, Object> companyInfo = allParams;

	    try {
	        teacherMemberService.insertTeacherMembership(id, hashedPassword, file,companyInfo);
	       
	        
	        return ApiResponse.<TeacherInsertResult>builder()
	                .code(201)
	                .success(true)
	                .message("회원가입 성공")
	                .data(new TeacherInsertResult(201, false, "회원가입성공"))
	                .build();

	    } catch (TeacherDocumentException te) {
	        return ApiResponse.<TeacherInsertResult>builder()
	                .code(500)
	                .success(false)
	                .message("회원가입 실패")
	                .data(new TeacherInsertResult(500, false, te.getMessage()))
	                .build();
	    }
	}


	// 문자인증
	@RequestMapping(value = "/signup-page4")
	public String getMoreWorkComments4() {

		return "securityphonesms";
	}

	// 회원가입전 이미 있는 아이디 인지 체그하는 아작스 호출
	@RequestMapping(value = "/checkout-signup-id")
	@ResponseBody
	public ResponseEntity<ApiResponse<DuplicateCheckResult>> checkOutPossibleSignUpId(UserVO vo, HttpSession session, HttpServletRequest req) throws Exception {

		boolean check = memberService.checkidMembership(vo);

		

		
		
		if (check) {
			DuplicateCheckResult  duplicateCheckResult = new DuplicateCheckResult(200,true);
			
			  ApiResponse<DuplicateCheckResult> response = ApiResponse.<DuplicateCheckResult>builder()
		                .code(200)
		                .success(false)
		                .message("")
		                .data(duplicateCheckResult)
		                .build();
			  
		        return ResponseEntity.status(HttpStatus.OK).body(response);
			
		
		} else {
			DuplicateCheckResult  duplicateCheckResult = new DuplicateCheckResult(409,false,"이미 존재하는 아이디 입니다.");
			
			  ApiResponse<DuplicateCheckResult> response = ApiResponse.<DuplicateCheckResult>builder()
		                .code(409)
		                .success(false)
		                .message("")
		                .data(duplicateCheckResult)
		                .build();
			  
		        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
		}

	}

	@GetMapping("/get-artwork-image")
	public ResponseEntity<Resource> servePrivateDraftImage(@RequestParam(defaultValue = "/userArtwork/") String folder, // ex:
																														// /userArtwork/
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

	@GetMapping("/search/ajax")
	@ResponseBody
	public Map<String, Object> searchAjax(@RequestParam String query, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "10") int limit) { // 기본 10개씩

		int offSet = (page - 1) * limit;

		ArtworkVO artWorkVO = new ArtworkVO();
		artWorkVO.setContent(query);
		artWorkVO.setLimit(limit);
		artWorkVO.setOffSet(offSet);

		Map<String, Object> searchData = artWorkService.searchyArtWork(artWorkVO);

		Map<String, Object> data = new HashMap<>();
		data.put("searchyList", searchData.get("searchyList"));

		return data;
	}

}
