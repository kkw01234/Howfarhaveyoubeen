<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String userID = null;
	if (session.getAttribute("userID") != null)
		userID = (String) session.getAttribute("userID");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

</head>
<style>
#page-top{
	background-size:cover;
}
#wrapper{
	
	width:100%;
	height:100%;
}
</style>

<body id="page-top" style="backgroud-size:cover;">
	<div id="background-changer">
	<jsp:include page="../main/layout.jsp" flush="false"></jsp:include>
	<div id="wrapper" style="display:block">
	<%if(session.getAttribute("userID")!=null) {%>
		<jsp:include page="../main/sidebar.jsp" flush="false"></jsp:include>
		<%}else{ %>
		<ul class="sidebar navbar-nav" id="sidebar" style="background-color:transparent">
		<li class="nav-item"><a class="nav-link" href="loginpage.do"> <i
					class="fas fa-fw fa-folder" style="color:white"></i> <span style="color:white">시작하기</span>
			</a></li>
		</ul>
		<%} %>
		<div id="content-wrapper">
			<!-- 이미지 첨부랑 설명이 필요한 메인 페이지 -->

			<div class="container-fluid">

				
				
				</div>
				
			</div>
			
		</div>
		</div>
		<jsp:include page="../main/footer.jsp" flush="false"></jsp:include>
</body>
<script>

var images = ["image/index/koln.png", "image/index/prague.png", "image/index/index1.jpg"];

$('#page-top').css('background-image', "url('" + images[0] + "')");
$('#page-top').css('background-size',"cover");
$(function () {
	var i = 0; 
	$("#page-top").css("background-image", "url(./" + images[i] + ")"); 
	setInterval(function () {
		i++; 
		if (i == images.length) {
			i = 0; 
			} 
		$("#page-top").fadeOut(0, function () {
			$(this).css("background-image", "url(./" + images[i] + ")"); 
			$(this).fadeIn(0); 
			}); 
		}, 5000); 
	});




</script>
</html>
