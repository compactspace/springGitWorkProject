package com.spring.finall.apiResponseController;

import javax.servlet.http.HttpServletRequest;

import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

@ControllerAdvice
public class ApiResponseAdvisor implements ResponseBodyAdvice<Object> {

    @Override
    public boolean supports(MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
        
    	  // 현재 요청 URL 가져오기
        ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        if (sra == null) {
            return false; // 요청 컨텍스트 없으면 false
        }
        HttpServletRequest request = sra.getRequest();
        String path = request.getRequestURI();

        System.out.println("path"+path);
        System.out.println("path.startsWith(\"/api/\")"+path.startsWith("/api/"));
        // /api/ 로 시작하는 요청에만 적용
        // 프로젝트 명 제외한 startWItdh로 수정하자. 현재 아작스 요청시 컨텍스트명 포함들어와서 인식못함
        // 또 String path = request.getRequestURI(); 가  a 링크, 아작스 등 요청으로 살짝 달라질수있는지도 파악하자 
        return path.startsWith("/api/");
    }

    @Override
    public Object beforeBodyWrite(Object body,
                                  MethodParameter returnType,
                                  MediaType selectedContentType,
                                  Class<? extends HttpMessageConverter<?>> selectedConverterType,
                                  ServerHttpRequest request,
                                  ServerHttpResponse response) {

        // 이미 ApiResponse 타입이면 그대로 리턴
        if (body instanceof ApiResponse) {
            return body;
        }

        // 기본 성공 응답으로 감싸기
        return ApiResponse.builder()
                .code(200)
                .success(true)          // success 필드 추가
                .message("성공")
                .data(body)
                .build();
    }

}
