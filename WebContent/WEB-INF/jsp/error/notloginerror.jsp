<!DOCTYPE html>
<html lang="ko">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>에러 페이지</title>

</head>
<!-- Session 없을때 -->
<body id="page-top">
	<jsp:include page="../main/layout.jsp" flush="false"></jsp:include>
	<div id="wrapper">
		<jsp:include page="../main/sidebar.jsp" flush="false"></jsp:include>
	</div>
<script>
	$(document).ready(function(){
		alert("로그인을 먼저 해주세요");
		window.location.href="loginpage.do";
	})

</script>

</body>


</html>
