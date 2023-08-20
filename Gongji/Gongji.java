package kr.ac.kopo.ctc.kopo39.domain;

import java.sql.Date;

public class Gongji { //변수 정의
	private int id; //번호
	private String title; //제목
	private Date date; //날짜
	private String content; //내용
	
	//getter, setter 만들기
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
}
