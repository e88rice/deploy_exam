<%@ page language="java" contentType="text/html; charset=UTF-8" %>
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
	
	if(rs.next()){ out.println("{\"result\":\"true\"}"); }
	else { out.println("{\"result\":\"false\"}"); }
%>