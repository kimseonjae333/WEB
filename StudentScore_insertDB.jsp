<%@ page import="kr.ac.kopo.ctc.kopo39.dao.StudentScoreDao"%>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.StudentScoreDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo39.domain.StudentScore"%>
<%@page import="java.util.List"%>
<%@ page import="java.net.*" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<!--html과 jsp에서 한글처리 지시-->


<html>
<head>
<title>insertDB</title>
</head>
<body>

<%
	//파라미터로 값 받아서 변수에 저장
	//UTF-8 인코딩 설정(넘어오는건 무조건 string)
	request.setCharacterEncoding("UTF-8"); 
    String cTmp = request.getParameter("name"); 
    int korean = 0;
    int english = 0;
    int mathmatic = 0;
    
   	//에러처리추가
    try{
    	String Skorean = request.getParameter("korean"); //파라미터 값 형변환
    	String Senglish = request.getParameter("english"); //파라미터 값 형변환
    	String Smathmatic = request.getParameter("mathmatic"); //파라미터 값 형변환
    	
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
    	    // 숫자 부분만 추출하여 변환한 후, 변환된 값을 사용하거나 다른 처리를 수행 가능
   	}


    StudentScore studentScore = new StudentScore(); //StudentScore 객체 생성하여 변수에 저장
	studentScore.setName(cTmp); //set으로 객체에 값 저장
	studentScore.setKor(korean); //set으로 객체에 값 저장
	studentScore.setEng(english); //set으로 객체에 값 저장
	studentScore.setMat(mathmatic); //set으로 객체에 값 저장
	StudentScoreDao studentScoreDao = new StudentScoreDaoImpl(); //selectOne 함수 불러오기위해 StudentScoreDaoImpl 객체 생성
	StudentScore studentScoreInsert = studentScoreDao.create(studentScore); //StudentScoreDaoImpl의 create() 함수 실행하여 변수에 값 저장

	if(studentScoreInsert == null) { //만약 create() 함수의 리턴값이 0이면
		out.println("데이터를 입력할 테이블이 없습니다. 테이블을 생성하세요"); //경고 문구 출력
	} else { //아니면 아래 처리
%>


<h1>성적입력추가완료</h1> <!--화면에 출력-->
    <form method='post' action='inputForm1.html'>
    <!--method = "post" -> 폼 데이터가 HTTP 요청의 본문(body)에 포함되어 서버로 전송 
    ,사용자가 폼을 제출하면 데이터가 브라우저의 주소 표시줄에 노출되지 않음, 보안성 더 높음-->
    <!--action -> 폼 데이터가 전송될 대상 URL을 지정--> 
        <table cellspacing=1 width=400 border=0> <!--테이블1 만들기-->
        <tr>
            <td width=300></td> <!--공백 처리-->
            <td width=100><input type="submit" value="뒤로가기"></td>
            <!--input 타입 submit으로 설정-->
        </table>

        <table cellspacing=1 width=400 border=1> <!--테이블2 만들기-->
            <tr>
                <td style="width: 100px;"><p align="center">이름</p></td> <!--1열-->
                <td style="width: 300px;"><p align="center"><input type="text" name="name" value="<%=cTmp%>" readonly></p></td>
                <!--input 타입 text, name 속성으로 이름 지정, 값은 사용자가 직접 입력-->
                <!--readonly: <input> 태그의 속성 중 하나, readonly 속성을 지정하면 입력란은 읽기 전용됨(사용자가 입력란 수정 불가)-->
            </tr>
            <tr>
                <td style="width: 100px;"><p align="center">학번</p></td> <!--1열-->
                <td style="width: 300px;"><p align="center"><input type="text" name="studentid" value="<%=studentScoreInsert.getStudentId()%>" readonly></p></td>
                <!--input 타입 text, name 속성으로 이름 지정, 문자열로 변환한 학번을 값으로 지정-->
            </tr>
            <tr>
                <td style="width: 100px;"><p align="center">국어</p></td> <!--1열-->
                <td style="width: 300px;"><p align="center"><input type="text" name="korean" value="<%=korean%>" readonly></p></td>
                <!--input 타입 text, name 속성으로 이름 지정, 값은 파라미터로 받은 값으로 지정-->
            </tr>
            <tr>
                <td style="width: 100px;"><p align="center">영어</p></td> <!--1열-->
                <td style="width: 300px;"><p align="center"><input type="text" name="english" value="<%=english%>" readonly></p></td>
                <!--input 타입 text, name 속성으로 이름 지정, 값은 파라미터로 받은 값으로 지정-->
            </tr>
            <tr>
                <td style="width: 100px;"><p align="center">수학</p></td> <!--1열-->
                <td style="width: 300px;"><p align="center"><input type="text" name="mathmatic" value="<%=mathmatic%>" readonly></p></td>
                <!--input 타입 text, name 속성으로 이름 지정, 값은 파라미터로 받은 값으로 지정-->
            </tr>
        </table>
    </form>
    
<%
	}
%>
</body>
</html>


		
	
