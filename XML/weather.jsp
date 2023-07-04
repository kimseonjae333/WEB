<%@page import="org.w3c.dom.*"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="org.w3c.dom.Element"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<title>Weather</title>
<style>
body {
   font-family: Arial, sans-serif; /* 전체 본문에 대한 글꼴 패밀리 설정 */
   margin: 0;
   padding: 20px;
   background-color: #f2f2f2; /* 본문의 배경색 설정 */
}

table {
   border-collapse: collapse; /* 테이블 셀 사이의 경계를 제거 */
   width: 100%;
   margin-bottom: 20px;
}

th, td {
   padding: 10px;
   text-align: center;
}

th {
   background-color: #336699; /* 테이블 헤더 셀의 배경색 설정 */
   color: #fff; /* 테이블 헤더 셀의 텍스트 색상 설정 */
}

tr:nth-child(even) {
   background-color: #e5f1f1; /* 테이블에서 짝수 행의 배경색 설정 */
}

img {
   height: 20px;
   width: 20px;
   vertical-align: middle;
}
</style>


<%
	String seq = ""; // 48시간 중 몇번째 인지
	String hour = ""; // 동네 예보 3시간 단위
	String day = ""; // 1번째 날 (0: 오늘, 1: 내일, 2: 모레)
	String temp = ""; // 현재 시간온도
	String tmx = ""; // 최고 온도
	String tmn = ""; // 최저 온도
	String sky = ""; // 하늘 상태코드 (1: 맑음, 2: 구름조금, 3: 구름많음, 4: 흐림)
	String pty = ""; // 강수 상태코드 (0: 없음, 1: 비, 2: 비/눈, 3: 눈/비, 4:눈)
	String wfKor = ""; // 날씨 한국어
	String wfEn = ""; // 날씨 영어
	String pop = ""; // 강수 확률 %
	String r12 = ""; // 12시간 예상 강수량
	String s12 = ""; // 12시간 예상 적설량
	String ws = ""; // 풍속 (m/s)
	String wd = ""; // 풍향 (0~7: 북, 북동, 동, 남동, 남, 남서, 서, 북서)
	String wdKor = ""; // 풍향 한국어
	String wdEn = ""; // 풍향 영어
	String reh = ""; // 습도 %
	String r06 = ""; // 6시간 예상 강수량
	String s06 = ""; // 6시간 예상 적설량
