<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>북마크 목록</title>

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>

<!-- Bootstrap CDN -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/lux/bootstrap.min.css"
	integrity="sha384-9+PGKSqjRdkeAU7Eu4nkJU8RFaH8ace8HGXnkiKMP9I9Te0GJ4/km3L1Z8tXigpG"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
	integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV"
	crossorigin="anonymous"></script>

<style>
/* content 3줄 이상이면 자름 */
#content {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 3; /* 라인수 */
	-webkit-box-orient: vertical;
	word-wrap: break-word;
	line-height: 1.2em;
	height: 3.5em;
	/* line-height 가 1.2em 이고 3라인을 자르기 때문에 height는 1.2em * 3 = 3.6em */
}

.card-body {
	overflow: auto;
}
</style>

<script>
	//검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	function fncGetList(currentPage) {

		$("#currentPage").val(currentPage);
		$("form[name='detailForm']").attr("method", "POST").attr("action",
				"/bookmark/listBookmark").submit();

	}

	$(function() {

		$("button:contains('Search')").on("click", function() { // 검색 버튼
			fncGetList(1); // currentpage : 1 
		});

		/* $(".breadcrumb-item").on("click", function() { // 정렬

			// <li> 클릭 시 해당 value 값 input type text 에 넣기
			$("#searchSorting").val($(this).attr('value'));
			fncGetList(1); // currentpage : 1 
		}); */

		$(".getDiary").on("click", function() {
			self.location = "/diary/getDiary?diaryNo=" + $(this).attr('id');
		});

		// 			$(".getProductSearch").on("click", function () { // 이미지 누르면 상품 보여지게 함
		// 				self.location = "/product/getProduct?prodNo="+$(this).attr('id')+"&menu=search";
		// 			});

	});
</script>

</head>

<body>
	<!-- ======= Header ======= -->
	<header>
		<jsp:include page="../layout/toolbar.jsp" />
	</header>
	<br />
	<br />
	<!-- End Header -->

	<form name="detailForm">

		<div class="container">
			<div class="row">
				<!-- ======= Diary Left ToolBar ======= -->
			<div class="col-md-3">
  					<jsp:include page="../diary/leftbar.jsp" />
				</div>
				<!-- End ToolBar -->

				<div class="col-md-9">
					<label class="col-form-label" for="inputDefault">북마크한 타 회원의 기록을 한눈에 볼 수 있습니다.</label>
					<br>
				
					<%-- <div class="row">
						<div class="col-md-2">
							<div class="form-group">
								<select class="custom-select" name="searchCondition">
									<option value="0"
										${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>제목</option>
									<option value="1"
										${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>내용</option>
									<option value="2"
										${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>원글 작성자</option>
								</select>

							</div>
						</div>
						<div class="col-md-7">
							<input type="text" name="searchKeyword" class="form-control"
								placeholder="검색어 입력" id="inputDefault"
								value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
						</div>
						<div class="col-md-3">
							<button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
						</div>
					</div> --%>

					<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
					<input type="hidden" id="currentPage" name="currentPage" value="" />
					
					<span class="badge badge-info">PAGE ${ resultPage.currentPage}, TOTAL ${ resultPage.totalCount }</span>
					
					<br><br>
					<div class="row">
						<c:set var="i" value="0" />
						<c:forEach var="bookmark" items="${	list }">
							<c:set var="i" value="${ i+1 }" />
							<div class="col-md-4">
								<div class="card bg-secondary mb-3" style="max-width: 20rem; height: 30rem;">
									<div class="card-header">
										<img src="../resources/images/marker_blue.png" height="12px"
											align="middle">&nbsp; 원글 작성자 : ${ bookmark.diary.nickname }<%-- &nbsp;&nbsp;${ diary.location } --%> <br>
										 <small>북마크 등록일자 : ${fn:substring(bookmark.bookmarkDate, 0, 10)}</small> 
									</div>
									<div class="card-body">
										<div class="getDiary" id="${ bookmark.diary.diaryNo }">
											<h5 class="card-title">${ bookmark.diary.title }</h5> 
											<p class="card-text"><img src="${ bookmark.diary.thumbnail }" width="210px" height="210px">
											<p class="card-text" id="content">
											<c:out value='${bookmark.diary.content.replaceAll("\\\<.*?\\\>","")}' /> 
											</p> 
										 </div> 
									</div>
								</div>
							</div>
						</c:forEach>

						<!-- PageNavigation Start... -->
						<jsp:include page="../common/pageNavigator.jsp" />
						<!-- PageNavigation End... -->

					</div>

				</div>
			</div>
		</div>

	</form>
</body>
</html>