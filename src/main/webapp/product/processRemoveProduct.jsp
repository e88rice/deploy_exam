<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest.*"%>
<%@page import="com.oreilly.servlet.*"%>
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
	
	String productId = request.getParameter("productId");
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "select * from product where productId = ?";
	pstmt = connection.prepareStatement(sql);
	pstmt.setString(1, productId);
	rs = pstmt.executeQuery();
	if(rs.next()){		
		sql = "delete from product where productId = ?";
		pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, productId);
		pstmt.executeUpdate();
	} else {
		out.println("일치하는 상품이 없습니다.");
	}
	if(rs != null) rs.close();
	if(pstmt != null) pstmt.close();
	if(connection != null) connection.close();
	
	response.sendRedirect("editProduct.jsp");
%>
</body>
</html>