package kr.ac.kopo.ctc.kopo39.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kr.ac.kopo.ctc.kopo39.domain.Gongji;

public class GongjiDaoImpl implements GongjiDao {

	@Override
	public List<Gongji> selectAll(int page, int countPerPage) { //전체 데이터 보기(페이지네이션)
		List<Gongji> gongjis = new ArrayList<>(); //리스트 변수 정의
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();
			
			int start = (page - 1) * countPerPage; //page,countPerPage 인자값을 받아 해당 페이지의 첫번째 데이터 번호 계산
			ResultSet rset = stmt.executeQuery("select * from gongji order by id desc "
					+ "limit " + start + "," + countPerPage +";"); //공지 테이블의 전체 데이터 조회, 번호 역순으로 정렬, 페이지 네이션 범위 지정
		
			while (rset.next()) { //rset 반복문 돌리기
				Gongji gongji = new Gongji(); //gongji 객체 생성
				gongji.setId(rset.getInt(1)); //gongji 객체 id 변수에 값 저장
				gongji.setTitle(rset.getString(2)); //gongji 객체 title 변수에 값 저장
				gongji.setDate(rset.getDate(3)); //gongji 객체 date 변수에 값 저장
				gongjis.add(gongji); //해당 데이터 리스트 변수에 저장
			}
			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기
			rset.close(); //열었으면 객체 닫기
			
		} catch (Exception e) { //예외 처리
			e.printStackTrace();
			System.out.println(e);
		}
		return gongjis; //리스트 값 반환
	}

	
	
	@Override
	public Gongji selectOne(int id) { //데이터 하나만 보기
		Gongji gongji = null; //gongji 객체 정의 및 초기화
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();
			
			ResultSet rset = stmt.executeQuery("select * from gongji where id = " + id + ";");
			//공지 테이블의 전체 데이터 중 번호 값이 인자로 받은 번호 값과 같은 데이터만 조회
			
			while (rset.next()) { //rset돌려서
				gongji = new Gongji(); //gongji 객체 호출
				gongji.setId(rset.getInt(1)); //gongji 객체 id 변수에 값 저장
				gongji.setTitle(rset.getString(2)); //gongji 객체 title 변수에 값 저장
				gongji.setDate(rset.getDate(3)); //gongji 객체 date 변수에 값 저장
				gongji.setContent(rset.getString(4)); //gongji 객체 content 변수에 값 저장
			}
		
			rset.close(); //열었으면 객체 닫기
			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기
			
		} catch (Exception e) { //예외 처리
			e.printStackTrace();
			System.out.println(e);
		}
		return gongji; //리스트 값 반환
	}



	@Override
	public void insertData(Gongji gongji) { //데이터 입력
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();
			
			stmt.execute("insert into gongji (title, date, content) values ('" + gongji.getTitle()
			+ "', '" + gongji.getDate() + "', '" + gongji.getContent() + "')");
			//공지 테이블 제목,일자,내용 새 데이터 추가(id는 자동부여)
			

			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기
			
		} catch (Exception e) { //예외 처리
			e.printStackTrace();
		}
	}



	@Override
	public Gongji updateData(Gongji gongji) { //데이터 수정 업데이트
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();
			
			String sql = "update gongji set id =" + gongji.getId() + ", title = '"
	                + gongji.getTitle() + "', date = '" + gongji.getDate() + "', content = '"
	                + gongji.getContent() + "' where id = " + gongji.getId();
			//인자로 받은 객체와 아이디 값이 같은 레코드 id, 제목, 일자, 내용 수정 데이터 업데이트(id는 기존 번호 유지)

			stmt.executeUpdate(sql); //sql문 실행
			
			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기
			
		} catch (Exception e) { //예외 처리
			e.printStackTrace();
			System.out.println(e); //예외 발생시 에러 매세지 출력
		}
		return gongji; //객체 반환
	}


	@Override
	public void deleteData(int id) { //데이터 삭제
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();
			
			stmt.executeUpdate("delete from gongji where id = " + id + ";");
			//인자로 받은 아이디가 같은 아이디를 가진 레코드 행 삭제
			
			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기
			
		} catch (Exception e) { //예외 처리
			e.printStackTrace();
		}
	
	}



	@Override
	public int count() { //전체 레코드 수 카운트
		int count = 0; //카운트 변수 선언 및 초기화
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();

			ResultSet rset = stmt.executeQuery("select count(*) from gongji;");
			//테이블의 전체 레코드 개수 구하기
			while (rset.next()) { //rset 돌려서
				count = rset.getInt(1); //전체 레코드 수 변수에 저장
			}
			rset.close(); //열었으면 객체 닫기
			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기

		} catch (Exception e) { //예외처리
			e.printStackTrace();
			return -1; //예외 발생시 -1값 반환
		}
		return count; //count 값 반환
	}
	
	
	
}
