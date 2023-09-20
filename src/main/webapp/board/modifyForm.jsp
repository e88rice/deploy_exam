<%@ page import="com.example.mvc.model.BoardDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  BoardDTO board = (BoardDTO) request.getAttribute("board");
  String sessionMemberId = (String) session.getAttribute("sessionMemberId");
  if (sessionMemberId == null) {
    response.sendRedirect("../member/loginMember.jsp");
  }
  else if (!sessionMemberId.equals(board.getMemberId())) {
    response.sendRedirect("/");
  }
%>
<html>
<head>
  <link rel="stylesheet" href="/css/bootstrap.min.css">
  <title>Board</title>
</head>
<body>

<jsp:include page="/inc/menu.jsp" />
<div class="jumbotron" >
  <div class="container">
    <h1 class="display-3">게시판</h1>
  </div>
</div>

<div class="container">
  <form name="frmModify" action="./boardModifyAction.do" method="post" class="form-horizontal">
    <input name="num" type="hidden" value="<%=board.getNum()%>">

    <div class="form-group row">
      <label class="col-sm-2 control-label">이름</label>
      <div class="col-sm-3">
        <input name="name" type="text" class="form-control" value="<%=board.getName()%>" placeholder="name">
      </div>
    </div>

    <div class="form-group row">
      <label class="col-sm-2 control-label">제목</label>
      <div class="col-sm-5">
        <input name="subject" type="text" class="form-control" value="<%=board.getSubject()%>" placeholder="subejct">
      </div>
    </div>

    <div class="form-group row">
      <label class="col-sm-2 control-label">내용</label>
      <div class="col-sm-8">
        <textarea name="content" cols="50" rows="5" class="form-control" placeholder="content"><%=board.getContent()%></textarea>
      </div>
    </div>

    <div class="form-group row">
      <div class="col-sm-offset-2 col-sm-10">
        <input type="button" class="btn btn-primary btn-submit" value=" 수정 ">
        <input type="reset" class="btn btn-primary" value=" 취소 ">
      </div>
    </div>
  </form>
  <hr>
</div>
<jsp:include page="/inc/footer.jsp" />
<script>
  document.addEventListener("DOMContentLoaded", function () {
    const btnSubmit = document.querySelector(".btn-submit");
    const frmModify = document.querySelector("form[name=frmModify]");

    btnSubmit.addEventListener('click', function () {
      if (!frmModify.name.value) {
        alert("이름을 입력하세요.");
        return;
      }
      else if (!frmModify.subject.value) {
        alert("제목을 입력하세요.");
        return;
      }
      else if (!frmModify.content.value) {
        alert("내용을 입력하세요.");
        return;
      }
      else {
        frmModify.submit();
      }
    })

  })
</script>

</body>
</html>
