<%@ page import="kr.ac.kopo.ctc.kopo39.dao.StudentScoreDao"%>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.StudentScoreDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo39.domain.StudentScore"%>
<%@ page import="java.net.*" %>
<!--한글이 post/get의 파라미터로 연동될때는 별도 처리 필요(java.net.* 임포트)-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<!--html과 jsp에서 한글처리 지시-->


<html>
<head>

    <script> 
	    function submitForm(mode){ //submitForm이라는 이름의 함수 생성, mode를 인자로 받음
	        if(mode == "update") { //mode가 update 일때
	            myform.action = "updateDB.jsp"; //myform의 폼 데이터가 전송될 대상 URL 지정
	            myform.submit(); //submit(): JavaScript에서 HTML 폼을 제출하는 메서드, 메서드를 호출하면 폼 데이터가 서버로 전송
	        } else if(mode == "delete") { //mode가 delete 일때
	            myform.action = "deleteDB.jsp"; //myform의 폼 데이터가 전송될 대상 URL 지정
	            myform.submit(); //submit(): JavaScript에서 HTML 폼을 제출하는 메서드, 메서드를 호출하면 폼 데이터가 서버로 전송
	        }
	    }    
    
        function checkForm2 () {
            const form = document.getElementById('myform'); //id값이 'form1'인 요소를 찾아 변수에 저장

            const userName = form.elements.name.value; //form 요소 내 name 속성을 가진 입력 필드의 값을 가져와 변수에 저장
            const kor = parseFloat(form.elements.korean.value); //form 요소 내 name 속성을 가진 입력 필드의 값을 가져와 변수에 저장 + parseFloat() 함수를 사용하여 실수로 변환
            const eng = parseFloat(form.elements.english.value); //form 요소 내 name 속성을 가진 입력 필드의 값을 가져와 변수에 저장 + parseFloat() 함수를 사용하여 실수로 변환
            const mat = parseFloat(form.elements.mathmatic.value); //form 요소 내 name 속성을 가진 입력 필드의 값을 가져와 변수에 저장 + parseFloat() 함수를 사용하여 실수로 변환   

            const pattern1 = /^([a-zA-Z]|[가-힣])+$/; //한글,영어만 입력받는 정규식1 생성
            const pattern2 = /^.{1,20}$/; //20자 이내만 입력받는 정규식2 생성
            const pattern3 = /^(?:100|[1-9]?[0-9])$/; //0~100사이의 정수값만 입력받는 정규식3 생성

            if ( !pattern1.test(userName) ) { //이름 칸에 한글, 영어 외의 값이 들어오면
                alert("한글, 영어만(공백제외) 입력하세요"); //경고 문구 출력
            } else if (!pattern2.test(userName)) { //이름 칸에 20자 넘게 값이 들어오면
                alert("20자 이내로 입력하세요"); //경고 문구 출력
            }
             else if (!pattern3.test(kor) || !pattern3.test(eng) || !pattern3.test(mat)) { //점수칸에 0부터 100 외의 숫자가 들어오면
                alert("각 과목의 점수는 0부터 100사이의 숫자입니다."); //경고 문구 출력
            }
            else { /* 위의 두 조건이 아닐 경우 submit() 실행 */ 
                form.action='updateDB.jsp'; /* 이름과 점수 란에 대하여 실행이 되는 조건이라면 'insertDB.jsp'실행*/ 
                form.submit(); /* DB로 넘김 */ 
            }
        }
           
    </script>
    
<title>showREC.jsp</title>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8"); //UTF-8 인코딩 설정(넘어오는건 무조건 string)
	String Tmp =request.getParameter("searchid"); //파라미터 값 받기
	int iTmp = 0; //형변환 한 값 담을 변수 선언
		if(Tmp == null || Tmp.isEmpty()) { //파라미터 값이 null이면
%>		
	<script>
		alert("조회할 학번을 입력하세요"); //경고메세지 출력
	</script>
<%
		} else {
			iTmp = Integer.parseInt(Tmp); //null이 아니면 파라미터값 형변환하여 변수에 저장
		}
    
     StudentScore studentScore = new StudentScore(); //StudentScore 객체 생성하여 변수에 저장
     studentScore.setStudentId(iTmp); //StudentScore 객체의 학번에 변수값 저장
     StudentScoreDao studentScoreDao = new StudentScoreDaoImpl(); //StudentScoreDaoImpl 객체 생성
     StudentScore studentScoreInfo = studentScoreDao.findInfo(studentScore); //StudentScoreDaoImpl의 findInfo() 함수 호출하여 리턴값 변수에 저장
%>

