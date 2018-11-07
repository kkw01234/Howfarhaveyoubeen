<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>로그인 페이지~~~</h1>
	<script src="js/default.js"></script>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/sha256.js"></script>
<script>
	function letsSubmit() {
		if($('#id').val() != '' && $('#password').val() != ''){
			doSha();
   		 	$('#login_form').submit();
		}
		else
			alert("빈 칸을 입력해주세요");
		}
	
	function doSha(){
		var forsha = $('#id').val() + $('#password').val();
        $('#password_hash').val(SHA256(forsha));
    
	}
</script>
<main>
    <div id="content">
        <div id="title">
            <div><a href="Index"><img src="img/logo.png" alt="" style="width: 300px; margin-bottom : 20px"></a></div>
        </div>
        <div id="information">로그인</div>
        <div>
            <div class="list">
                <div class="loginForm">
                    <form method="POST" action="login.do" id="login_form">
                        <div class="box">
                        	<input type="text" class="form-control" name="id" id="id" placeholder="아이디를 입력하세요." autofocus style="height : 50px;font-size:20px;" required>
                            <br>
                            <input type="submit" onclick="letsSubmit()" style="display:none">
                            <input type="password" class="form-control" name="password" id="password" placeholder="비밀번호를 입력하세요." style="height : 50px;font-size:20px;">
                            <input type="hidden" name="password_hash" id="password_hash" class="iText" value="VALUE_NOT_EMPTY">
                            <br>
                            <p>
                                <span id="wrong_password">초기 비밀번호는 생년월일(YYMMDD)입니다.</span>
                            </p>
                        </div>
                        <a href="#" class="loginBtn" onclick="letsSubmit()" style = "text-decoration: none;">
                            <div id="login_btn">
                            	   로그인
                            </div>
                        </a>
                        <a href="register.do" class="loginBtn" style = "text-decoration:none;">
                        	<div id="login_btn">
                        		회원가입
                        	</div>
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>
       		 <script>
                    	var panel = $('#wrong_password');
                    	var miss = 0;
                    	if(miss > 0){
                    		panel.text('잘못된 아이디, 혹은 비밀번호입니다 (' + miss + '회)');
                    		panel.css({'color' : 'red', 'font-weight' : 'bold', 'font-size' : '20px'});
                    	}
             </script>
</body>
</html>