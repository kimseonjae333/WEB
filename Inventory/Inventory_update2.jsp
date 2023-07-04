<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@ page import="kr.ac.kopo.ctc.kopo39.domain.Inventory" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.InventoryDao" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.InventoryDaoImpl" %>
<%@ page contentType="text/html; charset=utf-8" %> 

<html>
<head>
<title>inventory_update2.jsp</title>
<link rel="stylesheet" type="text/css" href="introTable.css"> <!-- CSS 스타일 시트 링크 -->
<link rel="stylesheet" type="text/css" href="Table.css"> <!-- CSS 스타일 시트 링크 -->
</head>
<body>
	<table> <!-- 인트로 테이블 -->
        <tr>
            <td width="50"></td>
            <td width="500">
                <p><h1>재고 수정</h1></p>
            </td>
            <td width="50"></td>
        </tr>
    </table>

<%
	request.setCharacterEncoding("UTF-8"); // 파라미터값 인코딩 설정
	String name = request.getParameter("name"); // 파라미터로 받은 값을 변수에 저장
%>

	<table class="maintable"> <!-- CSS 스타일 적용위해 class 부여 -->
		<tr>
			<td><p align=center><h1>[<%=name.replaceAll("<", "&lt;").replaceAll(">", "&gt;")%>] 상품이 수정되었습니다</h1></p></td>
			<!-- 태그 처리하여 화면에 출력 -->
		</tr>
	</table>

<%	
	String serialnum = request.getParameter("serialnum"); // 파라미터로 받은 값을 변수에 저장
	int stocknum = Integer.parseInt(request.getParameter("stocknum")); //파라미터로 받은 값을 변수에 저장+형변환
	
	Inventory inventory = new Inventory(); // Inventory 객체 생성해서 변수에 저장
	inventory.setSerialnum(serialnum); // Inventory의 상품번호에 set으로 값 저장
	inventory.setStocknum(stocknum); // Inventory의 재고수량에 set으로 값 저장
	
	InventoryDao inventoryDao = new InventoryDaoImpl(); //InventoryDaoImpl 객체 생성하여 변수에 저장
	Inventory inventoryUp = inventoryDao.updateData(inventory); 
	//InventoryDaoImpl의 updateData() 함수 호출하여 리턴값 Inventory 변수에 저장
%>

	
	<table class="maintable"> <!-- CSS 스타일 적용 위해 class 부여 -->
		<tr>
			<td width=650></td>
			<td><input type="button" value="재고현황" onClick="location.href='Inventory_list.jsp'"></td>
			<!-- 재고현황 버튼 누르면 리스트 목록으로 이동 -->
		</tr>
	</table>

	
</body>
</html>
