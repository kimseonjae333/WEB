<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.domain.Inventory" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.InventoryDao" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.InventoryDaoImpl" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<%@ page contentType="text/html; charset=utf-8" %> 
<!--utf-8 인코딩 처리-->

<html>
<head>	
<title>inventory_write.jsp</title>
<link rel="stylesheet" type="text/css" href="introTable.css"> <!-- CSS 스타일 적용 -->
<link rel="stylesheet" type="text/css" href="Table.css"> <!-- CSS 스타일 적용 -->
</head>

<body>
	<table> <!-- 인트로 테이블 -->
        <tr>
            <td width="50"></td>
            <td width="500">
                 <p><h1>재고 등록</h1></p>
            </td>
            <td width="50"></td>
        </tr>
    </table>

<%
	request.setCharacterEncoding("UTF-8"); // Add this line
	String path = "./image/"; //서버에서 저장할 localhost 뒤에 붙는 위치
	String realPath = application.getRealPath(path); //실제 저장되는 위치(하드디스크)
	//System.out.println("Inventory_write.jsp - realPath : " + realPath); // 절대경로 확인

	int size = 10 * 1024 * 1024; // 저장 용량 제한 (10MB)
	
	//파일이 업로드될 디렉토리가 존재하지 않는 경우 디렉토리를 생성
	//File uploadDir = new File(realPath);
	//if (!uploadDir.exists()) {
	 //uploadDir.mkdirs();
	// }
	
	//실제 파일 업로드하는 처리문
	MultipartRequest multi = new MultipartRequest(request, realPath, size, "UTF-8", new DefaultFileRenamePolicy());
	//request, 저장 위치, 용량 제한, 인코딩, 충돌 일어나면(중복되면) 새로운 이름으로 파일 만들어서 넣도록 처리
	//별도 임포트 필요(import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy")
	
	String name = multi.getParameter("name"); // 파라미터로 받은 값을 변수에 저장	
	String serialnum = multi.getParameter("serialnum"); // 파라미터로 받은 값을 변수에 저장
	int stocknum = 0; //정수형 변수 선언 및 초기화
	try {
	    stocknum = Integer.parseInt(multi.getParameter("stocknum")); 
	    // 정상적으로 형변환된 경우의 처리
	} catch (NumberFormatException e) {
	    // 형변환 에러가 발생한 경우의 처리
		 out.println("<script>alert('재고번호를 다시 입력해주세요'); location.href='Inventory_insert.jsp';</script>");
	}
	String content = multi.getParameter("content"); // 파라미터로 받은 값을 변수에 저장
	String image = multi.getFilesystemName("image"); // 파라미터로 받은 값을 변수에 저장
	
	Inventory inventory = new Inventory(); // Inventory 객체 생성해서 변수에 저장
	inventory.setSerialnum(serialnum); // Inventory의 상품번호에 set으로 값 저장
	inventory.setName(name); // Inventory의 상품명에 set으로 값 저장
	inventory.setStocknum(stocknum); // Inventory의 재고수량에 set으로 값 저장
	inventory.setContent(content); // Inventory의 내용에 set으로 값 저장
	inventory.setPhoto(path + image); // Inventory의 상품이미지에 set으로 값 저장
	    
	InventoryDao inventoryDao = new InventoryDaoImpl(); //InventoryDaoImpl 객체 생성하여 변수에 저장
	int result = inventoryDao.insertData(inventory); //InventoryDaoImpl의 insertData() 함수 호출하고 리턴값 변수에 저장
	
	if (result == -1) { //리턴값이 -1이면
	      out.println("<script>alert('이미 존재하는 상품번호 입니다'); location.href='Inventory_insert.jsp';</script>");
		  //isert 페이지로 이동하고 화면에 경고메세지 띄우기
	} else { //리턴값이 -1이 아니면 아래 출력
	
%>
	<table class="maintable"> <!-- CSS 스타일 적용위해 class 부여 -->
		<tr>
			<td><p align=center><h1>[<%=name.replaceAll("<", "&lt;").replaceAll(">", "&gt;")%>] 상품이 등록되었습니다</h1></p></td>
			<!-- 태그 처리하여 화면에 출력 -->
		</tr>
	</table>
	
	<table class="maintable"> <!-- CSS 스타일 적용위해 class 부여 -->
		<tr>
			<td width=650></td>
			<td><input type="button" value="재고현황" onClick="window.location='Inventory_list.jsp'"></td>
			<!-- 재고현황 버튼 누르면 리스트 목록으로 이동 -->
		</tr>
	</table>
<%
	}
%>

</body>
</html>