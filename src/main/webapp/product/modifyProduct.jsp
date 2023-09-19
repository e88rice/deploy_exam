<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<h1 class="display-3">상품 수정</h1>
	</div>
</div>
<%@ include file="../inc/dbconn.jsp" %>
<%
	String productId = request.getParameter("productId");
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "select * from product where productId = ?";
	pstmt = connection.prepareStatement(sql);
	pstmt.setString(1, productId);
	rs = pstmt.executeQuery();
	if(rs.next()){
%>
<div class="container">
	<form name="frmProduct" action="processModifyProduct.jsp" method="post" enctype="multipart/form-data">
	
		<div class="form-group row">
			<label class="col-sm-2">상품 코드</label>
			<div class="col-sm-3">
				<input type="text" name="productId" class="form-control" value="<%=rs.getString("productId")%>" readonly>
			</div>
		</div>
		
		<div class="form-group row">
			<label class="col-sm-2">상품명</label>
			<div class="col-sm-3">
				<input type="text" name="productName" class="form-control" value="<%=rs.getString("productName")%>">
			</div>
		</div>
				
		<div class="form-group row">
			<label class="col-sm-2">가격</label>
			<div class="col-sm-3">
				<input type="text" name="unitPrice" class="form-control" value="<%=rs.getString("unitPrice")%>">
			</div>
		</div>
				
		<div class="form-group row">
			<label class="col-sm-2">상세 정보</label>
			<div class="col-sm-3">
				<textarea width="1000px" name="description" cols="50" rows="10" class="form-control"><%=rs.getString("description") %></textarea>
			</div>
		</div>
				
		<div class="form-group row">
			<label class="col-sm-2">제조사</label>
			<div class="col-sm-3">
				<input type="text" name="manufacturer" class="form-control" value="<%=rs.getString("manufacturer")%>">
			</div>
		</div>
		
		<div class="form-group row">
			<label class="col-sm-2">분류</label>
			<div class="col-sm-3">
				<input type="text" name="category" class="form-control" value="<%=rs.getString("category")%>">
			</div>
		</div>
		
		<div class="form-group row">
			<label class="col-sm-2">재고 수</label>
			<div class="col-sm-3">
				<input type="text" name="unitsInStock" class="form-control" value="<%=rs.getString("unitsInStock")%>">
			</div>
		</div>
		
		<div class="form-group row">
			<label class="col-sm-2">상태</label>
			<div class="col-sm-3">
			<% String condition = rs.getString("condition"); %>
				<input type="radio" name="condition" value="New"> 신규 제품
<%-- 				<%if(condition.equals("New")){out.print(" checked");} %>> 신규 제품 --%>
				<input type="radio" name="condition" value="Old"> 중고 제품
<%-- 				<%if(condition.equals("Old")){out.print(" checked");} %>> 중고 제품 --%>
				<input type="radio" name="condition" value="Refurbished"> 재생 제품
<%-- 				<%if(condition.equals("Refurbished")){out.print(" checked");} %>> 재생 제품 --%>
				<input type="hidden" id="condition" value=<%=rs.getString("condition") %>>
			</div>
		</div>
		
		<div class="form-group row">
			<label class="col-sm-2">이미지</label>
			<div class="col-sm-3">
				<input type="file" name="fileName" class="form-control" value=<%rs.getString("fileName"); %>>
			</div>
		</div>						
		
		<div class="form-group row">
			<div class="col-sm-10">
				<input type="submit" class="btn btn-primary" value="등록">
			</div>
		</div>	
	</form>
</div>	
<% 
	}	
	if(rs != null) rs.close();
	if(pstmt != null) pstmt.close();
	if(connection != null) connection.close();
%>		
	
	<jsp:include page="../inc/footer.jsp" />
	<script>
		const radios = document.querySelectorAll("input[type=radio]");
		const condition = document.getElementById("condition").value;
		
      	document.addEventListener('DOMContentLoaded', () => {

			radios.forEach(radio => {
				if(condition === radio.value){
					radio.checked = true;
				}
			})
          
        });
		
	</script>
</body>
</html>