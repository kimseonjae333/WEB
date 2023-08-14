package kr.ac.kopo.ctc.kopo39.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kr.ac.kopo.ctc.kopo39.domain.VoteSystem;

public class VoteSystemDaoImpl implements VoteSystemDao {

	@Override
	public void insertHubo(String name) { //후보 데이터 추가
		int newKiho = 1; //새 학번 변수 정의
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();
		
			ResultSet rset = stmt.executeQuery("select kiho from hubo order by kiho asc"); //후보 테이블의 기호 정렬하여 기호 값 가져오기
			while(rset.next()) { //rset 반복문 돌려서
				int currentKiho = rset.getInt("kiho"); //현재 기호 변수 선언하고 rset의 기호 값 저장
				if(newKiho < currentKiho) { //currentKiho도 1부터 시작, 조건 같으면
					break; //반복문 탈출
				}
				newKiho = currentKiho+1; //현재 기호에 +1 하여 새 학번에 저장 -> 새 기호는 마지막 번호+1
			}
			stmt.execute("insert into hubo (kiho, name) values (" + newKiho + ", '" + name + "')"); //데이터 베이스에 새 기호 번호와 인자로 받은 이름 값 추가
			
			rset.close(); //열었으면 객체 닫기
			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기
			
		} catch (Exception e) {
			e.printStackTrace();

		}
	}

	
	
	@Override
	public int Calkiho() { //중간번호 구하는 함수
		int newKiho = 1; //새 학번 변수 정의
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();
		
			ResultSet rset = stmt.executeQuery("select kiho from hubo order by kiho asc"); //후보 테이블의 기호 정렬하여 기호 값 가져오기
			while(rset.next()) { //rset 반복문 돌려서
				int currentKiho = rset.getInt("kiho"); //현재 기호 변수 선언하고 rset의 기호 값 저장
				if(newKiho < currentKiho) { //currentKiho도 1부터 시작, 조건 같으면
					break; //반복문 탈출
				}
				newKiho = currentKiho+1; //현재 기호에 +1 하여 새 학번에 저장 -> 새 기호는 마지막 번호+1
			}
			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기
			rset.close(); //열었으면 객체 닫기
			
		} catch (Exception e) { //예외 처리
			e.printStackTrace(); 
			return -1; //예외 발생시 -1 리턴
		}
		return newKiho; //새 기호 값 리턴
	}

	@Override
	public void insertTupyo(int id, int age) { //투표 테이블에 값 넣기
		int inputkiho = 0; //변수 정의 및 초기화
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();
			
			ResultSet rset = stmt.executeQuery("select kiho from hubo where kiho =" + id + ";");
			//후보 테이블의 기호와 인자로 받은 기호(id) 값이 같으면 해당 기호 값 조회
			while(rset.next()) { //rset 반복문 돌려서
				inputkiho = rset.getInt("kiho"); //해당 기호값 변수에 저장
				String sql = "insert into tupyo (kiho, age) values (" + inputkiho + ", " + age + ")"; 
				//해당 기호값과 인자값으로 받은 연령대 투표 테이블에 데이터 추가
		        stmt.execute(sql); //sql문 실행
			}
			
			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기
			rset.close(); //열었으면 객체 닫기
		
		} catch (Exception e) { //예외처리
			e.printStackTrace();
			
		}
	} //리턴값 없음

	
	@Override
	public void deleteHubo(int kiho) { //후보 삭제
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();
			
			stmt.executeUpdate("delete from hubo where kiho = " + kiho + ";");
			//후보 테이블의 기호와 인자로 받은 기호 값이 같으면 해당 행 데이터 삭제
			
			stmt.close(); // statement 객체 열어줬으면 닫기
			conn.close(); // connection 객체 열어줬으면 닫기

		} catch (Exception e) { //예외처리
			e.printStackTrace();
		}
	} //리턴값 없음


	@Override
	public int countAll() { //총 투표수 구하기
		int total = 0; //변수 정의 및 초기화
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();
			
			ResultSet rset = stmt.executeQuery("select count(*) from tupyo;"); //투표 테이블의 전체 레코드 카운트 = 총 투표수
			
			while (rset.next()) { //rset 반복문 돌려서
				total = rset.getInt(1); //레코드 카운트 값 변수에 저장
			}
			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기
			rset.close(); //열었으면 객체 닫기
			
		} catch (Exception e) { //예외처리
			e.printStackTrace();
			return -1; //에러발생시 -1 반환
		}
	return total; //총 투표수 리턴값으로 설정
	}

	
	@Override
	public int countVotes(int id) { //후보별 득표수
		int count = 0; //변수 정의 및 초기화
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();
			
			ResultSet rset = stmt.executeQuery("select count(*) from tupyo where kiho = "+id+";");
			//투표 테이블의 기호와 인자로 받은 기호 값이 같은 레코드 전체 카운트
			while(rset.next()) { //rset 반복문 돌려서
				count = rset.getInt(1); //카운트 값 변수에 저장
			}
			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기
			rset.close(); //열었으면 객체 닫기
			
		} catch (Exception e) { //예외 처리
			e.printStackTrace();
			return -1; //에러 발생시 -1 반환
		}
	return count; //카운트 값 리턴값으로 설정
	}

	
	@Override
	public List<VoteSystem> selectAll() { //전체 데이터 조회
		List<VoteSystem> voteSystems = new ArrayList<>(); //리스트 변수 정의
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();
			
			ResultSet rset = stmt.executeQuery("select * from hubo"); //후보 테이블의 전체 데이터 조회
		
			while (rset.next()) { //rset 반복문 돌리기
				VoteSystem voteSystem = new VoteSystem(); //voteSystem 객체 생성
				voteSystem.setKiho(rset.getInt(1)); //voteSystem 객체 kiho 변수에 후보 테이블의 기호 값 저장
				voteSystem.setName(rset.getString(2)); //voteSystem 객체 name 변수에 후보 테이블의 이름 값 저장
				voteSystems.add(voteSystem); //해당 데이터 리스트 변수에 저장
			}
			stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기
			rset.close(); //열었으면 객체 닫기
			
		} catch (Exception e) { //예외 처리
			e.printStackTrace();
			return null; //예외 발생시 null 값 반환
		}
		return voteSystems; //리스트 값 반환
	}

	
	@Override
	public List<VoteSystem> selectOne(int kiho) { //데이터 하나 조회
	    List<VoteSystem> voteSystems = new ArrayList<>(); //리스트 변수 정의
	    try {
	    	// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
	        Statement stmt = conn.createStatement();
	        
	        ResultSet rset = stmt.executeQuery("SELECT t.age, COUNT(*) AS voteCnt " 
	                + "FROM hubo as h "
	                + "JOIN tupyo as t ON h.kiho = t.kiho " 
	                + "WHERE h.kiho = '" + kiho + "'"
	                + "GROUP BY t.age;");
	        //후보테이블(h로 별칭 지정)과 투표테이블(t로 별칭 지정) 조인,
	        //투표 테이블의 연령대와 전체 카운트(voteCnt로 별칭 지정) 조회(후보테이블과 투표 테이블의 기호 값은 행만 조회) 
	        //후보 테이블의 기호 값과 인자로 받은 기호 값이 일치하는 경우만 조회
	        //age열을 기준으로 결과 그룹화(같은 age면 하나로 합쳐짐)
	        
	        while (rset.next()) { //rset 반복문 돌리기 
	            VoteSystem voteSystem = new VoteSystem(); //voteSystem 객체 생성
	            voteSystem.setAge(rset.getInt(1)); //voteSystem 객체의 age 변수에 투표테이블의 age 값 저장
	            voteSystem.setCount(rset.getInt(2)); //voteSystem 객체의 count 변수에 투표테이블의 전체 카운트 값 저장
	            
	            voteSystems.add(voteSystem); //voteSystem 객체 리스트 변수에 추가
	        }
	        stmt.close(); //열었으면 객체 닫기
			conn.close(); //열었으면 객체 닫기
			rset.close(); //열었으면 객체 닫기
	        
	    } catch (Exception e) { //예외 처리
	        e.printStackTrace();
	        return null; //예외 발생 시 null 값 반환
	    }
	    return voteSystems; //리스트 값 반환
	}

		
	
}
