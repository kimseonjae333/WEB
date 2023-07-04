<%@page import="org.w3c.dom.*"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@ page contentType="text/html; charset=utf-8"%> <%-- 페이지의 콘텐츠 타입과 문자 인코딩 설정 --%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%> <%-- jsp파일에 java 클래스, java sql import --%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> <!-- html 한글처리 -->
</head>

<body>
	<table cellspacing=1 width=500 height=50 border=1> <!-- 카테고리 테이블 -->
		<tr>
			<td width=100 bgcolor='#FFFF00'><a href='Parsing.jsp'>성적표</a></td> <!-- 현재 선택한 테이블에 색깔 표시 -->
			<td width=100><a href='weather.jsp'>기상청</a></td>
		</tr>
	</table>
	<br>
<%
	DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder(); 
	// DocumentBuilder 객체 생성을 위해 DocumentBuilderFactory 클래스의 인스턴스를 얻어옴
	Document doc = docBuilder.parse(new File("C:\\Users\\사용자\\eclipse-workspace\\XMLWebpage\\src\\main\\webapp\\xmlmake.jsp")); 
	// 지정된 XML 파일을 파싱하여 Document 객체로 가져옴
	
	Element root = doc.getDocumentElement(); // Document 객체에서 루트 요소를 가져옴
	NodeList tag_name = doc.getElementsByTagName("name"); // "name" 태그를 가지고 있는 모든 요소를 가져와 NodeList 객체로 받음
	NodeList tag_studentid = doc.getElementsByTagName("studentid"); // "studentid" 태그를 가지고 있는 모든 요소를 가져와 NodeList 객체로 받음
	NodeList tag_kor = doc.getElementsByTagName("kor"); // "kor" 태그를 가지고 있는 모든 요소를 가져와 NodeList 객체로 받음
	NodeList tag_eng = doc.getElementsByTagName("eng"); // "eng" 태그를 가지고 있는 모든 요소를 가져와 NodeList 객체로 받음
	NodeList tag_mat = doc.getElementsByTagName("mat"); // "mat" 태그를 가지고 있는 모든 요소를 가져와 NodeList 객체로 받음
	
	out.println("<table cellspacing=1 width=500 border=1>");
	out.println("<tr>");
	out.println("<td width=100>이름</td>"); // 테이블 셀에 "이름" 출력
	out.println("<td width=100>학번</td>"); // 테이블 셀에 "학번" 출력
	out.println("<td width=100>국어</td>"); // 테이블 셀에 "국어" 출력
	out.println("<td width=100>영어</td>"); // 테이블 셀에 "영어" 출력
	out.println("<td width=100>수학</td>"); // 테이블 셀에 "수학" 출력
	out.println("</tr>");
	
	for(int i=0; i<tag_name.getLength();i++){ // tag_name의 길이만큼 루프
	    out.println("<tr>");
	out.println("<td width=100>"+tag_name.item(i).getFirstChild().getNodeValue()+"</td>"); // 테이블 셀에 이름 출력
	out.println("<td width=100>"+tag_studentid.item(i).getFirstChild().getNodeValue()+"</td>"); // 테이블 셀에 학번 출력
	out.println("<td width=100>"+tag_kor.item(i).getFirstChild().getNodeValue()+"</td>"); // 테이블 셀에 국어 점수 출력
	out.println("<td width=100>"+tag_eng.item(i).getFirstChild().getNodeValue()+"</td>"); // 테이블 셀에 영어 점수 출력
	out.println("<td width=100>"+tag_mat.item(i).getFirstChild().getNodeValue()+"</td>"); // 테이블 셀에 수학 점수 출력
	out.println("</tr>");
	}

%>
</body>

</html>