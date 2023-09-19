<%@page import="java.util.Enumeration"%>
<%@page import="com.example.dao.ProductRepository"%>
<%@page import="com.example.dto.Product"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.example.dto.Cart"%>
<%@page import="java.util.ArrayList"%>
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
	<jsp:include page="../inc/menu.jsp" />
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문 정보</h1>
		</div>
	</div>
	
	<%
		request.setCharacterEncoding("UTF-8");
		String orderId = "", orderName = "", tel = "", zipCode = "", address01 = "", address02 = "";
		
		Enumeration sessions = session.getAttributeNames();
		while(sessions.hasMoreElements()){
			String sName = (String) sessions.nextElement();
			switch (sName) {
				case "orderId":
					orderId = (String) session.getAttribute(sName);
					break;
				case "orderName":
					orderName = (String) session.getAttribute(sName);
					break;
				case "tel":
					tel = (String) session.getAttribute(sName);
					break;
				case "zipCode":
					zipCode = (String) session.getAttribute(sName);
					break;
				case "address01":
					address01 = (String) session.getAttribute(sName);
					break;
				case "address02":
					address02 = (String) session.getAttribute(sName);
					break;
				}
		}

	%>
	<div class="container col-8 alert alert-info">
	
		<div class="text-center">
			<h1>영수증</h1>
		</div>
		
		<div class="row justify-content-between">
			<div class="col-4" align="left">
				<strong>배송 주소</strong><br>
				성명 : <%=orderName %> <br>
				연락처 : <%=tel %> <br>
				우편번호 : <%=zipCode %> <br>
				주소 : <%=address01 %> <br>
				<%=address02 %> <br>
			</div>		
		</div>
		
		<div>
			<table class="table table-hover">
				<tr>
					<th class="text-center">사진</th>
					<th class="text-center">상품</th>
					<th class="text-center">가격</th>
					<th class="text-center">수량</th>
					<th class="text-center">소계</th>
				</tr>
				<%
					ArrayList<Cart> carts = (ArrayList<Cart>) session.getAttribute("carts");
					if(carts == null) {
						carts = new ArrayList<Cart>();
					}
					
					Integer totalPrice = 0;
					DecimalFormat formatter = new DecimalFormat("###,###.##");
					for(Cart cart : carts){
						Product product = ProductRepository.getInstance().getProductById(cart.getProductId());
						Integer price = product.getUnitPrice() * cart.getCartCnt();
						totalPrice += price;
				%>
					<tr>
						<td class="text-center"><img width="50px" src="\upload\<%=product.getFileName() %>"></td>
						<td class="text-center">
							<a style="color:black" href="../product/product.jsp?productId=<%=product.getProductId() %>">
								<em><%=product.getProductName() %></em>
							</a>
						</td>
						<td class="text-center"><%= formatter.format(product.getUnitPrice())%>원</td>
						<td class="text-center"><%= cart.getCartCnt() %></td>
						<td class="text-center"><%= formatter.format(price) %>원</td>
					</tr>			
				<%
					}
				%>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td class="text-center"><strong>총액:</strong></td>
					<td class="text-center text-danger"><strong><%= formatter.format(totalPrice) %>원</strong></td>
				</tr>
				
			</table>
			
			<a href="./shippingInfo.jsp" class="btn btn-secondary" role="button"> 이전 </a>
			<a href="./thankCustomer.jsp" class="btn btn-success" role="button"> 주문 완료 </a>
			<a href="./checkOutCancelled.jsp" class="btn btn-secondary" role="button"> 취소 </a>
			
		</div>
	</div>
	
	<jsp:include page="../inc/footer.jsp" />
</body>
</html>