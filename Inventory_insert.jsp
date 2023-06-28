<%@ page import="kr.ac.kopo.ctc.kopo39.domain.Inventory" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.InventoryDao" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.InventoryDaoImpl" %>
<%@ page contentType="text/html; charset=utf-8" %> 
<!--utf-8 인코딩 처리-->

<html>
<head>
<title>inventory_insert.jsp</title>
<link rel="stylesheet" type="text/css" href="introTable.css"> <!-- CSS 스타일시트 링크 -->
<link rel="stylesheet" type="text/css" href="Table.css"> <!-- CSS 스타일시트 링크 -->

	<script language="JavaScript">
	
        function checkForm() { //checkForm() 함수 정의
        	const form = document.getElementById('form1'); //id값이 'form1'인 요소를 찾아 변수에 저장
        	
			const _serialnum = form.elements.serialnum.value; //form 요소 내 name 속성을 가진 입력 필드의 값을 가져와 변수에 저장
			const _name = form.elements.name.value; //form 요소 내 name 속성을 가진 입력 필드의 값을 가져와 변수에 저장
			const _stocknum = form.elements.stocknum.value; //form 요소 내 name 속성을 가진 입력 필드의 값을 가져와 변수에 저장
			const _content = form.elements.content.value; //form 요소 내 name 속성을 가진 입력 필드의 값을 가져와 변수에 저장
			const _image = form.elements.image.value; //form 요소 내 name 속성을 가진 입력 필드의 값을 가져와 변수에 저장
			const allowedExtensions = ['jpg', 'jpeg', 'png', 'gif']; //허용된 파일 확장자를 배열로 저장
	        const fileExtension = _image.split('.').pop().toLowerCase(); 
			//_image:파일 경로 -> 경로를 .으로 구분하여 배열로 반환, pop()으로 배열의 가장 마지막 확장자 값 가져옴
			//_image 변수에 저장된 파일 경로에서 확장자를 추출하고, 추출한 확장자가 allowedExtensions 배열에 포함된 확장자인지 확인하는 기능을 수행
           
			const pattern1 = /^\d+$/; //숫자만 받는 정규식 1
            const pattern2 = /^.{1,20}$/; //20자 이내만 입력받는 정규식2 생성
            const pattern3 = /^[\s\S]{1,50}$/; //50자 이내의 모든 문자 허용(공백포함)하는 정규식3 생성
            const pattern4 = /^[\s\S]{1,300}$/; //300자 이내만 입력받는 정규식4 생성          
            
            if (_serialnum.trim().length === 0 
            		|| _name.trim().length === 0 
            		|| _stocknum.trim().length === 0
            		|| _content.trim().length === 0
            		) { //빈칸 있으면
               alert("빈 칸을 입력하세요"); //경고 문구 출력
            } else if (!pattern1.test(_serialnum) || !pattern2.test(_serialnum)) { //상품 번호칸에 20자 이상, 숫자 외의 입력값이 들어오면
                alert("상품 번호를 20자 이내(공백제외)의 숫자로만 입력해주세요"); //경고 문구 출력
            } else if (!pattern1.test(_stocknum) || !pattern2.test(_stocknum)) { //재고 현황칸에 20자 이상, 숫자 외의 입력값이 들어오면
                alert("재고 현황을 20자 이내(공백제외)의 숫자로만 입력해주세요"); //경고 문구 출력
            } else if (!pattern3.test(_name)) { //상품명 칸에 50자 이상 입력값 들어오면
                alert("상품명을 20자 이내(공백제외)의 한글,영문 조합으로 입력해주세요"); //경고 문구 출력
            } else if (!pattern4.test(_content)) { //상품 내용 칸에 300자 이상 들어오면
                alert("상품설명은 300자 이내로 입력해주세요"); //경고 문구 출력
            } else if (_image.trim().length === 0) { //상품 이미지 등록 안하면
                alert("상품사진을 첨부해주세요"); //경고 문구 출력
            } else if (!allowedExtensions.includes(fileExtension)) { //상다른 확장자 파일이 업로드되면
                alert("첨부할 수 없는 파일 유형입니다"); //경고 문구 출력
            } else { /* 위 조건들에 해당하지 않으면 submit() 실행 */ 
                form.action='Inventory_write.jsp' //폼 데이터 전송 경로 설정
                form.submit(); //폼 데이터 서버로 전송
            }
        }
    	
  
        function handleImageUpload(event) { // 파일 선택 이벤트 핸들러인 handleImageUpload 함수 정의
            const file = event.target.files[0]; // event.target.files[0]을 통해 선택된 파일을 가져와 file 변수에 할당
            const previewImage = document.getElementById('previewImage'); // id가 'previewImage'인 요소를 가져와 변수에 할당

            if (file) { // 선택된 파일이 존재할 경우
                const reader = new FileReader(); // FileReader 객체를 생성 
                reader.onload = function(event) { // FileReader의 onload 이벤트 핸들러를 정의
                previewImage.src = event.target.result; // FileReader가 읽은 파일의 데이터를 이미지 요소의 src 속성에 할당하여 미리보기 이미지를 표시
                previewImage.style.display = 'block'; // 이미지가 선택되었을 때만 미리보기 이미지를 보여주기 위해 스타일을 'block'으로 변경
                };
                reader.readAsDataURL(file); // FileReader를 사용하여 파일을 읽고, 읽은 데이터를 데이터 URL로 변환
            } else { // 선택된 파일이 없을 경우
                previewImage.src = "#"; // 미리보기 이미지의 src를 '#'로 설정하여 표시되지 않도록 함
                previewImage.style.display = 'none'; // 미리보기 이미지를 숨기기 위해 스타일을 'none'으로 변경
            }
        }

	</script>
