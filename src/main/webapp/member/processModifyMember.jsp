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
		
		String sessionMemberId = (String) session.getAttribute("sessionMemberId");
		
		PreparedStatement pstmt = null;
		
		String passwd = request.getParameter("passwd");
		String memberName = request.getParameter("memberName");
		String gender = request.getParameter("gender");
		String birthday = request.getParameter("birthyy")
						+"-"+request.getParameter("birthmm")
						+"-"+request.getParameter("birthdd");
		String email = request.getParameter("mail1")+"@"+request.getParameter("mail2");
		String phone = request.getParameter("phone");
		String zipCode = request.getParameter("zipCode");
		String address01 = request.getParameter("address01");
		String address02 = request.getParameter("address02");
		
		String sql = "update member set passwd = ?, memberName = ?, gender = ?, birthday = ?, "
					+"email = ?, phone = ?, zipCode = ?, address01 = ?, address02 = ? "
					+"where memberId = ?";
		pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, passwd);
		pstmt.setString(2, memberName);
		pstmt.setString(3, gender);
		pstmt.setString(4, birthday);
		pstmt.setString(5, email);
		pstmt.setString(6, phone);
		pstmt.setString(7, zipCode);
		pstmt.setString(8, address01);
		pstmt.setString(9, address02);
		pstmt.setString(10, sessionMemberId);
		
		if(pstmt.executeUpdate() == 1) { // Insert가 성공적으로 수행.
			response.sendRedirect("resultMember.jsp?msg=0");			
		}
		else {
			response.sendRedirect("resultMember.jsp?msg=3");
		}
	
	%>
</body>
</html>