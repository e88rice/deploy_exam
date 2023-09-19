<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>주문 정보</title>
</head>
<body>

<%@ include file="../inc/dbconn.jsp" %>
<% 
	request.setCharacterEncoding("UTF-8");
	
	String sessionMemberId = (String) session.getAttribute("sessionMemberId");
	
	PreparedStatement pstmt = null;
	String sql = "DELETE FROM member WHERE memberId = ?";
	pstmt = connection.prepareStatement(sql);
	pstmt.setString(1, sessionMemberId);
	pstmt.executeUpdate();
	
	session.invalidate();
	
	response.sendRedirect("resultMember.jsp");
%>

</body>
</html>