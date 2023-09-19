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
			<h1 class="display-3">회원 정보</h1>
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<h2 class="alert alert-danger">
			<%
				String msg = request.getParameter("msg");
			
				if(msg != null) {
					if(msg.equals("0")){
						out.println("회원정보가 수정되었습니다.");
					}
					else if(msg.equals("1")){
						out.println("회원가입을 축하드립니다.");
					}
					else if(msg.equals("2")){
						String sessionMemberId = (String) session.getAttribute("sessionMemberId");						
						String sessionMemberName = (String) session.getAttribute("sessionMemberName");						
						out.println(sessionMemberName+"님 환영합니다.");
					}
					else if(msg.equals("3")){
						String sessionMemberId = (String) session.getAttribute("sessionMemberId");						
						String sessionMemberName = (String) session.getAttribute("sessionMemberName");						
						out.println("회원 정보 수정에 실패했습니다.");
					}
					
				} else {
					out.println("회원정보가 삭제되었습니다.");
				}
			%></h2>
			
		</div>
	</div>
	
	
	
	<jsp:include page="../inc/footer.jsp" />
	<script>
	document.addEventListener("DOMContentLoaded", function(){
		let id = setInterval(() => {
			location.href = "../product/products.jsp";
		}, 1*2000) 
	})
	</script>
</body>
</html>