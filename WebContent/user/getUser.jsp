<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html>
	
<head>
	<meta charset="UTF-8" />
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<!-- jQuery CDN -->
		<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
		
		<!-- Bootstrap CDN -->
	    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/lux/bootstrap.min.css" integrity="sha384-9+PGKSqjRdkeAU7Eu4nkJU8RFaH8ace8HGXnkiKMP9I9Te0GJ4/km3L1Z8tXigpG" crossorigin="anonymous">
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
	

	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
    	 body >  div.container{ 
            margin-top: 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	/*
		//============= 회원정보수정 Event  처리 =============	
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( "button" ).on("click" , function() {
					self.location = "/user/updateUser?email=${user.email}"
				});
		});*/
		
		 
		 
		 $(function() {
				//신고내역
				 $( "button:contains('신고내역')" ).on("click" , function() {
						self.location = "/user/listReport?targetNick=${user.nickname}"
						
					});
			});
		 
		 
		 
		 
		 <%-- $(function() { --%>
			 document.addEventListener('DOMContentLoaded', () => {
				//구독여부확인
				
			 $.ajax({
		         url : "/subscribe/rest/checkSubscribe/${user.nickname}",   
		         type : "GET",
		         //dataType : "text",
		         headers: {
		            "Content-Type": "application/json"
		         },
		            	success : function(result) {
							if (result == true) {
								 console.log("체크완료");
								 
								const subCheck = document.querySelector("div.col-md-12.text-center");
								const subButton =  document.createElement("button");
								const userReport = document.createElement("button"); 
								subButton.setAttribute("type", "button");
								subButton.setAttribute("class", "btn btn-outline-success");
								subButton.textContent = "구독";
								userReport.setAttribute("type", "button");
								userReport.setAttribute("class", "btn btn-outline-danger");
								userReport.textContent = "회원신고";
								subCheck.appendChild(subButton);
								subCheck.appendChild(userReport);
								subButton.insertAdjacentHTML("afterend", "&nbsp;");
								
								$(function(){
									
									 $( "button:contains('구독')"  ).on("click" , function() {
									         
									         $.ajax({
									         url : "/subscribe/rest/addSubscribe/${user.nickname}",   
									         type : "GET",
									         //dataType : "text",
									         headers: {
									            "Content-Type": "application/json"
									         },
									            	success : function(result) {
														if (result == true) {
															alert("구독이 완료되었습니다.");
															
															location.reload();  
														} else {
														}
													}
									         
									         
									         });
										
										});
									});
								 $(function() {
										//신고
										 $( "button:contains('회원신고')" ).on("click" , function() {
											 
											
											 var msg = "정말로 신고하시겠습니까?";

											 var flag = confirm(msg);

											 if(flag==true) {
												 //self.location = "/user/addReport.jsp"
												 self.location = "/user/addReport?targetNick=${user.nickname}"
											 alert("신고창으로 이동합니다.");
											 }
											 else {alert("취소하였습니다.");}
											});
									});
								
							} else {
								 console.log("체크완료");
								 
								const subCheck = document.querySelector("div.col-md-12.text-center");
								const subButton =  document.createElement("button");
								const userReport = document.createElement("button"); 
								subButton.setAttribute("type", "button");
								subButton.setAttribute("class", "btn btn-outline-warning");
								subButton.textContent = "구독 취소";
								userReport.setAttribute("type", "button");
								userReport.setAttribute("class", "btn btn-outline-danger");
								userReport.textContent = "회원신고";
								subCheck.appendChild(subButton);
								subCheck.appendChild(userReport);
								subButton.insertAdjacentHTML("afterend", "&nbsp;");
								
								 $(function(){
										
									 $( "button:contains('구독 취소')"  ).on("click" , function() {
									         
									         $.ajax({
									         url : "/subscribe/rest/deleteSubscribe/${user.nickname}",   
									         type : "GET",
									         //dataType : "text",
									         headers: {
									            "Content-Type": "application/json"
									         },
									        
									            
									            	success : function(result) {
														if (result == true) {
															alert("구독이 취소되었습니다.");
															location.reload(); // 리로드 안하고 할 수 있게 해보기 
														} else {
															alert("구독취소안됨.");
														}
													}
									         
									         
									         });
										
										});
									});
								 $(function() {
										//신고
										 $( "button:contains('회원신고')" ).on("click" , function() {
											 
											
											 var msg = "정말로 신고하시겠습니까?";

											 var flag = confirm(msg);

											 if(flag==true) {
												 //self.location = "/user/addReport.jsp"
												 self.location = "/user/addReport?targetNick=${user.nickname}"
											 alert("신고창으로 이동합니다.");
											 }
											 else {alert("취소하였습니다.");}
											});
									});
							}
						}
		         
		         
		         });
				
						
					});
		 console.log("체크완료");
		
		 console.log("${user.nickname}");
		 console.log("${sessionScope.user.nickname}");
		
		 
		
	
		 
		
		
	</script>
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		
		
		<div class="page-header">
	       <h2 class="text-left">${user.nickname}님의 공간</h2>
	    </div>
	    
	    <div class="select-img"><img src="${user.profilePhoto}" style="width: 90%;"/></div>
	    
	    <input type="hidden" name="targetNick" value="${user.nickname}" />
	    <input type="hidden" name="nickname" value="${user.nickname}" />
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>닉네임</strong></div>
			<div class="col-xs-8 col-md-4">${user.nickname}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>이 름</strong></div>
			<div class="col-xs-8 col-md-4">${user.name}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>거주지</strong></div>
			<div class="col-xs-8 col-md-4">${user.address}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>관심지역</strong></div>
			<div class="col-xs-8 col-md-4">${user.likePlace}</div>
		</div>
		
		<hr/>
		
	
	
		

		
<!-- <c:set var="i" />
	<c:if test="${i eq 0}">
		<div class="form-group">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-outline-success">구독</button>
	  			<button type="button"  class="btn btn-outline-danger">회원신고</button>
	  		</div>
		</div>
		</c:if>

	<c:set var="i" />
	<c:if test="${i eq 1}">
		<div class="form-group">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-outline-warning">구독 취소</button>
	  			<a class="btn btn-outline-danger">회원신고</a>
	  		</div>
		</div>
		</c:if>

	-->
	<div class="form-group">
	  		<div class="col-md-12 text-center ">
	  		</div>
		</div>
		
		<c:if test="${sessionScope.user.role eq '0'.charAt(0)}">
			      <button type="button" class="btn btn-outline-prime">신고내역</button>
      	</c:if>
		

		
		<br/>
		
 	</div>
 	<!--  화면구성 div Start /////////////////////////////////////-->

</body>

</html>