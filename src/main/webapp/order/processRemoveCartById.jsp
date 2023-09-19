<%@page import="java.util.ArrayList"%>
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
		String productId = request.getParameter("productId");
		if (productId == null || productId.trim().equals("")){
			// null을 반환하거나 빈 문자열만 들어온 경우
			response.sendRedirect("../products.jsp");
//			return;
		}
		
		PreparedStatement pstmt = null;
		String sql = "delete from cart where productId = ?";
		pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, productId);
		pstmt.executeUpdate();
		response.sendRedirect("cart.jsp");
	%>
</body>
</html>