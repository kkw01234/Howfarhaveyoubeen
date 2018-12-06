<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String start = (String) request.getAttribute("start");
	String end = (String) request.getAttribute("end");
	String ticket =(String) request.getAttribute("ticket");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OCR 인식중</title>
<!-- ocr 인식 코드 -->
<style>
.modal-dialog.modal-fullsize {
  width: 100%;
  height: 100%;
  max-width : 90%
}
.modal-content.modal-fullsize {
  width : auto;
  height: auto;
  min-height: 80%;
  border-radius: 0; 
}

</style>
</head>

<body id="page-top">
	<jsp:include page="../main/layout.jsp" flush="false"></jsp:include>
	<div id="wrapper">
		<jsp:include page="../main/sidebar.jsp" flush="false"></jsp:include>
		<div id="content-wrapper">
			<!-- Modal -->
			<div class="modal fade" id="locModal"
				role="dialog" labelledby="myLargeModalLabel">
				<div class="modal-dialog modal-fullsize" role="document">
					<!-- Modal content-->
					<div class="modal-content modal-fullsize">
						<div class="modal-header"><h3>항공권 인식 완료</h3></div>
						<div class="modal-body" id="locModalbody">
							<div class="row">

								<div class="col-md-6">
									<h3>맞는 도시 (공항)를 선택해 주세요</h3>
									<div id="start" class="form-group">
										<label for="startloc">출발지</label> <select class="form-control"
											id="startloc">
										</select>
									</div>
									<br>
									<div id="end" class="form-group">
										<label for="endloc">도착지</label> <select class="form-control"
											id="endloc">
										</select>
									</div>
								<div>
									모두 없을 경우는 아래 모두 없음을 클릭해주세요
								</div>
								<br><br><br><br><br><br><br><br><br><br>
								</div>
								<div class="col-md-6" id="googlemaps"></div>
							</div>
						</div>
						<div class="modal-footer">
								<form name="ocr" method="post" action="diarywriter.do">
									<div>
										<input type="hidden" id="jsonobj" name="data" />
										<input type="hidden" id="ticket" name="ticket"/>
										<button type="submit" class="btn btn-primary" id="write"
											onclick="ocrcomplete()">확인</button>
										<a href="diarywriter.do"><button type="button"
												class="btn btn-primary">모두 없음</button></a> <a
											href="imageuploadpage.do"><button type="button"
												class="btn btn-default" id="cancel">취소</button></a>
									</div>
								</form>
							</div>
					</div>
				</div>
			</div>
			<!-- Modal end -->
			<jsp:include page="../main/footer.jsp" flush="false"></jsp:include>
		</div>
	</div>
</body>
<script>
	var a = 0;
	var startArr = <%=start%>;
	var endArr = <%=end%>;
	var map = null;
	var objArr = [];
	var markers = [];


	function geocodeAddress(geocoder, location, state, a, st) {
		geocoder.geocode({
			'address' : location
		}, function(results, status) {
			if (status === 'OK') {
				var loc = results[0].geometry.location;
				var addr = results[0].formatted_address;
				state.append('<option>' + addr + '</option>');
				var obj = new Object();
				obj.loclat = loc.lat();
				obj.loclng = loc.lng();
				obj.addr = addr;
				objArr.push(obj);

				if (a == 0) {
					if (st == "start")
						addMarker(map, loc, addr, 0);
					else if (st == "end")
						addMarker(map, loc, addr, 1);
				}

			}
		});
	};
	function Location() {
		initMap();
		var geocoder = new google.maps.Geocoder();
		var start = $('#startloc');
		var end = $('#endloc');
		var a = 0;
		for (var i = 0; i < startArr.length; i++) {
			geocodeAddress(geocoder, startArr[i], start, a, "start");
			a = 1;
		}
		a = 0;
		for (var j = 0; j < endArr.length; j++) {
			geocodeAddress(geocoder, endArr[j], end, a, "end");
			a = 1;
		}

		$('#locModal').modal('show');
	}

	function initMap() {
		map = new google.maps.Map(document.getElementById('googlemaps'), {
			zoom : 6,
			center : {
				lat : 36.123,
				lng : 126.342
			}
		});

	}

	function addMarker(resultsMap, loc, point, iterator) {
		//console.log("AddMarker : "+iterator);
		markers[iterator] = new google.maps.Marker({
			map : resultsMap,
			position : loc,
			title : point
		});

	}

	function ocrcomplete() {
		var obj = new Object();
		obj.start = $('#startloc').val();
		obj.end = $('#endloc').val();

		for (var i = 0; i < objArr.length; i++) {
			if (obj.start == objArr[i].addr) {
				obj.startlat = objArr[i].loclat;
				obj.startlng = objArr[i].loclng;
			} else if (obj.end == objArr[i].addr) {
				obj.endlat = objArr[i].loclat;
				obj.endlng = objArr[i].loclng;
			}
		}
	
		var jsonobj = JSON.stringify(obj);
		$('#jsonobj').val(jsonobj);
		$('#ticket').val('<%=ticket%>');

	}

	$('#startloc').on(
			'change',
			function() {
				var state = $('#startloc option:selected').val();
				console.log(state);
				for (var i = 0; i < objArr.length; i++) {
					if (objArr[i].addr == state) {
						var markerloc = new google.maps.LatLng(
								objArr[i].loclat, objArr[i].loclng);
						map.setCenter(markerloc);
						if (markers[0]) {
							markers[0].setPosition(loc);
							markers[0].setTitle(objArr[i].addr);
						} else {
							addMarker(map, markerloc, objArr[i].addr, 0);
						}
					}
				}
			});

	$('#endloc').on(
			'change',
			function() {
				var state = $('#endloc option:selected').val();
				console.log(state);
				for (var i = 0; i < objArr.length; i++) {
					if (objArr[i].addr == state) {
						var markerloc = new google.maps.LatLng(
								objArr[i].loclat, objArr[i].loclng);
						map.setCenter(markerloc);
						if (markers[1]) {
							markers[1].setPosition(markerloc);
							markers[1].setTitle(objArr[i].addr);
						} else {
							addMarker(map, markerloc, objArr[i].addr, 1);
						}

					}
				}
			});

	$('#locModal').on('hide.bs.modal',function(){
		window.location.href="imageuploadpage.do";
	});
</script>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBvJ_OC7o2tQfl9tKh6H0nNQhU-GAoYp3c&callback=Location"
	async defer></script>
</html>
