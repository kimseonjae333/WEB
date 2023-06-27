<%@page import="kr.ac.kopo.ctc.kopo39.dto.Pagination"%>
<%@page import="kr.ac.kopo.ctc.kopo39.service.InventoryServiceImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo39.service.InventoryService"%>
<%@ page import="kr.ac.kopo.ctc.kopo39.domain.Inventory" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.InventoryDao" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.InventoryDaoImpl" %>
<!-- domain, dto, dao, service 패키지 임포트 -->
<%@page import="java.util.List"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<%@ page contentType="text/html; charset=utf-8" %> 
<!--utf-8 인코딩 처리-->

<html>
<head>
<title>inventory_list.jsp</title>
<link rel="stylesheet" type="text/css" href="introTable.css"> <!-- CSS 스타일시트 링크 -->
<link rel="stylesheet" type="text/css" href="Table.css"> <!-- CSS 스타일시트 링크 -->

	<script language="JavaScript"> 
	
        function checkSearch() { //checkSearch 함수 생성
        	const form = document.getElementById('form'); //id값이 'form'인 요소를 찾아 변수에 저장
        	
			const _serialnum = form.elements.key.value; //form 요소 내 name 속성을 가진 입력 필드의 값을 가져와 변수에 저장
     
			const pattern1 = /^\d+$/; //숫자만 받는(공백제외) 정규식1 생성
            const pattern2 = /^.{1,20}$/; //20자 이내만 입력받는 정규식2 생성
            
            if (_serialnum.trim().length === 0) { //상품번호 값이 0이면
               alert("상품 번호를 입력하세요"); //경고 문구 출력
            } else if (!pattern1.test(_serialnum) || !pattern2.test(_serialnum)) { //상품명 칸에 20자 넘게 값이 들어오면
               alert("상품 번호를 20자 이내(공백제외)의 숫자로만 입력해주세요"); //경고 문구 출력
            } else { /* 위의 두 조건이 아닐 경우 submit() 실행 */ 
                form.action='Inventory_view.jsp' // 폼 데이터 전송할 경로 설정
                form.submit(); // 폼 데이터 전송
            }
        }
    
	</script>

</head>
</head>
<body>
    <table>  <!-- 인트로 테이블 -->
        <tr>
            <td width="50"></td>
            <td width="500">
                <p><h1>재고 전체 현황 보기</h1></p> 
            </td>
            <td width="50"></td>
        </tr>
    </table>

<form method="post" id="form">  <!-- 폼 요소 생성, 전송방식 post, id 부여 -->
	<table>
		<tr>
			<td style="text-align: center;"> 
			<input type="text" name="key" value=""> <!-- 입력값 텍스트로 받기, key값 설정 -->
			<input type="button" value="검색" onClick="checkSearch()"> 
			<!-- 검색 버튼 생성, 클릭하면 script의 checkSearch() 메소드 실행 -->
			</td>
		</tr>
	</table>
</form>	
	
	<table class="maintable"> <!-- CSS 적용위해 클래스 부여 -->
		<tr>
			<td width=100><p align=center>상품번호</p></td> <!-- 상품번호 열 -->
			<td width=200><p align=center>상품명</p></td> <!-- 상품명 열 -->
			<td width=100><p align=center>현재 재고</p></td> <!-- 현재 재고 열 -->
			<td width=150><p align=center>상품 등록일</p></td> <!-- 상품 등록일 열 -->
			<td width=150><p align=center>재고 파악일</p></td> <!-- 재고 파악일 열 -->
		</tr> 

