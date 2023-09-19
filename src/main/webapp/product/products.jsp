<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>상품 목록</title>
</head>
<body>
	<jsp:include page="../inc/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품목록</h1>
		</div>
	</div>
	
	<div class="container">
		<div class="row" align="center">
			<%@ include file="../inc/dbconn.jsp" %>
			<% 
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "select * from product";
				pstmt = connection.prepareStatement(sql);
				rs = pstmt.executeQuery();
				DecimalFormat formatter = new DecimalFormat("###,###.##");
				while(rs.next()){
			%>
			<div class="col-md-4">
				<img src="/upload/<%=rs.getString("fileName") %>" style="width:100%">
				<h3><%=rs.getString("productName")%></h3>
				<p><%=rs.getString("description") %></p>
				<p><%=formatter.format(Integer.parseInt(rs.getString("unitPrice")))%>원</p>
				<p>
					<a href="./product.jsp?productId=<%=rs.getString("productId")%>" class="btn btn-secondary" role="button">상세정보 >></a>
				</p>
			</div>
			<%
				}
			%>
		</div>
		<hr>
	</div>
	<%
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(connection != null) connection.close();
	%>
	<jsp:include page="../inc/footer.jsp"/>
</body>
</html>