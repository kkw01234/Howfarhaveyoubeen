<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin - 404 Error</title>

</head>

<body id="page-top">
	<jsp:include page="../main/layout.jsp" flush="false"></jsp:include>
	<div id="wrapper">
		<jsp:include page="../main/sidebar.jsp" flush="false"></jsp:include>
		<div id="content-wrapper">
			<div class="container-fluid">

				<!-- Breadcrumbs-->
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="index.html">Dashboard</a>
					</li>
					<li class="breadcrumb-item active">에러 페이지</li>
				</ol>

				<!-- Page Content -->
				<h1 class="display-1">Error page</h1>
				<p class="lead">
					페이지를 찾을 수 없습니다. <a href="javascript:history.back()">이전페이지</a> 또는 <a
						href="Index">메인페이지로</a>돌아가주세요
				</p>

				<jsp:include page="../main/footer.jsp" flush="false"></jsp:include>
			</div>
		</div>
	</div>


</body>

</html>
