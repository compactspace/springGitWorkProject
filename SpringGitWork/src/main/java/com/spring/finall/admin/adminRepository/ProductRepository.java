package com.spring.finall.admin.adminRepository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.spring.finall.admin.admindomain.ProductEntity;

public interface ProductRepository extends JpaRepository<ProductEntity, Integer> {
	
	@Query(value="update product set product_Registration_status='open' where product_cod= :product_cod", nativeQuery = true )
	Integer showupdateproduct(@Param("product_cod") Integer product_cod);
	
	
	@Query(value="update product set product_status = :product_status where product_cod= :product_cod", nativeQuery = true )
	Integer statuschange(@Param("product_cod") Integer product_cod, @Param("product_status") String product_status);
	

	@Query(value="update product set product_Registration_status = :product_Registration_status where product_cod= :product_cod", nativeQuery = true )
	Integer statusOpen(@Param("product_cod") Integer product_cod, @Param("product_Registration_status") String product_Registration_status);
	
	@Query(value="update product set product_quantity= :product_delivery_quantity  where product_cod= :product_cod", nativeQuery = true )
	Integer realproductquantityupdate(@Param("product_cod") Integer product_cod,@Param("product_delivery_quantity") Integer product_delivery_quantity );
	
	
	
	//쫌있다가 product 테이블에 제품군을 추가 한뒤 그것을 가져오도록 하며
	//게시빨 또 조인 해야하네???
	@Query(value="select * from product where product_group =:product_group", nativeQuery = true )
	List<ProductEntity> select(@Param("product_group") String product_group);
	
	
	
	
}
