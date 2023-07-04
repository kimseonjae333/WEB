<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.domain.Inventory" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.InventoryDao" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.InventoryDaoImpl" %>
<%@ page contentType="text/html; charset=utf-8" %> 
<!--utf-8 인코딩 처리-->

<html>
<head>	
<title>inventory_delete.jsp</title>
<link rel="stylesheet" type="text/css" href="introTable.css"> <!-- CSS 스타일 시트 링크 -->
<link rel="stylesheet" type="text/css" href="Table.css"> <!-- CSS 스타일 시트 링크 -->
</head>
<body>
	<table> <!-- 인트로 테이블 -->
        <tr>
            <td width="50"></td>
            <td width="500">
                <p><h1>재고 삭제</h1></p>
            </td>
            <td width="50"></td>
        </tr>
    </table>

<%
	request.setCharacterEncoding("UTF-8"); // UTF-8 인코딩 설정(넘어오는 건 무조건 string)
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
%>
	<table class="maintable"> <!-- CSS 스타일 적용위해 class 부여 -->
		<tr>
			<td><p align=center><h1>[<%=name.replaceAll("<", "&lt;").replaceAll(">", "&gt;")%>] 상품이 삭제되었습니다</h1></p></td>
			<!-- 태그처리하여 화면에 출력 -->
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
	String serialnum = multi.getParameter("serialnum"); // 파라미터로 받은 값을 변수에 저장
	
	InventoryDao inventoryDao = new InventoryDaoImpl(); //InventoryDaoImpl 객체 생성하여 변수에 저장
	inventoryDao.deleteData(serialnum); //InventoryDaoImpl의 deleteData() 함수 호출, 인자로 변수 전달
%>

</body>
</html>
