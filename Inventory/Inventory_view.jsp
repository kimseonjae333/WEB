<%@ page import="kr.ac.kopo.ctc.kopo39.domain.Inventory" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.InventoryDao" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.InventoryDaoImpl" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<%@ page contentType="text/html; charset=utf-8" %> 

<html>
<head>
<title>inventory_view.jsp</title>
<link rel="stylesheet" type="text/css" href="introTable.css"> <!-- CSS 스타일시트 링크 -->
<link rel="stylesheet" type="text/css" href="Table.css"> <!-- CSS 스타일시트 링크 -->
 
	<style> 
		.input-field { /* input 요소에 전체 적용 */
			border: none;
			outline: none;
			background-color: transparent;
			float: left;
		}
	</style>

	<script language="JavaScript">
	
		function checkForm() { //checkForm 함수 정의
	    	const form = document.getElementById('form'); //id값이 'form'인 요소를 찾아 변수에 저장
	    	
	    	   if (confirm("정말 삭제하시겠습니까?")) { //확인 메세지 띄우기
	    	        submitForm('delete'); //확인 누르면 submitForm() 함수 실행, 인자값으로 delete 실행
	    	    } else { //취소 누르면
	    	        return; //아무 작업도 수행하지 않고 원래 페이지 유지
	    	    }
	    }	
	
		function submitForm(mode){ //submitForm이라는 이름의 함수 생성, mode를 인자로 받음
			const form = document.getElementById('form'); //id값이 'form'인 요소를 찾아 변수에 저장
			if(mode == 'update') { //인자로 받는 값이 update 일때
	            form.action = 'Inventory_update.jsp'; //폼 데이터가 전송될 대상 URL 지정
	            form.submit(); //폼 데이터 서버로 전송
	        } else if(mode == 'delete') { //인자로 받는 값이 delete 일때
	            form.action = 'Inventory_delete.jsp'; //폼 데이터가 전송될 대상 URL 지정
	            form.submit(); //폼 데이터 서버로 전송
	        }
		} 
		
	</script>

</head>
<body>
	<table> <!-- 인트로 테이블 -->
        <tr>
            <td width="50"></td>
            <td width="500">
                <p><h1>재고 상세</h1></p>
            </td>
            <td width="50"></td>
        </tr>
    </table>


<%
	request.setCharacterEncoding("UTF-8"); //UTF-8 인코딩 설정(넘어오는건 무조건 string)
	String serialnum = request.getParameter("key"); //파라미터로 받은 값을 변수에 저장
	
	Inventory inventory = new Inventory(); // inventory 객체 생성해서 변수에 저장
	inventory.setSerialnum(serialnum); // set으로 inventory 객체의 상품번호 값 저장
	InventoryDao inventoryDao = new InventoryDaoImpl(); // InventoryDaoImpl 객체 생성하여 변수에 저장
	Inventory inventoryOne = inventoryDao.selectOne(serialnum); //InventoryDaoImpl의 selectOne() 함수 호출, 리턴값 변수에 저장
	
	if (inventoryOne == null) { //리턴값이 null이면
	      out.println("<script>alert('없는 상품 번호입니다.'); location.href='Inventory_list.jsp';</script>");
		  //Inventory_list.jsp로 화면 이동하고 경고 문구 출력
	} else { //리턴값이 있으면 아래 실행
%>

<form method="post" id="form" enctype="multipart/form-data"> <!-- 폼 요소 생성, 전송방식 post, id 부여, 파일 업로드 포함-->
<!-- enctype="multipart/form-data" -> 폼 데이터에 바이너리 파일(컴퓨터에서 사용되는 데이터를 이진 형식으로 표현한 파일)을 포함할 경우에 필요 -->

	<table class="maintable"> <!-- CSS 적용위해 클래스 부여 -->
		<tr>
			<td style="text-align: left;"><b>상품 번호</b></td> 
			<td><input type=text name=serialnum value='<%=inventoryOne.getSerialnum()%>' class="input-field" readonly>
			</td> <!-- inventoryOne 객체의 상품 번호 출력, readonly 처리, CSS 스타일 적용위해 클래스 부여 -->
		</tr>
		<tr>
			<td style="text-align: left;"><b>상품명</b></td>
			<td><input type=text name=name value='<%=inventoryOne.getName().replaceAll("<", "&lt;").replaceAll(">", "&gt;")%>' 
			class="input-field" readonly>
			</td> <!-- inventoryOne 객체의 상품명 출력(태그 그대로 문자열로 나오게 처리), readonly 처리, CSS 스타일 적용위해 클래스 부여 -->
		</tr>
		<tr>
			<td style="text-align: left;"><b>재고 현황</b></td>
			<td><input type=text name=stocknum value='<%=inventoryOne.getStocknum()%>' class="input-field" readonly></td>
			<!-- inventoryOne 객체의 재고 수량 출력, readonly 처리, CSS 스타일 적용위해 클래스 부여 -->
		</tr>
		<tr>
			<td style="text-align: left;"><b>상품등록일</b></td>
			<td><input type=text name=regdate value="<%=inventoryOne.getRegdate()%>" class="input-field" readonly></td>
			<!-- inventoryOne 객체의 상품 상품등록일 출력, readonly 처리, CSS 스타일 적용위해 클래스 부여 -->
		</tr>
		<tr>
			<td style="text-align: left;"><b>재고등록일</b></td>
			<td><input type=text name=checkdate value="<%=inventoryOne.getCheckdate()%>" class="input-field" readonly></td>
			<!-- inventoryOne 객체의 상품 재고등록일 출력, readonly 처리, CSS 스타일 적용위해 클래스 부여 -->
		</tr>
		<tr>
			<td style="text-align: left;"><b>상품설명</b></td>
			<td><textarea name="content" rows="5" cols="70" style="width:500; height:40; resize: none; 
			overflow: auto;" class="input-field"><%=inventoryOne.getContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;")%></textarea></td>
			<!-- inventoryOne 객체의 상품 내용 출력(태그 그대로 문자열로 나오게 처리), CSS 스타일 적용위해 클래스 부여, textarea 사이즈 고정, 글자수 넘어가면 자동 스크롤 생성 -->
		</tr>
		<tr>
			<td style="text-align: left;"><b>상품사진</b></td>
			<td><!-- inventoryOne 객체의 상품 이미지 출력 -->
			<%
				if(inventoryOne.getPhoto() == null){ // 상품 이미지 값이 null이면
			%>	<img src="image/defaultImg.jpg" width="400" height="550" name="img" class="input-field">
				<!-- 기본 이미지로 설정 -->
			<%	} else { // null이 아니면
			%>	<img src="<%= inventoryOne.getPhoto() %>" width="400" height="550" name="img" class="input-field">
				<!-- 해당 이미지 가져오기 -->	
			<% 	
				}
			%>
			</td>
		</tr>
	</table>
	
	<table class="maintable"> <!-- CSS 적용위해 클래스 부여 -->
		<tr>
			<td width=500></td>
			<td><input type="button" value="재고현황" onClick="location.href='Inventory_list.jsp'"></td>
			<!-- 재고현황 버튼 생성, 클릭하면 리스트 페이지로 복귀 -->
			<td><input type=button value="상품삭제" onClick="checkForm()"></td>
			<!-- 상품삭제 버튼 생성, 클릭하면 checkForm()함수 실행 -->
			<td><input type=button value="재고수정" onClick="submitForm('update')"></td>
			<!-- 재고수정 버튼 생성, 클릭하면 submitForm()함수 실행, 인자로 update 전달 -->
		</tr>
	</table>
</form>
<%
	}
%>
</body>
</html>
