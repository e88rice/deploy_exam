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
		<h1 class="display-3">회원가입</h1>
	</div>
</div>
	
<div class="container">
	<form name="frmMember" action="./processAddMember.jsp" method="post">
	
		<div class="form-group  row">
			<label class="col-sm-2">아이디</label>
			<div class="col-sm-10">
				<input name="memberId" type="text" class="form-control">
				<span class="memberIdCheck"></span>
				<br><input type="button" name="btnIsDuplication" value="팝업 아이디 중복 확인" class="btn">
				<input type="button" name="btnIsDuplication2nd" value="ajax 아이디 중복 확인" class="btn">
			</div>
		</div>
		
		<div class="form-group  row">
			<label class="col-sm-2">비밀번호</label>
			<div class="col-sm-10">
				<input name="passwd" type="password" class="form-control"> 
			</div>
		</div>
		
		<div class="form-group  row">
			<label class="col-sm-2">비밀번호 확인</label>
			<div class="col-sm-10">
				<input type="password" class="form-control"> 
			</div>
		</div>	
		
		<div class="form-group  row">
			<label class="col-sm-2">이름</label>
			<div class="col-sm-10">
				<input name="memberName" type="text" class="form-control"> 
			</div>
		</div>	
	
		<div class="form-group  row">
			<label class="col-sm-2">성별</label>
			<div class="col-sm-10">
				<input name="gender" type="radio" value="남" checked> 남
				<input name="gender" type="radio" value="여"> 여
			</div>
		</div>
		
		<div class="form-group row">
			<label class="col-sm-2">생일</label>
			<div class="col-sm-4  ">
				<input type="text" name="birthyy" maxlength="4" placeholder="년(4자)" size="6">
				<select name="birthmm">
					<option value="">월</option>
					<option value="01">1</option>
					<option value="02">2</option>
					<option value="03">3</option>
					<option value="04">4</option>
					<option value="05">5</option>
					<option value="06">6</option>
					<option value="07">7</option>
					<option value="08">8</option>
					<option value="09">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
				</select> <input type="text" name="birthdd" maxlength="2" placeholder="일" size="4">
			</div>
		</div>
		
		<div class="form-group  row ">
			<label class="col-sm-2">이메일</label>
			<div class="col-sm-10">
				<input type="text" name="mail1" maxlength="50">@
				<select name="mail2">
					<option>naver.com</option>
					<option>daum.net</option>
					<option>gmail.com</option>
					<option>nate.com</option>
				</select>
			</div>
		</div>
		
		<div class="form-group  row">
			<label class="col-sm-2">연락처</label>
			<div class="col-sm-10">
				<input name="phone" type="text" class="form-control"> 
			</div>
		</div>	
		
		<div class="form-group row">
			<label class="col-sm-2">우편번호</label>
			<div class="col-sm-2" style="display: flex">
				<input style="width: 200px; margin-right: 10px" type="text" id="zipCode" name="zipCode" class="form-control" readonly> 
				<span class="btnFindZipcode btn btn-secondary" style="cursor: pointer">우편번호 검색</span>
			</div>
		</div>
		
		<div class="form-group row">
			<label class="col-sm-2">주소 1</label>
			<div class="col-sm-10">
				<input style="background-color: white" type="text" id="address01" name="address01" class="form-control" readonly> 
			</div>
		</div>
		
		<div class="form-group row">
			<label class="col-sm-2">주소 2</label>
			<div class="col-sm-10">
				<input type="text" id="address02" name="address02" class="form-control" placeholder="상세 주소 입력"> 
			</div>
		</div>
		
		<div class="form-group row">
			<div class="col-sm-10">
				<input type="submit" class="btn btn-primary" value="등록">
			</div>
		</div>
	</form>		
