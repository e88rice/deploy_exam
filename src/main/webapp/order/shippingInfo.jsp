<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>배송 정보</title>
</head>
<body>
	<jsp:include page="../inc/menu.jsp" />
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">배송 정보</h1>
		</div>
	</div>
	<!--  주문번호 생성 및 사용 -->
	<%
		request.setCharacterEncoding("UTF-8");
		// 세션 ID 가져오기
		String sessionId = session.getId();
	
		// 현재 날짜와 시간 가져오기	
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		String currentDateTime = simpleDateFormat.format(new Date());
		
		// 현재 날짜와 시간과 세션아이디를 합쳐서 고유한 식별자 주문번호 생성
		String orderId = currentDateTime + "-" + sessionId;
		session.setAttribute("orderId", orderId);

	%>
	<div class="container">
		<form action="./processShippingInfo.jsp" method="post">
		<input type="hidden" name="orderId" value="<%=orderId %>">
		
			<div class="form-group row">
				<label class="col-sm-2">주문자 이름</label>
				<div class="col-sm-3">
					<input style="width: 210px;" type="text" name="orderName" class="form-control"> 
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">연락처</label>
				<div class="col-sm-3">
					<input style="width: 210px;" type="text" name="tel" class="form-control"> 
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">우편번호</label>
			<div class="col-sm-2" style="display: flex">
				<input style="width: 250px; margin-right: 10px" type="text" id="zipCode" name="zipCode" class="form-control"> 
				<span class="btnFindZipcode btn btn-secondary" style="cursor: pointer">우편번호 검색</span>
			</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">주소 1</label>
				<div class="col-sm-5">
					<input style="background-color: white" type="text" id="address01" name="address01" class="form-control" readonly> 
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">주소 2</label>
				<div class="col-sm-5">
					<input type="text" id="address02" name="address02" class="form-control" placeholder="상세 주소 입력"> 
				</div>
			</div>
			
			<div class="form-group row">
				<div class="col-sm-10">
					<a href="./cart.jsp" class="btn btn-secondary" role="button">이전</a>
					<input type="submit" class="btn btn-primary" value="등록"> 
				</div>
			</div>

		
		</form>
	</div>
	
	
	<jsp:include page="../inc/footer.jsp" />
	<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
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