<%@ page import="kr.ac.kopo.ctc.kopo39.dao.StudentScoreDao"%> <!--dao 패키지에서 StudentScoreDao 가져오기-->
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.StudentScoreDaoImpl"%> <!--dao 패키지에서 StudentScoreDaoImpl 가져오기-->
<%@ page import="kr.ac.kopo.ctc.kopo39.service.StudentScoreService"%> <!--service 패키지에서 StudentScoreService 가져오기-->
<%@ page import="kr.ac.kopo.ctc.kopo39.service.StudentScoreServiceImpl"%> <!--service 패키지에서 StudentScoreServiceImpl 가져오기-->
<%@page import="kr.ac.kopo.ctc.kopo39.domain.StudentScore"%> <!--domain 패키지에서 StudentScore 가져오기-->
<%@page import="kr.ac.kopo.ctc.kopo39.dto.Pagination"%> <!--dto 패키지에서 Pagination 가져오기-->
<%@page import="java.util.List"%> <!--리스트 임포트-->
<%@ page import="java.net.*" %> <!--파라미터값 받기 위해 임포트-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<!--utf-8 인코딩 처리-->


<html>
<head>
<title>deleteDB</title>
</head>
<body>
<h1>레코드 삭제</h1>

<%
	//파라미터 값 받고 저장
	String name="";
	int studentid=0, kor=0, eng=0, mat=0; //이름, 학번, 국어, 수학, 영어 점수 변수 선언
	
	request.setCharacterEncoding("UTF-8"); //UTF-8 인코딩 설정(넘어오는건 무조건 string)
	name = request.getParameter("name"); //파라미터 값 받기
	studentid = Integer.parseInt(request.getParameter("studentid")); //파라미터 값 받기+형변환
	kor = Integer.parseInt(request.getParameter("korean")); //파라미터 값 받기+형변환
	eng = Integer.parseInt(request.getParameter("english")); //파라미터 값 받기+형변환
	mat = Integer.parseInt(request.getParameter("mathmatic")); //파라미터 값 받기+형변환
	
	StudentScore studentScore = new StudentScore(); //StudentScore 객체 불러와서 변수에 저장
	studentScore.setName(name); //set으로 객체에 값 저장
	studentScore.setStudentId(studentid); //set으로 객체에 값 저장
	studentScore.setKor(kor); //set으로 객체에 값 저장
	studentScore.setEng(eng); //set으로 객체에 값 저장
	studentScore.setMat(mat); //set으로 객체에 값 저장

%>

<%
	//페이지 네이션 구현 위해 페이지랑 카운터 페이지 값 파라미터로 받기
	//파라미터 값이 있으면 형변환 하기
	//1보다 작은 값은 기본값 1로 설정(page), 10으로 설정(countPerPage)
	String pageValue = request.getParameter("page");
	int pageNum = 1;
	if (pageValue != null) { 
	   pageNum = Integer.parseInt(pageValue);
	   if (pageNum < 1) {
	      pageNum = 1;
	   }
	} 
	
	//페이지 네이션 구현 위해 페이지랑 카운터 페이지 값 파라미터로 받기
	//파라미터 값이 있으면 형변환 하기
	//1보다 작은 값은 기본값 1로 설정(page), 10으로 설정(countPerPage)
	String countPerPageValue = request.getParameter("countPerPage");
	int countPerPage = 10;
	if (countPerPageValue != null) {
	   countPerPage = Integer.parseInt(countPerPageValue);
	   if (countPerPage < 1) {
	      countPerPage = 10;
	   }
	}
%>
	<!--테이블 만들기-->
    <table callspacing=1 width=600 border=1>
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
		
		StudentScoreDao studentScoreDao = new StudentScoreDaoImpl(); //StudentScoreDaoImpl 객체 불러와서 변수에 저장
        int cp = studentScoreDao.getCurrentPage(studentid,countPerPage); 
		//StudentScoreDaoImpl의 getCurrentPage() 함수 불러와서 리턴값 변수에 저장
		//인자값 학번으로 전달해 해당 학번이 포함된 페이지(CurrentPage) 구하기
                	
        studentScoreDao.deleteByStuentId(studentid); //학번을 인자값으로 전달해 StudentScoreDaoImpl의 deleteByStuentId() 메서드 실행
        List<StudentScore> studentScores = studentScoreDao.selectAll(cp, countPerPage); //selectAll 함수 실행해서 결과 리스트에 담기
        StudentScoreService studentScoreService = new StudentScoreServiceImpl(); //getPagination 함수 불러오기 위해
        Pagination pagination = studentScoreService.getPagination(pageNum, countPerPage); //getPagination 함수 실행해서 결과 객체에 담기

                	
        int C = cp; //현재페이지(=현재블록)
        int S = pagination.getS(); //스타트블록
        int E = pagination.getE(); //앤드블록
        int P = pagination.getP(); //현재페이지(블록)-블록 사이즈
        int PP = pagination.getPP(); //맨 앞 블록
        int N = pagination.getN(); //현재페이지(블록)+블록 사이즈
        int NN = pagination.getNN(); //맨 뒤 블록


        for(int i = 0; i < studentScores.size(); i++) { //리스트 반복문 돌려서 데이터 전체 출력
         StudentScore studentScore1 = studentScores.get(i); //i에 해당하는 객체 값 변수에 담기
                		
         	out.println("<tr>");
         	//out.println("<td width=50><p align=center><a href='oneview.jsp?key="+studentScore1.getId()+"'> "+studentScore1.getId() +"</a></p></td>");
         	out.println("<td width=50><p align=center>" + studentScore1.getName()+"</p></td>"); //객체에서 이름 값 가져오기
         	out.println("<td width=50><p align=center><a href='oneview.jsp?key="+studentScore1.getStudentId()+"'> " + studentScore1.getStudentId()+"</p></td>"); 
         	//객체에서 학번 값 가져오기, 학번값을 키로 설정하여 파라미터 값으로 전달
         	out.println("<td width=50><p align=center>" + studentScore1.getKor()+"</p></td>"); //객체에서 국어점수 값 가져오기
         	out.println("<td width=50><p align=center>" + studentScore1.getEng()+"</p></td>"); //객체에서 영어점수 값 가져오기
         	out.println("<td width=50><p align=center>" + studentScore1.getMat()+"</p></td>"); //객체에서 수학점수 값 가져오기
         	out.println("<td width=50><p align=center>" + studentScore1.getSum() +"</p></td>"); //객체에서 합계 값 가져오기
         	out.println("<td width=50><p align=center>" + studentScore1.getAvg() +"</p></td>"); //객체에서 평균 값 가져오기
         	out.println("<td width=50><p align=center>" + studentScore1.getRank() +"</p></td>"); //객체에서 순위 값 가져오기
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




		
	
