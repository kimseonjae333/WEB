<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<%@ page contentType="text/html; charset=utf-8" %> 
<!--utf-8 인코딩 처리-->

<html>
<head>
<title>intro.jsp</title> 
</head>
<body>
    <h1>JSP Database 실습 1</h1> <!--화면에 출력-->
    

   <%
    //방문자 카운트
    String data; //변수 선언
    int cnt = 0; //카운트 변수 선언 및 초기화
    
    FileReader f1= new FileReader("C:/users/사용자/eclipse-workspace/StudentWebpage/src/main/webapp/cnt.txt");
    //cnt.txt 파일을 읽기 위해 경로를 지정하여 FileReader 객체 생성
    StringBuffer sb = new StringBuffer(); // 문자열을 담을 StringBuffer 객체 생성
    int ch = 0; //변수 선언
    while((ch=f1.read()) != -1) {
    	sb.append((char)ch);
    }
    data=sb.toString().trim().replace("\n",""); // StringBuffer를 문자열로 변환하여 data 변수에 저장
    f1.close(); //FileReader 객체 닫기
    
    cnt=Integer.parseInt(data); //문자열을 정수로 변환하여 cnt 변수에 저장
    cnt++; //cnt 값 1 증가
    data=Integer.toString(cnt); //cnt 값을 문자열로 변환하여 data 변수에 저장
    out.println("<br><br>현재 홈페이지 방문조회수는 ["+data+"] 입니다</br>"); //현재 방문조회수를 화면에 출력
    
    FileWriter f12 = new FileWriter("C:/users/사용자/eclipse-workspace/StudentWebpage/src/main/webapp/cnt.txt", false);
    //cnt.txt 파일을 쓰기 위해 경로를 지정하여 FileWriter 객체 생성, 기존 내용을 덮어쓰기 모드
    f12.write(data); //data 값을 파일에 쓰기
    f12.close(); //FileWriter 객체 닫기
    %>
</body>
</html>
