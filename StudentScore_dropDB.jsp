<%@ page import="kr.ac.kopo.ctc.kopo39.dao.StudentScoreDao" %> <!--dao 패키지에서 StudentScoreDao 가져오기-->
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.StudentScoreDaoImpl" %> <!--dao 패키지에서 StudentScoreDaoImpl 가져오기-->
<%@ page import="kr.ac.kopo.ctc.kopo39.service.StudentScoreService" %> <!--service 패키지에서 StudentScoreService 가져오기-->
<%@ page import="kr.ac.kopo.ctc.kopo39.service.StudentScoreServiceImpl" %> <!--service 패키지에서 StudentScoreServiceImpl 가져오기-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page contentType="text/html; charset=utf-8" %>
<!--utf-8 인코딩 처리-->

<html>
<head>
<title>dropDB</title>
</head>
<body>
   <%
   	StudentScoreDao studentScoreDao = new StudentScoreDaoImpl(); //StudentScoreDaoImpl 객체 생성
      String drop = studentScoreDao.droptable(); //StudentScoreDaoImpl 객체의 droptable() 함수 호출하여 리턴값 변수에 저장
      out.println(drop); //변수에 저장된 리턴값 출력
   %>
</body>
</html>
