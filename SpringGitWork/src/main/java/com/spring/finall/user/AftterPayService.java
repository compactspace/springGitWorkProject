package com.spring.finall.user;

public interface AftterPayService {
	
	public abstract void AftterPayUpdateService(String[] cart_id ,String user_code,String[] cart_quantity_array ,String[] product_cod_array,PayVO pvo);

}
