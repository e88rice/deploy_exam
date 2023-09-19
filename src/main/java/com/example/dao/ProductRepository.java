package com.example.dao;

import java.util.ArrayList;
import com.example.dto.Product;

public class ProductRepository {
	private static ProductRepository instance = new ProductRepository();
	
	public static ProductRepository getInstance() { // 싱글톤 비슷한 생성자 역할
		return instance;
	}
	
	public void addProduct(Product product) {
		products.add(product);
	}
	
	private ArrayList<Product> products = new ArrayList<>(); // 상품을 담을 바구니
	
	// 생성될 때 마다 Product 클래스의 객체 폰,노트북,타블렛을 listOfProducts 컬렉션에 추가하는 생성자
	public ProductRepository() {
		Product phone = new Product("P1234", "iPhone 6s", 800000);
		phone.setDescription("4.7-inch, 1334X750 Renina HD display, 8-megapixel iSight Camera");
		phone.setCategory("Smart Phone");
		phone.setManufacturer("Apple");
		phone.setUnitsInStock(1000);
		phone.setCondition("New");
		phone.setFileName("P1234.png");

		Product notebook = new Product("P1235", "LG PC 그램", 1500000);
		notebook.setDescription("13.3-inch, IPS LED display, 5rd Generation Intel Core processors");
		notebook.setCategory("Notebook");
		notebook.setManufacturer("LG");
		notebook.setUnitsInStock(1000);
		notebook.setCondition("Refurbished");
		notebook.setFileName("P1235.png");

		Product tablet = new Product("P1236", "Galaxy Tab S", 900000);
		tablet.setDescription("212.8*125.6*6.6mm,  Super AMOLED display, Octa-Core processor");
		tablet.setCategory("Tablet");
		tablet.setManufacturer("Samsung");
		tablet.setUnitsInStock(1000);
		tablet.setCondition("Old");
		tablet.setFileName("P1236.png");

		products.add(phone);
		products.add(notebook);
		products.add(tablet);
	}
	
	public ArrayList<Product> getAllProducts() { // 상품 리스트 객체를 반환
		return products; 
	}
	
	public Product getProductById(String productId) {
		Product product = null;
		
		// foreach로 목록 순회
		for(Product p : products) {
			if(p.getProductId().equals(productId)) {
				// 매개 변수와 객체의 Id가 같으면
				product = p;
				break;
			}
		}
		return product; // null 또는 해당ID를 가진 객체를 반환		
	}
	
	
	
	
	
	
	
}