%>
</head>
<body>
	<table cellspacing=1 width=500 height=50 border=1> <!-- 카테고리 테이블 -->
		<tr>
			<td width=100><a href='Parsing.jsp'>성적표</a></td> <!-- 현재 선택한 테이블에 색깔 표시 -->
			<td width=100 bgcolor='#FFFF00'><a href='weather.jsp'>기상청</a></td>
		</tr>
	</table>
	<br>
	
   <%
   DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder(); 
   // DocumentBuilder 객체를 생성하여 XML 문서를 파싱하기 위한 설정을 제공하는 DocumentBuilderFactory로부터 인스턴스를 가져옴
   Document doc = docBuilder.parse("http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=123"); 
   // 기상청에서 동네 예보 정보 가져오기

   Element root = doc.getDocumentElement(); // XML 문서의 루트 요소를 가져옴
   NodeList tag_001 = doc.getElementsByTagName("data"); // data 태그를 모두 가져옴
   %>
   <%
   out.println("<table>"); // table 열기
   out.println("<th>순서</th>"); // 순서 입력
   out.println("<th>시간</th>"); // 시간 입력
   out.println("<th>날짜</th>"); // 날짜 입력
   out.println("<th>현재 시간 온도</th>"); // 현재 시간 온도 입력
   out.println("<th>최고 온도</th>"); // 최고 온도 입력
   out.println("<th>최저 온도</th>"); // 최저 온도 입력
   out.println("<th>하늘 상태</th>"); // 하늘 상태 입력
   out.println("<th>강수 상태</th>"); // 강수 상태 입력
   out.println("<th>한국어 날씨</th>"); // 한국어 날씨 입력
   out.println("<th>영어 날씨</th>"); // 영어 날씨 입력
   out.println("<th>강수 확률(%)</th>"); // 강수 확률(%) 입력
   out.println("<th>12시간 예상 강수량</th>"); // 12시간 예상 강수량 입력
   out.println("<th>12시간 예상 적설량</th>"); // 12시간 예상 적설량 입력
   out.println("<th>풍속(m/s)</th>"); // 풍속 입력
   out.println("<th>풍향</th>"); //풍향 입력
   out.println("<th>한국어 풍향</th>"); // 한국어 풍향 입력
   out.println("<th>영어 풍향</th>"); // 영어 풍향 입력
   out.println("<th>습도(%)</th>"); // 습도(%) 입력
   out.println("<th>6시간 예상 강수량</th>"); //6시간 예상 강수량 입력
   out.println("<th>6시간 예상 적설량</th>"); //6시간 예상 적설량 입력
   %>
   
   <%
   for (int i = 0; i < tag_001.getLength(); i++) { // tag_001의 길이만큼 루프
      Element elmt = (Element) tag_001.item(i); // Element로 형변환하여 elmt객체에 할당
      seq = tag_001.item(i).getAttributes().getNamedItem("seq").getNodeValue(); // seq 변수에 현재 data 태그의 seq 속성값 저장
      hour = elmt.getElementsByTagName("hour").item(0).getFirstChild().getNodeValue(); // 현재 data 태그의 첫 번째 자식 노드의 값 저장함
      day = elmt.getElementsByTagName("day").item(0).getFirstChild().getNodeValue(); // 현재 data 태그의 첫 번째 자식 노드의 값 저장함
      if (day.equals("0")) { // day가 0이면
         day = "오늘"; // day에 오늘 할당
      } else if (day.equals("1")) { // day가 1이면
         day = "내일"; // day에 내일 할당
      } else if (day.equals("2")) { // day가 2이면
         day = "모레"; // day에 모레 할당
      }
      temp = elmt.getElementsByTagName("temp").item(0).getFirstChild().getNodeValue(); // 현재 data 태그의 첫 번째 자식 노드의 값 저장함
      tmx = elmt.getElementsByTagName("tmx").item(0).getFirstChild().getNodeValue(); // 현재 data 태그의 첫 번째 자식 노드의 값 저장함
      tmn = elmt.getElementsByTagName("tmn").item(0).getFirstChild().getNodeValue(); // 현재 data 태그의 첫 번째 자식 노드의 값 저장함
      sky = elmt.getElementsByTagName("sky").item(0).getFirstChild().getNodeValue(); // 현재 data 태그의 첫 번째 자식 노드의 값 저장함
      pty = elmt.getElementsByTagName("pty").item(0).getFirstChild().getNodeValue(); // 현재 data 태그의 첫 번째 자식 노드의 값 저장함
      wfKor = elmt.getElementsByTagName("wfKor").item(0).getFirstChild().getNodeValue(); // 현재 data 태그의 첫 번째 자식 노드의 값 저장함
      wfEn = elmt.getElementsByTagName("wfEn").item(0).getFirstChild().getNodeValue(); // 현재 data 태그의 첫 번째 자식 노드의 값 저장함
      pop = elmt.getElementsByTagName("pop").item(0).getFirstChild().getNodeValue(); // 현재 data 태그의 첫 번째 자식 노드의 값 저장함
      r12 = elmt.getElementsByTagName("r12").item(0).getFirstChild().getNodeValue(); // 현재 data 태그의 첫 번째 자식 노드의 값 저장함
      s12 = elmt.getElementsByTagName("s12").item(0).getFirstChild().getNodeValue(); // 현재 data 태그의 첫 번째 자식 노드의 값 저장함
      ws = elmt.getElementsByTagName("ws").item(0).getFirstChild().getNodeValue(); // 현재 data 태그의 첫 번째 자식 노드의 값 저장함
      wd = elmt.getElementsByTagName("wd").item(0).getFirstChild().getNodeValue(); // 현재 data 태그의 첫 번째 자식 노드의 값 저장함
      
      if (wd.equals("0")) { // wd가 0이면
         wd = "↑"; // 북풍
      } else if (wd.equals("1")) { // wd가 1이면
         wd = "↗"; //북동풍
      } else if (wd.equals("2")) { // wd가 2이면
         wd = "→"; // 동풍
      } else if (wd.equals("3")) { // wd가 3이면
         wd = "↘"; // 남동풍
      } else if (wd.equals("4")) { // wd가 4이면
         wd = "↓"; // 남풍
      } else if (wd.equals("5")) { // wd가 5이면
         wd = "↙"; // 남서풍
      } else if (wd.equals("6")) { // wd가 6이면
         wd = "←"; // 서풍
      } else if (wd.equals("7")) { // wd가 7이면
         wd = "↖"; // 북서풍
      }
      wdKor = elmt.getElementsByTagName("wdKor").item(0).getFirstChild().getNodeValue(); // 현재 data 태그의 첫 번째 자식 노드의 값 저장함
      wdEn = elmt.getElementsByTagName("wdEn").item(0).getFirstChild().getNodeValue(); // 현재 data 태그의 첫 번째 자식 노드의 값 저장함
      reh = elmt.getElementsByTagName("reh").item(0).getFirstChild().getNodeValue(); // 현재 data 태그의 첫 번째 자식 노드의 값 저장함
      r06 = elmt.getElementsByTagName("r06").item(0).getFirstChild().getNodeValue(); // 현재 data 태그의 첫 번째 자식 노드의 값 저장함
      s06 = elmt.getElementsByTagName("s06").item(0).getFirstChild().getNodeValue(); // 현재 data 태그의 첫 번째 자식 노드의 값 저장함

      out.println("<tr>");
      out.println("<td>" + seq + "</td>"); // seq 값 출력
      out.println("<td>" + hour + "</td>"); // hour 값 출력
      out.println("<td>" + day + "</td>"); // day 값 출력
      out.println("<td>" + temp + "</td>"); // temp 값 출력
      out.println("<td>" + tmx + "</td>"); // tmx 값 출력
      out.println("<td>" + tmn + "</td>"); // tmn 값 출력

      if (sky.equals("1")) {
          out.println("<td><img src='image/DB01.png'></td>"); // sky가 "1"일 때 DB01.png 이미지를 출력
      } else if (sky.equals("2")) {
          out.println("<td><img src='image/DB02.png'></td>"); // sky가 "2"일 때 DB02.png 이미지를 출력
      } else if (sky.equals("3")) {
          out.println("<td><img src='image/DB03.png'></td>"); // sky가 "3"일 때 DB03.png 이미지를 출력
      } else if (sky.equals("4")) {
          out.println("<td><img src='image/DB04.png'></td>"); // sky가 "4"일 때 DB04.png 이미지를 출력
      }

      if (pty.equals("0")) {
          out.println("<td><img src='image/None.png'></td>"); // pty가 "0"일 때 null.png 이미지를 출력
      } else if (pty.equals("1")) {
          out.println("<td><img src='image/DB05.png'></td>"); // pty가 "1"일 때 DB05.png 이미지를 출력
      } else if (pty.equals("2")) {
          out.println("<td><img src='image/DB06.png'></td>"); // pty가 "2"일 때 DB06.png 이미지를 출력
      } else if (pty.equals("3")) {
          out.println("<td><img src='image/DB07.png'></td>"); // pty가 "3"일 때 DB07.png 이미지를 출력
      } else if (pty.equals("4")) {
          out.println("<td><img src='image/DB08.png'></td>"); // pty가 "4"일 때 DB08.png 이미지를 출력
      }


      out.println("<td>" + wfKor + "</td>"); // wfKor 값 출력
      out.println("<td>" + wfEn + "</td>"); // wfEn 값 출력
      out.println("<td>" + pop + "</td>"); // pop 값 출력
      out.println("<td>" + r12 + "</td>"); // r12 값 출력
      out.println("<td>" + s12 + "</td>"); // s12 값 출력
      out.println("<td>" + ws + "</td>"); // ws 값 출력
      out.println("<td>" + wd + "</td>"); // wd 값 출력
      out.println("<td>" + wdKor + "</td>"); // wdKor 값 출력
      out.println("<td>" + wdEn + "</td>"); // wdEn 값 출력
      out.println("<td>" + reh + "</td>"); // reh 값 출력
      out.println("<td>" + r06 + "</td>"); // r06 값 출력
      out.println("<td>" + s06 + "</td>"); // s06 값 출력
      out.println("</tr>");
   }
   %>
</body>
</html>
