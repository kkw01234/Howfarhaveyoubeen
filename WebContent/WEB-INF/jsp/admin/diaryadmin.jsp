<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String diarylist = (String) request.getAttribute("diarylist");
    
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
							<h2>관리자용 여행 다이어리</h2>
							<p>최신 업로드된 다이어리 순으로 나열되어있습니다.</p>
							<div class="text-right">
								<a href="adminuser.do"><button type="button"
										class="btn btn-primary">계정 확인</button></a>
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
											<th data-field="diaryTitle" data-sortable="true">제목</th>
											<th data-field="diaryDate" data-sortable="true">작성일</th>
											<th data-field="startPoint" data-sortable="true">출발지역</th>
											<th data-field="endPoint" data-sortable="true">여행지역</th>
											<th data-field="userID" data-sortable="true">작성자</th>
											<th data-field="readCount" data-sortable="true">조회수</th>
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
function formatDate2(date){
	var d = date.split(" ");
	var month = d[0].split("월")[0];//이코드 수정 필요할듯 싶습니다.
	var day = d[1].split(",")[0];
	var year = d[2];
	if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;
	var newdate = year+"-"+month+"-"+day;
	return newdate;
}
	
	function callSetupTableView(){
		$('#table').bootstrapTable('append',data());
		$('#table').bootstrapTable('refresh');
	}
	
	function data(){
		var diarylist= <%=diarylist%>;
		var rows = [];
		for(var i=0;i<diarylist.length;i++){//아직 수정필요
				var value = diarylist[i];
				var startpoint = value.startPoint;
				var endpoint = value.endPoint;
				var a='',b='';
				var hit = value.readCount;
				var ID = value.userID;
				if(startpoint.length >15){
					a +="...";
					for(var j=startpoint.length-13;j<startpoint.length;j++){
						a+=startpoint[j];
					}
				}else
					a=value.startPoint;
				if(endpoint.length >15){
					b +="...";
					for(var j=endpoint.length-13;j<endpoint.length;j++){
						b+=endpoint[j];
					}
				}else
					b=value.endPoint;
				rows.push({
					id : i+1,
					diaryTitle : '<a href="diaryreader.do?diaryID='+value.diaryID+'">'+value.diaryTitle+'</a>',
					diaryDate : formatDate2(value.diaryDate),
					startPoint : '<a title="'+value.startPoint+'">'+a+'</a>',
					endPoint :  '<a title="'+value.endPoint+'">'+b+'</a>',
					userID : ID,
					readCount : hit
					
				});
		}
		return rows;
	}

	$(document).ready(function(){
        callSetupTableView();
     })
    
	</script>
</body>

</html>
