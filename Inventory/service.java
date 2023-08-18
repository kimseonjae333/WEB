package kr.ac.kopo.ctc.kopo39.service;

import kr.ac.kopo.ctc.kopo39.dto.Pagination;

public interface InventoryService {
	Pagination getPagination(int C, int countPerPage);
	//C와 countPerPage 인자값을 기반으로 Pagination 클래스의 객체를 생성하여 반환하는 메서드

	//int countVisitor(); 방문자 카운트 계산하는 변수
}
