<%@page import="java.util.List"%>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.VoteSystemDao"%>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.VoteSystemDaoImpl"%>
<%@ page import="kr.ac.kopo.ctc.kopo39.domain.VoteSystem"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page contentType="text/html; charset=utf-8"%>

<html>
<head>
<title>개표결과 C_02_H.jsp</title>
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
	//파리미터 값 받기
	request.setCharacterEncoding("UTF-8"); //UTF-8 인코딩 설정(넘어오는건 무조건 string)
	String name =request.getParameter("name"); //파라미터 값 받기
	String key =request.getParameter("key"); //파라미터 값 받기

%>
	<h1>[<%=key%>번 <%=name%> 후보 득표 성향]</h1> <!-- 화면에 출력 -->
	
	<table cellspacing=1 width=600 border=1> <!-- 테이블 생성 -->
		<tr>
			<td width=75><p align=center>연령대</p></td> <!-- 연령대 열 생성 -->
			<td width=500><p align=center>인기도</p></td> <!-- 인기도 열 생성 -->
		</tr>
	
<%	
	int kiho = Integer.parseInt(key); //파리미터 값 형변환
	VoteSystemDao voteSystemDao = new VoteSystemDaoImpl(); //VoteSystemDaoImpl 객체 생성하고 변수에 저장
	List<VoteSystem> list = voteSystemDao.selectOne(kiho); //VoteSystemDaoImpl의 selectOne() 함수 호출하고 리턴값 리스트 변수에 저장
	int kihoCount = voteSystemDao.countVotes(kiho); //countVotes() 함수 호출하여 인자값으로 파라미터로 받은 기호값 전달
													//리턴값으로 해당 기호(후보)의 총 득표수 받음, 변수에 저장
	
	for (int age = 1; age <= 9 ; age++) { //총 연령대 수만큼 반복
		int ageCount = 0; //연령대별 총 득표수 변수 정의
		for (int j = 0; j < list.size(); j++) { //리스트 반복문 돌려서
			VoteSystem voteSystem = list.get(j);  //리스트 변수에 저장된 데이터 한 행씩 가져와서 변수에 담기
			if(voteSystem.getAge() == age) { //가져온 데이터와 연령대가 같을때 
				ageCount = voteSystem.getCount(); //연령대별 총 득표수 저장 -> 9개 연령대의 총 득표수 구함
				break; //반복문 다 돌면 탈출
			}
		}
		
		int voteRate = kihoCount > 0 ? (int) ((double) ageCount / kihoCount * 100) : 0; //조건? true : false
		//삼항연산자, 해당 기호의 득표수가 0보다 크면(조건) true 값 저장, 틀리면 false 값 저장
		int barLength = (int)(voteRate * 4); //바 길이 설정
	
		out.println("<tr>");
	    out.println("<td width=100><p align=center>" + (age * 10) + "대" + "</p></td>"); //age 변수 활용해 10대,20대... 출력
	    out.println("<td width=500><p align=center>");
	    out.println("<div>");
	    out.println("<span><img src='bar.jpg' style='width: " + barLength
	        + "px; height: 20px; display: inline-block;'></span>"); //막대그래프 계산된 길이만큼 출력
	    out.println("<span>" + ageCount + "명 (" + voteRate + "%)</span>"); //연령대 별 총 득표수와 득표율 출력
	    out.println("</div>");
	    out.println("</td>");
	    out.println("</tr>");

	}

%>	
	
	</table>
</body>
</html>
