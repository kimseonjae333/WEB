package kr.ac.kopo.ctc.kopo39.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kr.ac.kopo.ctc.kopo39.domain.StudentScore;
import kr.ac.kopo.ctc.kopo39.dao.StudentScoreDaoImpl;

public class StudentScoreDaoImpl implements StudentScoreDao {
	// 테이블은 별도로 만들고 CRUD만 Test 돌리기
	// 파일을 읽고 계산하는 로직 구현(파일 경로 및 파일 읽기 관련 코드 필요)

	@Override
	public StudentScore create(StudentScore studentScore) { //데이터 추가(insert one)
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			Statement stmt = conn.createStatement();
			// SQL문을 실행하기 위한 statement 객체 생성
			
			
			int NewStdId = 209901; //NewStdId 변수 선언
			int CurrentStdId = 0; //현재 학번 변수
		
			ResultSet rset = stmt.executeQuery("select studentId from scoretable order by studentId;"); //테이블에서 학번 가져오기
			
			while (rset.next()) { //rset 돌려서 
				CurrentStdId = rset.getInt(1); //현재 학번에 데이터에서 가져온 학번이 넣기
				if(NewStdId < CurrentStdId) { //NewStdId 변수값과 현재 학번 비교해서 현재 학번이 더 크면
					break; //반복문 탈출
					//중간에 빠진 번호 있으면 최종 학번은 중간번호로 부여
					//중간에 빠진 번호 없으면 최종 학번은 마지막 번호 +1
				}
				NewStdId = CurrentStdId + 1; //현재학번에 +1해서 NewStdId에 값 저장
			}
			rset.close(); //열었으면 객체 닫기

			studentScore.setStudentId(NewStdId); //set으로 학번 값에 NewStdId 저장
		 
			String sql = "insert into scoretable (name, studentId, kor, eng, mat) values ('"
						+ studentScore.getName() + "', " + studentScore.getStudentId() 
		                + ", " + studentScore.getKor() + ", " + studentScore.getEng() + ", " + studentScore.getMat() + ")";
			//테이블에 새로운 값 넣기
		    stmt.execute(sql); //sql문 실행

			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기
		} catch (Exception e) { //예외 처리
			e.printStackTrace();
			return null; //예외 발생시 null 값 리턴
		}
		return studentScore; //리턴값 studentScore 객체
	}

	
	
	@Override
	public StudentScore selectOne(int id) { //select one
		StudentScore studentScore = null; //StudentScore 객체 선언 및 초기화
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();
			
			ResultSet rset = stmt.executeQuery("select *, b.kor + b.eng + b.mat, (b.kor + b.eng + b.mat) / 3, "
					+ "(select count(*) + 1 from scoretable as a where (a.kor + a.eng + a.mat) > (b.kor + b.eng + b.mat)) from scoretable as b "
					+ "where studentId = " + id + ";");
			//학번과 인자로 받은 학번 값이 같으면 전체 데이터와 데이터를 바탕으로 계산한 합계, 평균, 순위 데이터 전체 출력
			
			if (rset.next()) { //rset돌려서
				studentScore = new StudentScore(); //StudentScore 객체 호출
				studentScore.setId(rset.getInt(1)); //rset에서 1열의 값을 가져와 set으로 저장
				studentScore.setName(rset.getString(2)); //rset에서 2열의 값을 가져와 set으로 저장
				studentScore.setStudentId(rset.getInt(3)); //rset에서 3열의 값을 가져와 set으로 저장
				studentScore.setKor(rset.getInt(4)); //rset에서 4열의 값을 가져와 set으로 저장
				studentScore.setEng(rset.getInt(5)); //rset에서 5열의 값을 가져와 set으로 저장
				studentScore.setMat(rset.getInt(6)); //rset에서 6열의 값을 가져와 set으로 저장
				studentScore.setSum(rset.getInt(7)); //rset에서 7열의 값을 가져와 set으로 저장
				studentScore.setAvg(rset.getInt(8)); //rset에서 8열의 값을 가져와 set으로 저장
				studentScore.setRank(rset.getInt(9)); //rset에서 9열의 값을 가져와 set으로 저장
			}
		
			rset.close(); //열었으면 객체 닫기
			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기
			
		} catch (Exception e) { //예외처리
			e.printStackTrace();
			return null; //예외 발생시 리턴값 null
		}
		return studentScore; //리턴값 studentScore 객체
	}
	
	
	
	@Override
	public List<StudentScore> selectAll(int page, int countPerPage) { //select all
		List<StudentScore> studentScores = new ArrayList<>(); //리스트 변수 선언
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();
			
			
			int start = (page - 1) * countPerPage; //page,countPerPage 인자값을 받아 해당 페이지의 첫번째 데이터 번호 계산
			ResultSet rset = stmt.executeQuery("select *, b.kor + b.eng + b.mat, (b.kor + b.eng + b.mat) / 3,"
					+ "(select count(*) + 1 from scoretable as a where (a.kor + a.eng + a.mat) > (b.kor + b.eng + b.mat)) from scoretable as b "
					+ "ORDER BY b.studentId ASC "
					+ "limit " + start + "," + countPerPage +";");
			//전체 데이터와 데이터를 바탕으로 계산한 합계, 평균, 순위 데이터 전체 출력, 학번순으로 출력하고 start 변수값부터 countPerPage 값만큼 데이터 출력
			
			while (rset.next()) { //rset 돌려서
				StudentScore studentScore = new StudentScore(); //studentScore 객체 생성
				studentScore.setId(rset.getInt(1)); //rset에서 1열의 값을 가져와 set으로 저장
				studentScore.setName(rset.getString(2)); //rset에서 2열의 값을 가져와 set으로 저장
				studentScore.setStudentId(rset.getInt(3)); //rset에서 3열의 값을 가져와 set으로 저장
				studentScore.setKor(rset.getInt(4)); //rset에서 4열의 값을 가져와 set으로 저장
				studentScore.setEng(rset.getInt(5)); //rset에서 5열의 값을 가져와 set으로 저장
				studentScore.setMat(rset.getInt(6)); //rset에서 6열의 값을 가져와 set으로 저장
				studentScore.setSum(rset.getInt(7)); //rset에서 7열의 값을 가져와 set으로 저장
				studentScore.setAvg(rset.getInt(8)); //rset에서 8열의 값을 가져와 set으로 저장
				studentScore.setRank(rset.getInt(9)); //rset에서 9열의 값을 가져와 set으로 저장
				studentScores.add(studentScore); //리스트 객체에 값 추가
			}
		
			rset.close(); //열었으면 객체 닫기
			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기
			
		} catch (Exception e) { //예외 처리
			e.printStackTrace();
			return null; //예외 발생시 null값 반환
		}
		return studentScores; //studentScores 리스트 객체 반환
	}


	@Override
	public StudentScore update(int id, StudentScore studentScore) { //조회 후 정정/삭제 update
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();

			String sql = "update scoretable set name = '" + studentScore.getName() + "', studentId = "
		                + studentScore.getStudentId() + ", kor = " + studentScore.getKor() + ", eng = "
		                + studentScore.getEng() + ", mat = " + studentScore.getMat() + " where studentId = " + id;
			//데이터의 학번과 인자로 받은 학번값이 같으면 (파라미터로 값을 받아 객체에 저장했던) 인자 객체의 데이터 값을 가져와서 데이터 업데이트

		    stmt.executeUpdate(sql); //sql문 실행
					
			
			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기

		} catch (Exception e) { //예외처리
			e.printStackTrace();
			return null; //예외 발생시 null값 반환
		}
		return studentScore; //studentScores 객체 반환
	}

	
	
	@Override
	public StudentScore deleteByStuentId(int id) { //조회 후 정정/삭제 delete
		StudentScore studentScore = null; //StudentScore 객체 선언 및 초기화
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();

		    String sql = "delete from scoretable where studentId = " + id; //데이터의 학번과 인자로 받은 학번 값이 같으면 해당 데이터 삭제
		    stmt.executeUpdate(sql); //sql문 실행
			
			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기

		} catch (Exception e) { //예외처리
			e.printStackTrace();
			return null; //예외 발생시 null값 반환
		}
		return studentScore; //studentScores 객체 반환
	}

	
	
	@Override
	public int count() { //토탈 카운트 계산
		int count = 0; //카운트 변수 선언 및 초기화
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();

			ResultSet rset = stmt.executeQuery("select count(*) from scoretable;");
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



	@Override
	public String maketable() { //create table
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();
			
			String sql = "create table scoretable ("
			        + "id int not null AUTO_INCREMENT primary key,"
			        + "name varchar(20),"
			        + "studentId int unique,"
			        + "kor int,"
			        + "eng int,"
			        + "mat int"
			        + ")";
			//테이블 생성 쿼리문 작성
			stmt.execute(sql); //쿼리문 실행

			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기
		
		} catch (Exception e) { //예외처리
			e.printStackTrace();
			return e.toString(); //예외 발생시 화면에 메세지 출력
		}
		return "SUCCESS CREATE TABLE" ; //문자열 리턴값 화면에 띄우기
	}



	@Override
	public String inserttable() { //insert all
		StudentScore studentScore = null; //StudentScore 객체 선언 및 초기화
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();
			
			int cnt = 0; //카운트 변수 선언
			while(cnt < 135) { //135개까지만 데이터 입력
				cnt = cnt+1; //카운트 1씩 증가
				studentScore = new StudentScore(); //StudentScore 객체 호출
			    studentScore.setName("홍길" + cnt); //이름 설정
			    studentScore.setStudentId(209900 + cnt); //학번 설정
 			    studentScore.setKor((int) (Math.random() * 100)); //국어점수 랜덤값 부여
			    studentScore.setEng((int) (Math.random() * 100)); //영어점수 랜덤값 부여
			    studentScore.setMat((int) (Math.random() * 100)); //수학점수 랜덤값 부여
			    
			    String sql = "insert into scoretable( name, studentId, kor, eng, mat) values ('"
			            + studentScore.getName() + "', " 
			            + studentScore.getStudentId() + ", "
			            + studentScore.getKor() + ", " 
			            + studentScore.getEng() + ", " 
			            + studentScore.getMat() + ")";
			    //테이블에 데이터 값 넣기
			    
				stmt.execute(sql); //쿼리문 실행
			}
			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기
					
		} catch (Exception e) { //예외처리
			e.printStackTrace();
			return e.toString(); //예외 발생시 화면에 메세지 출력
		}
		return "SUCCESS INSERT TABLE"; //문자열 리턴값 화면에 띄우기
	}



	@Override
	public String droptable() { //drop table
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();
			
			String sql = "drop table scoretable;"; //테이블 삭제 쿼리문 작성
			stmt.execute(sql); //쿼리문 실행
 
			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기
		
		} catch (Exception e) { //예외처리
			e.printStackTrace();
			return e.toString(); //예외 발생시 화면에 메세지 출력
		}
		return "SUCCESS DROP TABLE" ; //문자열 리턴값 화면에 띄우기
	}



	@Override
	public StudentScore findInfo(StudentScore studentScore) {  //학번으로 해당 데이터 구하기
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();
			
			ResultSet rset = stmt.executeQuery("select * from scoretable"); //전체 데이터 조회
			
			while (rset.next()) { //rset 돌려서
				if(rset.getInt(3) == studentScore.getStudentId()) { //데이터의 학번과 인자로 받은 객체의 학번 값이 같으면
					studentScore.setName(rset.getString(2)); //인자로 받은 객체에 해당 학번의 이름 데이터 저장
					studentScore.setStudentId(rset.getInt(3)); //인자로 받은 객체에 해당 학번의 학번 데이터 저장
					studentScore.setKor(rset.getInt(4)); //인자로 받은 객체에 해당 학번의 국어점수 데이터 저장
					studentScore.setEng(rset.getInt(5)); //인자로 받은 객체에 해당 학번의 영어점수 데이터 저장
					studentScore.setMat(rset.getInt(6)); //인자로 받은 객체에 해당 학번의 수학점수 데이터 저장
					studentScore.setSum(rset.getInt(7)); //인자로 받은 객체에 해당 학번의 합계 데이터 저장
					studentScore.setAvg(rset.getInt(8)); //인자로 받은 객체에 해당 학번의 평균 데이터 저장
					studentScore.setRank(rset.getInt(9)); //인자로 받은 객체에 해당 학번의 순위 데이터 저장
					break; //데이터 저장되면 반복문 탈출
				}
			}
			
			rset.close(); //열었으면 객체 닫기
			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기
			
		} catch (Exception e) { //예외 처리
			e.printStackTrace();
			System.out.println(e);
		}
		return studentScore; //studentScore 객체 값 리턴
	}
	

	   @Override
	   public int getCurrentPage(int id, int countPerpage) { //해당 학번 포함된 현재 페이지 구하기
	      int cnt = 0; //cnt 변수 선언
	      int c = 0; //c 변수 선언
	      try {
	    	 // JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			 // getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			 // SQL문을 실행하기 위한 statement 객체 생성
	         Class.forName("com.mysql.cj.jdbc.Driver"); 
	         Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
	         Statement stmt = conn.createStatement(); 

	         ResultSet rset = stmt.executeQuery("select * from scoretable order by studentId;");
	         //학번으로 정렬하여 전체 데이터 조회
	         
	         while (rset.next()) { //rset 반복문 돌려서
		            int sId = rset.getInt(3); //rset의 학번 값 변수에 저장
		            cnt++; //cnt 1씩 증가
		            if (id == sId){ //인자로 받은 값과 학번 값이 같다면
		            break; //반복문 탈출
		            }
		         }

	         conn.close(); //열었으면 객체 닫기
	         stmt.close(); //열었으면 객체 닫기
	         rset.close(); //열었으면 객체 닫기
	         
	         c = cnt%countPerpage == 0 ? cnt/countPerpage : (cnt/countPerpage) +1; //조건식 ? true : false
	         //삼항 연산자, 조건 -> cnt%countPerpage의 값이 0, true면 cnt/countPerpage 값 변수에 저장, false면 (cnt/countPerpage) +1 값 변수에 저장
	      } catch (Exception e) { //에러 처리
	         // e.printStackTrace();
	         System.out.println(e); //에러 메세지 출력
	      }
	      return c; //c값 리턴
	   }
	   
}
