<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dto.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>
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
		String pageFlag = request.getParameter("pageFlag");
		if (productId == null || productId.trim().equals("")){
			// null을 반환하거나 빈 문자열만 들어온 경우
// 			response.sendRedirect("../product/products.jsp");
// 			return;
		}
		
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 전달받은 정보와 동일한 주문번호에 같은 상품번호가 있으면 업데이트
		String sql = "SELECT * FROM cart where (orderId=?) AND (productId=?)";
		pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, orderId);
		pstmt.setString(2, productId);
		rs = pstmt.executeQuery();
		if(rs.next()){ // 동일 상품이 있는 경우 갯수 업데이트
			sql = "UPDATE cart SET cnt = cnt + 1 where num=?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, rs.getInt("num"));
			pstmt.executeUpdate();
			if(pageFlag.equals("1")){
				response.sendRedirect("./cart.jsp");			
			}
			else{
				response.sendRedirect("../product/product.jsp?productId="+productId);
			}
		} else {
			// 회원번호 관련 처리
			String memberId = (String) session.getAttribute("sessionMemberId");
			memberId = (memberId == null) ? "Guest" : memberId;
			
			int cnt = 1;
			
			sql = "INSERT INTO cart (orderId, memberId, productId, cnt, addDate)" +
				"VALUES (?, ?, ?, ?, now())";
			try {
				pstmt = connection.prepareStatement(sql);
				pstmt.setString(1, orderId);
				pstmt.setString(2, memberId);
				pstmt.setString(3, productId);
				pstmt.setInt(4, cnt);
				pstmt.executeUpdate();
				
				if(pageFlag.equals("1")){
					response.sendRedirect("./cart.jsp");			
				}
				else{
					response.sendRedirect("../product/product.jsp?productId="+productId);
				}
			} catch (SQLException e) {
				out.println("ㅎㅇㅎㅇ");
				throw new RuntimeException(e);
			}
		}
		
	%>
</body>
</html>