<%
 	//page 파라미터 값 받아서 정수형으로 형변환 후 변수에 저장, 값이 1보다 작으면 기본값 1로 설정
 	String pageValue = request.getParameter("page"); 
 	int pageNum = 1; 
 	if (pageValue != null) { 
 	   pageNum = Integer.parseInt(pageValue); 
 	   if (pageNum < 1) {
 	      pageNum = 1;
 	   }
 	}
 	
 	//countPerPage 파라미터 값 받아서 정수형으로 형변환 후 변수에 저장, 값이 1보다 작으면 기본값 10으로 설정
 	String countPerPageValue = request.getParameter("countPerPage");
 	int countPerPage = 10;
 	if (countPerPageValue != null) {
 	   countPerPage = Integer.parseInt(countPerPageValue);
 	   if (countPerPage < 1) {
 	      countPerPage = 10;
 	   }
 	}
 		
 	InventoryService inventoryService = new InventoryServiceImpl(); // InventoryServiceImpl 객체 생성
 	Pagination pagination = inventoryService.getPagination(pageNum, countPerPage);
 	// InventoryServiceImpl getPagination 함수(인자값으로 page, countPerPage 넣음) 불러와서 리턴값 Pagination 객체에 저장
 	
 	//pagination 객체에 저장된 값 가져와서 변수에 값 저장
 	int C = pagination.getC(); //현재페이지(=현재블록)
 	int S = pagination.getS(); //스타트블록
 	int E = pagination.getE(); //앤드블록
 	int P = pagination.getP(); //현재페이지(블록)-블록 사이즈
 	int PP = pagination.getPP(); //맨 앞 블록
 	int N = pagination.getN(); //현재페이지(블록)+블록 사이즈
 	int NN = pagination.getNN(); //맨 뒤 블록

 	InventoryDao invetoryDao = new InventoryDaoImpl(); // InventoryDaoImpl 객체 생성
 	List<Inventory> list = invetoryDao.selectAll(C, countPerPage); 
 	//invetoryDao selectAll() 함수 호출하여 리턴값 리스트 변수에 저장
 	
 %>
		
<%
	//데이터베이스에 저장된 데이터들 출력
	for (int i = 0; i < list.size(); i++) { //리스트 반복문 돌려서
	Inventory inventory = list.get(i); //리스트 변수에 저장된 데이터 한 행씩 가져와서 변수에 담기
		
	out.println("<tr>");
	out.println("<td><p align=center><a href='Inventory_view.jsp?key="+ inventory.getSerialnum() +"'>" + inventory.getSerialnum() + "</p></td>");
	//하이퍼링크 걸기, key 값으로 inventory 객체의 상품번호 값 전달, inventory 객체의 상품번호 값 출력
	out.println("<td><p align=center><a href='Inventory_view.jsp?key="+ inventory.getSerialnum() +"'>" 
	+ inventory.getName().replaceAll("<", "&lt;").replaceAll(">", "&gt;") + "</a></p></td>");
	//하이퍼링크 걸기, key 값으로 inventory 객체의 상품번호 값 전달, inventory 객체의 상품명 값 출력, 태그 문자열로 그대로 나오게 처리
	out.println("<td>" + inventory.getStocknum() + "</td>"); // inventory 객체의 재고 수량 값 출력
	out.println("<td>" + inventory.getRegdate() + "</td>"); // inventory 객체의 상품 등록일 값 출력
	out.println("<td>" + inventory.getCheckdate() + "</td>"); // inventory 객체의 재고 등록일 값 출력
	out.println("</tr>");
	}
%>
	
	</table>
	
	<table class="maintable"> <!-- CSS 적용위해 클래스 부여 -->
    <tr>
        <td width="75%">
            <div class="pagination"> <!-- CSS 적용위해 클래스 부여 -->
				<%
				if(C > 10) { //현재 페이지가 0보다 큰 경우에만 이전 페이지로 이동할 수 있도록 조건 확인
				%>
				<a href="Inventory_list.jsp?page=<%=PP%>" style="color:black"><<</a> <!--클릭하면 현재페이지 유지, 페이지 값은 PP-->
				<a href="Inventory_list.jsp?page=<%=P%>" style="color:black"><</a> <!--클릭하면 현재페이지 유지, 페이지 값은 P-->
				<%
				}
				for(int i = S; i <= E; i++) { //스타트 블록부터 앤드 블록까지 반복문 돌려서 출력
					if(C == i) { //현재 페이지와 i 값이 같으면
				%>
				<a href="Inventory_list.jsp?page=<%=i%>" style="color:red"><%=i%></a> <!--빨간색으로 표시-->
				<% 
				} else {
				%>
				<a href="Inventory_list.jsp?page=<%=i%>" style="color:black"><%=i%></a> <!--아니면 검은색으로 표시-->
				<%
				}
				}
				if(NN != -1){ //NN의 값이 -1이 아니면
				%>
				<a href="Inventory_list.jsp?page=<%=N%>" style="color:black">></a> <!--클릭하면 현재페이지 유지, 페이지 값은 N-->
				<a href="Inventory_list.jsp?page=<%=NN%>" style="color:black">>></a> <!--클릭하면 현재페이지 유지, 페이지 값은 NN-->
				<%
				}
				%>
			</div></td>
		<td width="25%"><input type="button" value="신규등록" onClick="window.location='Inventory_insert.jsp'"></td>
		<!-- 신규등록 버튼 생성, 버튼 누르면 Inventory_insert.jsp로 위치 이동-->
	</table>
	
</body>
</html>