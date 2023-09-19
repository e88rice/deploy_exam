<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<%@ include file="../inc/dbconn.jsp" %>
	<%
		request.setCharacterEncoding("UTF-8");
	
		String folder = "C:\\upload";  // 저장 폴더
		int maxSize = 5 * 1024 * 1024; // 업로드 최대 크기 5MB
		String encType = "UTF-8";	   // 인코딩 타입
		DefaultFileRenamePolicy dfrp = new DefaultFileRenamePolicy(); // 이름이 중복일 경우 뒤에 번호 달아주는 친구 +1씩 증가
		
		MultipartRequest multipartRequest = new MultipartRequest(request, folder, maxSize, encType, dfrp);
	/*
		private String productId; 	// 상품 아이디
		private String productName;	// 상품명
		private Integer unitPrice;	// 상품 가격
		private String description;	// 상품 설명
		private String manufacturer;// 제조사
		private String category;	// 분류
		private long unitsInStock; 	// 재고 수
		private String condition;	// 신상품 or 중고품 or 재생품
	*/
		String productId = multipartRequest.getParameter("productId");
		String productName = multipartRequest.getParameter("productName");
		String unitPrice = multipartRequest.getParameter("unitPrice");
		String description = multipartRequest.getParameter("description");
		String manufacturer = multipartRequest.getParameter("manufacturer");
		String category = multipartRequest.getParameter("category");
		String unitsInStock = multipartRequest.getParameter("unitsInStock");
		String condition = multipartRequest.getParameter("condition");
		String fileName = multipartRequest.getFilesystemName("fileName"); // 원본 파일 이름
		
		// 문자열을 변경
		Integer price = unitPrice.isEmpty() ? 0 : Integer.parseInt(unitPrice);
		Long stock = unitsInStock.isEmpty() ? 0L : Long.parseLong(unitsInStock);
		
		PreparedStatement pstmt = null;
		
		String sql = "insert into product values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, productId);
		pstmt.setString(2, productName);
		pstmt.setInt(3, price);
		pstmt.setString(4, description);
		pstmt.setString(5, manufacturer);
		pstmt.setString(6, category);
		pstmt.setLong(7, stock);
		pstmt.setString(8, condition);
		pstmt.setString(9, fileName);
		pstmt.executeUpdate();
		
		if(pstmt != null) pstmt.close();
		if(connection != null) connection.close();
		
		response.sendRedirect("products.jsp");
	%>
	
	
	
	
	
	
	
	
	
	
</body>
</html>