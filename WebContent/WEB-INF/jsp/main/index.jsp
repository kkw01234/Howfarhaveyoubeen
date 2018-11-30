<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
	String userID = null;
	if (session.getAttribute("userID") != null)
		userID = (String) session.getAttribute("userID");
%>

<jsp:include page="layout.jsp" flush="false"></jsp:include> <!-- layout으로 inlcude 설정 -->

<div id="content-wrapper"> <!-- 이미지 첨부랑 설명이 필요한 메인 페이지 -->

	<div class="container-fluid">

		<!-- /.container-fluid -->
		<div id="carouselExampleControls" class="carousel slide"
			data-ride="carousel">
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img class="d-block w-100" src="image/1.jpg" alt="첫번째 슬라이드">
				</div>
				<div class="carousel-item">
					<img class="d-block w-100" src="image/2.jpg" alt="두번째 슬라이드">
				</div>
				<div class="carousel-item">
					<img class="d-block w-100" src="image/Kakaofriends.png" alt="세번째 슬라이드">
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
		<div class="text-right">
			<button type="button" class="btn btn-primary" id="start">시작하기</button> <!-- 버튼 변경 하자 -->
		</div>
		<!-- Sticky Footer -->
		<footer class="sticky-footer">
			<div class="container my-auto">
				<div class="copyright text-center my-auto">
					<span>Copyright ⓒ Your Website 2018</span>
				</div>
			</div>
		</footer>

	</div>
	<!-- /.content-wrapper -->

</div>

<script>
	$('#start').click(function() {
<%if (userID == null) {%>
	window.location.href = 'loginpage.do';
<%} else {%>
	window.location.href = 'diarylist.do';
<%}%>
	})
</script>
</body>

</html>
