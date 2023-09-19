<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<title>주문 취소</title>
</head>
<body>
	<jsp:include page="../inc/menu.jsp" />
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문 취소</h1>
		</div>
	</div>
	
	<div class="container">
		<h2 class="alert alert-danger">주문이 취소되었습니다.</h2>
	</div>
	
	<div class="container">
		<p><a href="../product/products.jsp" class="btn btn-secondary"> 상품 목록 >> </a></p>
	</div>
	<%
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