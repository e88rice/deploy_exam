<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<%@ include file="../inc/dbconn.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");	

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	String sql = "SELECT * FROM member WHERE memberId = ?";
	pstmt = connection.prepareStatement(sql);
	String memberId = (String) session.getAttribute("sessionMemberId");
	pstmt.setString(1, memberId);
	rs = pstmt.executeQuery();
	if(rs.next()){
		session.setAttribute("sessionMemberName", rs.getString("memberName"));
	}
%>
<style>
* {
	font-family: 'SUITE-Regular';
	font-size: 16px;
	font-weight: bold;
}

@font-face {
	font-family: 'HANAMDAUM';
	src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/HANAMDAUM.woff2') format('woff2');
	font-weight: 400;
	font-style: normal;
}

@font-face {
	font-family: 'SUITE-Regular';
	src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
	font-weight: 900;
	font-style: normal;
}

@font-face {
	font-family: 'Giants-Inline';
	src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2307-1@1.1/Giants-Inline.woff2') format('woff2');
	font-weight: normal;
	font-style: normal;
}

@font-face {
	font-family: 'IAMAPLAYER';
	src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2307-2@1.0/IAMAPLAYER.woff2') format('woff2');
	font-weight: normal;
	font-style: normal;
}

@font-face {
    font-family: 'Cafe24Supermagic-Bold-v1.0';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2307-2@1.0/Cafe24Supermagic-Bold-v1.0.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}
@font-face {
    font-family: 'DOSPilgiMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/DOSPilgiMedium.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

.navbar-brand {
	font-family: 'HANAMDAUM';
	font-size: 16px;
	font-weight: bold;
	border: 3px solid white;
	padding: 10px;
	border-radius: 0.4em;
}

h1.display-3 {
	padding-top: 35px;
	font-family: 'HANAMDAUM';
}

#nav-boss {
	background-color: #fff;
	transition-duration : 1s;
	font-weight: bold;
}
#nav-boss a {
	color: #000;
}
.bg-dark {
	background-color: #343a40;
	transition-duration : 1s;
}

.bg-dark a {
	color: white !important;
}
.nav-link:hover {
	box-sizing: border-box;
	border-bottom: 2px solid lightblue;
	padding: 0px;
}
.bg-dark > .container > div:nth-of-type(2) > ul > li .nav-link:hover {
	box-sizing: border-box;
	border-bottom: 1px solid red;
	padding: 0px;
}
.mr-auto p {
	border: none !important;
}


::-webkit-scrollbar { width: 16px; }
::-webkit-scrollbar-track { background-color: #f1f1f1; }
::-webkit-scrollbar-thumb { background-color: #a0b2b1; border-radius: 10px; }
::-webkit-scrollbar-thumb:hover { background-color: #54605f; }
/*::-webkit-scrollbar-button:start:decrement, ::-webkit-scrollbar-button:end:increment { width: 16px; height: 16px; background-color: #2f2f2f; }*/

</style>
<body>
<nav style="position: fixed; z-index: 999; width: 100vw; opacity: 0.8;" class="navbar navbar-expand" id="nav-boss">
	<div class="container">
		<div class="navbar-header">
			<%= ProductDTO productDTO = %>
			<a class="navbar-brand" href="../welcome/welcome.jsp">Home</a>
		</div>
		<div>		
			<ul class="navbar-nav mr-auto">
				<c:choose>
					<c:when test="${empty sessionMemberId}">
						<li class="nav-item"><a class="nav-link" href="../member/loginMember.jsp">로그인</a></li>
						<li class="nav-item"><a class="nav-link" href="../member/addMember.jsp">회원 가입</a></li>
					</c:when>
					<c:otherwise>
						<li class="nav-item"><p class="nav-link" style="color: coral; height:20px;">[<%= session.getAttribute("sessionMemberName") %>님]</p></li>
						<li class="nav-item"><a class="nav-link" href="../member/processLogoutMember.jsp">로그아웃</a></li>
						<li class="nav-item"><a class="nav-link" href="../member/modifyMember.jsp">회원 수정</a></li>					
					</c:otherwise>
				</c:choose>
						<li class="nav-item"><a class="nav-link" href="../product/products.jsp">상품 목록</a></li>
						<li class="nav-item"><a class="nav-link" href="../product/addProduct.jsp">상품 등록</a></li>
						<li class="nav-item"><a class="nav-link" href="../product/editProduct.jsp">상품 편집</a></li>
						<li class="nav-item"><a class="nav-link" href="../order/cart.jsp">장바구니</a></li>
						<li class="nav-item"><a class="nav-link" href="../boardController/boardList.do">게시판</a></li>
			</ul>			
		</div>
	</div>
</nav>
<script>
	document.addEventListener("DOMContentLoaded", function(){
		const bossNav = document.querySelector("#nav-boss");
		window.addEventListener("scroll", function(){
			if(window.scrollY > 0){
				bossNav.classList.add("bg-dark");
			}
			else {
				bossNav.classList.remove("bg-dark");
			}
		})
	})
</script>
</body>
</html>