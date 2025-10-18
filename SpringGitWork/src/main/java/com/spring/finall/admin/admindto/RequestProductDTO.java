package com.spring.finall.admin.admindto;



import com.spring.finall.admin.admindomain.ProductEntity;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class RequestProductDTO {

	public Integer product_cod;
	public String product_name;
	public Integer product_price;
	public String product_img;
	public String product_info;

	// 공장상의 실제 제고이다.
	public Integer product_quantity;

	// 고객들의 결제이후 재고이다.
	public Integer product_order_quantity;

	// 택배 배송이 이루어 진후 실제 재고-고객들의 결제이후 재고 차이값
	public Integer product_delivery_quantity;

	private String product_Registration_status;
	private String product_status;
	private String product_group;

	public ProductEntity toEntity(RequestProductDTO reqdto) {

		return ProductEntity.builder()
				.product_cod(reqdto.product_cod)
				.product_name(reqdto.product_name)
				.product_price(reqdto.product_price)
				.product_img(reqdto.product_img)
				.product_info(reqdto.product_info)
				.product_quantity(reqdto.product_quantity)
				.product_delivery_quantity(reqdto.product_delivery_quantity)
				.product_order_quantity(reqdto.product_order_quantity)
				.product_Registration_status(reqdto.product_Registration_status)
				.product_status(reqdto.product_status)
				.product_group(reqdto.product_group).build();

	}

}
