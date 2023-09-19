<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<%
		request.setCharacterEncoding("UTF-8");
		
		String orderId = (String) request.getAttribute("orderId");
	%>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<title>주문 완료</title>
</head>
<body>
	<jsp:include page="../inc/menu.jsp" />
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문 완료</h1>
		</div>
	</div>
	
	<div class="container">
		<h2 class="alert alert-danger">주문해주셔서 감사합니다.</h2>
		<p> 주문번호 : <%=orderId %></p>
	</div>
	
	<div class="container">
		<p><a href="../product/products.jsp" class="btn btn-secondary"> 상품 목록 >> </a></p>
	</div>
	<%
		/* 실제 작업은 페이지 상단이나, 이전 페이지에서 데이터베이스에 저장이 되어야 함.
		   데이터베이스 저장에 성공한 후 완료 페이지가 출력이 되어야 함.
		   
		   1) 세션의 장바구니 삭제  2) 세션의 주문 정보를 삭제 해야 함. */

		// 1) 세션의 장바구니 삭제
		session.removeAttribute("carts");

		// 세션의 주문 정보 삭제
		Enumeration sessions = request.getAttributeNames();
		while(sessions.hasMoreElements()){
			String sName = (String) sessions.nextElement();
			switch (sName){
				case "orderId": case "orderName": case "tel": case "zipCode": case "address01": case "address02": // 해당하는 이름을 찾으면
					session.removeAttribute(sName);
					break;
			}
		}

	%>
	
	
	<jsp:include page="../inc/footer.jsp" />
</body>
</html>