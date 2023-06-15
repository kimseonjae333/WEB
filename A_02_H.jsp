<%@ page import="kr.ac.kopo.ctc.kopo39.dao.VoteSystemDao" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.VoteSystemDaoImpl" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.domain.VoteSystem" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page contentType="text/html; charset=utf-8" %>

<html>
<head>
<title>후보등록  A_02_H.jsp</title>
</head>
<body>
	<table cellspacing=1 width=600 height=50 border=1> <!-- 카테고리 테이블 -->
		<tr>
			<td width=100 bgcolor='#FFFF00'><a href='A_01_H.jsp'>후보등록</a></td> <!-- 현재 선택한 테이블에 색깔 표시 -->
			<td width=100><a href='B_01_H.jsp'>투표</a></td>
			<td width=100><a href='C_01_H.jsp'>개표결과</a></td>
		</tr>
	</table>

	<br>
	
	<h3>후보등록 결과: 후보가 추가 되었습니다.</h3> <!-- 화면에 출력 -->

	<%
	request.setCharacterEncoding("UTF-8"); //UTF-8 인코딩 설정(넘어오는건 무조건 string)
	String name = request.getParameter("name"); //파라미터로 받은 값을 변수에 저장
	int kiho = Integer.parseInt(request.getParameter("id")); //파라미터로 받은 값을 변수에 저장+형변환
	
	VoteSystem voteSystem = new VoteSystem(); //VoteSystem 객체 생성해서 변수에 저장
	voteSystem.setKiho(kiho); //VoteSystem의 kiho에 set으로 값 저장
	voteSystem.setName(name); //VoteSystem의 name에 set으로 값 저장
	VoteSystemDao voteSystemDao = new VoteSystemDaoImpl(); //VoteSystemDaoImpl 객체 생성하여 변수에 저장
	voteSystemDao.insertHubo(name); //VoteSystemDaoImpl의 insertHubo() 함수 호출
	%>
</body>
</html>
