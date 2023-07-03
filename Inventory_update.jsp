<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.domain.Inventory" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.InventoryDao" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.InventoryDaoImpl" %>
<%@ page contentType="text/html; charset=utf-8" %> 

<html>
<head>
<title>inventory_update.jsp</title>
<link rel="stylesheet" type="text/css" href="introTable.css"> <!-- CSS 스타일 시트 링크 -->
<link rel="stylesheet" type="text/css" href="Table.css"> <!-- CSS 스타일 시트 링크 -->
	
	<style>
		.input-field {  /* input 요소에 전체 적용 */
			border: none;
			outline: none;
			background-color: transparent;
			float: left;
		}
	</style>
	
	<script>
		
		function checkForm() { //checkForm() 함수 정의
	    	const form = document.getElementById('form3'); //id값이 'form3'인 요소를 찾아 변수에 저장

			const _stocknum = form.elements.stocknum.value; //form 요소 내 name 속성을 가진 입력 필드의 값을 가져와 변수에 저장
           
			const pattern1 = /^\d+$/; //숫자만 입력받는 정규식1 생성
            const pattern2 = /^.{1,20}$/; //30자 이내만 입력받는 정규식2 생성
            
            if (_stocknum.trim().length === 0) { //재고수량이 빈칸이면
               alert("빈 칸을 입력하세요"); //경고 문구 출력
            } else if (!pattern1.test(_stocknum) || !pattern2.test(_stocknum)) { //재고수량 칸에 20자 넘게 값이 들어오면
                alert("재고 현황을 20자 이내(공백제외)의 숫자로만 입력해주세요"); //경고 문구 출력
            } else { //위 두 조건이 아니면
                checkForm2();  //checkForm2() 함수 실행
            }
        }
		
		function checkForm2() { //checkForm2() 함수 정의
	    	const form = document.getElementById('form3'); //id값이 'form3'인 요소를 찾아 변수에 저장
	    	
	    	   if (confirm("정말 수정하시겠습니까?")) { //확인 메세지 띄우기
	    	        form.action = 'Inventory_update2.jsp'//확인 누르면 update2 페이지로 폼 데이터 전달
	    	        form.submit(); //서버에 폼 데이터 전달
	    	    } else {
	    	        return; // 아무 작업도 수행하지 않고 원래 페이지에 머무르기
	    	    }
	    }	
	         	
	</script>
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
	int stocknum = Integer.parseInt(multi.getParameter("stocknum")); //파라미터로 받은 값 변수에 저장하고 형변환
	String content = multi.getParameter("content"); // 파라미터로 받은 값을 변수에 저장
	String image = multi.getFilesystemName("image"); // 파라미터로 받은 값을 변수에 저장
	String dateString = multi.getParameter("regdate"); // 파라미터로 받은 값을 변수에 저장
	
	// 날짜 파싱
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		//날짜 형식을 지정하기 위해 SimpleDateFormat 객체를 생성
		java.util.Date parsedDate = null;
		//파싱된 날짜 값을 저장하기 위한 java.util.Date 객체를 선언하고 초기화
		try {
		    parsedDate = dateFormat.parse(dateString);
		    //SimpleDateFormat 객체를 사용하여 문자열 형태의 날짜를 파싱하여 java.util.Date 객체로 변환
		} catch (Exception e) { //만약 날짜 형식이 올바르지 않으면 예외가 발생
		    e.printStackTrace();
		    out.println("날짜 형식이 올바르지 않습니다."); //예외 처리 코드 작성
		}
		
		java.sql.Date regdate = null;
		if (parsedDate != null) {
		    regdate = new java.sql.Date(parsedDate.getTime());
		    // 날짜 파싱이 성공한 경우에 실행됨
		    // 여기에 데이터베이스 저장 등의 처리 코드 작성
		}
	
	Inventory inventory = new Inventory(); // Inventory 객체 생성해서 변수에 저장
	inventory.setSerialnum(serialnum); // Inventory의 상품번호에 set으로 값 저장
	inventory.setName(name); // Inventory의 상품명에 set으로 값 저장
	inventory.setRegdate(regdate); // Inventory의 상품등록일에 set으로 값 저장
	inventory.setStocknum(stocknum); // Inventory의 재고수량에 set으로 값 저장
	inventory.setContent(content); // Inventory의 상품설명에 set으로 값 저장
	inventory.setPhoto(path + image); // Inventory의 상품이미지에 set으로 값 저장
	   	
    InventoryDao inventoryDao = new InventoryDaoImpl(); //InventoryDaoImpl 객체 생성하여 변수에 저장
  	Inventory inventoryInfo = inventoryDao.findInfo(serialnum); 
    //InventoryDaoImpl의 findInfo() 함수 호출하고 리턴값 Inventory 객체에 저장
