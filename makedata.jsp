<%@ page import="kr.ac.kopo.ctc.kopo39.domain.Inventory" %>
<%@ page import="java.sql.*, javax.sql.*, java.net.*, java.io.*" %> <!--list 받기 위해 임포트-->
<%@ page contentType="text/html; charset=utf-8" language="java" %> <!--utf-8 인코딩 처리-->

<html>
<head>
<title>Make table</title>
</head>
<body>

<%
	try{
	//JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
	// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
	// SQL문을 실행하기 위한 statement 객체 생성
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
	Statement stmt = conn.createStatement();

	stmt.execute("drop table inventory");
	out.println("drop table inventory OK<br>");

	stmt.execute("create table inventory("
			+ "id int not null primary key auto_increment,"
			+ "serialnum varchar(70),"
			+ "name varchar(70),"
			+ "stocknum int,"
			+ "regdate DATE,"
			+ "checkdate DATE,"
			+ "content text,"
			+ "photo text)"
			+ "DEFAULT CHARSET=utf8");
	out.println("create table inventory OK<br>");
	
	
	String sql="";
	sql= "insert into inventory(serialnum, name,stocknum,regdate,checkdate,content,photo)"
			+ "values ('211','재고1',3,'2022-01-03',date(now()),'재고입니당','사진입니당')"; 
	stmt.execute(sql);
	sql= "insert into inventory(serialnum,name,stocknum,regdate,checkdate,content,photo)"
			+ "values ('222','재고2',5,'2022-01-03',date(now()),'재고입니당','사진입니당')"; 
	stmt.execute(sql);
	sql= "insert into inventory(serialnum,name,stocknum,regdate,checkdate,content,photo)"
			+ "values ('233','재고3',6,'2022-01-03',date(now()),'재고입니당','사진입니당')"; 
	stmt.execute(sql);
	out.println("insert into inventory OK<br>");
	
	stmt.close();
	conn.close();
	
	} catch (Exception e) {
		out.println("drop table inventory NOT OK<br>");
		out.println(e.toString());
	}
	
%>
  
</body>
</html>