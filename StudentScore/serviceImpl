package kr.ac.kopo.ctc.kopo39.service;

import kr.ac.kopo.ctc.kopo39.dao.StudentScoreDao;
import kr.ac.kopo.ctc.kopo39.dao.StudentScoreDaoImpl;
import kr.ac.kopo.ctc.kopo39.dto.Pagination;

public class StudentScoreServiceImpl implements StudentScoreService { 
//StudentScoreService 인터페이스를 실제로 구현하는 StudentScoreServiceImpl 클래스

	@Override
	//페이지 네이션 계산하는 함수
	public Pagination getPagination(int C, int countPerPage) { //인자값 받기
		Pagination pagination = new Pagination(); //Pagination 객체 생성하여 변수에 저장
		
		int currentPage = C; //현재 페이지
		if(currentPage <= 0) { //현재 페이지가 0보다 작거나 같으면
			currentPage = 1; //현재 페이지는 1
		}
		
		StudentScoreDao studentScore = new StudentScoreDaoImpl(); //StudentScoreDaoImpl 객체 생성
		int total = studentScore.count(); //StudentScoreDaoImpl의 count()함수 호출하여 리턴값 total에 저장
		//int total = 135; //전체 데이터 수
		int lastpage; //마지막 페이지(=전체 페이지 수) 변수 선언
		
		if(total%countPerPage == 0) { //마지막 페이지(=전체 페이지 수) 변수 처리, 나눈 나머지 값이 0이면
			lastpage = total/countPerPage; //마지막 페이지 = 전체 데이터 수/페이지별 데이터 수
		} else { //아니면(남는 데이터 값이 있으면)
			lastpage = total/countPerPage + 1; //마지막 페이지 = 전체 데이터 수/페이지별 데이터 수+1
		}
		if(currentPage >= lastpage) { //현재 페이지가 마지막 페이지보다 크면
			currentPage = lastpage; //현재 페이지는 마지막 페이지로 설정
		}
		
		
		int blocksize = 10; //블록 사이즈 설정
		int startBlock = ((currentPage- 1) / blocksize) * blocksize + 1; //스타트 블록 (=시작 페이지 번호)
		int endBlock = startBlock + 9; //앤드 블록 (=종료 페이지 번호)

		int p = 0; //p 변수선언
		int n = 0; //n 변수선언
		int pp = 0; //pp 변수선언
		int nn = 0; //nn 변수선언
		
		
		if(startBlock == 1) { //스타트 블록이 1이면
			p = -1; //p 값 -1로 설정
			pp = -1; //pp 값 -1로 설정
			if(lastpage < 10) { //앤드 블록이 마지막 페이지와 값이 같거나 더 크면
				endBlock = lastpage; //앤드 블록 마지막 페이지로 재설정
				n = -1; //n도 -1로 설정
				nn = -1; //nn도 -1로 설정
			}
			else {
			//n = startBlock + blocksize; //n 값은 스타트블록 + 블록사이즈(10)로 설정
			nn = lastpage; //nn 값 마지막 페이지로 설정
			//if(currentPage > 1) { //현재 페이지가 1보다 크면
			n = currentPage + blocksize; //n 값은 현재 페이지 + 블록 사이즈(10)로 설정
				if(currentPage + blocksize > lastpage) {
					n = lastpage;
				}
			}
		}
		
		else { //스타트 블록이 1이 아니면
			p = currentPage-blocksize; //p 값은 현재 페이지 - 블록 사이즈(10)로 설정
			pp = 1; //pp 값 1로 설정
			n = currentPage + blocksize; //n은  현재 페이지 + 블록사이즈(10)로 설정
			if(currentPage + blocksize > lastpage) {
				n = lastpage;
			}
			nn = lastpage; //nn 값 마지막 페이지로 설정
			if(endBlock >= lastpage) { //앤드 블록이 마지막 페이지와 값이 같거나 더 크면
				endBlock = lastpage; //앤드 블록 마지막 페이지로 재설정
				n = -1; //n도 -1로 설정
				nn = -1; //nn도 -1로 설정
			}
		}
		
		pagination.setC(currentPage); //현재페이지 값 pagination 객체에 set
		pagination.setS(startBlock); //스타트블록 값 pagination 객체에 set
		pagination.setE(endBlock); //앤드블록 값 pagination 객체에 set
		pagination.setP(p); //p 값 pagination 객체에 set
		pagination.setPP(pp); //pp 값 pagination 객체에 set
		pagination.setN(n); //n 값 pagination 객체에 set
		pagination.setNN(nn); //nn 값 pagination 객체에 set
		
		return pagination; //pagination 객체 값 리턴
	}

}