</div>
<jsp:include page="../inc/footer.jsp"/>	
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
    
    <script>
    	document.addEventListener("DOMContentLoaded", function() {
    		const frmMember = document.frmMember; // 폼을 가져 옴.
    		
    		// 1. 팝업을 이용한 ID 중복확인
    		// 팝업을 띄우는 이유는, 현재 페이지에서 데이터베이스에 중복 조회를 할려면 페이지 새로고침 이외에는 방법이 없음
    		const btnIsDuplication = document.querySelector('input[name=btnIsDuplication]');
    		btnIsDuplication.addEventListener('click', function() {
    			const memberId = frmMember.memberId.value; // 아이디 input에 있는 값.
    			if(memberId === "") {
    				alert("아이디를 입력해 주세요.");
    				frmMember.memberId.focus();
    				return;
    			}
    			// 아이디 중복 확인을 위해 팝업을 띄움.
    			// window.open('페이지이름.jsp?id=memberId') = 페이지를 새 창으로 염 'idCheck' = 뭔지몰겠음,   
    			// width,height = 새 창으로 연 페이지의 가로 세로 사이즈,  top,left = 페이지가 열릴 모니터 상 위치, location = 뭔지몰겠음 
    			window.open('popupIdCheck.jsp?id='+memberId, 'idCheck', 'width = 500, height = 20, top = 100, left = 200, location = no');  			
    		})	
    		
    		// 2.
    		
    		const xhr = new XMLHttpRequest(); // XMLHttpRequest 객체 생성
    		const btnIsDuplication2nd = document.querySelector('input[name=btnIsDuplication2nd]');
    		btnIsDuplication2nd.addEventListener('click', function() {
    			
    			const memberId = frmMember.memberId.value; // 아이디 input에 있는 값.
    			xhr.open('GET', 'ajaxIdCheck.jsp?id=' + memberId); // HTTP 요청 초기화 통신 방식과 url 설정.
    			xhr.send(); // 설정된 방식의 요청을 보냄
    			// 이벤트 등록 XMLHttpRequest 객체의 readyState 프로퍼티 값이 변할 때 마다 자동으로 호출
    			xhr.onreadystatechange = () => {
    				
    				if(xhr.readyState !== XMLHttpRequest.DONE) return; // readyState 프로퍼티의 값이 DONE : 요청한 데이터의 처리가 완료되어 응답할 준비가 완료됨.
    				
    				if(xhr.status === 200) { // 서버(url)에 문서가 존재함
    					const json = JSON.parse(xhr.response);
    					if(json.result === 'true') {
    						alert("동일한 아이디가 있습니다.");
    					} else alert("동일한 아이디가 없습니다");
    				}
    				else { // 서버(url)에 문서가 존재하지 않음.
    					console.error("Error", xhr.status, xhr.statusText); 					
    				}
    				
    			} // onreadystatechange 익명 함수 끝
    	
    		}) // ajax 버튼 이벤트 끝	
    		
    		// 3.
    		const inputId = document.querySelector("input[name=memberId]");
    		inputId.addEventListener('keyup', function() {
    			const id = frmMember.memberId.value; // 아이디 input에 있는 값.
    			const memberIdCheck = document.querySelector('.memberIdCheck'); // 결과 문자열이 표현될 영역
    			xhr.open('GET', 'ajaxIdCheck.jsp?id=' + id); // HTTP 요청 초기화. 통신 방식과 url 설정.
    			xhr.send(); // url에 요청을 보냄
    			// 이벤트 등록 XMLHttpRequest 객체의 readyState 프로퍼티 값이 변할 때 마다 자동으로 호출
    			xhr.onreadystatechange = () => {
    				
    				if(xhr.readyState !== XMLHttpRequest.DONE) return; // readyState 프로퍼티의 값이 DONE : 요청한 데이터의 처리가 완료되어 응답할 준비가 완료됨.
    				
    				if(xhr.status === 200) { // 서버(url)에 문서가 존재함
    					const json = JSON.parse(xhr.response);
    					if(json.result === 'true') {
    						memberIdCheck.style.color = 'red';
    						memberIdCheck.innerHTML = '동일한 아이디가 있습니다.';
    					} else {
    						memberIdCheck.style.color = 'blue';
    						memberIdCheck.innerHTML = '동일한 아이디가 없습니다.';
   						}
   					} else { // 서버(url)에 문서가 존재하지 않음.
    					console.error("Error", xhr.status, xhr.statusText); 					
    				}
    			}
    		}) // InputId 이벤트 끝
    	}) // DOMContentLoaded 이벤트 끝
    
    </script>
</body>
</html>