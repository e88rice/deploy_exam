<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	String id = request.getParameter("id");
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "SELECT * FROM member WHERE memberID = ?";
	
	pstmt = connection.prepareStatement(sql);
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();
	
	if(rs.next()){
		out.println("동일한 아이디가 있습니다.");
	} else {
		out.println("동일한 아이디가 없습니다.");
	}






%>

</body>
</html>