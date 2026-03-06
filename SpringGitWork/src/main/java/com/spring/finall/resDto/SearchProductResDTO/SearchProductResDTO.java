package com.spring.finall.resDto.SearchProductResDTO;

public class SearchProductResDTO {

    private int productId;
    private int productCod;
    private String productName;
    private String productImg;
    private String productFilePath;   // DB에서 가져오는 절대 경로
    private String productFileName;   // JSP에서 사용할 상대 경로
    private String lastedUpdatePrice;
    private String lastedChangedAt;

    // 기본 생성자
    public SearchProductResDTO() {
    }

    // 모든 필드 생성자
    public SearchProductResDTO(int productId, String productName, String productImg, String productFilePath,
                               String lastedUpdatePrice, String lastedChangedAt) {
        this.productId = productId;
        this.productName = productName;
        this.productImg = productImg;
        this.setProductFilePath(productFilePath); // setter에서 상대경로 변환
        this.lastedUpdatePrice = lastedUpdatePrice;
        this.lastedChangedAt = lastedChangedAt;
    }

    
    
    
    
    public int getProductCod() {
		return productCod;
	}

	public void setProductCod(int productCod) {
		this.productCod = productCod;
	}

	// ===== 게터 & 세터 =====
    public int getProductId() {
        return productId;
    }
    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductImg() {
        return productImg;
    }
    public void setProductImg(String productImg) {
        this.productImg = productImg;
    }

    public String getProductFilePath() {
        return productFilePath;
    }

    // DB에서 절대 경로를 가져오면 상대 경로도 자동 생성
    public void setProductFilePath(String productFilePath) {
        this.productFilePath = productFilePath;

        // 절대 경로 -> JSP용 상대 경로 변환
        String basePath = "C:/upload/product/";
        if (productFilePath != null && productFilePath.startsWith(basePath)) {
            this.productFileName = productFilePath.substring(basePath.length()).replace("\\", "/");
        } else {
            this.productFileName = productFilePath; // 안전하게 그대로
        }
    }

    // JSP에서 사용할 상대 경로
    public String getProductFileName() {
        return productFileName;
    }

    public String getLastedUpdatePrice() {
        return lastedUpdatePrice;
    }
    public void setLastedUpdatePrice(String lastedUpdatePrice) {
        this.lastedUpdatePrice = lastedUpdatePrice;
    }

    public String getLastedChangedAt() {
        return lastedChangedAt;
    }
    public void setLastedChangedAt(String lastedChangedAt) {
        this.lastedChangedAt = lastedChangedAt;
    }
}