<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<%@ include file="../inc/dbconn.jsp" %>
	<%
		request.setCharacterEncoding("UTF-8");
	/*
		private String memberId;	// 아이디
		private String passwd;	// 비밀번호
		private String memberName;	// 이름
		private String gender;		// 성별
		private String birthday;	// 생일 예) 2000-10-01
		private String email;		// 이메일 예) abc@abc.com
		private String phone;		// 연락처
		private String address;		// 주소
	*/
		String memberId = request.getParameter("memberId");
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

		PreparedStatement pstmt = null;
		
		String sql = "INSERT INTO member (memberId, passwd, memberName, gender, birthday, " +
					"email, phone, zipCode, address01, address02, addDate) " +
					"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now())";
		pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, memberId);
		pstmt.setString(2, passwd);
		pstmt.setString(3, memberName);
		pstmt.setString(4, gender);
		pstmt.setString(5, birthday);
		pstmt.setString(6, email);
		pstmt.setString(7, phone);
		pstmt.setString(8, zipCode);
		pstmt.setString(9, address01);
		pstmt.setString(10, address02);
		
		if(pstmt.executeUpdate() == 1) { // Insert가 성공적으로 수행.
			response.sendRedirect("resultMember.jsp?msg=0");			
		}
		else {
			response.sendRedirect("resultMember.jsp?msg=3");
		}
		
	%>
</body>
</html>