package com.teulda.common;

//==>리스트화면을 모델링(추상화/캡슐화)한 Bean 
public class Search {

	/// Field
	private int currentPage;
	private String searchCondition; // 검색 조건 ex) 제목, 내용, 작성자 등
	private String searchKeyword; // 검색어
	private String searchSorting; // 검색 된거 정렬 ex) 최신순, 조회수 높은순 등
	private int pageSize;
	// ==> 리스트화면 currentPage에 해당하는 회원정보를 ROWNUM 사용 SELECT 위해 추가된 Field
	// ==> mini project UserMapper.xml 의
	// ==> <select id="getUserList" parameterType="search"
	// resultMap="userSelectMap">
	// ==> 참조
	private int endRowNum;
	private int startRowNum;

	private String ascend;

	/// Constructor
	public Search() {
	}

	/// Method
	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int paseSize) {
		this.pageSize = paseSize;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public String getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getSearchSorting() {
		return searchSorting;
	}

	public void setSearchSorting(String searchSorting) {
		this.searchSorting = searchSorting;
	}

	// ==> Select Query 시 ROWNUM 마지막 값
	public int getEndRowNum() {
		return getCurrentPage() * getPageSize();
	}

	// ==> Select Query 시 ROWNUM 시작 값
	public int getStartRowNum() {
		return (getCurrentPage() - 1) * getPageSize() + 1;
	}

	// 오름차순 정렬
	public String getAscend() {
		return ascend;
	}

	public void setAscend(String ascend) {
		this.ascend = ascend;
	}

	@Override
	public String toString() {
		return "Search [currentPage=" + currentPage + ", searchCondition=" + searchCondition + ", searchKeyword="
				+ searchKeyword + ", searchSorting=" + searchSorting + ", pageSize=" + pageSize + ", endRowNum="
				+ endRowNum + ", startRowNum=" + startRowNum + ", ascend=" + ascend + "]";
	}

}