package com.spring.finall.admin.admindto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class ResponseProductDTO {
	public Integer product_cod;
	public String product_name;
	public Integer product_price;
	public String product_img;
	public String product_info;	
	private String product_Registration_status;
	private String product_status;
	private String product_group;
	
	// 공장상의 실제 제고이다.
	public Integer product_quantity;

	// 고객들의 결제이후 재고이다.
	public Integer product_order_quantity;

	// 택배 배송이 이루어 진후 실제 재고-고객들의 결제이후 재고 차이값
	public Integer product_delivery_quantity;
}
