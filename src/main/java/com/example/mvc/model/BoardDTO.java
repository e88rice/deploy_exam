package com.example.mvc.model;
// DTO는 필드, 게터세터
public class BoardDTO {
	private Integer num;
	private String memberId;
	private String name;
	private String subject;
	private String content;
	private Integer hit;
	private String ip;
	private String addDate;
	
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public Integer getHit() {
		return hit;
	}
	public void setHit(Integer hit) {
		this.hit = hit;
	}
	
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	
	public String getAddDate() {
		return addDate;
	}
	public void setAddDate(String addDate) {
		this.addDate = addDate;
	}


	@Override
	public String toString() {
		return "BoardDTO{" +
				"num=" + num +
				", memberId='" + memberId + '\'' +
				", name='" + name + '\'' +
				", subject='" + subject + '\'' +
				", content='" + content + '\'' +
				", hit=" + hit +
				", ip='" + ip + '\'' +
				", addDate='" + addDate + '\'' +
				'}';
	}
}
