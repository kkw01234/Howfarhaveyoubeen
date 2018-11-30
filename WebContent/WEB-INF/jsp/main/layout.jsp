<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin - Dashboard</title>

<!-- Bootstrap core CSS-->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">

<!-- Page level plugin CSS-->
<link href="vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin.css" rel="stylesheet">

</head>

<%
	String userID = null;
	if (session.getAttribute("userID") != null)
		userID = (String) session.getAttribute("userID");
%>

<body id="page-top">

	<nav class="navbar navbar-expand navbar-dark bg-dark static-top">

		<a class="navbar-brand mr-1" href="Index"><img src="image/weblogo_small.png"></img></a>

		<button class="btn btn-link btn-sm text-white order-1 order-sm-0"
			id="sidebarToggle" href="#">
			<i class="fas fa-bars"></i>
		</button>

		<!-- Navbar -->
		<ul class="navbar-nav ml-auto ml-md-12 text-right">
			<%
				if (userID == null) {
			%>
			<h6 style="color:white">로그인 해주세요</h6>
			<%
				} else {
			%>
			<h6 style="color:white"><%=userID %>님 환영합니다</h6>
			<%
				}
			%>
		</ul>
		<ul class="navbar-nav ml-auto ml-md-1">
			<li class="nav-item dropdown no-arrow"><a
				class="nav-link dropdown-toggle" href="#" id="userDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-user-circle fa-fw"></i>
			</a>


				<div class="dropdown-menu dropdown-menu-right"
					aria-labelledby="userDropdown">
					<%
						if (userID == null) {
					%>
					<a class="dropdown-item" href="loginpage.do">로그인</a> <a
						class="dropdown-item" href="registerpage.do">회원가입</a> <a
						class="dropdown-item" href="forgotpasswordpage.do">아이디/비밀번호 찾기</a>
					<%
						} else {
					%>
					<!-- 우선 삭제 안해놓을게 -->
					<a class="dropdown-item" href="changepasswordpage.do">비밀번호 변경</a> <a
						class="dropdown-item" href="logout.do">로그아웃</a>
					<%
						}
					%>
				</div></li>
		</ul>
		

	</nav>

	<div id="wrapper">

		<!-- Sidebar -->
		<ul class="sidebar navbar-nav">
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="pagesDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-fw fa-folder"></i> <span>여행 기록하기</span>
			</a>
				<div class="dropdown-menu" aria-labelledby="pagesDropdown">
					<a class="dropdown-item" href="imageuploadpage.do">항공권 인식</a> <a
						class="dropdown-item" href="diarywriter.do">항공권 없이 쓰기</a>
				</div></li>
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="pagesDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-fw fa-folder"></i> <span>나의 여행기</span>
			</a>
				<div class="dropdown-menu" aria-labelledby="pagesDropdown">
					<a class="dropdown-item" href="diarylist.do">리스트</a> <a
						class="dropdown-item" href="diarymaplist.do">지도</a>
				</div></li>
			<li class="nav-item"><a class="nav-link" href="shareddiarypage.do?seq=1"> <i
					class="fas fa-fw fa-chart-area"></i> <span>친구의 여행기</span>
			</a></li>
		</ul>
		<!-- /#wrapper -->
	</div>
		<!-- Scroll to Top Button-->
		<a class="scroll-to-top rounded" href="#page-top"> <i
			class="fas fa-angle-up"></i>
		</a>

		<!-- Bootstrap core JavaScript-->
		<script src="vendor/jquery/jquery.min.js"></script>
		<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

		<!-- Core plugin JavaScript-->
		<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

		<!-- Page level plugin JavaScript-->
		<script src="vendor/datatables/jquery.dataTables.js"></script>
		<script src="vendor/datatables/dataTables.bootstrap4.js"></script>

		<!-- Custom scripts for all pages-->
		<script src="js/sb-admin.min.js"></script>

		<!-- Demo scripts for this page-->
		<script src="js/demo/datatables-demo.js"></script>
</body>

</html>
