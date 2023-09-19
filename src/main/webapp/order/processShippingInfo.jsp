<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String encoding = "UTF-8";
		request.setCharacterEncoding(encoding);
	

		session.setAttribute("orderId", request.getParameter("orderId"));
		session.setAttribute("orderName", request.getParameter("orderName"));
		session.setAttribute("tel", request.getParameter("tel"));
		session.setAttribute("zipCode", request.getParameter("zipCode"));
		session.setAttribute("address01", request.getParameter("address01"));
		session.setAttribute("address02", request.getParameter("address02"));
		
// 		int maxAge = 24 * 60 * 60;
// 		session.setMaxInactiveInterval(maxAge);
		
		response.sendRedirect("./orderConfirm.jsp");
		
	%>

</body>
</html>