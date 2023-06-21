<%@ page import="kr.ac.kopo.ctc.kopo39.dao.StudentScoreDao"%>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.StudentScoreDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo39.domain.StudentScore"%>
<%@ page import="kr.ac.kopo.ctc.kopo39.service.StudentScoreService"%>
<%@ page import="kr.ac.kopo.ctc.kopo39.service.StudentScoreServiceImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo39.dto.Pagination"%>
<%@page import="java.util.List"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<!--html과 jsp에서 한글처리 지시-->

<html>
<head>
<title>updateDB</title>
</head>
<body>
	<h1>레코드 수정</h1>

	<%
	//파라미터 값 받고 저장
	request.setCharacterEncoding("UTF-8"); //UTF-8 인코딩 설정(넘어오는건 무조건 string)
	String name = "";
	int studentid = 0;
	int korean = 0;
	int english = 0;
	int mathmatic = 0; //이름, 학번, 국어, 수학, 영어 점수 변수 선언
	

	try {
		name = request.getParameter("name"); //파라미터 값 받기
		String Sstudentid = request.getParameter("studentid"); //파라미터 값 받기+형변환
		String Skorean = request.getParameter("korean"); //파라미터 값 받기+형변환
		String Senglish = request.getParameter("english"); //파라미터 값 받기+형변환
		String Smathmatic = request.getParameter("mathmatic"); //파라미터 값 받기+형변환

		if (Sstudentid != null) {
			String numericPart = Sstudentid.replaceAll("[^0-9]", ""); // 숫자 이외의 문자는 제거
			studentid = Integer.parseInt(numericPart);
		}
		if (Skorean != null) {
			String numericPart = Skorean.replaceAll("[^0-9]", ""); // 숫자 이외의 문자는 제거
			korean = Integer.parseInt(numericPart);
		}
		if (Senglish != null) {
			String numericPart = Senglish.replaceAll("[^0-9]", ""); // 숫자 이외의 문자는 제거
			english = Integer.parseInt(numericPart);
		}
		if (Smathmatic != null) {
			String numericPart = Smathmatic.replaceAll("[^0-9]", ""); // 숫자 이외의 문자는 제거
			mathmatic = Integer.parseInt(numericPart);
		}

	} catch (NumberFormatException e) {
		// 숫자로 변환할 수 없는 경우에 대한 예외 처리
		// 숫자 부분만 추출하여 변환한 후, 변환된 값을 사용하거나 다른 처리를 수행할 수 있습니다.
	}

	StudentScore studentScore = new StudentScore(); //StudentScore 객체 불러와서 변수에 저장
	studentScore.setName(name); //set으로 객체에 값 저장
	studentScore.setStudentId(studentid); //set으로 객체에 값 저장
	studentScore.setKor(korean); //set으로 객체에 값 저장
	studentScore.setEng(english); //set으로 객체에 값 저장
	studentScore.setMat(mathmatic); //set으로 객체에 값 저장

	StudentScoreDao studentScoreDao = new StudentScoreDaoImpl(); //StudentScoreDaoImpl 객체 불러와서 변수에 저장
	studentScoreDao.update(studentid, studentScore); //StudentScoreDaoImpl의 update() 함수 호출

	
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

	
	
	StudentScoreDao studentScoreDao1 = new StudentScoreDaoImpl(); //StudentScoreDaoImpl 객체 불러와서 변수에 저장
	int currentPage = studentScoreDao1.getCurrentPage(studentid, countPerPage); 
	//StudentScoreDaoImpl의 getCurrentPage 함수 호출
	//인자값 학번으로 전달해 해당 학번이 포함된 페이지(CurrentPage) 구하기
	 
	
	List<StudentScore> studentScores2 = studentScoreDao1.selectAll(currentPage, countPerPage); //selectAll 함수 실행해서 결과 리스트에 담기
	
	
	StudentScoreService studentScoreService = new StudentScoreServiceImpl(); //getPagination 함수 불러오기 위해
	Pagination pagination = studentScoreService.getPagination(currentPage, countPerPage); //getPagination 함수 실행해서 결과 객체에 담기

	//페이지네이션 변수
	int C = pagination.getC(); //현재페이지(=현재블록)
	//out.println("c : " + C);
	int S = pagination.getS(); //스타트블록
	//out.println("s : " + S);
	int E = pagination.getE(); //앤드블록
	//out.println("e : " + E);
	int P = pagination.getP(); //현재페이지(블록)-블록 사이즈
	//out.println("p : " + P);
	int PP = pagination.getPP(); //맨 앞 블록
	//out.println("pp : " + PP);
	int N = pagination.getN(); //현재페이지(블록)+블록 사이즈
	//out.println("n : " + N);
	int NN = pagination.getNN(); //맨 뒤 블록
	//out.println("nn : " + NN);
	%>

	<!--테이블 만들기-->
	<table callspacing=1 width=600 border=1>
		<tr>
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
	//현재 페이지
		for (int i = 0; i < studentScores2.size(); i++) { //리스트 반복문 돌려서 전체 데이터 출력
			StudentScore studentScore1 = studentScores2.get(i); //i에 해당하는 객체 값 변수에 담기

			if (studentScore1.getStudentId() == studentid) {
				out.println("<tr bgcolor = '#ffff00'>"); //업데이트 된 행 배경색 지정(노란색)
				//out.println("<td width=50><p align=center><a href='oneviewDB.jsp?key=" + studentScore1.getId() + "'> "
				//+ studentScore1.getId() + "</a></p></td>");
				out.println("<td width=50><p align=center>" + studentScore1.getName() + "</p></td>"); //객체에서 이름 값 가져오기
				out.println("<td width=50><p align=center><a href='oneviewDB.jsp?key=" + studentScore1.getStudentId() +"'>" + studentScore1.getStudentId() +"</a></p></td>"); 
				//getString()메서드로 결과셋의 세번째 열의 값 가져옴
				out.println("<td width=50><p align=center>" + studentScore1.getKor() + "</p></td>"); //객체에서 국어점수 값 가져오기
				out.println("<td width=50><p align=center>" + studentScore1.getEng() + "</p></td>"); //객체에서 영어점수 값 가져오기
				out.println("<td width=50><p align=center>" + studentScore1.getMat() + "</p></td>"); //객체에서 수학점수 값 가져오기
				out.println("<td width=50><p align=center>" + studentScore1.getSum() + "</p></td>"); //객체에서 합계 값 가져오기
				out.println("<td width=50><p align=center>" + studentScore1.getAvg() + "</p></td>"); //객체에서 평균 값 가져오기
				out.println("<td width=50><p align=center>" + studentScore1.getRank() + "</p></td>"); //객체에서 순위 값 가져오기
				out.println("</tr>");
			} else { //학번이 다른 경우
				out.println("<tr>");
				//out.println("<td width=50><p align=center><a href='oneviewDB.jsp?key=" + studentScore1.getId() + "'> "
				//+ studentScore1.getId() + "</a></p></td>");
				out.println("<td width=50><p align=center>" + studentScore1.getName() + "</p></td>"); //객체에서 이름 값 가져오기
				out.println("<td width=50><p align=center><a href='oneviewDB.jsp?key=" + studentScore1.getStudentId() +"'>" + studentScore1.getStudentId() +"</a></p></td>"); 
				//getString()메서드로 결과셋의 세번째 열의 값 가져옴
				out.println("<td width=50><p align=center>" + studentScore1.getKor() + "</p></td>"); //객체에서 국어점수 값 가져오기
				out.println("<td width=50><p align=center>" + studentScore1.getEng() + "</p></td>"); //객체에서 영어점수 값 가져오기
				out.println("<td width=50><p align=center>" + studentScore1.getMat() + "</p></td>"); //객체에서 수학점수 값 가져오기
				out.println("<td width=50><p align=center>" + studentScore1.getSum() + "</p></td>"); //객체에서 합계 값 가져오기
				out.println("<td width=50><p align=center>" + studentScore1.getAvg() + "</p></td>"); //객체에서 평균 값 가져오기
				out.println("<td width=50><p align=center>" + studentScore1.getRank() + "</p></td>"); //객체에서 순위 값 가져오기
				out.println("</tr>");
			}
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




