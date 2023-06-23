<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@ page import="kr.ac.kopo.ctc.kopo39.domain.Gongji" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.GongjiDao" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.GongjiDaoImpl" %>
<%@ page contentType="text/html; charset=utf-8" %> 

<html>
<head>
<title>gongji_update.jsp</title>

</head>
<body>
	<!-- 카테고리 테이블 -->
 	<table cellspacing=1 width=700 height=50 border=1>
		<tr>
			<td width=100><p align=center><a href='gongji_list.jsp'>공지사항 리스트</a></p></td>
			<td width=100><p align=center><a href='gongji_insert.jsp'>새 글 입력</a></p></td>
			<td width=100><p align=center><a href='gongji_view.jsp'>글 보기</a></p></td>
			<td width=100 bgcolor='#FFFF00'><p align=center><a href='gongji_UnD.jsp'>글 수정/삭제</a></p></td>
		</tr>
	</table>
	<br>
	
	<table cellspacing=0 cellpadding=5 width=700 border=0>
		<tr>
			<td><p align=center><h1>내용이 수정되었습니다^0^</h1></p></td>
		</tr>
	</table>

<%
	request.setCharacterEncoding("UTF-8"); // UTF-8 인코딩 설정(넘어오는 건 무조건 string)
	String id = request.getParameter("id"); // 파라미터로 받은 값을 변수에 저장
	int Id = Integer.parseInt(id); // 파라미터로 받은 값을 변수에 저장
	String title = request.getParameter("title"); // 파라미터로 받은 값을 변수에 저장
	String dateString = request.getParameter("date"); // 파라미터로 받은 값을 변수에 저장
	String content = request.getParameter("content"); // 파라미터로 받은 값을 변수에 저장
	
	
	java.sql.Date date = null;
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
		
	if (parsedDate != null) {
		 date = new java.sql.Date(parsedDate.getTime());
		 // 날짜 파싱이 성공한 경우에 실행됨
		 // 여기에 데이터베이스 저장 등의 처리 코드 작성
	
	Gongji gongji = new Gongji(); // VoteSystem 객체 생성해서 변수에 저장
    gongji.setId(Id); // VoteSystem의 kiho에 set으로 값 저장
    gongji.setTitle(title); // VoteSystem의 kiho에 set으로 값 저장
    gongji.setDate(date); // VoteSystem의 kiho에 set으로 값 저장
    gongji.setContent(content); // VoteSystem의 kiho에 set으로 값 저장
   
    GongjiDao gongjiDao = new GongjiDaoImpl(); //VoteSystemDaoImpl 객체 생성하여 변수에 저장
    Gongji gongjiUp = gongjiDao.updateData(gongji);
%>

<form method = 'post'>
	<table cellspacing=0 cellpadding=5 width=700 border=1>
		<tr>
			<td><p align=center><b>번호</b></p></td>
			<td><input type=text name=id value="<%=gongjiUp.getId()%>" style='border:0;' readonly></td>
		</tr>
		<tr>
			<td><p align=center><b>제목</b></p></td>
			<td><input type=text name=title size=70 maxlength=70 value="<%=gongjiUp.getTitle()%>" style='border:0;' readonly></td>
		</tr>
		<tr>
			<td><p align=center><b>일자</b></p></td>
			<td><input type=text name=date value="<%=gongjiUp.getDate()%>" size=20 style='border:0;' readonly></td>
		</tr>
		<tr>
			<td><p align=center><b>내용</b></p></td>
			<td><textarea name=content cols=70 rows=10 style="width: 530px; height: 250px; border:0;" readonly><%=gongjiUp.getContent()%></textarea></td>
		</tr>
	</table>
	<br>
	
	<table width=700>
		<tr>
			<td width=650></td>
			<td><input type="button" value="목록" onClick="location.href='gongji_list.jsp'"></td>
		</tr>
	</table>
</form>

<%
	} 
	else {
	}
%>
</body>
</html>