%>

<form method = 'post' id= 'form3'> <!-- 폼 설정, 전송방식 post, id부여 -->
	<table class="maintable"> <!-- CSS 스타일 적용 위해 class 부여 -->
		<tr>
			<td style="text-align: left;"><b>상품 번호</b></td>
			<td><input type=text name=serialnum value='<%=inventoryInfo.getSerialnum()%>' class="input-field" readonly></td>
			<!-- inventoryInfo의 상품번호 값 가져오기 -->
		</tr>
		<tr>
			<td style="text-align: left;"><b>상품명</b></td>
			<td><input type=text name=name value='<%=inventoryInfo.getName()%>' class="input-field" readonly></td>
			<!-- inventoryInfo의 상품명 값 가져오기 -->
		</tr>
		<tr>
			<td style="text-align: left;"><b>재고 현황</b></td>
			<td><input type=text name=stocknum value='<%=inventoryInfo.getStocknum()%>' style='float:left;'></td>
			<!-- inventoryInfo의 재고현황 값 가져오기 -->
		</tr>
		<tr>
			<td style="text-align: left;"><b>상품등록일</b></td>
			<td><input type=text name=regdate value="<%=inventoryInfo.getRegdate()%>" class="input-field" readonly></td>
			<!-- inventoryInfo의 상품등록일 값 가져오기 -->
		</tr>
		<tr>
			<td style="text-align: left;"><b>재고등록일</b></td>
			 <% java.text.SimpleDateFormat CdateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
			 <!-- 재고등록일은 현재 날짜로 받기 위해 SimpleDateFormat 객체 생성 -->
			<td><input type=text name=checkdate value="<%= CdateFormat.format(new java.util.Date()) %>" class="input-field" readonly></td>
			<!-- 현재날짜를 포맷하여 출력 -->
		</tr>
		<tr>
			<td style="text-align: left;"><b>상품설명</b></td>
			<td><textarea name="content" rows="5" cols="70" style="width:500; height:40; resize: none; 
			overflow: auto;" class="input-field"><%=inventoryInfo.getContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;")%></textarea></td>
			<!-- inventoryInfo 객체의 상품 내용 출력(태그 그대로 문자열로 나오게 처리), CSS 스타일 적용위해 클래스 부여, textarea 사이즈 고정, 글자수 넘어가면 자동 스크롤 생성 -->
		</tr>
		<tr>
			<td style="text-align: left;"><b>상품사진</b></td>
			<td>
			<%
				if(inventoryInfo.getPhoto() == null){ //만약 가져온 값이 null이면
			%>	<img src="image/defaultImg.jpg" width="200" height="250" class="input-field"> <!-- 기본이미지 출력 -->
			<%	} else { //가져온 값이 null이 아니면
			%>	<img src="<%= inventoryInfo.getPhoto() %>" width="200" height="250" class="input-field"> <!-- inventoryInfo의 상품이미지 가져오기 -->
			<% 	
				}
			%>
			</td>
		</tr>
	</table>
	<table class="maintable"> <!-- CSS 스타일 적용위해 class 부여 -->
		<tr>
			<td width=600></td>
			<td><input type=button value="재고수정" onClick="checkForm()"></td> <!-- 재고수정 버튼 누르면 checkForm() 함수 호출 -->
		</tr>
	</table>
</form>

</body>
</html>