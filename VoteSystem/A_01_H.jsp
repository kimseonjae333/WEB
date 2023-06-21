<%@page import="java.util.List"%>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.VoteSystemDao" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.VoteSystemDaoImpl" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.domain.VoteSystem" %>
<%@ page import="java.net.*" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page contentType="text/html; charset=utf-8"%>


<html>
<head>
<title>후보등록 A_01_H.jsp</title>
 <script>
        //후보 이름 넣는칸 에러 처리
        function checkForm1 () { //checkForm1 함수 생성
            const form = document.getElementById('form1'); //id값이 'form1'인 요소를 찾아 변수에 저장

            const userName = form.elements.name.value; //form 요소 내 name 속성을 가진 입력 필드의 값을 가져와 변수에 저장
            
            const pattern1 = /^([a-zA-Z]|[가-힣])[^ ]*$/; //한글,영어만 입력받는(공백 안받음) 정규식1 생성
            const pattern2 = /^.{1,20}$/; //20자 이내만 입력받는 정규식2 생성

            if ( !pattern1.test(userName) ) { //이름 칸에 한글, 영어 외의 값이 들어오면
                alert("한글, 영어만(공백 제외) 입력하세요"); //경고 문구 출력
            } else if (!pattern2.test(userName)) { //이름 칸에 20자 넘게 값이 들어오면
                alert("20자 이내로 입력하세요"); //경고 문구 출력
            }
            else { //위의 조건들을 타지 않을 경우 submit() 실행
                form.action='A_02_H.jsp'; //위 조건들을 모두 만족한다면 'A_02_H.jsp'실행
                form.submit(); //폼 데이터 서버로 전송
            }
        }
        
    </script>
	
</head>
<body>
	
	<table cellspacing=1 width=600 height=50 border=1> <!-- 카테고리 테이블 -->
		<tr>
			<td width=100 bgcolor='#FFFF00'><a href='A_01_H.jsp'>후보등록</a></td> <!-- 현재 선택한 테이블에 색깔 표시 -->
			<td width=100><a href='B_01_H.jsp'>투표</a></td>
			<td width=100><a href='C_01_H.jsp'>개표결과</a></td>
		</tr>
	</table>
	<br>
	
	<table cellspacing=1 width=600 border=1> <!-- 후보 등록 테이블 -->

	<h1> 후보등록</h1> <!-- 화면에 출력 -->
<%
		VoteSystemDao voteSystemDao = new VoteSystemDaoImpl(); //VoteSystemDaoImpl 객체 생성
		List<VoteSystem> list  = voteSystemDao.selectAll(); //VoteSystemDaoImpl의 selectAll() 함수 호출하여 리턴값 리스트 변수에 저장
		int NewKiho  = voteSystemDao.Calkiho(); //VoteSystemDaoImpl의 Calkiho() 함수 호출하여 리턴값 변수에 저장
		
		//데이터베이스에 저장된 데이터들 출력
		for (int i = 0; i < list.size(); i++) { //리스트 반복문 돌려서
			VoteSystem voteSystem = list.get(i); //리스트 변수에 저장된 데이터 한 행씩 가져와서 변수에 담기
				
				out.println("<tr>");
				out.println("<form method='post' action='A_03_H.jsp'>"); //삭제 버튼 누르면 A_03_H.jsp로 폼 데이터 전송
				out.println("<td>기호번호:<input type='text' name='id' value='" + voteSystem.getKiho() + "' style='width:50;' readonly>");
				//'id'로 이름 지정, voteSystem 객체에 저장된 해당 데이터 행의 기호 열 값 가져옴, readonly 처리
				out.println("후보명: <input type='text' name='name' value='" + voteSystem.getName() + "' readonly>");
				//'name'으로 이름 지정, voteSystem 객체에 저장된 해당 데이터 행의 이름 열 값 가져옴, readonly 처리
				out.println("<input type='submit' value='삭제' style='float: right; width:100;'></td>");
				//삭제 버튼 생성 -> 누르면 form 요소의 action 속성 실행, submit 표 오른쪽으로 붙이기
				out.println("</form>"); 
				out.println("</tr>");
		}
		//데이터 베이스에 없는, 새로운 데이터 추가하기
				out.println("<tr>");
				out.println("<form method='post' id='form1'>"); //'form1'이라는 id 부여
				out.println("<td>기호번호:<input type='text' name='id' value=" + NewKiho + " style='width:50;' readonly>");
				//'id'로 이름 지정, 학번은 Calkiho() 함수 리턴값으로 지정(자동계산된 값으로 부여), readonly 처리
				out.println("후보명: <input type='text' name='name' value=''>");
				//'name'으로 이름 지정, 값은 사용자가 직접 입력, readonly 처리
				out.println("<input type='button' value='추가' style='float: right; width:100;' onClick='checkForm1()'></td>");
				//타입 버튼으로 변경, onclick 속성 걸어서 script에 적은 함수 실행, 버튼 표 오른쪽으로 붙이기
				out.println("</form>");
				out.println("</tr>");
		
%>	
	</table>
</body>
</html>
