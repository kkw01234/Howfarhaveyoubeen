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


<body id="page-top">

	<jsp:include page="../main/layout.jsp" flush="false"></jsp:include>
	<div id="wrapper">
		<jsp:include page="../main/sidebar.jsp" flush="false"></jsp:include>
		<div id="content-wrapper">
			<!-- 이미지 첨부랑 설명이 필요한 메인 페이지 -->

			<div class="container-fluid">

				<!-- /.container-fluid -->
				<div id="carouselExampleControls" class="carousel slide"
					data-ride="carousel" style="height: 100%; width: 100%">
					<div class="carousel-inner" >
						<div class="carousel-item active" >
							<img class="d-block w-100" src="image/index1.jpg" alt="첫번째 슬라이드" >
						</div>
						<div class="carousel-item">
							<img class="d-block w-100" src="image/2.jpg" alt="두번째 슬라이드">
						</div>
						<div class="carousel-item">
							<img class="d-block w-100" src="image/Kakaofriends.png"
								alt="세번째 슬라이드">
						</div>
					</div>
					<a class="carousel-control-prev" href="#carouselExampleControls"
						role="button" data-slide="prev"> <span
						class="carousel-control-prev-icon" aria-hidden="true"></span> <span
						class="sr-only">이전</span>
					</a> <a class="carousel-control-next" href="#carouselExampleControls"
						role="button" data-slide="next"> <span
						class="carousel-control-next-icon" aria-hidden="true"></span> <span
						class="sr-only">다음</span>
					</a>
				</div>
				<jsp:include page="../main/footer.jsp" flush="false"></jsp:include>
			</div>
		</div>
	</div>
</body>

</html>
