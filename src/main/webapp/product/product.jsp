<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProductRepository"%>
<%@ page import="dto.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="exception/exceptionNoProduct.jsp" %>
<jsp:useBean id="productDAO" class="dao.ProductRepository"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../inc/dbconn.jsp" %>
	<jsp:include page="../inc/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품정보</h1>
		</div>
	</div>
	<%
		String productId = request.getParameter("productId");
		DecimalFormat formatter = new DecimalFormat("###,###.##");
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from product where productId = ?";
		pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, productId);
		rs = pstmt.executeQuery();
		if(rs.next()){
	%>
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<img src="/upload/<%=rs.getString("fileName") %>" style="width:100%">
				<h3><%=rs.getString("productName")%></h3>
				<p><%=rs.getString("description") %></p>
				<p><strong>상품 코드</strong> : <span class="badge badge-danger"><%=rs.getString("productId") %></span></p>
				<p><strong>제조사</strong> : <%=rs.getString("manufacturer") %></p>
				<p><strong>분류</strong> : <%=rs.getString("category") %></p>
				<p><strong>재고 수</strong> : <%= formatter.format(Integer.parseInt(rs.getString("unitsInStock"))) %>EA</p>
				<h4><%= formatter.format(Integer.parseInt(rs.getString("unitPrice"))) %> 원</h4>
				<form name="frmAddCart" action="../order/processAddCart.jsp" method="post">
					<input type="hidden" name="productId" value="<%=rs.getString("productId")%>">
					<input type="hidden" name="pageFlag" value="0">
				</form>
				<p>					
					<a href="#" class="btn btn-info">장바구니 담기 >></a>
					<a href="../order/cart.jsp" class="btn btn-info">장바구니 목록 >></a>
					<a href="./products.jsp" class="btn btn-secondary">상품목록 >></a>
				</p>
			</div>
		</div>
		<hr>
	</div>
	<%
		}
	%>
	<jsp:include page="../inc/footer.jsp"/>	
	<script>
    document.addEventListener('DOMContentLoaded', function () {
    	const frmAddCart = document.frmAddCart;
    	const btnCart = document.querySelector(".btn-info");
    	let pageFlag = document.querySelector("input[name=pageFlag]");
    	
    	btnCart.addEventListener("click", function() {
    		if(confirm("장바구니 페이지로 이동하시겠습니까?")){
    			pageFlag.value = 1;
    		}
    		frmAddCart.submit();
    	})
//     	console.log(pageFlag);
    });
	</script>
</body>
</html>