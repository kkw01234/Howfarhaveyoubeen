<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String diaryread = (String) request.getAttribute("diaryread");
	String diaryid = (String) request.getAttribute("diaryID");
	String coordinates = (String) request.getAttribute("coordinates");
	String userID = (String) request.getAttribute("userID");
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

<title>SB Admin - Blank Page</title>

<link rel="stylesheet" href="css/bootstrap-table.css" />

<style>
	.td .tr
	{
		vertical-align: middle !important;
		max-width: inherit;
		
	}
	.table > tbody > tr> td:nth-child(1), .table > tbody > tr> td:nth-child(2) {
		vertical-align: middle ! important;
	}
</style>

</head>

<body id="page-top">
	<jsp:include page="../main/layout.jsp" flush="false"></jsp:include>
	<div id="wrapper">
		<jsp:include page="../main/sidebar.jsp" flush="false"></jsp:include>
		
		<div id="content-wrapper">
			<!-- 이미지 첨부랑 설명이 필요한 메인 페이지 -->
			<div class="container-fluid">
				<div id="main" class="wrapper style1">
					<div class="container">
						<br>
						<header class="major">
							<h2>다이어리 보기</h2>
							<p>자신의 다이어리일 경우 수정,삭제가 가능합니다.</p>
						</header>
						<br>
						<!-- Page Content -->
						<div class="card mb-3">
							<div class="row">
								<div class="col-md-6">

									<table class="table" style=" width: 100%; height: 316px;  vertical-align: middle">
										<tbody>
											<tr>
												<td>제목 :</td>
												<td id="diaryTitle">
											</tr>
											<tr>
												<td>이름 :</td>
												<td id="user">
											</tr>
											<tr>
												<td>날짜 :</td>
												<td id="date">
											</tr>
											<tr>
												<td>출발 :</td>
												<td id="startpoint">
											</tr>
											<tr>
												<td>도착 :</td>
												<td id="endpoint">
											</tr>
										</tbody>

									</table>
								</div>
								<div class="col-md-6" style="width: inherit;">
									<div id="googlemaps"
										style="width: inherit; height: 316px; padding: 0; overflow: auto;"></div>
								</div>
								</div>

								<textarea name="content" id="editor" ></textarea>
						</div>
						<br>
						<div class="text-right" style= float:right;'>
						<%
							if(userID.equals(session.getAttribute("userID"))){ 
						%>
							<button id="modify" type="button" class="btn btn-primary" >수정</button>
							<button id="delete" type="button" class="btn btn-danger" onclick="return delconfirm()">삭제</button>
						<%
							}
						%>
							<button id="back" type="button" class="btn btn-default" >뒤로</button>
						</div>
					</div>
				</div>
			</div>
			<br><br>
				<jsp:include page="../main/footer.jsp" flush="false"></jsp:include>
			</div>
			</div>
		
	

</body>

<script src="js/bootstrap.min.js"></script>
<script src="js/ckeditor.js"></script>
<script>
  $('#modify').click(function(){
	  	document.location.href = "diarymodifier.do?diaryID=<%=diaryid%>";
	  })
  $('#back').click(function(){
			location.href = 'javascript:history.go(-1);';
	})
</script>
<script>
	//여기 삭제 코드 추가했습니다ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ
	function delconfirm(){
		var message = confirm("정말로 삭제하시겠습니까?");
		if(message == true){
			document.location.href = "diarydelete.do?diaryID=<%=diaryid%>";
		}else
			return false;
	}
	
	

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

    function formatDate(date) {
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();
           hour = d.getHours();
           minute = d.getMinutes();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-') + ' ' + [hour, minute].join(':');
    }
    
    var theEditor = null;

    function getDataFromTheEditor(){//ckeditor 데이터 바당오기
 	   return theEditor.getData();
    }
    

    $(document).ready(function() {
    	ClassicEditor.create(document.querySelector('#editor'),{//CKEditor 사용할 수 있게
			   ckfinder:{
				uploadUrl :"ckeditorupload.do"
			   },
		   }).then( editor => {
			   	editor.setData(diaryRead.diaryContent);
				theEditor =editor;
		   }).catch (err =>{
			   console.error(err.stack);
		   }
		   );
    	
    	
    	var diaryRead= <%=diaryread%>; //다이어리 디비 저장
		$('#diaryTitle').append(diaryRead.diaryTitle); //제목출력
		$('#user').append(diaryRead.userID); //작성자 출력
		var date = $('#date');
		var data = diaryRead.diaryDate;

		$('#date').append(formatDate2(data));
		$('#startpoint').append(diaryRead.startPoint); //출발지 출력
		$('#endpoint').append(diaryRead.endPoint); //도착지 출력
		$('#editor').append(getDataFromTheEditor()); //내용 출력
		var session = <%=request.getSession().getAttribute("userID")%>
		if(diaryRead.userID.indexof(session)) 
			{
							var a = '<div class="text-right" style=' + 'display:inline; float:right;' + '><button id="modify" type="button" class="btn btn-primary" >수정</button>';
							a += '<button id="delete" type="button" class="btn btn-danger" onclick="return delconfirm()">삭제</button>';
							a += '<button id="back" type="button" class="btn btn-default" >뒤로</button></div>';
							
							$('#useronlybutton').html(a);
							if (diaryRead.share == true)
								$('input:radio[name="shared"]:radio[value=true]').prop('checked', true);
							else
								$('input:radio[name="shared"]:radio[value=false]').prop('checked', true);
			}
		});
</script>
<script>
	//구글 지도
	var map = null;
	var marker = null;
	var startp = null;
	var endp = null;
	var addrArr = [];
	var stopover = [];
	var markers = [];
	var markerloc = [];
	var coordinates =
<%=coordinates%>
	;
	console.log(coordinates[1].latitude);
	console.log(coordinates[1].longitude);
	function startMap() {
		map = new google.maps.Map(document.getElementById('googlemaps'), {
			zoom : 6,
			center : {
				lat : Math.floor(coordinates[1].latitude),
				lng : Math.floor(coordinates[1].longitude)
			}
		})

		for (var i = 0; i < coordinates.length; i++) {
			var coo = coordinates[i];
			if (coo.point == "start") {
				startp = coo.region;
				addrArr[0] = startp;
				markerloc[0] = new google.maps.LatLng(coo.latitude,
						coo.longitude);
				addMarker(map, markerloc[0], "start", 0);
			} else if (coo.point == "end") {
				endp = coo.region;
				addrArr[1] = endp;
				markerloc[1] = new google.maps.LatLng(coo.latitude,
						coo.longitude);
				addMarker(map, markerloc[1], "end", 1);
			} else if (coo.point == "stopover") {
				stopover.push(address);
				addrArr.concat(stopover);
			}

		}
	}
	
	function addMarker(resultsMap, loc, point, iterator) {
		console.log("AddMarker : " + iterator);
		markers[iterator] = new google.maps.Marker({
			map : resultsMap,
			position : loc,
			title : point
		});
	}
</script>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBvJ_OC7o2tQfl9tKh6H0nNQhU-GAoYp3c&callback=startMap"
	async defer></script>

</html>
