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
		PreparedStatement pstmt = null;
		String sql = "delete from cart";
		pstmt = connection.prepareStatement(sql);
		pstmt.executeUpdate();
		response.sendRedirect("cart.jsp");
	%>
</body>
</html>