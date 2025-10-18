package com.spring.finall.user;

public class ReceiptVO {

	private String receipt_buyer_id;
	private String receipt_buyer_tel;
	private String receipt_buyer_addr;
	private String receipt_paid_amount;
	private String receipt_imp_uid;
	private String receipt_merchant_uid;
	private int receipt_product_cod;
	
//	public void drop() {
//this.receipt_buyer_id=null;
//this.receipt_buyer_tel=null;
//this.receipt_buyer_addr=null;
//this.receipt_paid_amount=null;
//this.receipt_imp_uid=null;
//this.receipt_merchant_uid=null;
//
//
//
//	} 
	
	
	
	public int getreceipt_product_cod() {
		return receipt_product_cod;
	}

	public void setreceipt_product_cod(int receipt_product_cod) {
		this.receipt_product_cod =receipt_product_cod;
	}
	
	
	
	
	public String getReceipt_buyer_id() {
		return receipt_buyer_id;
	}

	public void setReceipt_buyer_id(String receipt_buyer_id) {
		this.receipt_buyer_id = receipt_buyer_id;
	}

	public String getReceipt_buyer_tel() {
		return receipt_buyer_tel;
	}

	public void setReceipt_buyer_tel(String receipt_buyer_tel) {
		this.receipt_buyer_tel = receipt_buyer_tel;
	}

	public String getReceipt_buyer_addr() {
		return receipt_buyer_addr;
	}

	public void setReceipt_buyer_addr(String receipt_buyer_addr) {
		this.receipt_buyer_addr = receipt_buyer_addr;
	}

	public String getReceipt_paid_amount() {
		return receipt_paid_amount;
	}

	public void setReceipt_paid_amount(String receipt_paid_amount) {
		this.receipt_paid_amount = receipt_paid_amount;
	}

	public String getReceipt_imp_uid() {
		return receipt_imp_uid;
	}

	public void setReceipt_imp_uid(String receipt_imp_uid) {
		this.receipt_imp_uid = receipt_imp_uid;
	}

	public String getReceipt_merchant_uid() {
		return receipt_merchant_uid;
	}

	public void setReceipt_merchant_uid(String receipt_merchant_uid) {
		this.receipt_merchant_uid = receipt_merchant_uid;
	}

	@Override
	public String toString() {
		return "ReceiptVO [receipt_buyer_id=" + receipt_buyer_id +"receipt_product_cod=" + receipt_product_cod + ", receipt_buyer_tel=" + receipt_buyer_tel
				+ ", receipt_buyer_addr=" + receipt_buyer_addr + ", receipt_paid_amount=" + receipt_paid_amount
				+ ", receipt_imp_uid=" + receipt_imp_uid + ", receipt_merchant_uid=" + receipt_merchant_uid + "]";
	}

	
	
}
