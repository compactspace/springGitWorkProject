package com.spring.finall.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.spring.finall.exception.ManageProductException.ManageProductException;
import com.spring.finall.exception.common.CommonFileException;
import com.spring.finall.service.ManageProductService;
import com.spring.finall.user.ProductGroupVO;
import com.spring.finall.user.ProductPriceHistoryVO;
import com.spring.finall.user.ProductVO;

@Service
public class ManageProductServiceImpl implements ManageProductService {

	@Autowired
	private ManageProductServiceDAO manageProductServiceDAO;

	@Override
	public List<Map<String, Object>> getProductCode() {

		return manageProductServiceDAO.getProductCode();
	}

	@Override
	public List<Map<String, Object>> getActiveProductList(int groupId) {
		// groupId 기준으로 상품 조회
		return manageProductServiceDAO.getActiveProductList(groupId);
	}

	@Override
	public void updateProductStatus(int productId, String status) {
		// productId와 status를 Map으로 전달

		manageProductServiceDAO.updateProductStatus(productId, status);

	}

	@Override
	@Transactional
	public void saveProduct(ProductVO productVO, MultipartFile img) {
		String savedFilePath = null;
		try {			

			String alreadyExsistProduct = manageProductServiceDAO.alreadyExsistProduct(productVO.getProduct_name());
			if (alreadyExsistProduct != null) {

				ManageProductException manageProductException = new ManageProductException(
						"해당 상품" + productVO.getProduct_name() + "이미 등록된 상품 입니다.", 4001);
				throw manageProductException;
			}

			int productCod = manageProductServiceDAO.getproductCod();
			productVO.setProduct_cod(productCod);

			// 파일 저장 후 경로 세팅
			savedFilePath = uploadProductImage(img, productVO);
			productVO.setProduct_file_path(savedFilePath);

			
			ProductPriceHistoryVO productPriceHistoryVO = new ProductPriceHistoryVO();
		
			int newPrice=productVO.getProduct_price();
			// 첫 삽입은 0 으로한다. 조회 조건이 스냅샷이기 때문에 상품의 등록시 첫 가격은 0 으로
			productVO.setProduct_price(0);
			// DB 저장
			manageProductServiceDAO.saveProduct(productVO);
			productPriceHistoryVO.setProductId(productVO.getProduct_id());
			productPriceHistoryVO.setOldPrice(productVO.getProduct_price());
			productPriceHistoryVO.setNewPrice(newPrice);
			// 스냅샷으로 저장한다. 조회 조건이니깐
			manageProductServiceDAO.insertProductPriceHistory(productPriceHistoryVO);
			
			
			

		} catch (CommonFileException cfe) {
			ManageProductException manageProductException = new ManageProductException(
					cfe.getBussinessExceptionMessage(), cfe.getBussinessCode());
			throw manageProductException;

		}

		catch (Exception e) {
			deleteProductImage(savedFilePath);
			ManageProductException manageProductException = new ManageProductException("알수 없는 서버내부 에러 혹은 디비 접근 관련 에러",
					5001);
			throw manageProductException;
		}
	}

	public String uploadProductImage( MultipartFile img, ProductVO productVO) {
		String savedFilePath = null;
	
		try {
		
			
			String uploadPath = "C:/upload/product/" + productVO.getProduct_group() + "/";

			// 2️⃣ 폴더 없으면 생성
			File folder = new File(uploadPath);
			if (!folder.exists()) {
				folder.mkdirs();
			}

			// 3️⃣ 파일 저장
			if (img != null && !img.isEmpty()) {
				String fileName = System.currentTimeMillis() + "_" + img.getOriginalFilename();
				productVO.setFile_name(fileName);
				productVO.setFile_category(productVO.getProduct_group());
				savedFilePath = uploadPath + fileName;

				img.transferTo(new File(savedFilePath));

				// DB에 저장할 파일명
				productVO.setProduct_img(fileName);
			}

		} catch (IOException ioe) {

			CommonFileException commonFileException = new CommonFileException("파일 업로드하다 실패", 5001);
			throw commonFileException;

		}

		return savedFilePath;
	}

	public void deleteProductImage(String savedFilePath) {
		if (savedFilePath == null || savedFilePath.isEmpty()) {
			// 삭제할 파일 경로가 없으면 바로 리턴
			return;
		}

		File file = new File(savedFilePath);
		if (file.exists()) {
			boolean deleted = file.delete();
			if (!deleted) {
				System.out.println("파일 삭제 실패: " + savedFilePath);
			} else {
				System.out.println("파일 삭제 성공: " + savedFilePath);
			}
		} else {
			System.out.println("삭제할 파일이 존재하지 않음: " + savedFilePath);
		}
	}

	// ProductGroupEnum.java (Service 내부 or 별도)
	public enum ProductGroupEnum {
		PENCIL(1, "pencil"), ERASER(2, "색연필"), NOTEBOOK(3, "notebook");

		private final int id;
		private final String folderName;

		ProductGroupEnum(int id, String folderName) {
			this.id = id;
			this.folderName = folderName;
		}

		public int getId() {
			return id;
		}

		public String getFolderName() {
			return folderName;
		}

		// id로 enum 찾기
		public static ProductGroupEnum fromId(int id) {
			for (ProductGroupEnum e : values()) {
				if (e.id == id)
					return e;
			}
			throw new IllegalArgumentException("Invalid group_id: " + id);
		}
	}

	@Override
	public void addProductGroup(ProductGroupVO productGroupVO) {

		try {

			boolean alreadyExsistGroupName = manageProductServiceDAO.alreadyProductGroupName(productGroupVO);
			if (alreadyExsistGroupName) {

				ManageProductException manageProductException = new ManageProductException("이미 존재하는 상품 그룹입니다.", 4001);
				throw manageProductException;
			}
			
			
			boolean insertStatus = manageProductServiceDAO.addProductGroup(productGroupVO);
			if(!insertStatus) {
				
				ManageProductException manageProductException = new ManageProductException("DB에 인설트하다가 실패", 4001);
				throw manageProductException;
			}
			
			

		} catch (Exception e) {
			
			ManageProductException manageProductException = new ManageProductException("서버상의 코드문제 혹은 DB접근시 문제가 예상됩니다.", 5001);
			throw manageProductException;
			

		}

	}

}
