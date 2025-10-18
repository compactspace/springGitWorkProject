package com.spring.finall.user;

import java.util.HashMap;
import java.util.List;

public interface ReceiptService {
	
	public abstract void insertReceipt(ReceiptVO vo);
	
	public abstract void deleteReceipt(ReceiptVO vo);
	
	public abstract List<HashMap<String,Object>> testcanclequantity(); 

}
