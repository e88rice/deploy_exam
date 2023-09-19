package com.example.dto;

public class Cart {
	private String productId; // 상품 아이디
	private Integer cartCnt;  // 장바구니에 담은 개수
	
	public Cart(String productId, Integer cartCnt) {
		this.productId = productId;
		this.cartCnt = cartCnt;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public Integer getCartCnt() {
		return cartCnt;
	}

	public void setCartCnt(Integer cartCnt) {
		this.cartCnt = cartCnt;
	}

	
	@Override
	public String toString() {
		return "productId = "+productId+", cartCnt = "+cartCnt;
	}
	
	
	
}
