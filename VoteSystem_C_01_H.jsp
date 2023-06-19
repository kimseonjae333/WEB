<%@page import="java.util.List"%>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.VoteSystemDao"%>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.VoteSystemDaoImpl"%>
<%@ page import="kr.ac.kopo.ctc.kopo39.domain.VoteSystem"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page contentType="text/html; charset=utf-8"%>

<html>
<head>
<title>개표결과 C_01_H.jsp</title>
</head>
<body>

	<table cellspacing=1 width=600 height=50 border=1> <!-- 카테고리 테이블 -->
		<tr>
			<td width=100><a href='A_01_H.jsp'>후보등록</a></td>
			<td width=100><a href='B_01_H.jsp'>>투표</a></td>
			<td width=100 bgcolor='#FFFF00'><a href='C_01_H.jsp'>개표결과</a></td> <!-- 현재 선택한 테이블에 색깔 표시 -->
		</tr>
	</table>
	<br>
	
<%
	VoteSystemDao voteSystemDao = new VoteSystemDaoImpl(); //VoteSystemDaoImpl 객체 생성하여 변수에 저장
	List <VoteSystem> list = voteSystemDao.selectAll(); //VoteSystemDaoImpl의 selectAll() 함수 호출하여 리턴값 리스트 변수에 저장
	if(list.size() == 0) { //데이터 없으면
		out.println("<h3>투표 데이터가 없습니다</h3>"); //화면에 출력
	} else { //아니면 아래 실행
		
%>
	<h1>후보별 득표 결과</h1> <!-- 화면에 출력 -->

	<table cellspacing=1 width=600 border=1> <!-- 테이블 생성 -->
		<tr>
			<td width=100><p align=center>이름</p></td> <!-- 이름 열 생성 -->
			<td width=500><p align=center>인기도</p></td> <!-- 인기도 열 생성 -->
		</tr>
		
<%
		int total = voteSystemDao.countAll(); //VoteSystemDaoImpl의 countAll() 함수 호출하여 리턴값 변수에 저장
	
		for (int i = 0; i < list.size(); i++) { //리스트 반복문 돌려서
			VoteSystem voteSystem = list.get(i); //리스트 변수에 저장된 데이터 한 행씩 가져와서 변수에 담기
			
			int kihoCount = voteSystemDao.countVotes(voteSystem.getKiho()); 
			//VoteSystemDaoImpl의 countVotes() 함수 호출하여 인자값으로 가져온 데이터의 기호값 전달, 리턴값 변수로 받기
			int voteRate= 0; //득표율 변수 선언 및 초기화
			voteRate =(int)((double)kihoCount/total*100); //득표율 구하는 공식
		
			int barLength = (int)(voteRate * 4); //바 길이 설정
	
			out.println("<tr>");
		    out.println("<td style='width:100px;'><a href='C_02_H.jsp?key=" + voteSystem.getKiho() + "&name=" + voteSystem.getName()
		     	+ "'><p align=center>" + voteSystem.getKiho() + "번 " + voteSystem.getName() + "</p></a></td>");
		    //파라미터 값으로 가져온 데이터의 기호와 이름 값 받음 -> 하이퍼링크 걸기, 화면에 기호와 이름 값 출력
		    out.println("<td style='width:500px;'>");
		    out.println("<div>"); //div 태그로 감싸기
		    out.println("<span><img src='bar.jpg' style='width: " + barLength
		        + "px; height: 20px; display: inline-block;'></span>"); //막대그래프 계산된 길이만큼 출력
		    out.println("<span>" + kihoCount + "명 (" + voteRate + "%)</span>"); //해당 기호(후보)의 득표수와 득표율 출력
		    out.println("</div>");
		    out.println("</td>");
		    out.println("</tr>");
	
		}
	
	}	
%>
	</table>
</body>
</html>
