package kr.ac.kopo.ctc.kopo39.dao;

import java.util.List;

import kr.ac.kopo.ctc.kopo39.domain.Gongji;

public interface GongjiDao { //함수정의
	List<Gongji> selectAll(int page, int countPerPage); //전체 데이터 보기(페이지네이션)
	Gongji selectOne(int id); //데이터 하나만 보기
	void insertData(Gongji gongji); //신규 등록
	Gongji updateData(Gongji gongji); //데이터 수정
	void deleteData(int id); //데이터 삭제
	int count(); //토탈 카운트 계산
}
