<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
	    <title>내 기록 조회</title>
	    
	    <!-- jQuery CDN -->
		<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
		
		<!-- Bootstrap CDN -->
	    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/lux/bootstrap.min.css" integrity="sha384-9+PGKSqjRdkeAU7Eu4nkJU8RFaH8ace8HGXnkiKMP9I9Te0GJ4/km3L1Z8tXigpG" crossorigin="anonymous">
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
	
		<style>
/* 		h6 { text-align: center; color: gray; } */
/* 		h3 { text-align: center; } */
/* 		h5 { text-align: center; } */
/* 		p  { text-align: center; } */
		img[src$="../resources/images/user.png"] { display: block; margin: 0px auto; }
		</style>
		
		<script>
		$(function () {
			
			$("span:contains('수정')").on("click", function () {
				self.location = "/diary/updateDiary?diaryNo=${ diary.diaryNo }";
			});
			
			$("span:contains('삭제')").on("click", function () {
				var result = confirm("휴지통으로 기록이 이동됩니다.");
				if(result)
				{
				self.location = "/diary/updateDiaryStatus?diaryNo=${ diary.diaryNo }";
				}
			});
			
			$("button:contains('확인')").on("click", function() { 
				history.go(-1); 
			});
			
			// ================ 지출내역  ================ //
			var state = '${ diary.currency }';

			if (state == 'KRW') {
				$("td:even").prepend('₩ &nbsp;');
			} else if (state == 'USD') {
				$("td:even").prepend('$ &nbsp;');
			} else if (state == 'JPY') {
				$("td:even").prepend('¥ &nbsp;');
			} else if (state == 'EUR') {
				$("td:even").prepend('€ &nbsp;');
			} else if (state == 'AUD') {
				$("td:even").prepend('A$ &nbsp;');
			} else {
				
			}
			// ==========================================
			

			});
		</script>
		
		
	</head>
	<body>
  		<!-- ======= Header ======= -->
		<header>
			<jsp:include page="../layout/toolbar.jsp"/>
		</header><br/><br/>
		<!-- End Header -->
		
		<div class="container">
			<div class="row">
				<!-- ======= Diary Left ToolBar ======= -->
				<div class="col-md-3">
  					<jsp:include page="../diary/leftbar.jsp" />
				</div>
				<!-- End ToolBar -->
				
				<div class="col-md-9">
					<div class="jumbotron">
						<h6 style="text-align: center;">
						<c:choose>
							<c:when test="${ diary.groupName eq 'default2' }"></c:when> <!-- 그룹 미지정일땐 아무것도 안 보이게 함 -->
							<c:otherwise>${ diary.groupName }</c:otherwise>
						</c:choose>
						</h6>
  						<h3 style="text-align: center;">${ diary.title }</h3>
  						<p style="text-align: center;"><img src="../resources/images/marker_blue.png" height="15px" align="middle">
  						${ diary.location } | ${ diary.startDate } ~ ${ diary.endDate }</p>
  						
  						<div class="row">
  							<div class="col-md-3">
  								<img src="../resources/images/user.png" height="30px">
  								<h6 style="text-align: center;">${ diary.nickname }</h6>
  							</div>
  							<div class="col-md-9" align="right">
  								<span class="badge badge-info">수정</span>
  								<span class="badge badge-danger">삭제</span>
  							</div>
  						</div>
 						<hr class="my-4">
 						<p style="text-align: right">
 							<c:if test="${ diary.isPublic eq 't'.charAt(0) }"> <!-- 공개 --> 
 								<img src="../resources/images/unlock.png" height="20px" align="middle">
 							</c:if> 
 							<c:if test="${ diary.isPublic eq 'f'.charAt(0) }"> <!-- 비공개 --> 
 								<img src="../resources/images/lock.png" height="20px" align="middle">
 							</c:if>
 						작성일 : ${ diary.writeDate }
 						<c:if test="${ diary.updateDate ne null }"> <!-- 수정일자 있으면 보여줌 -->
 						| 마지막 수정일 : ${ diary.updateDate }
 						</c:if>
 						</p>
 						
 						<p class="lead">${ diary.content }</p>
 						
 						<hr class="my-4">
							
							<h5 style="text-align: center;">EXPENSES
							<br><a href=#none id="show" onclick="if(hide.style.display=='none') {hide.style.display='';show.innerText='▲'} else {hide.style.display='none';show.innerText='▼'}">▼</a>
							</h5>
							
							<div id="hide" style="display: none">
							<table class="table table-hover">
								<thead>
									<tr class="table-light">
										<th scope="col">분 류</th>
										<th scope="col">금 액</th>
										<th scope="col">통 화</th>
									</tr>
								</thead>
								<tbody>
									<tr class="table-light">
										<th scope="row">교통비</th>
										<td>${ diary.transBill }</td>
										<td>${ diary.currency }</td>
									</tr>
									<tr class="table-light">
										<th scope="row">숙박비</th>
										<td>${ diary.roomBill }</td>
										<td>${ diary.currency }</td>
									</tr>
									<tr class="table-light">
										<th scope="row">식비</th>
										<td>${ diary.foodBill }</td>
										<td>${ diary.currency }</td>
									</tr>
									<tr class="table-light">
										<th scope="row">관광비</th>
										<td>${ diary.tourBill }</td>
										<td>${ diary.currency }</td>
									</tr>
									<tr class="table-light">
										<th scope="row">쇼핑비</th>
										<td>${ diary.shopBill }</td>
										<td>${ diary.currency }</td>
									</tr>
								</tbody>
							</table>
							</div> 
							
							<hr class="my-4">
							
							<h5 style="text-align: center;">HASHTAG</h5>
							<div class="row">
								<c:set var="i" value="0" />
									<c:forEach var = "hashTag" items = "${ diary.hashTagList }">
										<c:set var="i" value="${ i+1 }" />
											<span class="badge badge-info">${ hashTag.hashTagName }</span>&nbsp;&nbsp;
									</c:forEach>
								
							</div>
					</div>

					조회수 ${ diary.viewCount }회 | 북마크 ${ diary.bookmarkCount }회 
					<button type="button" class="btn btn-primary btn-sm" style="float: right;" >확인</button>
				</div>
				
			</div>
		</div>
		
	</body>
</html>