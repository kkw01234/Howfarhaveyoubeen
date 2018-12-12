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

  <title>How far have you been - Register</title>

  <!-- Bootstrap core CSS-->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <!-- Custom styles for this template-->
  <link href="css/sb-admin.min.css" rel="stylesheet">
  <link href="css/card.css" rel="stylesheet">
 <style>
.caution{
	font-size:12px;
	color:red;
	text-align:center;
}
.success{
	font-size:12px;
	color:#4dbce9;
	text-align:center;
}
 
 
 </style>
</head>
<%
	String userID = null;
	if(session.getAttribute("userID") != null)
		userID = (String) session.getAttribute("userID");
%>
<body class="bg-dark">

<nav class="navbar navbar-expand navbar-dark bg-dark static-top">

  <a class="navbar-brand mr-1" href="Index"><img src="image/weblogo_small.png"></img></a>

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

  <div class="container" id="container">
    <div class="card card-register mx-auto mt-5">
      <div class="card-header" style="text-align: center;">회원가입</div>
      <div class="card-body">
        <form id="form" name="wform" method="post" action="register.do" onsubmit="return check_on()">
          <div class="form-group">
            <div class="form-label-group">
              <input type="text" id="inputID" name="userID" class="form-control" placeholder="ID" required="required">
                <label for="inputID">아이디</label>
                 <div class="caution" id="notid"></div>
              </div>
            </div>
            <div class="form-group">
              <div class="form-row">
                <div class="col-md-6">
                  <div class="form-label-group">
                    <input type="password" id="inputPassword" name="userPassword" class="form-control" placeholder="Password" required="required">
                      <label for="inputPassword">비밀번호</label>
                       <div class="caution" id="notpassword"></div>
                       <div class="success" id="successpassword"></div>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-label-group">
                      <input type="password" id="confirmPassword" name="userPasswordCheck" class="form-control" placeholder="Confirm password" required="required">
                        <label for="confirmPassword">비밀번호 확인</label>
                        <div class="caution" id="notequal"></div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <div class="form-label-group">
                    <input type="text" id="inputName" name="userName" class="form-control" placeholder="Name" required="required">
                      <label for="inputName">이름</label>
                       <div class="caution" id="notname"></div>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="form-label-group">
                      <input type="email" id="inputEmail" name="userEmail" class="form-control" placeholder="Email address" required="required">
                        <label for="inputEmail">이메일 주소</label>
                        <div class="caution" id="notemail"></div>
                      </div>
                    </div>
                    <div class="caution">이메일 인증을 하시면 로그인 가능합니다.</div>
                    <input id="login" type="submit" class="btn btn-primary btn-block" value="가입하기">
                    
                    </form>
                    <div class="text-center">
                      <a class="d-block small mt-3" href="loginpage.do" ">로그인 페이지</a>
                      <a class="d-block small" href="forgotpasswordpage.do">비밀번호를 잃어버리셨나요?</a>
                    </div>
                  </div>
                </div>
              </div>
             <div id="aftercontainer">
	 				<div class="card card-login mx-auto mt-5" id="incard">
	 				</div>
			</div>

              <!-- Bootstrap core JavaScript-->
              <script src="vendor/jquery/jquery.min.js"></script>
              <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

              <!-- Core plugin JavaScript-->
              <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
				<script src="js/sendmail.js"></script>
				<script>
				$(document).ready(function(){
					$('#aftercontainer').hide();
					$("#incard").hide();
				})
				var checkedid= false;
				var checkedpassword = false;
				var checkedemail =false;
				function check_on(){
					var userID = $('#inputID').val();
					if(userID ==''){
						$('#inputID').focus();
						return false;
					}
					var password = $('#inputPassword').val();
					if(password ==''){
						$('#inputPassword').focus();
						
						return false;
					}
					var confirm = $('#confirmPassword').val();
					var name= $('#inputName').val();
					if(name ==''){
						$('#inputName').focus();
						return false;
					}
					var email = $('#inputEmail').val();
					if(email ==''){
						$('#inputEmail').focus();
						return false;
					}
					
					if( password=='' || confirm=='' || password != confirm){
						$('#confimPassword').focus();
						$('#notequal').html("비밀번호와 일치하지 않습니다.");
						return false;
					}
					if(checkedid && checkedpassword && checkedemail){
						var text = '';
						text+='<div class="text-center"><br><br>'+$('#inputEmail').val()+'로 메일을 보내고있습니다.<br> 잠시만 기다려주세요 <br> <span style="color:red;font-size:20px">완료시 로그인페이지로 이동됩니다.</span></div>';
						sendmail('#container','#incard',text);
						$('#aftercontainer').show();
						return true;
					}else{
						alert("다시 확인해 주세요");
						return false;
					}
				}
				$('#inputID').keyup(function(){
					$.ajax({
				   		url : "ajaxregister.do",
				   		type : "post",
				   		data:{
				   			req : "userID",
				   			data : $('#inputID').val()
				   		},
				   		success : function(data){
				   			$('#notid').html(data);
							if(data ==""){
								checkedid =true;
							}
			   		}});
				})
				$('#inputEmail').keyup(function(){
					$.ajax({
				   		url : "ajaxregister.do",
				   		type : "post",
				   		data:{
				   			req : "email",
				   			data : $('#inputEmail').val()
				   		},
				   		success : function(data){
				   			$('#notemail').html(data);
				   			if(data ==""){
								checkedemail =true;
							}
			   		}});
				})
				
				$('#inputPassword').keyup(function(){
					var getpw = RegExp("((?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()]).{8,})");
					var password = $('#inputPassword').val();
					if(!getpw.test(password)){
						$('#notpassword').html("비밀번호는 숫자, 영문, 특수기호를<br>포함한 8자 이상이여야 합니다.");
						$('#successpassword').html("");
					}else{
						$('#notpassword').html("");
						$('#successpassword').html("확인되었습니다.(비밀번호 확인을 입력해주세요)");
					}
				})
				$('#confirmPassword').keyup(function(){
					var pw = $('#inputPassword').val();
					if(pw == ''){
						$('#confimPassword').focus();
						$('#notequal').html("비밀번호부터 입력해주세요");
					}
					if(pw != $('#confirmPassword').val()){
						$('#notequal').html("비밀번호와 일치하지 않습니다.");
					}else{
						$('#notequal').html("");
						checkedpassword = true;
					}
				})
				
		
				</script>
            </body>

          </html>
