<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<jsp:include page="../inc/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 편집</h1>
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
				<p><%=formatter.format(rs.getInt("unitPrice"))%>원</p>
				<p>
					<a href="./modifyProduct.jsp?productId=<%=rs.getString("productId")%>" class="btn btn-success" role="button">수정 >></a>
					<a href="#" class="btn btn-danger btn-remove" role="button" id="<%=rs.getString("productId")%>">삭제 >></a>
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
	<script>
	const btns = document.querySelectorAll(".btn-remove");
	
   	document.addEventListener('DOMContentLoaded', () => {

		btns.forEach(btn => {
			btn.addEventListener('click', function(e) {
				if(confirm('해당 상품을 삭제하시겠습니까?')) {
					const productId = e.target.id;
					location.href = './processRemoveProduct.jsp?productId=' + productId;
				}
			});
		});		
	});
		
	</script>
</body>
</html>