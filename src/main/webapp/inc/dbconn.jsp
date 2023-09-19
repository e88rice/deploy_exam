<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<%
	Connection connection = null;
	try {
		String url 				= "jdbc:mariadb://localhost:3306/servlet_sample_market";
		String user 			= "root";
		String password			= "2115";
		Class.forName("org.mariadb.jdbc.Driver");
		
		connection = DriverManager.getConnection(url, user, password); 
	} catch (SQLException e) {
		out.println("데이터베이스 연결이 실패했습니다<br>");
		out.println("SQLException : " + e.getMessage());
	}
	
	// 주문번호 관련 처리
	String orderId = (String) session.getAttribute("orderId");
	if(orderId == null) {
		
		String sessionId = session.getId();
		
		// 현재 날짜와 시간 가져오기	
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		String currentDateTime = simpleDateFormat.format(new Date());
		
		// 현재 날짜와 시간과 세션아이디를 합쳐서 고유한 식별자 주문번호 생성
		orderId = currentDateTime + "-" + sessionId;
		session.setAttribute("orderId", orderId);
	}
%>