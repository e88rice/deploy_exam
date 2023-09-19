<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			<h1 class="display-3">장바구니</h1>
		</div>
	</div>
	
	<div class="container">
	
		<div class="row">
			<table width="100%">
				<tr>
					<td align="left">
						<a href="#" class="btn btn-danger btn-removeAll">비우기</a>
						<a href="#" class="btn btn-danger btn-selected">선택 삭제</a>
						<a href="./shippingInfo.jsp" class="btn btn-success">주문</a>
					</td>
				</tr>
			</table>
		</div>
		
		<div style="padding-top: 50px">
			<form name="frmCart" method="post">
			<input type="hidden" name="productId">
			<table class="table table-hover">
				<tr>
					<td>선택</td>
					<td>사진</td>
					<td>상품</td>
					<td>가격</td>
					<td>수량</td>
					<td>소계</td>
					<td>비고</td>
				</tr>
				
				<%
					Integer totalPrice = 0;
					
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					
					DecimalFormat formatter = new DecimalFormat("###,###.##");
					
					String sql = "SELECT c.productId, fileName, productName, unitPrice, cnt "
							+"FROM cart c LEFT JOIN product p ON c.productId = p.productId where orderId = ?";
					
					pstmt = connection.prepareStatement(sql);
					pstmt.setString(1, orderId);
					rs = pstmt.executeQuery();
					
					while(rs.next()){
					Integer price = rs.getInt("unitPrice") * rs.getInt("cnt");
					totalPrice += price;
				%>
					<tr>
						<td><input type="checkbox" name="checkedId" value="<%=rs.getString("productId") %>"></td>
						<td><img width="50px" src="\upload\<%=rs.getString("fileName") %>"></td>
						<td><a style="color:black" href="../product/product.jsp?productId=<%=rs.getString("productId") %>"><%=rs.getString("productName") %></a></td>
						<td><%= formatter.format(rs.getInt("unitPrice")) %></td>
						<td> <input type="number" value="<%=rs.getString("cnt")%>"></td>
						<td><%=formatter.format(price) %></td>
						<td><a href="#" role="<%=rs.getString("productId") %>" class="badge badge-danger btn-removeById">삭제</a></td>
					</tr>			
				<%
					}
				%>
				<tr>
					<td colspan="7">합계 : <%= formatter.format(totalPrice) %>원</td>
				</tr>
			</table>
			</form>
		</div>
	</div>
	
	<jsp:include page="../inc/footer.jsp" />
	
	<script>
    document.addEventListener('DOMContentLoaded', function () {
    	// 모두 삭제
    	const removeBtn = document.querySelector(".btn-removeAll");
    	
    	// 모두 삭제 함수
    	removeBtn.addEventListener("click", function() {
    		if(confirm("정말 삭제하시겠습니까?")){
    			location.href = './processRemoveCart.jsp';
    		}
    	})
    	
    	// 선택 삭제
    	const removeCheckBtn = document.querySelector(".btn-selected");
    	const frmCart = document.querySelector("form[name=frmCart]");
    	
    	// 선택 삭제 함수
    	removeCheckBtn.addEventListener("click", function() {
    		if(confirm("정말 삭제하시겠습니까?")){
    			frmCart.action = '../order/processRemoveCartSelected.jsp';
    			frmCart.submit();
    		}
    	})
    	
    	// 개별 삭제
    	const btnRemoveByIds = document.querySelectorAll('.btn-removeById');
    	btnRemoveByIds.forEach(button => {
    		button.addEventListener('click', function(e) {
    			if(confirm('정말 삭제하시겠습니까?')) {
    				frmCart.productId.value = e.target.role;
    				frmCart.action = '../order/processRemoveCartById.jsp';
    				frmCart.submit();
    			}
    		})
    	})
    });
	</script>
</body>
</html>