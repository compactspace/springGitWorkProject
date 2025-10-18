package com.spring.finall.admin.admindomain;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.spring.finall.admin.admindto.ResponseProductDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;
@Table(name="product")
@Entity
@Builder
@ToString
@AllArgsConstructor
@Getter
//이게 없으면 기본생성자 없단 오류가 계속 뜬다.
@RequiredArgsConstructor
public class ProductEntity {	
	
	@Id
	private Integer product_cod;
	private String product_name;
	private Integer product_price;
	private String product_img;
	private String product_info;
	
	private String product_Registration_status;
	private String product_status;
	private String product_group;
	
	//공장상의 실제 제고이다.
	private Integer product_quantity;
		
		//고객들의 결제이후 재고이다.
		public Integer product_order_quantity;
		
		//택배 배송이 이루어 진후 실제 재고-고객들의 결제이후 재고 차이값
		public Integer product_delivery_quantity;
	
	public ResponseProductDTO toResponseDTO(ProductEntity productEntity) {
		return ResponseProductDTO.builder().product_cod(productEntity.product_cod)
				.product_name(productEntity.product_name).product_price(productEntity.product_price)
				.product_img(productEntity.product_img).product_info(productEntity.product_info)
				.product_quantity(productEntity.product_quantity)
				.product_delivery_quantity(productEntity.product_delivery_quantity)
				.product_order_quantity(productEntity.product_order_quantity)
				.product_Registration_status(productEntity.product_Registration_status)
				.product_status(productEntity.product_status).
				product_group(productEntity.product_group)
				.build();

	}

}
