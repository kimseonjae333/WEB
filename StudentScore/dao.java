package kr.ac.kopo.ctc.kopo39.dao;

import java.util.List;

import kr.ac.kopo.ctc.kopo39.domain.StudentScore;

public interface StudentScoreDao {
	//함수 정의
	StudentScore create (StudentScore studentScore); //데이터 추가(insert one)
	StudentScore selectOne (int id); //select one
	List<StudentScore> selectAll (int page, int countPerPage); //select all
	StudentScore update (int id, StudentScore studentScore); //조회 후 정정/삭제 update
	StudentScore deleteByStuentId(int id); //조회 후 정정/삭제 delete
	int count(); //토탈 카운트 계산
	String maketable (); //create table
	String inserttable (); //insert all
	String droptable (); //drop table
	StudentScore findInfo (StudentScore studentScore); //학번으로 해당 데이터 구하기
	int getCurrentPage(int id, int countPerpage); //해당 학번 포함된 현재 페이지 구하기
	
}
