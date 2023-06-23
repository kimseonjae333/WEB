<%@ page import="kr.ac.kopo.ctc.kopo39.domain.Gongji" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.GongjiDao" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.GongjiDaoImpl" %>
<%@ page contentType="text/html; charset=utf-8" %> 
<!--utf-8 인코딩 처리-->

<html>
<head>	
<title>gongji_delete.jsp</title>
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
			<td><p align=center><h1>삭제가 완료되었습니당;)</h1></p></td>
		</tr>
	</table>
	
	<table width=700>
		<tr>
			<td width=650></td>
			<td><input type="button" value="목록" onClick="window.location='gongji_list.jsp'"></td>
		</tr>
	</table>
	
<%	
	request.setCharacterEncoding("UTF-8"); // UTF-8 인코딩 설정(넘어오는 건 무조건 string)
	String id = request.getParameter("id"); // 파라미터로 받은 값을 변수에 저장
	int Id = Integer.parseInt(id); // 파라미터로 받은 값을 변수에 저장
	
	GongjiDao gongjiDao = new GongjiDaoImpl(); //VoteSystemDaoImpl 객체 생성하여 변수에 저장	
	gongjiDao.deleteData(Id);
%>

</body>
</html>