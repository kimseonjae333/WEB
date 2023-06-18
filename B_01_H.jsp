<%@page import="java.util.List"%>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.VoteSystemDao" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.VoteSystemDaoImpl" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.domain.VoteSystem" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page contentType="text/html; charset=utf-8" %>

<html>
<head>
<title>투표 B_01_H.jsp</title>
</head>
<body>


	<table cellspacing=1 width=600 height=50 border=1> <!-- 카테고리 테이블 -->
		<tr>
			<td width=100><a href='A_01_H.jsp'>후보등록</a></td>
			<td width=100 bgcolor='#FFFF00'><a href='B_01_H.jsp'>>투표</a></td> <!-- 현재 선택한 테이블에 색깔 표시 -->
			<td width=100><a href='C_01_H.jsp'>개표결과</a></td>
		</tr>
	</table>
	<br>
	
	<h1>투표</h1> <!-- 화면에 출력 -->
	<table cellspacing=1 width=600 border=1> <!-- 테이블 생성 -->
		<tr>
			<form method='post' action='B_02_H.jsp'> <!-- 폼 데이터 B_02_H.jsp로 전송 -->
			<td width=200><p align=center><select name="kiho"> <!-- select 태그 1, 이름 'kiho'로 설정 -->
			
<%
		VoteSystemDao voteSystemDao = new VoteSystemDaoImpl(); //VoteSystemDaoImpl 객체 생성하여 변수에 저장
		List<VoteSystem> list  = voteSystemDao.selectAll(); //VoteSystemDaoImpl의 selectAll() 함수 호출하여 리턴값 리스트 변수에 저장

			for (int i = 0; i < list.size(); i++) { //리스트 반복문 돌려서
				VoteSystem voteSystem = list.get(i); //리스트 변수에 저장된 데이터 한 행씩 가져와서 변수에 담기
				out.println("<option value=" + voteSystem.getKiho() + ">" + voteSystem.getKiho() + "번 " + voteSystem.getName() + "</option>");
				//옵션 값에 데이터베이스에 있는 기호와 이름 값 뜰 수 있게 설정
			}
%>

			</select></p></td> 
			
			<td width=300><p align=center>
			<select name="age"> <!-- select 태그 2, 이름 'age'로 설정 -->
			<option value=1> 10대
			<option value=2> 20대
			<option value=3> 30대
			<option value=4> 40대
			<option value=5> 50대
			<option value=6> 60대
			<option value=7> 70대
			<option value=8> 80대
			<option value=9> 90대 <!-- 옵션 값 입력 -->
			</select>
			</p></td>

			<td><input type=submit value='투표하기' style='width:100'></td> <!-- 투표하기 버튼 만들기 -->
			
			</form>
		</tr>
	</table>

</body>
</html>