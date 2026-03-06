package com.spring.finall.reqDto.atemptStockInRequestDTO;

import java.util.List;

public class AtemptStockInWrapperDTO {

    private List<AtemptStockInRequestDTO> purchaceRows;
    private List<AtemptStockInRequestDTO> initialRows;
	public List<AtemptStockInRequestDTO> getPurchaceRows() {
		return purchaceRows;
	}
	public void setPurchaceRows(List<AtemptStockInRequestDTO> purchaceRows) {
		this.purchaceRows = purchaceRows;
	}
	public List<AtemptStockInRequestDTO> getInitialRows() {
		return initialRows;
	}
	public void setInitialRows(List<AtemptStockInRequestDTO> initialRows) {
		this.initialRows = initialRows;
	}
    
    
    
    

}
