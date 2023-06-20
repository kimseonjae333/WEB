<%@ page import="kr.ac.kopo.ctc.kopo39.domain.Gongji" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.GongjiDao" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.GongjiDaoImpl" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<%@ page contentType="text/html; charset=utf-8" %> 
<!--utf-8 인코딩 처리-->

<html>
<head>
<title>gongji_view.jsp</title>

	<script language="JavaScript">
	
		function submitForm(){ //submitForm이라는 이름의 함수 생성, mode를 인자로 받음
			const form = document.getElementById('form2'); //id값이 'form1'인 요소를 찾아 변수에 저장
			form.action = 'gongji_UnD.jsp?id=' + form.elements.id.value
		    		+ '&title=' + form.elements.title.value 
		    		+'&content=' + form.elements.content.value; //myform의 폼 데이터가 전송될 대상 URL 지정
		    form.submit(); //submit(): JavaScript에서 HTML 폼을 제출하는 메서드, 메서드를 호출하면 폼 데이터가 서버로 전송
		} 
		
	</script>

</head>
<body>
	<!-- 카테고리 테이블 -->
 	<table cellspacing=1 width=700 height=50 border=1>
		<tr>
			<td width=100><p align=center><a href='gongji_list.jsp'>공지사항 리스트</a></p></td>
			<td width=100><p align=center><a href='gongji_insert.jsp'>새 글 입력</a></p></td>
			<td width=100 bgcolor='#FFFF00'><p align=center><a href='gongji_view.jsp'>글 보기</a></p></td>
			<td width=100><p align=center><a href='gongji_UnD.jsp'>글 수정/삭제</a></p></td>
		</tr>
	</table>
	<br>


<%
	request.setCharacterEncoding("UTF-8"); //UTF-8 인코딩 설정(넘어오는건 무조건 string)
	String ckey = request.getParameter("key"); //파라미터로 받은 값을 변수에 저장
	int key = Integer.parseInt(ckey); //파라미터로 받은 값을 변수에 저장+형변환
	
	Gongji gongji = new Gongji(); //VoteSystem 객체 생성해서 변수에 저장
	gongji.setId(key); //VoteSystem의 kiho에 set으로 값 저장
	GongjiDao gongjiDao = new GongjiDaoImpl(); //VoteSystemDaoImpl 객체 생성하여 변수에 저장
	Gongji gongjiOne = gongjiDao.selectOne(key); //VoteSystemDaoImpl의 insertHubo() 함수 호출
%>

<form method='post' id='form2'>
	<table cellspacing=0 cellpadding=5 width=700 border=1>
		<tr>
			<td width=100><p align=center><b>번호</b></p></td>
			<td><%=gongjiOne.getId()%><input type="hidden" name="id" value="<%=gongjiOne.getId()%>"></td>
		</tr>
		<tr>
			<td width=100><p align=center><b>제목</b></p></td>
			<td><%=gongjiOne.getTitle()%><input type="hidden" name="title" value="<%=gongjiOne.getTitle()%>"></td>
		</tr>
		<tr>
			<td width=100><p align=center><b>일자</b></p></td>
			<td><%=gongjiOne.getDate()%></td>
		</tr>
		<tr>
			<td width=100><p align=center><b>내용</b></p></td>
			<td><%=gongjiOne.getContent()%><input type="hidden" name="content" value="<%=gongjiOne.getContent()%>"></td>
		</tr>
	</table>
	<br>
	
	<table width=700>
		<tr>
			<td width=600></td>
			<td><input type=button value="목록" onClick="location.href='gongji_list.jsp'"></td>
			<td><input type=button value="수정" onClick="submitForm()"></td>
		</tr>
	</table>
</form>
</body>
</html>