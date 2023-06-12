<%@ page import="kr.ac.kopo.ctc.kopo39.dao.StudentScoreDao"%> <!--dao 패키지에서 StudentScoreDao 가져오기-->
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.StudentScoreDaoImpl"%> <!--dao 패키지에서 StudentScoreDaoImpl 가져오기-->
<%@ page import="kr.ac.kopo.ctc.kopo39.service.StudentScoreService"%> <!--service 패키지에서 StudentScoreService 가져오기-->
<%@ page import="kr.ac.kopo.ctc.kopo39.service.StudentScoreServiceImpl"%> <!--service 패키지에서 StudentScoreServiceImpl 가져오기-->
<%@page import="kr.ac.kopo.ctc.kopo39.domain.StudentScore"%> <!--domain 패키지에서 StudentScore 가져오기-->
<%@page import="kr.ac.kopo.ctc.kopo39.dto.Pagination"%> <!--dto 패키지에서 Pagination 가져오기-->
<%@ page contentType="text/html; charset=utf-8"%> <!--utf-8 인코딩 처리-->
<%@page import="java.util.List"%> <!--list 받기 위해 임포트-->


<html>
<head>
<title>AllviewDB</title>
</head>
<body>

<%
	 out.println("<h1>조회</h1>");  //화면에 출력
     
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
%>

<%
	//StudentScoreDaoImpl의 selectAll 함수(인자값으로 page, countPerPage 넣음) 불러와서 리턴값 list에 저장
	StudentScoreDao studentScoreDao = new StudentScoreDaoImpl();
	List<StudentScore> studentScores = studentScoreDao.selectAll(pageNum, countPerPage); 

	//StudentScoreServiceImpl의 getPagination 함수(인자값으로 page, countPerPage 넣음) 불러와서 리턴값 Pagination 객체에 저장
	StudentScoreService studentScoreService = new StudentScoreServiceImpl(); 
	Pagination pagination = studentScoreService.getPagination(pageNum, countPerPage); 
	
	//pagination 객체에 저장된 값 가져와서 변수에 값 저장
	int C = pagination.getC(); //현재페이지(=현재블록)
	int S = pagination.getS(); //스타트블록
	int E = pagination.getE(); //앤드블록
	int P = pagination.getP(); //현재페이지(블록)-블록 사이즈
	int PP = pagination.getPP(); //맨 앞 블록
	int N = pagination.getN(); //현재페이지(블록)+블록 사이즈
	int NN = pagination.getNN(); //맨 뒤 블록
%>
	<!--테이블 생성하고 스타일 설정-->
	<table cellspacing=1 width=600 border=1>
		<tr>
			<!--<td width=50><p align=center>번호</p></td>-->
			<td width=50><p align=center>이름</p></td>
			<td width=50><p align=center>학번</p></td>
			<td width=50><p align=center>국어</p></td>
			<td width=50><p align=center>영어</p></td>
			<td width=50><p align=center>수학</p></td>
			<td width=50><p align=center>합계</p></td>
			<td width=50><p align=center>평균</p></td>
			<td width=50><p align=center>순위</p></td>
		</tr>

<%
	//selectAll 함수의 리턴값으로 받은 리스트 for문 돌려서 데이터 다 출력
	for(int i = 0; i < studentScores.size(); i++) {
		StudentScore studentScore = studentScores.get(i); //리스트에서 뽑은 값(객체) 변수에 저장(객체 형태로)
		
	    out.println("<tr>");
        //out.println("<td width=50><p align=center><a href='oneviewDB.jsp?key=" + studentScore.getId() +"'> "+studentScore.getId()+"</a></p></td>");
        out.println("<td width=50><p align=center>" + studentScore.getName() + "</p></td>"); //studentScore 객체의 이름 값 가져오기
        out.println("<td width=50><p align=center><a href='oneviewDB.jsp?key=" + studentScore.getStudentId() +"'>" + studentScore.getStudentId() +"</a></p></td>"); 
		//studentScore 객체의 학번 값 가져오기
		//a 태그의 href 속성을 사용하여 링크의 대상 URL을 지정(oneview.jsp?key=와 studentScore 객체의 학번을 조합하여 링크의 URL이 생성)
		//링크를 클릭하면 해당 값을 파라미터로 전달하면서 oneview.jsp 페이지로 이동
        out.println("<td width=50><p align=center>" + studentScore.getKor() +"</p></td>"); //studentScore 객체의 국어점수 값 가져오기
        out.println("<td width=50><p align=center>" + studentScore.getEng() +"</p></td>"); //studentScore 객체의 영어점수 값 가져오기
        out.println("<td width=50><p align=center>" + studentScore.getMat() +"</p></td>"); //studentScore 객체의 수학점수 값 가져오기
        out.println("<td width=50><p align=center>" + studentScore.getSum() +"</p></td>"); //studentScore 객체의 합계 값 가져오기
        out.println("<td width=50><p align=center>" + studentScore.getAvg() +"</p></td>"); //studentScore 객체의 평균 값 가져오기
        out.println("<td width=50><p align=center>" + studentScore.getRank() +"</p></td>"); //studentScore 객체의 순위 값 가져오기옴
        out.println("</tr>");
	}
%>
	</table>

<!--페이지 버튼 생성하는 부분-->
<div style="width:600px; text-align:center; font-size:20px; margin-top:10px;">
	<%
	if(C > 10) { //현재 페이지가 0보다 큰 경우에만 이전 페이지로 이동할 수 있도록 조건 확인
	%>
	<a href="AllviewDB.jsp?page=<%=PP%>" style="color:black"><<</a> <!--클릭하면 AllviewDB.jsp로 이동, 페이지 값은 PP-->
	<a href="AllviewDB.jsp?page=<%=P%>" style="color:black"><</a> <!--클릭하면 AllviewDB.jsp로 이동, 페이지 값은 P-->
	<%
	}
	for(int i = S; i <= E; i++) { //스타트 블록부터 앤드 블록까지 반복문 돌려서 출력
		if(C == i) { //현재 페이지와 i 값이 같으면
	%>
	<a href="AllviewDB.jsp?page=<%=i%>" style="color:red"><%=i%></a> <!--빨간색으로 표시-->
	<% 
	} else {
	%>
	<a href="AllviewDB.jsp?page=<%=i%>" style="color:black"><%=i%></a> <!--아니면 검은색으로 표시-->
	<%
	}
	}
	if(NN != -1){ //NN의 값이 -1이 아니면
	%>
	<a href="AllviewDB.jsp?page=<%=N%>" style="color:black">></a> <!--클릭하면 AllviewDB.jsp로 이동, 페이지 값은 N-->
	<a href="AllviewDB.jsp?page=<%=NN%>" style="color:black">>></a> <!--클릭하면 AllviewDB.jsp로 이동, 페이지 값은 NN-->
	<%
	}
	%>
</div>
</body>
</html>
