package kr.ac.kopo.ctc.kopo39.domain;

public class StudentScore {
	
	//변수 선언
	private int id; //자동으로 부여되는(autocreaet) 식별자, 이 id를 기준으로 모든 CRUD 진행
	private String name; //이름
	private int studentId; //학번
	private int kor; //국어점수
	private int eng; //영어점수
	private int mat; //수학점수
	private int sum; //합계
	private float avg; //평균
	private int rank; //순위
	private int count; //전체 카운트
	
	//getter, setter 만들기
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = sum;
	}
	public float getAvg() {
		return avg;
	}
	public void setAvg(float avg) {
		this.avg = avg;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getStudentId() {
		return studentId;
	}
	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}
	public int getKor() {
		return kor;
	}
	public void setKor(int kor) {
		this.kor = kor;
	}
	public int getEng() {
		return eng;
	}
	public void setEng(int eng) {
		this.eng = eng;
	}
	public int getMat() {
		return mat;
	}
	public void setMat(int mat) {
		this.mat = mat;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}

}
