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
		String[] checkedId = request.getParameterValues("checkedId");
	
		PreparedStatement pstmt = null;
		
		if(checkedId != null) {
			for(String s : checkedId) {
				String sql = "delete from cart where productId = ?";
				pstmt = connection.prepareStatement(sql);
				pstmt.setString(1, s);
				pstmt.executeUpdate();
			}
		}
		
		response.sendRedirect("./cart.jsp");
	%>
</body>
</html>