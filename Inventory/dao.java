package kr.ac.kopo.ctc.kopo39.dao;

import java.util.List;

import kr.ac.kopo.ctc.kopo39.domain.Inventory;

public interface InventoryDao {
	//함수정의
	int count(); //토탈 카운트 계산
	List<Inventory> selectAll(int page, int countPerPage); //데이터 전체보기(페이지네이션)
	Inventory selectOne(String serialnum); //데이터 하나만 보기
	int insertData(Inventory inventory); //데이터 넣기
	Inventory updateData(Inventory inventory); //데이터 수정 업데이트
	void deleteData(String serialnum); //데이터 삭제
	Inventory findInfo(String serialnum); //serialnum 이용해서 전체 데이터 찾기
}
