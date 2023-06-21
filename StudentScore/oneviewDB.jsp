<%@ page import="kr.ac.kopo.ctc.kopo39.dao.StudentScoreDao"%> <!--dao 패키지에서 StudentScoreDao 가져오기-->
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.StudentScoreDaoImpl"%> <!--dao 패키지에서 StudentScoreDaoImpl 가져오기-->
<%@page import="kr.ac.kopo.ctc.kopo39.domain.StudentScore"%> <!--domain 패키지에서 StudentScore 가져오기-->
<%@ page contentType="text/html; charset=utf-8" %>
<!--utf-8 인코딩 처리-->


<html>
<head>
<title>OneviewDB</title>
</head>
<body>

<%
    //파라미터로 키 값 받아서 변수에 저장하고 형변환
    String ckey = request.getParameter("key"); 
	int key = Integer.parseInt(ckey);

    //StudentScoreDaoImpl 객체 불러와서 selectOne() 함수 호출, 키 값 인자로 전달, 리턴값 변수에 저장
	StudentScoreDao studentScoreDao = new StudentScoreDaoImpl(); 
	StudentScore studentScoreOne = studentScoreDao.selectOne(key); 
%>

 <!--뒤로가기 버튼 생성-->
 <form method='post' action='AllviewDB.jsp'> <!--action 속성으로 폼데이터 이동 경로 지정-->
 <div ><p align=left ><button type="submit">뒤로가기</button>뒤로가기</button></p></div>
 </form>
                  
<h1>[<%=key%>]조회</h1> <!--화면에 출력-->

<!--테이블 생성하고 스타일 설정-->
<table cellspacing=1 width=600 border=1> 
    <tr>
    	<!--<td width=50><p align=center>순번</p></td>-->
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
	out.println("<tr>"); //행 추가해서 데이터 값 넣기
	//out.println("<td width=50><p align=center>" + studentScoreOne.getId() +"</p></td>"); 
    out.println("<td width=50><p align=center>" + studentScoreOne.getName() +"</p></td>"); //selectOne() 함수의 리턴값(객체)에서 이름 값 가져오기
    out.println("<td width=50><p align=center>" + studentScoreOne.getStudentId() +"</p></td>"); //selectOne() 함수의 리턴값(객체)에서 학번 값 가져오기
    out.println("<td width=50><p align=center>" + studentScoreOne.getKor() + "</p></td>"); //selectOne() 함수의 리턴값(객체)에서 국어 점수 값 가져오기
    out.println("<td width=50><p align=center>" + studentScoreOne.getEng() + "</p></td>"); //selectOne() 함수의 리턴값(객체)에서 영어 점수 값 가져오기
    out.println("<td width=50><p align=center>" + studentScoreOne.getMat() + "</p></td>"); //selectOne() 함수의 리턴값(객체)에서 수학 점수 값 가져오기
    out.println("<td width=50><p align=center>" + studentScoreOne.getSum() +"</p></td>"); //selectOne() 함수의 리턴값(객체)에서 합계 값 가져오기
    out.println("<td width=50><p align=center>" + studentScoreOne.getAvg() +"</p></td>"); //selectOne() 함수의 리턴값(객체)에서 평균 값 가져오기
    out.println("<td width=50><p align=center>" + studentScoreOne.getRank() +"</p></td>"); //selectOne() 함수의 리턴값(객체)에서 순위 값 가져오기
    out.println("</tr>");	
%>

</table>
</body>
</html>

