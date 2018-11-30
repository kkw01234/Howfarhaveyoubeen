<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String startArray = (String) request.getAttribute("startArray");
	String endArray = (String) request.getAttribute("endArray");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OCR 인식중</title><!-- ocr 인식 코드 -->

</head>

<body>
	<jsp:include page="../main/layout.jsp" flush="false"></jsp:include>
	<!-- 3개정도 값 받아와서 제일 괜찮은거?  -->
	<!-- 잠시만 기다려주세요 하고 다되면 모달띄워서 이 도시 (공항)이 맞습니까??? 맞으면 바로 넘긴다!!!-->
	<!-- 아닐 경우 ping을 찍어서 선택 후 그 주소 받아서  writediary.jsp로 넘긴다 -->
	<div class="text-center">
		<img src="image/Loading.gif"></img>
		<p>wait please...</p>
	</div>
	<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="locModal" role="dialog" labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" style="max-width:80%">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
      	항공권 인식 완료
        </div>
        <div class="modal-body" id = "locModalbody">
        <div class="row">
        	
        	<div class="col-md-6">
        		<h3> 맞는 도시 (공항)를 선택해 주세요</h3>
        		<div id="start" class="form-group">
         			<label for="startloc">출발지</label>
         			<select class="form-control" id="startloc">
         			</select>
        		</div>
        		<div id="end" class="form-group">
        			<label for="endloc">도착지</label>
        			<select class="form-control" id="endloc">
        			</select>
        		</div>
        	</div>
        
        	<div class="col-md-6" id="googlemaps">
        	</div>
        </div>
        
        <div class="modal-footer">
        	<form name="ocr" method="post" action="diarywriter.do">
        	<div>
        		<input type="hidden" id="jsonobj" name="data"/>
        		
        		<button type="submit" class="btn btn-primary" id="write" onclick="ocrcomplete()">확인</button>
        		<a href="diarywriter.do"><button type="button" class="btn btn-primary">모두 없음</button></a>
        		<a href="imageuploadpage.do"><button type="button" class="btn btn-default" id="cancel">취소</button></a>
        	</div>
        		</form>
        </div>
      </div>
    </div>
  </div>
  </div>
</body>
<script>
	var a = 0;
	var startArr = []; 
	var endArr = [];
	var map =null;
	var objArr = [];
	var markers = [];
	function ocrload(){
		$.ajax({
			url : "ajaxdiary.do",
			async : false,
			dataType : "json",
			type : "post",
			data : {
				req : "ocrloading"
			},
			success : function(data){
				var d = data;
				for(var i = 0;i<d.length;i++){
					if(d[i].start != null){
						startArr.push(d[i].start);
					}else if(d[i].end != null){
						endArr.push(d[i].end);
					}
				}
				
			}
		});
	}
	
	
	function geocodeAddress(geocoder,location,state,a,st){
		geocoder.geocode({'address':location}, function(results, status){
			if(status === 'OK'){	
				var loc = results[0].geometry.location;
				var addr = results[0].formatted_address;
				state.append('<option>'+addr+'</option>');
				var obj = new Object();
				obj.loclat=loc.lat();
				obj.loclng=loc.lng();
				obj.addr=addr;
				objArr.push(obj);
				
				
				if(a==0){
					if(st=="start")
						addMarker(map,loc,addr,0);
					else if(st=="end")
						addMarker(map,loc,addr,1);
				}
				
			}
		});
	};
	function Location(){
		ocrload();
		initMap();
		var geocoder = new google.maps.Geocoder();
		var start =$('#startloc');
		var end = $('#endloc');
		var a=0;
		for(var i=0;i<startArr.length;i++){
			geocodeAddress(geocoder,startArr[i],start,a,"start");
			a=1;
		}
		a=0;
		for(var j=0;j<endArr.length;j++){
			geocodeAddress(geocoder,endArr[j],end,a,"end");
			a=1;
		}
		
		$('#locModal').modal('show');
	}
	
	
	
	function initMap(){
		map = new google.maps.Map(document.getElementById('googlemaps'),{
			zoom : 6,
			center : {lat : 36.123, lng : 126.342}
		});
		
	}
	
	function addMarker(resultsMap,loc,point,iterator){
   		//console.log("AddMarker : "+iterator);
   		markers[iterator] = new google.maps.Marker({
				map: resultsMap,
				position: loc,
				title : point
		});
   		
   	}
	
	function ocrcomplete(){
		var obj = new Object();
		obj.start = $('#startloc').val();
		obj.end = $('#endloc').val();
		
		for(var i=0;i<objArr.length;i++){
			if(obj.start == objArr[i].addr){
				obj.startlat=objArr[i].loclat;
				obj.startlng=objArr[i].loclng;
			}else if(obj.end ==objArr[i].addr){
				obj.endlat=objArr[i].loclat;
				obj.endlng=objArr[i].loclng;
			}
		}
		var jsonobj = JSON.stringify(obj);
		$('#jsonobj').val(jsonobj);
		
	}
	
	$('#startloc').on('change',function(){
		var state = $('#startloc option:selected').val();
		console.log(state);
		for(var i=0;i<objArr.length;i++){
			if(objArr[i].addr == state){
				var markerloc= new google.maps.LatLng(objArr[i].loclat,objArr[i].loclng);
				map.setCenter(markerloc);   
				if(markers[0]){
					markers[0].setPosition(loc);
					markers[0].setTitle(objArr[i].addr);
				}else{
					addMarker(map,markerloc,objArr[i].addr,0);
				}
			}
		}
	});
	
	$('#endloc').on('change',function(){
		var state = $('#endloc option:selected').val();
		console.log(state);
		for(var i=0;i<objArr.length;i++){
			 if(objArr[i].addr == state){
				var markerloc= new google.maps.LatLng(objArr[i].loclat,objArr[i].loclng);
				map.setCenter(markerloc);   
				if(markers[1]){
					markers[1].setPosition(markerloc);
					markers[1].setTitle(objArr[i].addr);
				}else{
					addMarker(map,markerloc,objArr[i].addr,1);
				}
					
			}
		}
	});
	
	
	
	
	
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBvJ_OC7o2tQfl9tKh6H0nNQhU-GAoYp3c&callback=Location" async defer></script>
</html>