<h1>성적 조회후 정정 / 삭제</h1>
    <form method='post' action='showREC.jsp'>
    <!--method = "post" -> 폼 데이터가 HTTP 요청의 본문(body)에 포함되어 서버로 전송 
    ,사용자가 폼을 제출하면 데이터가 브라우저의 주소 표시줄에 노출되지 않음, 보안성 더 높음-->
    <!--action -> 폼 데이터가 전송될 대상 URL을 지정-->
    <!--여기서는 폼 데이터를 다시 자기 자신에게 보내야함/수정,삭제.jsp랑 연결되어야 함-->
       <table callspacing=1 width=400 border=0> <!--테이블1 만들기-->
        <tr>
            <td width=300><p align=center>조회할 학번</p></td> 
            <td width=100><p align=center><input type="text" name="searchid" value=""></p></td>
             <!--input 타입 text, name 속성으로 이름 지정, 값은 사용자가 직접 입력-->
            <td width=100><input type="submit" value="조회"></td>
            <!--input 타입 submit으로 설정-->
        </tr>
        </table>
    </form>

    <form method='post' id='myform'> <!--form id 부여-->   
        <table callspacing=1 width=400 border=1> <!--테이블2 만들기-->   
  
 <%		
 	 String name = studentScoreInfo.getName(); //studentScoreInfo 객체의 이름 값 가져와서 변수에 저장
 	 String studentid = Integer.toString(studentScoreInfo.getStudentId()); //studentScoreInfo 객체의 학번 값 가져와서 변수에 저장
	 String kor = Integer.toString(studentScoreInfo.getKor()); //studentScoreInfo 객체의 국어점수 값 가져와서 변수에 저장
 	 String eng = Integer.toString(studentScoreInfo.getEng()); //studentScoreInfo 객체의 영어점수 값 가져와서 변수에 저장
	 String mat = Integer.toString(studentScoreInfo.getMat()); //studentScoreInfo 객체의 수학점수 값 가져와서 변수에 저장
	 
        if(studentScoreInfo.getName() == null) { //이름 값이 null이면
        	name = "해당학번없음"; //name 변수 재설정
        	//아래 테이블 출력
 %>       	
			<!-- 입력칸 readonly로 막기 -->
        	<tr>
            	<td width=100><p align=center>이름</p></td>
        		<td width=300><p align=center><input type="text" name="name" value="<%=name%>" readonly></p></td>
            </tr>
            <tr>
                <td width=100><p align=center>학번</p></td> 
                <td width=300><p align=center><input type="text" name="studentid" value="<%=studentid%>" readonly></p></td>
            </tr>
            <tr>
                <td width=100><p align=center>국어</p></td>
                <td width=300><p align=center><input type="text" name="korean" value="" readonly></p></td>
            </tr>
            <tr>
                <td width=100><p align=center>영어</p></td>
                <td width=300><p align=center><input type="text" name="english" value="" readonly></p></td>
            </tr>
            <tr>
                <td width=100><p align=center>수학</p></td>
                <td width=300><p align=center><input type="text" name="mathmatic" value="" readonly></p></td>
            </tr>
           
 <%
        }
        else { //이름 값이 있으면
        	//아래 테이블 출력   	
 %>		
 		<tr>
        	<td width=100><p align=center>이름</p></td>
    		<td width=300><p align=center><input type="text" name="name" value="<%=name%>"></p></td>         
        </tr>
        <tr>
            <td width=100><p align=center>학번</p></td> 
            <td width=300><p align=center><input type="text" name="studentid" value="<%=studentid%>" readonly></p></td>
        <tr>
            <td width=100><p align=center>국어</p></td>
            <td width=300><p align=center><input type="text" name="korean" value="<%=kor%>"></p></td>
        </tr>
        <tr>
            <td width=100><p align=center>영어</p></td> 
            <td width=300><p align=center><input type="text" name="english" value="<%=eng%>"></p></td>
        </tr>
        <tr>
            <td width=100><p align=center>수학</p></td>
            <td width=300><p align=center><input type="text" name="mathmatic" value="<%=mat%>"></p></td>
        </tr>
      
<%
        }
	 
%>
  </table>
  
<%
        if(name != "해당학번없음" && iTmp!=0){ //학번이 0이 아니고 name이 해당학번없음 값이 아닐때만
            out.println("<table callspacing=1 width=400 border=0>"); //테이블 생성
            out.println("<tr>"); //행 열기
            out.println("<td width=200></td>"); //1열 공백처리
            out.println("<td width=100><p align=center><input type= button value=\"수정\" onClick=\"checkForm2()\"></p></td>");
            //button 생성,OnClick=\"submitForm('delete')\"-> 버튼이 클릭되었을 때 submitForm 함수를 호출하는 이벤트 핸들러를 지정
            out.println("<td width=100><p align=center><input type= button value=\"삭제\" OnClick=\"submitForm('delete')\"></p></td>");
            //button 생성,OnClick=\"submitForm('delete')\"-> 버튼이 클릭되었을 때 submitForm 함수를 호출하는 이벤트 핸들러를 지정
            out.println("</tr>");
            out.println("</table>"); 
        }
%>
    </form>
</body>
</html>


		
	
