package com.spring.finall.admin.adminresolver;

import org.springframework.core.MethodParameter;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import com.spring.finall.admin.admindto.PageableRequest;

public class PageableHandlerMethodArgumentResolve implements HandlerMethodArgumentResolver {

	private PageableRequest defaultRequest;

	// xml 에서 p:으로 등록할때 set 메서드 사용
	// 또는 자바기반에서 등록
	public void setDefaultRequest(PageableRequest defaultRequest) {
		this.defaultRequest = defaultRequest;
	}

	// 1) supportsParameter - 바인딩할 클래스를 지정
	@Override
	public boolean supportsParameter(MethodParameter parameter) {
		System.out.println("파라미터 타입은->>>" + parameter.getParameterType());

		return Pageable.class.isAssignableFrom(parameter.getParameterType());
	}

	// 2) resolveArgument - 바인딩할 객체를 조작할 수 있는 그런 메서드
	@Override
	public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer,
			NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {

		String offsetStr = "10";
		String limitStr = "0";
		System.out.println("Long.parseLong(offsetStr)->>>" + Long.parseLong(offsetStr));
		return new PageableRequest(Long.parseLong(offsetStr), Integer.parseInt(limitStr));
	}

}
