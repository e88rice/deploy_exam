<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023-09-18
  Time: 오후 4:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
  String memberId = (String) session.getAttribute("sessionMemberId");
  String memberName = (String) session.getAttribute("sessionMemberName");
  if (memberId == null) {
    response.sendRedirect("../member/loginMember.jsp");
  }
%>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
  <meta charset="utf-8">
  <title>Board</title>
</head>
<body>
<jsp:include page="/inc/menu.jsp" />
<div class="jumbotron">
  <div class="container">
    <h1 class="display-3">글 등록</h1>
  </div>
</div>
<div class="container">
  <form name="frmAdd" action="./boardAddAction.do" method="post" class="form-horizontal">
    <input name="id" type="hidden" class="form-control" value="<%=memberId%>">
    <div class="form-group row">
      <label class="col-sm-2 control-label" >이름</label>
      <div class="col-sm-3">
        <input name="name" type="text" class="form-control" value="<%=memberName%>" placeholder="name">
      </div>
    </div>
    <div class="form-group row">
      <label class="col-sm-2 control-label">제목</label>
      <div class="col-sm-5">
        <input name="subject" type="text" class="form-control" placeholder="subject">
      </div>
    </div>
    <div class="form-group row">
      <label class="col-sm-2 control-label">내용</label>
      <div class="col-sm-8">
        <textarea name="content" cols="50" rows="5" class="form-control" placeholder="content"></textarea>
      </div>
    </div>
    <div class="form-group row">
      <div class="col-sm-offset-2 col-sm-10">
        <input type="button" class="btn btn-primary btn-submit" value=" 등록 ">
        <input type="reset" class="btn btn-primary" value=" 취소 ">
      </div>
    </div>
  </form>
  <hr>
</div>
<jsp:include page="/inc/footer.jsp" />
<script>
  document.addEventListener('DOMContentLoaded', function () {
    const btnSubmit = document.querySelector('.btn-submit');
    const frmAdd = document.querySelector('form[name=frmAdd]');

    btnSubmit.addEventListener('click', function () {
      if (!frmAdd.name.value) {
        alert("이름을 입력하세요.");
        return;
      }
      if (!frmAdd.subject.value) {
        alert("제목을 입력하세요.");
        return;
      }
      if (!frmAdd.content.value) {
        alert("내용을 입력하세요.");
        return;
      }
      frmAdd.submit();
    });
  });
</script>
</body>
</html>