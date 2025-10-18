package com.spring.finall;



import org.springframework.web.multipart.MultipartFile;

public class BoardVO {

	private int seq;
	private String title;
	private String writer;
	private String content;
	private String regdate;
	private int cnt;
	private String filename;
	private int num;
	private Boolean flagendpage;
	
	//검색조건 판단 필드로 검색조건 전용임
	// 나중에 vo로 분리해보자 한 vo에 다때려박으니 그런데 단점은 리턴시에 분리된 vo를 계속 2개 생성해서 리턴할듯?
	private String isserch;
	private String keyword;
	private String serchvalue;
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	private String status;
	
	

	
	
	
	
	
	
	
	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getSerchvalue() {
		return serchvalue;
	}

	public void setSerchvalue(String serchvalue) {
		this.serchvalue = serchvalue;
	}

	public String getIsserch() {
		return isserch;
	}

	public void setIsserch(String isserch) {
		this.isserch = isserch;
	}

	public Boolean getFlagendpage() {
		return flagendpage;
	}

	public void setFlagendpage(Boolean flagendpage) {
		this.flagendpage = flagendpage;
	}

	public int getStartpage() {
		return startpage;
	}

	public void setStartpage(int startpage) {
		this.startpage = startpage;
	}

	private int startpage;
	private int nextpage;
	private int backpage;
	
	private int startbtn;
	private int endbtn;
	
	private Integer totalrow;
	
	
	
	
	public Integer getTotalrow() {
		return totalrow;
	}

	public void setTotalrow(Integer totalrow) {
		this.totalrow = totalrow;
	}

	private int btncounting;
	
	public int getStartbtn() {
		return startbtn;
	}

	public void setStartbtn(int startbtn) {
		this.startbtn = startbtn;
	}

	public int getEndbtn() {
		return endbtn;
	}

	public void setEndbtn(int endbtn) {
		this.endbtn = endbtn;
	}

	public int getNextpage() {
		return nextpage;
	}

	public void setNextpage(int nextpage) {
		this.nextpage = nextpage;
	}

	public int getBackpage() {
		return backpage;
	}

	public void setBackpage(int backpage) {
		this.backpage = backpage;
	}


	
	
	
	
public int getBtncounting() {
		return btncounting;
	}

	public void setBtncounting(int btncounting) {
		this.btncounting = btncounting;
	}

	//	분기점 변수 추가
	 private int page;
	 
// 파일을 받기위한 추가
	 
	 private MultipartFile worklist_img_upload;

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public MultipartFile getWorklist_img_upload() {
		return worklist_img_upload;
	}

	public void setWorklist_img_upload(MultipartFile worklist_img_upload) {
		this.worklist_img_upload = worklist_img_upload;
	}

	//원래 객체=인스턴스 변수는 주소값이 나옴
	// 그러나 투스트링은 값을 보여주며
	// 객체 를 출력시 자동으로 실행되는 메소드임 암튼 좋음ㅋ
	@Override
	public String toString() {
		return "BoardVO [seq=" + seq + ", title=" + title + ", writer=" + writer + ", content=" + content + ", regdate="
				+ regdate + ", cnt=" + cnt + ", filename=" + filename + ", num=" + num + ", page=" + page
				+ ", worklist_img_upload=" + worklist_img_upload + "]";
	} 
	 
	 

	
	
	
	
	 
	 
	 
	 

	

}
