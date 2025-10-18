package com.spring.finall.admin.admindto;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
// HandlerMethodArgumentResolver 구현 클래스의  바인드 대상 클래스
public class PageableRequest implements Pageable {

	private final long page;
	private final int size;

	public PageableRequest(long page, int size) {
		this.page = page;
		this.size = size;
	}

	@Override
	public int getPageNumber() {
		// TODO Auto-generated method stub
		return (int)this.page;
	}

	@Override
	public int getPageSize() {
		// TODO Auto-generated method stub
		return this.size;
	}

	@Override
	public long getOffset() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Sort getSort() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Pageable next() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Pageable previousOrFirst() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Pageable first() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean hasPrevious() {
		// TODO Auto-generated method stub
		return false;
	}

}
