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
<%@ include file="../inc/dbconn.jsp" %>
	<jsp:include page="../inc/menu.jsp" />
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">로그인</h1>
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<div class="col-md-9">
				<h3 class="form-signin-heading">Please sign in</h3>
				<%
					String error = request.getParameter("error");
					if(error != null) {
						out.println("<div class='alert alert-danger'>");
						out.println("아이디와 비밀번호를 확인해 주세요");
						out.println("</div>");
					}
				%>
				<form class="frmlogin" action="./processLoginMember.jsp" method="post">
					<div class="form-group">
						<label for="memberId" class="sr-only">User Id</label>
						<input type="text" name="memberId" id="memberId" class="form-control" placeholder="ID" required autofocus>
					</div>
					<div class="form-group">
						<label for="passwd" class="sr-only">Password</label>
						<input type="password" name="passwd" id="passwd" class="form-control" placeholder="Password" required>
					</div>
					<button class="btn btn btn-lg btn-success btn-block" type="submit">로그인</button>
				</form>
				
				
				
			</div>
		</div>
	</div>
	
	
	
	<jsp:include page="../inc/footer.jsp" />
</body>
</html>