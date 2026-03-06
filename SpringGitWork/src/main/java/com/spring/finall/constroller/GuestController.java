package com.spring.finall.constroller;

import java.io.File;
import java.io.IOException;
import java.io.Writer;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.pdfbox.text.TextPosition;
import org.mindrot.jbcrypt.BCrypt;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.finall.WorkImgVO;
import com.spring.finall.Validator.UploadSecurityManager.UploadSecurityManager;
import com.spring.finall.apiResponseController.ApiResponse;
import com.spring.finall.businessresult.DuplicateCheckResult;
import com.spring.finall.businessresult.SignUpSmsSendResult;
import com.spring.finall.businessresult.TeacherInsertResult;
import com.spring.finall.exception.teacherMemberShip.TeacherDocumentException;
import com.spring.finall.reqDto.teacherSignUpRequest.TeacherSignupRequestDTO;
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
	
	 // 서버 구동 시 단 1회 생성, 모든 요청 공유
    private final ExecutorService executor = Executors.newFixedThreadPool(3);
	

	@Autowired
	private UploadSecurityManager uploadSecurityManager;

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
	public ResponseEntity<ApiResponse<Boolean>> testFNC() {
		ApiResponse<Boolean> response = ApiResponse.<Boolean>builder().code(502).success(false)
				.message("커스텀코드는 502 이고 그냥 문자열 커스텀데이터").data(false).build();

		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);

	}
	
