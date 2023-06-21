<%@ page import="kr.ac.kopo.ctc.kopo39.domain.Gongji" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.GongjiDao" %>
<%@ page import="kr.ac.kopo.ctc.kopo39.dao.GongjiDaoImpl" %>
<%@ page contentType="text/html; charset=utf-8" %> 
<!--utf-8 인코딩 처리-->

<html>
<head>

	<script language="JavaScript">
	
        function checkForm() {
        	const form = document.getElementById('form1'); //id값이 'form1'인 요소를 찾아 변수에 저장
        	
			const Title = form.elements.title.value; //form 요소 내 name 속성을 가진 입력 필드의 값을 가져와 변수에 저장
			const Content = form.elements.content.value;
           
            const pattern1 = /^.{1,30}$/; //30자 이내만 입력받는 정규식2 생성
            const pattern2 = /^.{1,1000}$/; //1000자 이내만 입력받는 정규식2 생성
			
            if (Title.trim().length === 0 && Content.trim().length === 0) { //이름 칸에 20자 넘게 값이 들어오면
                alert("내용을 입력하세요"); //경고 문구 출력
            } else if (Title.trim().length === 0) { //이름 칸에 20자 넘게 값이 들어오면
                alert("제목을 입력하세요"); //경고 문구 출력
            } else if (!pattern1.test(Title)) { //이름 칸에 20자 넘게 값이 들어오면
                alert("제목은 30자 이내로 가능합니다"); //경고 문구 출력
            } else if (Content.trim().length === 0) { //이름 칸에 20자 넘게 값이 들어오면
                alert("본문을 입력하세요"); //경고 문구 출력
            } else if (!pattern2.test(Content)) { //이름 칸에 20자 넘게 값이 들어오면
                alert("본문은 1000자 이내로 가능합니다"); //경고 문구 출력
            } else { /* 위의 두 조건이 아닐 경우 submit() 실행 */ 
                form.action='gongji_write.jsp?title=' + form.elements.title.value 
                		+'&date=' + form.elements.date.value
                		+'&content=' + form.elements.content.value; //이름과 점수 란에 대하여 실행이 되는 조건이라면 'insertDB.jsp'실행
                form.submit(); /* DB로 넘김 */ 
            }
        }
    
	</script>
	
<title>gongji_insert.jsp</title>
</head>
<body>
	<!-- 카테고리 테이블 -->
 	<table cellspacing=1 width=700 height=50 border=1>
		<tr>
			<td width=100><p align=center><a href='gongji_list.jsp'>공지사항 리스트</a></p></td>
			<td width=100 bgcolor='#FFFF00'><p align=center><a href='gongji_insert.jsp'>새 글 입력</a></p></td>
			<td width=100><p align=center><a href='gongji_view.jsp'>글 보기</a></p></td>
			<td width=100><p align=center><a href='gongji_UnD.jsp'>글 수정/삭제</a></p></td>
		</tr>
	</table>
	<br>

<form method="post" id="form1">
	<table cellspacing=0 cellpadding=5 width=700 border=1>
		<tr>
			<td><p align=center><b>번호</b></p></td>
			<td><input type=text name=id value="자동생성" style='border:0;' readonly></td>
		</tr>
		<tr>
			<td><p align=center><b>제목</b></p></td>
			<td><input type=text name=title value='' size=70 maxlength=70></td>
		</tr>
		<tr>
			<td><p align=center><b>일자</b></p></td>
			 <% java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
			<td><input type=text name=date value="<%= dateFormat.format(new java.util.Date()) %>" size=20 style='border:0;' readonly></td>
		</tr>
		<tr>
			<td><p align=center><b>내용</b></p></td>
			<td><textarea name=content cols=70 rows=10 style="width: 530px; height: 250px;"></textarea></td>
			<!-- cols: textarea에 80개의 문자열이 표시되도록 지정, rows: n개의 행이 표시되도록 지정 -->
		</tr>
	</table>
	<br>
	
	<table width=700>
		<tr>
			<td width=600></td>
			<td><input type=button value="취소" onClick="location.href='gongji_list.jsp'"></td>
			<td><input type=button value="쓰기" onClick="checkForm()"></td>
		</tr>
	</table>
</form>
</body>
</html>
