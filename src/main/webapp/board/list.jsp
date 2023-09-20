<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<%@ page import="com.example.mvc.model.BoardDTO" %>
<%
    request.setCharacterEncoding("UTF-8");
    List boardList = (List) request.getAttribute("boardList");              // 게시물 리스트
    int totalRecord = (Integer) request.getAttribute("totalRecord");        // 전체 게시물 숫자
    int pageNum = (Integer) request.getAttribute("pageNum");                // 페이지 수
    int totalPage = (Integer) request.getAttribute("totalPage");            // 총 페이지 수
    int startNum = (Integer) request.getAttribute("startNum");              // 시작 인덱스

    String items = "", text = "";
    if(request.getParameter("items") != null && request.getParameter("text") != null){
        items = request.getParameter("items");
        text = request.getParameter("text");
    }
    System.out.println("items : " + items);
    System.out.println("text : " + text);
%>
<html>
<head>
    <title>Board</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script type="text/javascript">
        function checkForm() {
            location.href = "/boardController/boardAddForm.do"; // 글쓰기 버튼 클릭 시 글쓰기 페이지로 이동
        }
    </script>
</head>
<body>
<jsp:include page="/inc/menu.jsp" />
<div class="jumbotron" >
    <div class="container">
        <h1 class="display-3">게시판</h1>
    </div>
</div>
<div class="container">
        <div>
            <div class="text-right">
                <span class="badge badge-success">전체 <%=totalRecord%></span>
            </div>
        </div>

        <div style="padding-top: 50px">
            <table class="table table-hover">
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성일</th>
                    <th>조회</th>
                    <th>글쓴이</th>
                </tr>
                <%
                    for(int j=0; j<boardList.size(); j++){
                        BoardDTO board = (BoardDTO)boardList.get(j);
                %>
                <tr>
                    <td><input type="hidden" name="num" value="<%=board.getNum()%>"><%=startNum--%></td>
                    <td><a style="color: blue" href="./boardView.do?num=<%=board.getNum()%>&pageNum=<%=pageNum%>&items=<%=items%>&text=<%=text%>"><%=board.getSubject()%></a></td>
                    <td><%=board.getAddDate()%></td>
                    <td><%=board.getHit()%></td>
                    <td><%=board.getName()%></td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>
        <div align="center">
            <c:set var="pageNum" value="<%=pageNum%>" />
            <c:forEach var="i" begin="1" end="<%=totalPage%>">
                <%
                    if(text.equals("") && items.equals("")){
                %>
                    <a href="./boardList.do?pageNum=${i}">
                <%
                    } else if(text != null && items != null) {
                %>
                    <a href="./boardList.do?pageNum=${i}&items=<%=items%>&text=<%=text%>">
                <%
                    }
                %>
                <c:choose>
                    <c:when test="${pageNum == i}">
                        <%-- 폰트 태그에 줄이 그이는 이유는 오래된 태그라 사용하지 말라는 표시 --%>
                        <font color="#dc143c"><b>[${i}]</b></font> <%-- 현재 페이지는 굵게 --%>
                    </c:when>
                    <c:otherwise>
                        <font color="4C5317">[${i}]</font> <%-- 나머지는 볼드 없음 --%>
                    </c:otherwise>
                </c:choose>
                </a>
            </c:forEach>
        </div>
        <div align="left">
            <form action="./boardList.do" method="get" name="searchFrm">
                <table>
                    <tr>
                        <td width="100%" align="left">
                            <select name="items" class="txt">
                                <option value="subject">제목검색</option>
                                <option value="content">내용검색</option>
                                <option value="name">글쓴이검색</option>
                            </select> <input name="text" type="text" value="<%=text%>"/>
                            <input type="submit" id="btnAdd" class="btn btn-primary" value="검색 " />
                        </td>
                        <td width="100%" align="right">
                            <a href="#" onclick="checkForm(); return false;" class="btn btn-primary">글쓰기</a>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    <hr>
</div>
<jsp:include page="/inc/footer.jsp" />
</body>
</html>
