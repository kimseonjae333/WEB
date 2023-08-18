package kr.ac.kopo.ctc.kopo39.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kr.ac.kopo.ctc.kopo39.domain.Inventory;

public class InventoryDaoImpl implements InventoryDao {

	@Override
	public int count() { //전체 데이터 수 카운트
		int count = 0; // 카운트 변수 선언 및 초기화
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();

			ResultSet rset = stmt.executeQuery("select count(*) from inventory;");
			//재고 테이블의 전체 레코드 개수 구하기
			while (rset.next()) { // rset 돌려서
				count = rset.getInt(1); // 전체 레코드 수 변수에 저장
			}
			rset.close(); // 열었으면 객체 닫기
			stmt.close(); // 열었으면 객체 닫기
			conn.close(); // 열었으면 객체 닫기

		} catch (Exception e) { // 예외처리
			e.printStackTrace();
			return -1; // 예외 발생시 -1값 반환
		}
		return count; // count 값 반환
	}

	@Override
	public List<Inventory> selectAll(int page, int countPerPage) { //데이터 전체보기(페이지 네이션)
		List<Inventory> inventorys = new ArrayList<>(); //리스트 변수 정의
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();

			int start = (page - 1) * countPerPage; // page,countPerPage 인자값을 받아 해당 페이지의 첫번째 데이터 번호 계산
			ResultSet rset = stmt.executeQuery("SELECT * FROM inventory ORDER BY id DESC LIMIT " 
			+ start + ", " + countPerPage + ";"); // 페이지의 첫번째 데이터부터 countPerPage개의 데이터 출력(id 번호 역순)
																												

			while (rset.next()) { // rset 반복문 돌리기
				Inventory inventory = new Inventory(); // inventory 객체 생성
				inventory.setSerialnum(rset.getString(2)); // inventory 객체 상품번호 값 저장
				inventory.setName(rset.getString(3)); // inventory 객체 상품명 값 저장
				inventory.setStocknum(rset.getInt(4)); // inventory 객체 재고수량 값 저장
				inventory.setRegdate(rset.getDate(5)); // inventory 객체 상품등록일 값 저장
				inventory.setCheckdate(rset.getDate(6)); // inventory 객체 재고확인일 값 저장
				inventorys.add(inventory); // 해당 데이터 리스트 변수에 저장
			}
			stmt.close(); // 열었으면 객체 닫기
			conn.close(); // 열었으면 객체 닫기
			rset.close(); // 열었으면 객체 닫기

		} catch (Exception e) { // 예외 처리
			e.printStackTrace();
			System.out.println(e); //예외 발생 시 에러메세지 출력
		}
		return inventorys; // 리스트 값 반환
	}

	
	
	@Override
	public Inventory selectOne(String serialnum) { //데이터 하나 보기
		Inventory inventory = null; //inventory 객체 선언 및 초기화
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();

			ResultSet rset = stmt.executeQuery("select * from inventory where serialnum = " + serialnum + ";");
			// 상품번호가 인자로 받은 상품 번호가 같은 레코드의 전체 데이터 조회

			while (rset.next()) { // rset돌려서
				inventory = new Inventory(); // inventory 객체 호출
				inventory.setSerialnum(rset.getString(2)); // inventory 객체 상품번호 값 저장
				inventory.setName(rset.getString(3)); // inventory 객체 상품명 값 저장
				inventory.setStocknum(rset.getInt(4)); // inventory 객체 재고수량 값 저장
				inventory.setRegdate(rset.getDate(5)); // inventory 객체 상품등록일 값 저장
				inventory.setCheckdate(rset.getDate(6)); // inventory 객체 재고확인일 값 저장
				inventory.setContent(rset.getString(7)); // inventory 객체 상품내용 값 저장
				inventory.setPhoto(rset.getString(8)); // inventory 객체 상품이미지 값 저장
			}

			rset.close(); // 열었으면 객체 닫기
			stmt.close(); // 열었으면 객체 닫기
			conn.close(); // 열었으면 객체 닫기

		} catch (Exception e) { // 예외 처리
			e.printStackTrace();
			System.out.println(e); // 예외 발생 시 에러메시지 출력
		}
		return inventory; // inventory 객체 반환
	}

	
	
	@Override
	public int insertData(Inventory inventory) { //데이터 넣기
	    try {
	    	// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
	    	// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
	    	// SQL문을 실행하기 위한 statement 객체 생성
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
	        Statement stmt = conn.createStatement();
	        
	        String sql = "insert into inventory (serialnum, name, stocknum, regdate, checkdate, content, photo) " +
                    "values ('" + inventory.getSerialnum() + "', '" + inventory.getName() + "', " +
                    inventory.getStocknum() + ", NOW(), NOW(), '" + inventory.getContent() + "', '" +
                    inventory.getPhoto() + "')";
	        //데이터 넣기, regdate와 checkdate는 현재 시간으로 넣기
 
	        stmt.executeUpdate(sql); //sql문 실행
	        
	        stmt.close(); // 열었으면 객체 닫기
			conn.close(); // 열었으면 객체 닫기
	        
	    } catch (Exception e) { //예외 처리
	        e.printStackTrace();
	        return -1; //예외 발생 시 -1 반환
	    }
	    return 0; //0 반환
	}

	
	
	@Override
	public void deleteData(String serialnum) { //데이터 삭제
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();

			stmt.executeUpdate("delete from inventory where serialnum = " + serialnum + ";");
			//상품번호가 인자로 받은 상품번호와 같은 레코드 삭제

			stmt.close(); // 열었으면 객체 닫기
			conn.close(); // 열었으면 객체 닫기

		} catch (Exception e) { // 예외 처리
			e.printStackTrace();
		} //리턴값 없음
	}

	
	
	@Override
	public Inventory findInfo(String serialnum) { //serialnum으로 전체 데이터 찾기
		Inventory inventory = new Inventory(); // inventory 객체 생성
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();

			ResultSet rset = stmt.executeQuery("select * from inventory"); //재고 테이블 전체 데이터 조회

			while (rset.next()) { // rset 돌려서
				if (rset.getString(2).equals(serialnum)) { // 데이터의 상품번호와 인자로 받은 상품번호가 같으면
					inventory.setSerialnum(rset.getString(2)); // inventory 객체 상품번호 값 저장
					inventory.setName(rset.getString(3)); // inventory 객체 상품명 값 저장
					inventory.setStocknum(rset.getInt(4)); // inventory 객체 재고수량 값 저장
					inventory.setRegdate(rset.getDate(5)); // inventory 객체 상품등록일 값 저장
					inventory.setCheckdate(rset.getDate(6)); // inventory 객체 재고확인일 값 저장
					inventory.setContent(rset.getString(7)); // inventory 객체 상품내용 값 저장
					inventory.setPhoto(rset.getString(8)); // inventory 객체 상품이미지 값 저장
				}

			}
			rset.close(); // 열었으면 객체 닫기
			stmt.close(); // 열었으면 객체 닫기
			conn.close(); // 열었으면 객체 닫기

		} catch (Exception e) { // 예외 처리
			e.printStackTrace();
			System.out.println(e); //예외 발생 시 에러메세지 출력
		}
		return inventory; // inventory 객체 값 리턴
	}

	
	
	@Override
	public Inventory updateData(Inventory inventory) { //데이터 수정 업데이트
		try {
			// JDBC 드라이버 클래스 로드, 데이터베이스와 연결을 설정하기 위해 필요
			// getConnetion 메서드를 호출하여 MySQL 데이터베이스와 연결, 매개변수 순서(JDBC URL, DB NAME, DB USER,PASSWD)
			// SQL문을 실행하기 위한 statement 객체 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.108:33060/kopo39", "root", "kopo39");
			Statement stmt = conn.createStatement();

			String sql = "update inventory set stocknum =" + inventory.getStocknum() + ", checkdate = NOW() "
					+ "where serialnum ='" + inventory.getSerialnum() + "';";
			// 상품번호가 인자로 받은 객체의 상품번호와 같은 레코드의 상품명 값 수정(업데이트)

			stmt.executeUpdate(sql); // sql문 실행

			stmt.close(); // 열었으면 객체 닫기
			conn.close(); // 열었으면 객체 닫기

		} catch (Exception e) { // 예외 처리
			e.printStackTrace();
			System.out.println(e); // 예외 발생시 에러메시지 출력
		}
		return inventory; // inventory 객체 반환
	}


}
