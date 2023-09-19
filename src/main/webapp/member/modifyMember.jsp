<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>정보 수정</title>
</head>
<body>

<%@ include file="../inc/dbconn.jsp" %>
<% 
	request.setCharacterEncoding("UTF-8"); 
%>
	<jsp:include page="../inc/menu.jsp" />
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원정보 수정</h1>
		</div>
	</div>
	
	<div class="container">
	
	
		<form name="frmMember" action="./processModifyMember.jsp" method="post">
		
		<%
			String sessionMemberId = (String) session.getAttribute("sessionMemberId");
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			String sql = "SELECT * FROM member where memberId = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, sessionMemberId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String passwd = rs.getString("passwd");
				String memberName = rs.getString("memberName");
				String gender = rs.getString("gender");
				String birthday = rs.getString("birthday");
				String[] birthdayArr = birthday.split("-");
				String birthyy = birthdayArr[0];
				String birthmm = birthdayArr[1];
				String birthdd = birthdayArr[2];
				String email = rs.getString("email");
				String[] emailArr = email.split("@");
				String mail1 = emailArr[0];
				String mail2 = emailArr[1];
				String phone = rs.getString("phone");
				String zipCode = rs.getString("zipCode");
				String address01 = rs.getString("address01");
				String address02 = rs.getString("address02");
		%>

		<div class="form-group row">
			<label class="col-sm-2">아이디</label>
			<div class="col-sm-10">
				<input name="memberId" type="text" class="form-control" value="<%=sessionMemberId %>" readonly>
			</div>
		</div>
		
		<div class="form-group  row">
			<label class="col-sm-2">비밀번호</label>
			<div class="col-sm-10">
				<input name="passwd" type="password" class="form-control" value="<%= passwd %>"> 
			</div>
		</div>
		
		<div class="form-group  row">
			<label class="col-sm-2">비밀번호 확인</label>
			<div class="col-sm-10">
				<input type="password" class="form-control" value="<%=passwd %>"> 
			</div>
		</div>	
		
		<div class="form-group  row">
			<label class="col-sm-2">이름</label>
			<div class="col-sm-10">
				<input name="memberName" type="text" class="form-control" value="<%= memberName %>"> 
			</div>
		</div>	
	
		<div class="form-group  row">
			<label class="col-sm-2">성별</label>
			<div class="col-sm-10">
				<input name="gender" type="radio" value="남"
				<%if(gender.equals("남")){out.println("checked");} %>> 남
				<input name="gender" type="radio" value="여"
				<%if(gender.equals("여")){out.println("checked");} %>> 여
			</div>
		</div>
		
		<div class="form-group row">
			<label class="col-sm-2">생일</label>
			<div class="col-sm-4  ">
				<input type="text" name="birthyy" maxlength="4" placeholder="년(4자)" size="6" value="<%=birthyy %>">
				<select name="birthmm">
					<% for(int i=1; i<=12; i++){
						String month = String.format("%02d", i); // 숫자를 두 자리 문자열로 변환
						out.println("<option value=\"" + month + "\"");
						if(birthmm.equals(month)){
							out.println(" selected");
						}
						out.print(">" + i + "</option>");
					}
					%>
				</select> <input type="text" name="birthdd" maxlength="2" placeholder="일" size="4" value="<%=birthdd %>">
			</div>
		</div>
		
		<div class="form-group  row ">
			<label class="col-sm-2">이메일</label>
			<div class="col-sm-10">
				<input type="text" name="mail1" maxlength="50" value="<%=mail1 %>">@
				<select name="mail2">
					<option
					<%if(mail2.equals("naver.com")) {out.println("selected");} %>>naver.com</option>
					<option
					<%if(mail2.equals("daum.net")) {out.println("selected");} %>>daum.net</option>
					<option
					<%if(mail2.equals("gmail.com")) {out.println("selected");} %>>gmail.com</option>
					<option
					<%if(mail2.equals("nate.com")) {out.println("selected");} %>>nate.com</option>
				</select>
			</div>
		</div>
		
		<div class="form-group  row">
			<label class="col-sm-2">연락처</label>
			<div class="col-sm-10">
				<input name="phone" type="text" class="form-control" value="<%=phone %>"> 
			</div>
		</div>	
		
		<div class="form-group row">
			<label class="col-sm-2">우편번호</label>
			<div class="col-sm-2" style="display: flex">
				<input style="width: 200px; margin-right: 10px" type="text" id="zipCode" name="zipCode" class="form-control" value="<%=zipCode %>" readonly> 
				<span class="btnFindZipcode btn btn-secondary" style="cursor: pointer">우편번호 검색</span>
			</div>
		</div>
		
		<div class="form-group row">
			<label class="col-sm-2">주소 1</label>
			<div class="col-sm-10">
				<input style="background-color: white" type="text" id="address01" name="address01" class="form-control" value="<%=address01 %>" readonly> 
			</div>
		</div>
		
		<div class="form-group row">
			<label class="col-sm-2">주소 2</label>
			<div class="col-sm-10">
				<input type="text" id="address02" name="address02" class="form-control" value="<%= address02 %>" placeholder="상세 주소 입력" > 
			</div>
		</div>
		<%
			}
		%>	
		<div class="form-group row">
			<div class="col-sm-10">
				<input type="submit" class="btn btn-primary" value="수정">
				<a href="processRemoveMember.jsp" class="btn btn-danger">회원탈퇴</a>
			</div>
		</div>
	</form>		
</div>
	
	
	<jsp:include page="../inc/footer.jsp" />
	<script>
      document.querySelector('span.btnFindZipcode').addEventListener('click', execDaumPostcode);
      /*
      카카오 우편번호 검색 가이드 페이지 :  https://postcode.map.daum.net/guide
      */
      function execDaumPostcode() {
        /* 상황에 맞춰서 변경해야 하는 부분 */
        const zipcode = document.getElementById('zipCode');
        const address01 = document.getElementById('address01');
        const address02 = document.getElementById('address02');

        /* 수정없이 사용 하는 부분 */
        new daum.Postcode({
          oncomplete: function (data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') {
              // 사용자가 도로명 주소를 선택했을 경우
              fullAddr = data.roadAddress;
            } else {
              // 사용자가 지번 주소를 선택했을 경우(J)
              fullAddr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            if (data.userSelectedType === 'R') {
              //법정동명이 있을 경우 추가한다.
              if (data.bname !== '') {
                extraAddr += data.bname;
              }
              // 건물명이 있을 경우 추가한다.
              if (data.buildingName !== '') {
                extraAddr += extraAddr !== '' ? ', ' + data.buildingName : data.buildingName;
              }
              // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
              fullAddr += extraAddr !== '' ? ' (' + extraAddr + ')' : '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            zipcode.value = data.zonecode; //5자리 새우편번호 사용
            address01.value = fullAddr;

            // 커서를 상세주소 필드로 이동한다.
            address02.focus();
          },
        }).open();
      }
    </script>
</body>
</html>