</head>
<body>
	<table><!-- 인트로 테이블 -->
        <tr>
            <td width="50"></td>
            <td width="500">
                <p><h1>재고 등록</h1></p>
            </td>
            <td width="50"></td>
        </tr>
    </table>

<form method="post" id="form1" enctype="multipart/form-data"> <!-- 폼 요소 생성, 전송방식 post, id 부여, 파일 업로드 포함-->
<!-- enctype="multipart/form-data" -> 폼 데이터에 바이너리 파일(컴퓨터에서 사용되는 데이터를 이진 형식으로 표현한 파일)을 포함할 경우에 필요 -->

	<table class="maintable"> <!-- CSS 적용위해 클래스 부여 -->
		<tr>
			<td style="text-align: left;"><b>상품 번호</b></td>
			<td><input type=text name=serialnum value='' style='float:left;'></td>
			<!-- 상품 번호 입력 받기, name 속성으로 파라미터값 전달 -->
		</tr>
		<tr>
			<td style="text-align: left;"><b>상품명</b></td>
			<td><input type=text name=name value='' style='float:left;'></td>
			<!-- 상품명 입력 받기, name 속성으로 파라미터값 전달 -->
		</tr>
		<tr>
			<td style="text-align: left;"><b>재고 현황</b></td>
			<td><input type=text name=stocknum value='' style='float:left;'></td>
			<!-- 재고 현황 입력 받기, name 속성으로 파라미터값 전달 -->
		</tr>
		<tr>
			<td style="text-align: left;"><b>상품등록일</b></td>
			<% java.text.SimpleDateFormat RdateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd"); %> 
			<!-- SimpleDateFormat 클래스의 인스턴스를 생성하여 변수에 저장 -->
			<td><input type=text name=regdate value="<%= RdateFormat.format(new java.util.Date()) %>" style='border: 0; float:left;' readonly></td>
			<!-- 상품 등록일은 현재 시간으로 받기, readonly 처리, name 속성으로 파라미터값 전달 -->
		</tr>
		<tr>
			<td style="text-align: left;"><b>재고등록일</b></td>
			 <% java.text.SimpleDateFormat CdateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
			 <!-- SimpleDateFormat 클래스의 인스턴스를 생성하여 변수에 저장 -->
			<td><input type=text name=checkdate value="<%= CdateFormat.format(new java.util.Date()) %>" style='border: 0; float:left;' readonly></td>
			<!-- 재고 등록일은 현재 시간으로 받기, readonly 처리, name 속성으로 파라미터값 전달 -->
		</tr>
		<tr>
	    	<td style="text-align: left;"><b>상품설명</b></td>
	    	<td><textarea name="content" rows="5" cols="70" style="width:500; height:30; resize: none; overflow: auto; float:left;"></textarea></td>
	    	<!-- 상품 설명 입력받기, textarea 사이즈 고정, 글자수 넘어가면 자동 스크롤 생성 -->
		</tr>
		<tr>
			<td style="text-align: left;"><b>상품사진</b></td>
			<td><input type=file name=image onchange="handleImageUpload(event)" style='float: left;'>
			<!-- file 타입 설정하여 첨부 파일 받기, 파일 업로드되면 handleImageUpload(event) 함수 실행 -->
			<img id="previewImage" alt="미리보기 이미지" style="max-width: 200px; max-height: 200px; display: none;">
			<!-- 미리 보기 이미지 생성 -->
			</td>
		</tr>
	</table>
	<table class="maintable"> <!-- CSS 적용위해 클래스 부여 -->
		<tr>
			<td width=600></td>
			<td><input type=button value="취소" onClick="location.href='Inventory_list.jsp'"></td>
			<!-- 취소 버튼 생성, 클릭하면 Inventory_list.jsp 페이지로 이동 -->
			<td><input type=button value="등록" onClick="checkForm()"></td>
			<!-- 등록 버튼 생성, 클릭하면 checkForm() 함수 실행 -->
		</tr>
	</table>
</form>
</body>
</html>