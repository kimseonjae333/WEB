<%@page import="kr.ac.kopo.ctc.kopo39.dto.Pagination"%>
<%@page import="kr.ac.kopo.ctc.kopo39.service.GongjiServiceImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo39.service.GongjiService"%>
<%@ page import="kr.ac.kopo.ctc.kopo39.domain.Gongji" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.GongjiDao" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.GongjiDaoImpl" %>
<%@page import="java.util.List"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<%@ page contentType="text/html; charset=utf-8" %> 
<!--utf-8 인코딩 처리-->

<html>
<head>
<title>gongji_list.jsp</title>
</head>
<body>
	<!-- 카테고리 테이블 -->
 	<table cellspacing=1 width=700 height=50 border=1>
		<tr>
			<td width=100 bgcolor='#FFFF00'><p align=center><a href='gongji_list.jsp'>공지사항 리스트</a></p></td>
			<td width=100><p align=center><a href='gongji_insert.jsp'>새 글 입력</a></p></td>
			<td width=100><p align=center><a href='gongji_view.jsp'>글 보기</a></p></td>
			<td width=100><p align=center><a href='gongji_UnD.jsp'>글 수정/삭제</a></p></td>
		</tr>
	</table>
	<br>



	<table cellspacing=0 width=700 border=1>
		<tr>
			<td width=50><p align=center>번호</p></td>
			<td width=500><p align=center>제목</p></td>
			<td width=150><p align=center>등록일</p></td>
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
	
	//StudentScoreDaoImpl의 selectAll 함수(인자값으로 page, countPerPage 넣음) 불러와서 리턴값 list에 저장
	GongjiDao gongjiDao = new GongjiDaoImpl(); //VoteSystemDaoImpl 객체 생성
	List<Gongji> list = gongjiDao.selectAll(pageNum, countPerPage); //VoteSystemDaoImpl의 selectAll() 함수 호출하여 리턴값 리스트 변수에 저장
	//StudentScoreServiceImpl의 getPagination 함수(인자값으로 page, countPerPage 넣음) 불러와서 리턴값 Pagination 객체에 저장
	GongjiService gongjiservice = new GongjiServiceImpl();
	Pagination pagination = gongjiservice.getPagination(pageNum, countPerPage); 
	
	//pagination 객체에 저장된 값 가져와서 변수에 값 저장
	int C = pagination.getC(); //현재페이지(=현재블록)
	int S = pagination.getS(); //스타트블록
	int E = pagination.getE(); //앤드블록
	int P = pagination.getP(); //현재페이지(블록)-블록 사이즈
	int PP = pagination.getPP(); //맨 앞 블록
	int N = pagination.getN(); //현재페이지(블록)+블록 사이즈
	int NN = pagination.getNN(); //맨 뒤 블록
%>
		
<%
	//데이터베이스에 저장된 데이터들 출력
	for (int i = 0; i < list.size(); i++) { //리스트 반복문 돌려서
	Gongji gongji = list.get(i); //리스트 변수에 저장된 데이터 한 행씩 가져와서 변수에 담기
		
	out.println("<tr>");
	out.println("<td><p align=center>" + gongji.getId() + "</p></td>");
	out.println("<td><p align=center><a href='gongji_view.jsp?key="+ gongji.getId() +"'>" + gongji.getTitle() + "</a></p></td>");
	//'id'로 이름 지정, voteSystem 객체에 저장된 해당 데이터 행의 기호 열 값 가져옴, readonly 처리
	out.println("<td><p align=center>" + gongji.getDate() + "</p></td>");
	//'name'으로 이름 지정, voteSystem 객체에 저장된 해당 데이터 행의 이름 열 값 가져옴, readonly 처리
	out.println("</tr>");
	}
%>
	</table>
	<div style="width:700px; text-align:center; font-size:20px; margin-top:10px;">
	<%
	if(C > 10) { //현재 페이지가 0보다 큰 경우에만 이전 페이지로 이동할 수 있도록 조건 확인
	%>
	<a href="gongji_list.jsp?page=<%=PP%>" style="color:black"><<</a> <!--클릭하면 AllviewDB.jsp로 이동, 페이지 값은 PP-->
	<a href="gongji_list.jsp?page=<%=P%>" style="color:black"><</a> <!--클릭하면 AllviewDB.jsp로 이동, 페이지 값은 P-->
	<%
	}
	for(int i = S; i <= E; i++) { //스타트 블록부터 앤드 블록까지 반복문 돌려서 출력
		if(C == i) { //현재 페이지와 i 값이 같으면
	%>
	<a href="gongji_list.jsp?page=<%=i%>" style="color:red"><%=i%></a> <!--빨간색으로 표시-->
	<% 
	} else {
	%>
	<a href="gongji_list.jsp?page=<%=i%>" style="color:black"><%=i%></a> <!--아니면 검은색으로 표시-->
	<%
	}
	}
	if(NN != -1){ //NN의 값이 -1이 아니면
	%>
	<a href="gongji_list.jsp?page=<%=N%>" style="color:black">></a> <!--클릭하면 AllviewDB.jsp로 이동, 페이지 값은 N-->
	<a href="gongji_list.jsp?page=<%=NN%>" style="color:black">>></a> <!--클릭하면 AllviewDB.jsp로 이동, 페이지 값은 NN-->
	<%
	}
	%>
	</div>
	
	<table width=700>
		<tr>
			<td width=650></td>
			<td><input type="button" value="신규" onClick="window.location='gongji_insert.jsp'"></td>
		</tr>
	</table>
	
</body>
</html>
