<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String userlist = (String)request.getAttribute("userlist");
	%>
<!DOCTYPE html>
<html lang="ko">

<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>나의 여행 다이어리</title>


<link rel="stylesheet" href="css/bootstrap-table.css" />
<link href="css/boardtable.css" rel="stylesheet">
<link href="css/card.css" rel="stylesheet">
</head>
<body id="page-top">
	<jsp:include page="../main/layout.jsp" flush="false"></jsp:include>
	<div id="wrapper">
		<jsp:include page="../main/sidebar.jsp" flush="false"></jsp:include>
		<div id="content-wrapper">

			<div class="container-fluid">


				<!-- Page Content -->
				<div id="main" class="wrapper style1">
					<div class="container">
						<header class="major">
							<h2>가입된 계정 확인</h2>
							<p>최신 업로드된 다이어리 순으로 나열되어있습니다.</p>
							<div class="text-right">
								<a href="admindiary.do"><button type="button"
										class="btn btn-primary">다이어리 관리</button></a>
							</div>
						</header>

						<!-- Table -->
						<section>
							<br>

							<div id="maincontent" class="table-wrapper">
								<table class="boardtable" id="table" data-toggle="table"
									data-pagination="true" data-page-list="[10]" data-search="true">
									<thead>
										<tr class="table-style">
											<th data-field="id" data-sortabel="true">번호</th>
											<th data-field="userID" data-sortable="true">ID</th>
											<th data-field="userName" data-sortable="true">이름</th>
											<th data-field="userEmail" data-sortable="true">이메일</th>
											<th data-field="userEmailChecked" data-sortable="true">이메일 확인여부</th>
											<th data-field="emailCode" data-sortable="true">이메일 코드</th>
											<th data-field="deleteuser" data-sortable="true">삭제</th>
										</tr>
									</thead>
								</table>
							</div>
						</section>
					</div>

				</div>

				<jsp:include page="../main/footer.jsp" flush="false"></jsp:include>
			</div>
		</div>
	</div>
		<!-- /#wrapper -->

		


		<script src="js/bootstrap.min.js"></script>
		<script src="js/bootstrap-table.js"></script>
		<script src="js/bootstrap-table-cookie.js"></script>
	<script>
	
	function callSetupTableView(){
		$('#table').bootstrapTable('append',data());
		$('#table').bootstrapTable('refresh');
	}
	
	function data(){
		var userlist = <%=userlist%>;
		var rows = [];
		
		for(var i=0;i<userlist.length;i++){//아직 수정필요
				var value = userlist[i];
				
				rows.push({
					id : i+1,
					userID : value.userID,
					userName : value.userName,
					userEmail : value.userEmail,
					userEmailChecked :  value.userEmailChecked,
					emailCode : value.emailCode,
					deleteuser : '<a href="#" onclick="deleteuser(\''+value.userID+'\')">삭제</a>'
				});
		}
		return rows;
	}

	$(document).ready(function(){
        callSetupTableView();
     })
    
     function deleteuser(userID){
		$.ajax({
	   		url : "ajaxdiary.do",
	   		type : "post",
	   		data:{
	   			req : "deleteuser",
	   			user : userID
	   		},
	   		success : function(data){
	   			var d = data;
	   			if(d =="Success"){
		   			alert("계정 삭제 완료");
	   				window.location.href="adminuser.do";
	   			}
   		}});
	}
	
	
	</script>
</body>

</html>
