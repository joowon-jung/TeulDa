<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8" />
	    <title>내 앨범목록</title>

		<!-- jQuery CDN -->
		<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
		
		<!-- Bootstrap CDN -->
	    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/lux/bootstrap.min.css" integrity="sha384-9+PGKSqjRdkeAU7Eu4nkJU8RFaH8ace8HGXnkiKMP9I9Te0GJ4/km3L1Z8tXigpG" crossorigin="anonymous">
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
		<script>
		
		function removeCheck() {

 			if (confirm("정말 삭제하시겠습니까?? \n삭제시 복구할 수 없습니다!!") == true){    //확인
 				document.detailForm.action="/photo/deletePhoto";
 			}else{   //취소
     			return false;
 			}
		}
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
  				<!-- diary toolbar로 빼도 될 듯 -->
  				  	<div class="col-md-3">
						<div class="list-group">
							<button type="button" class="btn btn-link disabled">~ 사진을 봅시다 ~</button>
							<button type="button" id="deletePhoto" class="btn btn-outline-info" onclick="removeCheck()"> 휴지통 비우기</button><br/>
							<a href="/photo/getPhotoMap" class="list-group-item list-group-item-action"><center>내 사진 지도</center></a>
							<a href="/photo/listPhoto" class="list-group-item list-group-item-action"><center>내 사진 목록&nbsp&nbsp${totalCount}</center></a>
							<a href="/photo/photoBin" class="list-group-item list-group-item-action active"><center>사진 휴지통</center></a>
						</div>
	
				</div>
				
				<div class="col-md-9">
  					<div class="list-group">
  					<a href="#" class="list-group-item list-group-item-action active">Delete Albums</a></br></br>
  					<c:if test="${!empty group.deleteDate}">
	  					<c:set var = "i" value = "0" />
		          			<c:forEach var = "group" items = "${groupList}">
		            	<c:set var = "i" value = "${i+1}" />
		            		<div class="card" style="width: 18rem">
		               		<a href="/photo/album?groupNo=${group.groupNo}"><img class="card-img-top" src="..." alt="${group.groupName}"></a>
		              		<div class="card-body">
		                		<h5 class="card-title">${group.groupName}</h5>
				                <p class="card-text">${group.groupNo}</p>
				                <p class="card-text"><small class="text-muted">${group.deleteDate}</small></p>
				                <p class="card-text"><small class="text-muted">${group.nickname}</small></p>
				                <p class="card-text" style="text-align:right;"><small class="text-muted"><a href="#">복구</a></small></p>
		                	</div>
		                	</div>
		                	</c:forEach>
		                </c:if>
					</div>
				</div>
				
				<div class="col-md-3"></div>
				
				<div class="col-md-9">
	  					<div class="list-group">
	  					<a href="#" class="list-group-item list-group-item-action active">Delete Photos</a></br></br>
	  					
		  					<c:set var = "i" value = "0" />
			          			<c:forEach var = "photo" items = "${photoList}">
			            	<c:set var = "i" value = "${i+1}" />
			            		<div class="card" style="width: 18rem">
			               		<img class="card-img-top" src="..." alt="${photo.photoName}">
			              		<div class="card-body">
			                		<h5 class="card-title">${photo.photoName}</h5>
					                <p class="card-text">${photo.photoAddr}</p>
					                <p class="card-text"><small class="text-muted">${photo.deleteDate}</small></p>
					                <p class="card-text"><small class="text-muted">${photo.photoNo}</small></p>
					                <p class="card-text" style="text-align:right;"><small class="text-muted"><a href="#">복구</a></small></p>
			                	</div>
			                	</div>
			                	</c:forEach>
			            
						</div>
					</div>
					
					
			</div>
  		</div>
  		
  		

	</body>
	
	
	
	
</html>