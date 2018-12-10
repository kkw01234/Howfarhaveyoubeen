<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String diarylist = (String) request.getAttribute("diarylist");
	String Allcoordinates = (String) request.getAttribute("Allcoordinates");
%>
<!DOCTYPE html>
<html lang="ko">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>DiaryListMap</title>
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
						<header class="major">
							<h2>다이어리 리스트</h2>
						</header>

						<!-- Table -->
						<section>
							<div>
								<button id="switch" style="float: right" type="button"
									class="btn btn-default">전환</button>

							</div>
							<br>
							<br>
							<!-- Page Content 수정파트 -->
							<div class="card mb-3">
								<div class="card-header">다이어리 리스트</div>
								<div class="card-body" style="height: 500px">
									<div class="row">
										<div id="googlemaps" class="col-md-8 col-sm-6"
											style="width: 100%; height: -webkit-fill-available; overflow: auto;">

										</div>
										<div class="col-md-4 col-sm-6" id="text"></div>
									</div>
								</div>
							</div>
						</section>
					</div>

					<!-- /.container-fluid -->
					<jsp:include page="../main/footer.jsp" flush="false"></jsp:include>
				</div>
			</div>
		</div>

		<script>
			function formatDate2(date) {//이코드 수정 필요할듯 싶습니다.
				var d = date.split(" ");
				var month = d[0].split("월")[0];
				var day = d[1].split(",")[0];
				var year = d[2];
				if (month.length < 2)
					month = '0' + month;
				if (day.length < 2)
					day = '0' + day;
				var newdate = year + "-" + month + "-" + day;
				return newdate;
			}

			var map = null;
			var Allcoordinates =
		<%=Allcoordinates%>
			;
			var diarylist =
		<%=diarylist%>
			;
			var markers = [];
			function initMap() {//구글맵 callback
				map = new google.maps.Map(
						document.getElementById('googlemaps'), {
							zoom : 4,
							center : {
								lat : 0.000,
								lng : 0.000
							}
						//오류났을경우 좌표
						});
				var markersloc = [];
				for (var i = 0; i < Allcoordinates.length; i++) { //회의내용 출발지-도착지에서 도착지만 띄우게??
					var coo = Allcoordinates[i];
					if (coo.point == "end") {
						var latlng = new google.maps.LatLng(coo.latitude,
								coo.longitude);
						addMarker(map, latlng, null, i);
					}
				}
			}

			function addMarker(resultsMap, loc, point, iterator) {//마커하나씩 추가
				markers[iterator] = new google.maps.Marker({
					map : resultsMap,
					position : loc
				});
				clickListener(iterator);
				resultsMap.setCenter(loc);
			}
			var b = null;
			function clickListener(iterator) {//clicklistener (수정필요)
				google.maps.event
						.addListener(
								markers[iterator],
								"click",
								function() {//클릭이벤트 발생시
									var diary = Allcoordinates[iterator].diaryID;
									for (var j = 0; j < diarylist.length; j++) {
										if (diary == diarylist[j].diaryID) {
											b = diarylist[j].diaryID;
											var a = '<div id="title"><h2> 제목 : '
													+ diarylist[j].diaryTitle
													+ '</h2></div>'; //제목설정
											a += '<div>날짜 : '
													+ formatDate2(diarylist[j].diaryDate)
													+ '</div>';
											a += '<div>지역 : '
													+ diarylist[j].endPoint
													+ '</div>';
											a += '내용 : <br><div>'
													+ diarylist[j].diaryContent
													+ '</div>';
											a += '<div class="text-right"><button id="modify" type="button" class ="btn btn-primary" onclick ="modify()">수정</button></div>'//내용설정
											$('#text').html(a);
										}
									}

								});
			}
			$('#modify').click(function() {//이게 왜 인식이 안되는지 모르겠음
				document.location.href = "diarymodifier.do?diaryID=" + b;
			})
			function modify() {//똑같은 코드
				document.location.href = "diarymodifier.do?diaryID=" + b;
			}
			$('#switch').click(function(){
		   		window.location.href="diarylist.do";
		   	})
		</script>

		<script
			src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBvJ_OC7o2tQfl9tKh6H0nNQhU-GAoYp3c&callback=initMap"
			async defer></script>
</body>

</html>
