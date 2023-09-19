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

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	String sql = "SELECT * FROM member WHERE memberId = ? AND passwd = ?";
	pstmt = connection.prepareStatement(sql);
	String memberId = request.getParameter("memberId");
	String passwd = request.getParameter("passwd");
	pstmt.setString(1, memberId);
	pstmt.setString(2, passwd);
	rs = pstmt.executeQuery();
	if(rs.next()){
		session.setAttribute("sessionMemberId", rs.getString("memberId"));
		session.setAttribute("sessionMemberName", rs.getString("memberName"));
		// 1. 로그인시에 비회원 상태에서 장바구니에 담은 상품정보의 아이디 정보 업데이트
		sql = "UPDATE cart SET memberId = ? where orderId = ? "; // 멤버이름 업데이트
		pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, memberId);
		pstmt.setString(2, orderId);
		pstmt.executeUpdate();
		// 2. 로그인시에 회원 아이디는 같고 주문 번호는 다른 장바구니 데이터에 현재 주문 번호로 업데이트.
// 		sql = "UPDATE cart SET orderId = ? where memberId = ? AND orderId != ? ";
// 		pstmt = connection.prepareStatement(sql);
// 		pstmt.setString(1, orderId);
// 		pstmt.setString(2, memberId);
// 		pstmt.setString(3, orderId);
		pstmt.executeUpdate();
		response.sendRedirect("./resultMember.jsp?msg=2");
	} else {
		response.sendRedirect("./loginMember.jsp?error=1");
	}
	
%>	
</body>
</html>