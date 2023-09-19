<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest.*"%>
<%@page import="com.suoreilly.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

	String productId = multipartRequest.getParameter("productId");
	String productName = multipartRequest.getParameter("productName");
	String unitPrice = multipartRequest.getParameter("unitPrice");
	String description = multipartRequest.getParameter("description");
	String manufacturer = multipartRequest.getParameter("manufacturer");
	String category = multipartRequest.getParameter("category");
	String unitsInStock = multipartRequest.getParameter("unitsInStock");
	String condition = multipartRequest.getParameter("condition");
	String fileName = multipartRequest.getFilesystemName("fileName"); // 원본 파일 이름

	Integer price = unitPrice.isEmpty() ? 0 : Integer.parseInt(unitPrice);
	Long stock = unitsInStock.isEmpty() ? 0L : Long.parseLong(unitsInStock);
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "select * from product where productId = ?";
	pstmt = connection.prepareStatement(sql);
	pstmt.setString(1, productId);
	rs = pstmt.executeQuery();
	
	if(rs.next()){ // productId에 대한 상품이 있다면
		if(fileName != null) { // 전달받은 첨부 파일이 있는 경우
			sql = "update product set productName = ?, unitPrice = ?, description = ?, manufacturer = ?,"+
				"category = ?, unitsInStock = ?, `condition` = ?, fileName = ? where productId = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, productName);
			pstmt.setInt(2, price);
			pstmt.setString(3, description);
			pstmt.setString(4, manufacturer);
			pstmt.setString(5, category);
			pstmt.setLong(6, stock);
			pstmt.setString(7, condition);
			pstmt.setString(8, fileName);
			pstmt.setString(9, productId);
			pstmt.executeUpdate();
		} else { // 전달받은 첨부 파일이 없는 경우
			sql = "update product set productName = ?, unitPrice = ?, description = ?, manufacturer = ?,"+
					"category = ?, unitsInStock = ?, `condition` = ? where productId = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, productName);
			pstmt.setInt(2, price);
			pstmt.setString(3, description);
			pstmt.setString(4, manufacturer);
			pstmt.setString(5, category);
			pstmt.setLong(6, stock);
			pstmt.setString(7, condition);
			pstmt.setString(8, productId);
			pstmt.executeUpdate();
		}
		
	}
	if(rs != null) rs.close();
	if(pstmt != null) pstmt.close();
	if(connection != null) connection.close();
	
	response.sendRedirect("products.jsp");
%>
</body>
</html>