package com.spring.finall.admin.adminService;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finall.admin.adminRepository.ProductRepository;
import com.spring.finall.admin.admindomain.ProductEntity;
import com.spring.finall.admin.admindto.RequestProductDTO;
import com.spring.finall.admin.admindto.ResponseProductDTO;

@Service("ProductService")
public class ProductService {

	@Autowired
	ProductRepository productRepository;

	public Integer insertProduct(RequestProductDTO reqdto) {

		ProductEntity productEntity = reqdto
				.toEntity(reqdto.builder().product_cod(reqdto.getProduct_cod()).product_img(reqdto.getProduct_img())
						.product_info(reqdto.getProduct_info()).product_name(reqdto.getProduct_name())
						.product_price(reqdto.getProduct_price()).product_quantity(reqdto.getProduct_quantity())
						.product_Registration_status("hidden")
						.product_status("판매중단")
						.build()
				);

//		System.out.println("productEntity투스트링" + productEntity.toString());

		Optional<ProductEntity> op = productRepository.findById(reqdto.getProduct_cod());

		System.out.println("비어있니?" + op.isEmpty());

		if (op.isEmpty()) {

			try {

				productRepository.save(productEntity);
				System.out.println("트라이문");
				return 1;

			} catch (Exception e) {
				System.out.println("상품등록 에러" + e);
				return -1;
			}
		} else {
			System.out.println(op.get().getProduct_cod());
			return 0;

		}

	}

	public Integer showupdateproduct(Integer product_cod) {

		try {
			Integer executerow = productRepository.showupdateproduct(product_cod);
			System.out.println("홈페이지 반영 실행 로우 값은" + executerow );
			return executerow;

		} catch (Exception e) {
			System.out.println("홈페이지 반영 에러" + e);
			return 0;
		}

	}
	
	
	
	public List<ResponseProductDTO> productlist(String product_group){		
		
		
		List<ProductEntity> entitylist=productRepository.select(product_group);
		
		List<ResponseProductDTO> resdtolist= new ArrayList();
		
		for( ProductEntity entity :entitylist) {
			
			resdtolist.add(entity.toResponseDTO(entity));		
		}
		
		
		
		
		return resdtolist;
	}
	
	public Integer statuschange(Integer product_cod, String product_status) {
		
		
		try {
			Integer executerow=productRepository.statuschange(product_cod,product_status);
			System.out.println("품절 또는 판매 상태로 변경 로우수" + executerow );
			return executerow;

		} catch (Exception e) {
			System.out.println("홈페이지 반영 에러" + e);
			return 0;
		}
		
	
	};
	
	
	public Integer statusOpen(Integer product_cod, String product_Registration_statu) {
		
	 Integer executrow=productRepository.statusOpen(product_cod, product_Registration_statu);
	 
	 System.out.println("실행로우 값->>>"+executrow);
		
		return executrow;
	}
	
	// 결제지이후 배송이 이루어졌다면 가재고량을 확정 재고량으로 변경하는 함수
	public Integer realproductquantityupdate(Integer product_cod, Integer product_delivery_quantity) {
		
		System.out.println("확정수량"+product_delivery_quantity+" 그리고 상품코드"+product_cod);
		
		//ㅂㄷㅂㄷ update 의 성공값는 null 임..
		 Integer executrow=productRepository.realproductquantityupdate(product_cod, product_delivery_quantity);
		 
		 System.out.println("실행로우 값->>>"+executrow);
			
			return executrow;
	};
	
	
	

}