//제이미터 테스트용이다. 
	  @GetMapping("/test-summary")	
	    @ResponseBody
	    public List<Map<String, Object>> testSummary() {
	        List<Map<String, Object>> resultList = new ArrayList<>();

	        String url = "jdbc:mysql://localhost:3306/employees?serverTimezone=UTC";
	        String user = "root";
	        String password = "1111";

	        String sql =
	                "SELECT d.dept_name, t.title, COUNT(e.emp_no) AS employee_count, " +
	                "AVG(s.salary) AS avg_salary, MAX(s.salary) AS max_salary, MIN(s.salary) AS min_salary " +
	                "FROM employees e " +
	                "JOIN dept_emp de ON e.emp_no = de.emp_no " +
	                "JOIN departments d ON de.dept_no = d.dept_no " +
	                "JOIN titles t ON e.emp_no = t.emp_no " +
	                "JOIN salaries s ON e.emp_no = s.emp_no " +
	                "WHERE t.to_date > CURDATE() AND s.to_date > CURDATE() " +
	                "GROUP BY d.dept_name, t.title " +
	                "ORDER BY avg_salary DESC";

	        try (Connection conn = DriverManager.getConnection(url, user, password);
	             PreparedStatement pstmt = conn.prepareStatement(sql);
	             ResultSet rs = pstmt.executeQuery()) {

	            while (rs.next()) {
	                Map<String, Object> row = new HashMap<>();
	                row.put("dept_name", rs.getString("dept_name"));
	                row.put("title", rs.getString("title"));
	                row.put("employee_count", rs.getInt("employee_count"));
	                row.put("avg_salary", rs.getDouble("avg_salary"));
	                row.put("max_salary", rs.getDouble("max_salary"));
	                row.put("min_salary", rs.getDouble("min_salary"));

	                resultList.add(row);
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return resultList;
	    }
	
	 
	  
	  @GetMapping("/test-findUserDB")
	  @ResponseBody
	  public List<Map<String, Object>> testfindUserDB() {

	      List<Map<String, Object>> resultList = new ArrayList<>();

	      String url = "jdbc:mysql://localhost:3306/finall?serverTimezone=UTC";
	      String user = "root";
	      String password = "1111";

	      String sql =
	              "SELECT " +
	              " user_code, " +
	              " user_where, " +
	              " id, " +
	              " user_tell, " +
	              " user_name, " +
	              " email, " +
	              " user_role, " +
	              " enabled, " +
	              " create_signup " +
	              "FROM user " +
	              "WHERE id = ?";

	      try (Connection conn = DriverManager.getConnection(url, user, password);
	           PreparedStatement pstmt = conn.prepareStatement(sql)) {

	          pstmt.setString(1, "asd123");

	          ResultSet rs = pstmt.executeQuery();

	          while (rs.next()) {
	              Map<String, Object> row = new HashMap<>();

	              row.put("user_code", rs.getInt("user_code"));
	              row.put("user_where", rs.getString("user_where"));
	              row.put("id", rs.getString("id"));
	              row.put("user_tell", rs.getString("user_tell"));
	              row.put("user_name", rs.getString("user_name"));
	              row.put("email", rs.getString("email"));
	              row.put("user_role", rs.getString("user_role"));
	              row.put("enabled", rs.getInt("enabled"));
	              row.put("create_signup", rs.getTimestamp("create_signup"));

	              resultList.add(row);
	          }

	      } catch (SQLException e) {
	          e.printStackTrace();
	      }

	      return resultList;
	  }
	   //테스트 용 오토 위리드
	  @Autowired
	    private RedisTemplate<String, Object> redisTemplate;

	    @GetMapping("/test-findUserRedis")
	    @ResponseBody
	    public List<Map<String, Object>> testFindUserRedis() {

	        List<Map<String, Object>> resultList = new ArrayList<>();

	        // 9만 번째 유저 id 하드코딩
	        String userId = "user90000";
	        String redisKey = "user:" + userId;

	        // Redis Hash 조회
	        HashOperations<String, String, Object> hashOps = redisTemplate.opsForHash();
	        Map<String, Object> userMap = hashOps.entries(redisKey);

	        if (!userMap.isEmpty()) {
	            Map<String, Object> row = new HashMap<>();

	            row.put("user_code", userMap.get("user_code"));
	            row.put("user_where", userMap.get("user_where"));
	            row.put("id", userMap.get("id"));
	            row.put("user_tell", userMap.get("user_tell"));
	            row.put("user_name", userMap.get("user_name"));
	            row.put("email", userMap.get("email"));
	            row.put("user_role", userMap.get("user_role"));
	            row.put("enabled", userMap.get("enabled"));
	            row.put("create_signup", userMap.get("create_signup"));

	            resultList.add(row);
	        }

	        return resultList;
	    }
		  
	    @Autowired
	    private SqlSessionTemplate mybatisl;

	    @GetMapping("/test-getfakeartworks")
	    @ResponseBody
	    @Transactional  // 트랜잭션 유지
	    public ResponseEntity<Map<String, Object>> testGetfakeartworks() {
	        List<Map<String, Object>> rows = null;
	        String message = "게시글 리턴완료";

	        ExecutorService executor = Executors.newSingleThreadExecutor();
	        Future<List<Map<String, Object>>> future = executor.submit(() -> {
	            // SELECT FOR UPDATE
	            List<Map<String, Object>> tempRows = mybatisl.selectList(
	                "FakeArtworkMapper.selectFakeArtworksForUpdate"
	            );

	            // UPDATE
	            mybatisl.update("FakeArtworkMapper.updateCheckedFakeArtworks");

	            return tempRows;
	        });

	        HttpStatus status = HttpStatus.OK;

	        try {
	            // 10ms 안에 완료되지 않으면 TimeoutException 발생
	            rows = future.get(10000, TimeUnit.MILLISECONDS);
	        } catch (TimeoutException e) {
	            future.cancel(true);
	            rows = Collections.emptyList();
	            message = "작업이 0.01초 이상 걸려 취소되었습니다: " + e.getMessage();
	            System.err.println(message);
	            status = HttpStatus.INTERNAL_SERVER_ERROR; // 500으로 설정
	        } catch (Exception e) {
	            rows = Collections.emptyList();
	            message = "쿼리 실행 중 에러 발생: " + e.getMessage();
	            System.err.println(message);
	            status = HttpStatus.INTERNAL_SERVER_ERROR; // 500으로 설정
	        } finally {
	            executor.shutdown();
	        }

	        Map<String, Object> result = new HashMap<>();
	        result.put("message", message);
	        result.put("data", rows);

	        return new ResponseEntity<>(result, status);
	    }

	    

	    
	    
	    @GetMapping("/test-increment-redis-view")
	    @ResponseBody
	    public ResponseEntity<Map<String, Object>> testIncrementRedisView() {
	        String message = "조회 없이 view 증가 완료";
	        HttpStatus status = HttpStatus.OK;

	        ExecutorService executor = Executors.newSingleThreadExecutor();
	        Future<Long> future = executor.submit(() -> {

	            // Pipeline으로 view만 증가
	            List<Object> pipelineResults = redisTemplate.executePipelined((RedisCallback<Object>) connection -> {
	                byte[] keyBytes = "fakeartwork:1".getBytes();

	                // HINCRBY view 1
	                connection.hIncrBy(keyBytes, "view".getBytes(), 1);

	                return null;
	            });

	            // pipelineResults에는 증가된 값이 들어있지 않을 수 있음
	            // 단순 증가만 필요하면 반환값은 무시 가능
	            return 1L; // 성공 시 1 반환
	        });

	        try {
	            future.get(100, TimeUnit.MILLISECONDS); // 타임아웃을 현실적으로 설정
	        } catch (TimeoutException e) {
	            future.cancel(true);
	            message = "Redis 증가 작업이 0.1초 이상 걸려 취소됨: " + e.getMessage();
	            status = HttpStatus.INTERNAL_SERVER_ERROR;
	        } catch (Exception e) {
	            message = "Redis 처리 중 에러 발생: " + e.getMessage();
	            status = HttpStatus.INTERNAL_SERVER_ERROR;
	        } finally {
	            executor.shutdown();
	        }

	        Map<String, Object> result = new HashMap<>();
	        result.put("message", message);
	        return new ResponseEntity<>(result, status);
	    }

	    
	    
	    
	    

	@RequestMapping(value = "/productGroupList")
	public String ajaxProductGroupList(ProductVO vo,
			@RequestParam(value = "product_group", required = false, defaultValue = "pencile") String product_group,
			@AuthenticationPrincipal UserDetailsVO2 user, Model model) {

		// 제품군 미정 처리
		if ("groupdetermined".equals(product_group)) {
			product_group = "제품군미정";
		}

		vo.setProduct_group(product_group);
		List<Map<String, Object>> grouplist = protService.productGroupLlist(vo);

		// 안전하게 새 컬럼만 별도 모델로 추가
		for (Map<String, Object> item : grouplist) {
			// file_category와 file_name이 존재하고 널이 아닐 때만
			if (item.containsKey("file_category") && item.get("file_category") != null && item.containsKey("file_name")
					&& item.get("file_name") != null) {

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
	
	
	
	// 바로위 ajaxProductGroupList 는 현재 디비 컬럼 value = "product_group", 수정중으로 ajaxProductCategoryList로 바꾸는중
	@RequestMapping(value = "/product-categorylist")
	public String ajaxProductCategoryList(ProductVO vo,
			@RequestParam(value = "category_id", required = false, defaultValue = "4") int category_id,
			@AuthenticationPrincipal UserDetailsVO2 user, Model model) {

		

		vo.setCategory_id(category_id);
		List<Map<String, Object>> grouplist = protService.productCategoryList(vo);
		
		
		// 안전하게 새 컬럼만 별도 모델로 추가
		for (Map<String, Object> item : grouplist) {
			// file_category와 file_name이 존재하고 널이 아닐 때만
			if (item.containsKey("file_category") && item.get("file_category") != null && item.containsKey("file_name")
					&& item.get("file_name") != null) {

				// MVC리솔스 처리경로 /images/
				item.put("imagePath", "/images/" + item.get("file_category") + "/" + item.get("file_name"));
			}
		}

		model.addAttribute("productService", grouplist);

		// 로그인 여부
		Boolean isAuthenticated = user != null;
		model.addAttribute("isAuthenticated", isAuthenticated);

		// JSP는 #content2 부분만 포함한 조각 페이지
		return "compoents/products/productPaintList";
	}
	
	
	
	
	
	
	

	@RequestMapping(value = "/get-motre-reviews")
	public String getdynamicworkimg(@RequestParam(defaultValue = "취미만화반") String onedayclass_name,
			@RequestParam(defaultValue = "0") int nextpage, WorkImgVO vo, OneDayClassVO ovo, Model model,
			HttpServletRequest req) {

		ovo.setOnedayclass_name(onedayclass_name);
		ovo.setNextpage(nextpage);

		HashMap<String, Object> map = oneDayClassService.getReview2(ovo);

		List<Object> reviewList = (List<Object>) map.get("joinToReview");
		boolean endPageFlag = (reviewList == null || (reviewList != null && reviewList.isEmpty()));
		model.addAttribute("endPageFlag", endPageFlag);
		model.addAttribute("joinToReview", map.get("joinToReview"));
		return "compoents/onedayclassinfopage/reviewFragment";
	}

	@RequestMapping(value = "/get-reviews-short-form")
	public String getReviewsShortForm( OneDayClassVO ovo, Model model,
			HttpServletRequest req) throws JsonProcessingException {

	
		OneDayClassVO  shortReviewList = oneDayClassService.getReviewsShortForm(ovo);
		
		model.addAttribute("shortReviewList", shortReviewList);

		return "compoents/onedayclassinfopage/reviewShortFomFragment";
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

		// System.out.println("비로그인 사용자의 세션 ID: " + sessionId);
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
	@RequestMapping(value = "/teacher-action-signup", method = RequestMethod.POST)
	@ResponseBody
	public ApiResponse<TeacherInsertResult> insertTeacherTest(
			@RequestHeader(value = "X-Auth-Token", required = false) String authToken,
			@Valid @ModelAttribute TeacherSignupRequestDTO request, BindingResult bindingResult,
			@RequestParam("businessCertificate") MultipartFile file, HttpServletRequest req

	) throws Exception {
		System.out.println("authToken: " + authToken);

		// 사실 토큰은 헤커를 낚는 낚시값이다. 값만 있냐 없냐로 일차 방어
		// 다른 레디스 키로 만료를 판단 할것이다.
		if (authToken == null) {
			return ApiResponse.<TeacherInsertResult>builder().code(401).success(false).message("curl요청등 개수작 금지")
					.data(new TeacherInsertResult(400, false, "curl요청등 개수작 금지")).build();
		} else {

			// 1. 현재 사용자의 HttpSession 객체 획득
			HttpSession session = req.getSession();

			// 2. 이 사용자의 고유 세션 ID 확인
			String sessionId = session.getId();

			System.out.println("비로그인 사용자의 세션 ID: " + sessionId);
			if (signUpSmsSendService.isExpired(sessionId, session, authToken) < 0) {
				return ApiResponse.<TeacherInsertResult>builder().code(401).success(false).message("curl요청등 개수작 금지")
						.data(new TeacherInsertResult(400, false, "curl요청등 개수작 금지")).build();
			}

		}

		// DTO 유효성 체크
		if (bindingResult.hasErrors()) {
			String errorMsg = bindingResult.getAllErrors().get(0).getDefaultMessage();
			return ApiResponse.<TeacherInsertResult>builder().code(400).success(false).message(errorMsg)
					.data(new TeacherInsertResult(400, false, errorMsg)).build();
		}

		// 파일 체크
		if (file == null || file.isEmpty()) {
			return ApiResponse.<TeacherInsertResult>builder().code(400).success(false).message("사업자등록증을 첨부해주세요")
					.data(new TeacherInsertResult(400, false, "파일 필수")).build();
		}

		// 파일 크기 체크 (예: 최대 5MB)
		long maxFileSize = 5 * 1024 * 1024; // 5MB
		if (file.getSize() > maxFileSize) {
			System.out.println(file.getSize());
			return ApiResponse.<TeacherInsertResult>builder().code(400).success(false)
					.message("첨부파일이 너무 큽니다. 최대 5MB까지 업로드 가능합니다.").data(new TeacherInsertResult(400, false, "파일 용량 초과"))
					.build();
		}

		// C:\Users\82109\AppData\Local\Temp
		// 이건 자바의 내장 세팅으로 File.createTempFile("upload_", null); 는 기본경로 를 위로 세팅한다고하네
		File temp = File.createTempFile("upload_", null);
		file.transferTo(temp);
		String originalName = file.getOriginalFilename();

		if (!checkUploadSecurityManager(originalName, temp)) {
			return ApiResponse.<TeacherInsertResult>builder().code(401).success(false).message("주작금지")
					.data(new TeacherInsertResult(400, false, "주작금지")).build();
		}

		String id = request.getId();
		String password = request.getPassword();
		String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

		// 나머지 회사 정보
		Map<String, Object> companyInfo = new HashMap<>();
		companyInfo.put("company_name", request.getCompany_name());
		companyInfo.put("registration_number", request.getRegistration_number());
		companyInfo.put("representative_name", request.getRepresentative_name());
		companyInfo.put("company_phone", request.getCompany_phone());
		companyInfo.put("address", request.getAddress());
		companyInfo.put("email", request.getEmail());
		// 테스트용 로그 출력
		System.out.println("===== Teacher Signup Company Info =====");
		companyInfo.forEach((key, value) -> {
			System.out.printf("%-20s : %s%n", key, value);
		});
		System.out.println("=======================================");

		try {
			teacherMemberService.insertTeacherMembership(id, hashedPassword, file, companyInfo, temp);

			return ApiResponse.<TeacherInsertResult>builder().code(201).success(true).message("회원가입 성공")
					.data(new TeacherInsertResult(201, false, "회원가입성공")).build();

		} catch (TeacherDocumentException te) {
			return ApiResponse.<TeacherInsertResult>builder().code(500).success(false).message("회원가입 실패")
					.data(new TeacherInsertResult(500, false, te.getMessage())).build();
		}
	}

	// 선생님 회원가입
	@RequestMapping(value = "/unitTestInsertTeacherTest", method = RequestMethod.POST)
	@ResponseBody
	public ApiResponse<TeacherInsertResult> unitTestInsertTeacherTest(
			@RequestParam("businessCertificate") MultipartFile file, HttpServletRequest req

	) throws Exception {

		
		System.out.println(file.getSize());
		return ApiResponse.<TeacherInsertResult>builder().code(400).success(false)
				.message("첨부파일이 너무 큽니다. 최대 5MB까지 업로드 가능합니다.").data(new TeacherInsertResult(400, false, "파일 용량 초과"))
				.build();

	}
	
	// 선생님 회원가입
		@RequestMapping(value = "/unitTestServerDown", method = RequestMethod.GET)
		@ResponseBody
		public ApiResponse<TeacherInsertResult> unitTestServerDown(
				 HttpServletRequest req

		) throws Exception {

			
			
			
			 File file = new File("C:\\fake\\pdf_zip_bomb.pdf");
		      // OS 파일 시스템의 실제 디스크 파일과 JVM File 객체 연결

		      try (PDDocument doc = PDDocument.load(file)) {
		          // ① PDF 구조 파싱
		          // FileInputStream → OS 파일 핸들 통해 디스크 파일 읽음
		          // PDFBox 내부에서 PDF Body, Page Tree, Page Object 생성

		          System.out.println("① PDF 구조 파싱 성공");

		          PDFTextStripper stripper = new PDFTextStripper();

		          System.out.println("② 내용(stream) 파싱 시작...");
		          // ② 내용(stream) 파싱
		          // Page Object → /Contents → Stream Object 접근
		          // Stream Object 내 /Filter /FlateDecode 확인
		          // 압축된 스트림 데이터를 JVM 메모리에서 FlateDecode 수행
		          // 압축 해제된 실제 텍스트가 InputStream / 내부 버퍼로 제공

		          String text = stripper.getText(doc);

		      
		          // ③ 압축 해제된 데이터를 기반으로 텍스트 추출 완료

		      } catch (OutOfMemoryError e) {
		          System.out.println("💥 PDF ZIP-BOMB 발동!");
		          e.printStackTrace();

		      } catch (Exception e) {
		          System.out.println("❌ PDF 파싱 실패");
		          e.printStackTrace();
		      }
			
			
			
			
			return ApiResponse.<TeacherInsertResult>builder().code(400).success(false)
					.message("첨부파일이 너무 큽니다. 최대 5MB까지 업로드 가능합니다.").data(new TeacherInsertResult(400, false, "파일 용량 초과"))
					.build();

		}
		
		
		@RequestMapping(value = "/unitTestExcuteFileProcess", method = RequestMethod.GET)
		@ResponseBody
		public ApiResponse<TeacherInsertResult> unitTestExcuteFileProcess() throws InterruptedException{
			
			 try {
			        // 1. 실행할 JAR 절대 경로
				 String jarPath = "C:\\swork\\file-process\\target\\file-process-0.0.1-SNAPSHOT.jar";
				 String javaPath = "C:\\Program Files\\jdk-17.0.4\\bin\\java.exe";

			        // 2. ProcessBuilder로 새 JVM 실행
			        ProcessBuilder pb = new ProcessBuilder(javaPath, "-jar", jarPath);

			        // 3. 로그 파일로 출력 리디렉션 (C:\otherprocesslog)
			        File outputFile = new File("C:\\otherprocesslog\\parser_output.log");
			        File errorFile = new File("C:\\otherprocesslog\\parser_error.log");

			        pb.redirectOutput(ProcessBuilder.Redirect.appendTo(outputFile));
			        pb.redirectError(ProcessBuilder.Redirect.appendTo(errorFile));

			        // 4. 프로세스 시작
			        Process process = pb.start();

			        // 5. (선택) 프로세스 끝날 때까지 기다림
			       // process.waitFor();

			    } catch (IOException e) {
			        e.printStackTrace();
			        return null;
			    } /*catch (InterruptedException e) {
			        e.printStackTrace();
			        return ApiResponse.error("파일 처리 실행 중 인터럽트");
			    }*/

			 return null;
			
		}
	
		  // 커스터마이징한 PDFTextStripper (인터럽트 감지)
		static class InterruptiblePDFTextStripper extends PDFTextStripper {
		    public InterruptiblePDFTextStripper() throws IOException {
		        super();
		    }

		    @Override
		    public String getText(PDDocument doc) throws IOException {
		        checkInterrupt();
		        return super.getText(doc);
		    }

		    @Override
			public void writeText(PDDocument doc, Writer output) throws IOException {
		        checkInterrupt();
		        super.writeText(doc, output);
		    }

		    @Override
		    protected void writeString(String text, List<TextPosition> textPositions) throws IOException {
		        checkInterrupt();
		        super.writeString(text, textPositions);
		    }

		    private void checkInterrupt() {
		    	  System.out.println("name: "+Thread.currentThread().isInterrupted());
		        if (Thread.currentThread().isInterrupted()) {
		            System.out.println("인터럽트 감지!");
		            throw new RuntimeException("인터럽트 감지됨");
		        }
		    }
		}

		@RequestMapping(value = "/unitTestPDFReadTime", method = RequestMethod.GET)
		@ResponseBody
		public ApiResponse<TeacherInsertResult> unitTestPDFReadTime(HttpServletRequest req) {
		    CompletableFuture<String> pdfTask = CompletableFuture.supplyAsync(() -> {
		        PDDocument doc = null;
		        try {
		            doc = PDDocument.load(new File("C:\\fake\\pdf_zip_bomb.pdf"));
		            InterruptiblePDFTextStripper stripper = new InterruptiblePDFTextStripper();

		            // 싱글 페이지 처리 (첫 페이지만)
		            stripper.setStartPage(1);
		            stripper.setEndPage(1);

		            // 인터럽트 체크
		            if (Thread.currentThread().isInterrupted()) {
		                System.out.println("인터럽트 감지! PDF 처리 중단");
		                throw new RuntimeException("PDF 처리 중 인터럽트 감지됨");
		            }

		            String text = stripper.getText(doc);
		            System.out.println("페이지 텍스트 길이: " + text.length());
		            return "PDF 완료, 길이=" + text.length();

		        } catch (Exception e) {
		            throw new RuntimeException("PDF 처리 실패: " + e.getMessage(), e);
		        } finally {
		            try {
		                if (doc != null) {
		                    doc.close();
		                    System.out.println("PDF 닫기 완료");
		                }
		            } catch (IOException ignored) {}
		        }
		    }, executor);

		    try {
		        // 최대 3초만 기다림
		        String result = pdfTask.get(3, TimeUnit.SECONDS);
		        return ApiResponse.<TeacherInsertResult>builder()
		                .code(200)
		                .success(true)
		                .message(result)
		                .data(new TeacherInsertResult(200, true, "완료"))
		                .build();
		    } catch (TimeoutException e) {
		  
		        pdfTask.cancel(true); // 타임아웃 시 작업 취소
		        return ApiResponse.<TeacherInsertResult>builder()
		                .code(408)
		                .success(false)
		                .message("PDF 처리 시간 초과")
		                .data(new TeacherInsertResult(408, false, "시간 초과"))
		                .build();
		    } catch (ExecutionException e) {
		        return ApiResponse.<TeacherInsertResult>builder()
		                .code(500)
		                .success(false)
		                .message("PDF 처리 중 오류: " + e.getCause().getMessage())
		                .data(new TeacherInsertResult(500, false, "처리 실패"))
		                .build();
		    } catch (InterruptedException e) {
		        Thread.currentThread().interrupt();
		        System.out.println("호출자 쓰레드 인터럽트 발생");
		        return ApiResponse.<TeacherInsertResult>builder()
		                .code(500)
		                .success(false)
		                .message("PDF 처리 중 인터럽트 발생")
		                .data(new TeacherInsertResult(500, false, "인터럽트"))
		                .build();
		    }
		}

	
		
		
		
	

	private boolean checkUploadSecurityManager(String originalName, File tempFile) {

		return uploadSecurityManager.validate(originalName, tempFile);
	}

	// 문자인증
	@RequestMapping(value = "/signup-page4")
	public String getMoreWorkComments4() {

		return "securityphonesms";
	}

	// 회원가입전 이미 있는 아이디 인지 체그하는 아작스 호출
	@RequestMapping(value = "/checkout-signup-id")
	@ResponseBody
	public ResponseEntity<ApiResponse<DuplicateCheckResult>> checkOutPossibleSignUpId(UserVO vo, HttpSession session,
			HttpServletRequest req) throws Exception {

		boolean check = memberService.checkidMembership(vo);

		if (check) {
			DuplicateCheckResult duplicateCheckResult = new DuplicateCheckResult(200, true);

			ApiResponse<DuplicateCheckResult> response = ApiResponse.<DuplicateCheckResult>builder().code(200)
					.success(false).message("").data(duplicateCheckResult).build();

			return ResponseEntity.status(HttpStatus.OK).body(response);

		} else {
			DuplicateCheckResult duplicateCheckResult = new DuplicateCheckResult(409, false, "이미 존재하는 아이디 입니다.");

			ApiResponse<DuplicateCheckResult> response = ApiResponse.<DuplicateCheckResult>builder().code(409)
					.success(false).message("").data(duplicateCheckResult).build();

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
