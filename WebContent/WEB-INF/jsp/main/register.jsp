<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

  <title>SB Admin - Register</title>

  <!-- Bootstrap core CSS-->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <!-- Custom styles for this template-->
  <link href="css/sb-admin.css" rel="stylesheet">
 
</head>
<%
	String userID = null;
	if(session.getAttribute("userID") != null)
		userID = (String) session.getAttribute("userID");
%>
<body class="bg-dark">

<nav class="navbar navbar-expand navbar-dark bg-dark static-top">

  <a class="navbar-brand mr-1" href="Index"><img src="image/weblogo_small.png"></img></a>

  <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
    <i class="fas fa-bars"></i>
  </button>

  <!-- Navbar Search -->
  <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0"></form>

  <!-- Navbar -->
  <ul class="navbar-nav ml-auto ml-md-0">

    <li class="nav-item dropdown no-arrow">
      <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <i class="fas fa-user-circle fa-fw"></i>
      </a>
      <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
            <%
          if(userID == null){
          %>
            <a class="dropdown-item" href="loginpage.do">로그인</a>
            <a class="dropdown-item" href="registerpage.do">회원가입</a>
            <a class="dropdown-item" href="forgotpasswordpage.do">아이디/비밀번호 찾기</a>
            <%
				}else{
			%>
            <!-- 우선 삭제 안해놓을게 -->
            <a class="dropdown-item" href="changepassword.do" >비밀번호 변경</a>
            <a class="dropdown-item" href="logout.do" >로그아웃</a>
            <%
				}
			%>
          </div>
    </li>
  </ul>

</nav>

  <div class="container">
    <div class="card card-register mx-auto mt-5">
      <div class="card-header" style="text-align: center;">회원가입</div>
      <div class="card-body">
        <form name="wform" method="post" action="register.do">
          <div class="form-group">
            <div class="form-label-group">
              <input type="text" id="inputID" name="userID" class="form-control" placeholder="ID" required="required">
                <label for="inputID">아이디</label>
              </div>
            </div>
            <div class="form-group">
              <div class="form-row">
                <div class="col-md-6">
                  <div class="form-label-group">
                    <input type="password" id="inputPassword" name="userPassword" class="form-control" placeholder="Password" required="required">
                      <label for="inputPassword">비밀번호</label>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-label-group">
                      <input type="password" id="confirmPassword" name="userPasswordCheck" class="form-control" placeholder="Confirm password" required="required">
                        <label for="confirmPassword">비밀번호 확인</label>
                        
                      </div>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <div class="form-label-group">
                    <input type="text" id="inputName" name="userName" class="form-control" placeholder="Name" required="required">
                      <label for="inputName">이름</label>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="form-label-group">
                      <input type="email" id="inputEmail" name="userEmail" class="form-control" placeholder="Email address" required="required">
                        <label for="inputEmail">이메일 주소</label>
                      </div>
                    </div>
                    <input type="submit" class="btn btn-primary btn-block" value="가입하기">
                    </form>
                    <div class="text-center">
                      <a class="d-block small mt-3" href="loginpage.do" ">로그인 페이지</a>
                      <a class="d-block small" href="forgotpasswordpage.do">비밀번호를 잃어버리셨나요?</a>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Bootstrap core JavaScript-->
              <script src="vendor/jquery/jquery.min.js"></script>
              <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

              <!-- Core plugin JavaScript-->
              <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

            </body>

          </html>
