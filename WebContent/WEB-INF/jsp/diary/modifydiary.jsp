<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String diaryread = (String) request.getAttribute("diaryread");
    String coordinates = (String) request.getAttribute("coordinates");
    String diaryid = (String) request.getAttribute("diaryid");
    %>
<!DOCTYPE html>
<html>

  <head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin - Blank Page</title>


    <link rel="stylesheet" href="css/bootstrap-table.css"/>
    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/ckeditor.js"></script>
 
  </head>

  <jsp:include page="../main/layout.jsp" flush="false"></jsp:include>
      <div id="content-wrapper">

        <div class="container-fluid">

          <!-- Page Content -->
          <div class="card mb-3">
            <div class="card-header">
                 다이어리 읽기</div>
               <div class="card-body">
                  <form>
                       <div class="row">
                             <div class="col-sm-2">
                              <label for="diaryTitle" class="text-center">제목 : </label>
                           </div>
                              <div class="col-sm-10">
                                 <input type="text" class="form-control" id="diaryTitle" />
                             </div>                        
                       </div>
                       <div class="row">
                          <div class="col-md-6">
                                <label for="user"> 이름 : </label>
                                 <input type="text" class="form-control" id="user" disabled/>
                                 <label for="date"> 날짜 : </label>
                                 <input type="date" class="form-control" id="date"/>
                             <label for="startpo"> 출발지 : </label>
                             <div class="row">
                                <div class="col-sm-9">
                                   <input type="text" class="form-control" id="start" disabled/>
                                </div>
                                <div id="startb" class="col-sm-3">
  										<button id="startbutton" type="button" class="btn btn-default" onclick="modifybutton('start')" >수정</button>
  								</div>
                             </div>
                             <label for="endpoint"> 도착지 : </label>
                             <div class="row">
                                <div class="col-sm-9">
                                   <input type="text" class="form-control" id="end" disabled/>
     	                          </div>
     	                          <div id="endb" class="col-sm-3">
  											<button id="endbutton" type="button" class="btn btn-default" onclick="modifybutton('end')">수정</button>
  									</div>
                               </div>
                          </div>
                          <div class="col-md-6">
                             <div class="col-md-6">
                                 <div id="googlemaps" style="width:300px;height:300px;overflow:auto;">
                                </div>
                             </div>
                          </div>
                       </div>
                       
                </form>
                <textarea name="content" id="editor" style="width:100%;height:400px"></textarea>
                <div class="text-right">
                <!-- 공개 비공개 라디오 버튼 -->
	    				<div class="btn-group" data-toggle="buttons">
						  <label class="btn btn-primary btn-sm ">
						    <input type="radio" name="shared" id="shared" autocomplete="off" value="true" checked > 공개
						  </label>
						  <label class="btn btn-primary btn-sm active">
						    <input type="radio" name="shared" id="shared" autocomplete="off" value="false" checked > 비공개
						  </label>
  						</div>
                   <button type="button" class ="btn btn-primary" onclick="modifyDiary()">수정</button>
                   <button type="button" class = "btn btn-default" id="back">뒤로</button><!--  -->
                </div>
               </div>
         </div>

        </div>
        <!-- /.container-fluid -->

        <!-- Sticky Footer -->
        <footer class="sticky-footer">
          <div class="container my-auto">
            <div class="copyright text-center my-auto">
              <span>Copyright Aⓒ Your Website 2018</span>
            </div>
          </div>
        </footer>

      </div>
      <!-- /.content-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">A?</span>
            </button>
          </div>
          <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
          <div class="modal-footer">
            <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
            <a class="btn btn-primary" href="login.html">Logout</a>
          </div>
        </div>
      </div>
    </div>
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
    $(document).ready(function() {
		   var diaryRead= <%=diaryread%>; //다이어리 디비 저장	
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
		
		$('#diaryTitle').val(diaryRead.diaryTitle); //제목출력
		$('#user').val(diaryRead.userID); //작성자 출력
		var date = $('#date');
		var data = diaryRead.diaryDate;
		$('#date').attr('value',formatDate2(data));
		
		$('#start').val(diaryRead.startPoint); //출발지 출력
		$('#end').val(diaryRead.endPoint); //도착지 출력
    });
    
    function getDataFromTheEditor(){//ckeditor 데이터 바당오기
 	   return theEditor.getData();
    }
	function modifyDiary(){//다이어리 수정
		
    	var obj = new Object();
    	obj.diaryID=<%=diaryid%>;
    	obj.diaryTitle=$('#diaryTitle').val();
	  	obj.user=$('#user').val();
	  	obj.date=$('#date').val();
		obj.shared=$('#radio input:radio:checked').val();
	  	obj.startpoint=$('#start').val();
	  	obj.endpoint=$('#end').val();	  
    	obj.content=getDataFromTheEditor();
    	if(obj.diaryTitle =='' || obj.user==''|| obj.date == '' || obj.startpoint == '' || obj.endpoint == '' ||obj.content == ''){
    		alert("모두 입력해 주세요!");
    		return;
    	}
    	if(markerloc[0] == null ||markerloc[1] == null || markerloc[0].lat() == '' ||markerloc[0].lng() == '' || markerloc[1].lat() == '' || markerloc[1].lng() == ''){
    	   	alert("모두 확인 버튼을 눌러주세요!");
    	   	return;
    	}
    	obj.startplat=markerloc[0].lat();
   	  	obj.startplng=markerloc[0].lng();
   		obj.endplat=markerloc[1].lat();
	  	obj.endplng=markerloc[1].lng();
    	var jsonobj=JSON.stringify(obj);
	    $.ajax({
	   		url : "ajaxdiary.do",
	   		type : "post",
	   		dataType : "json",
	   		data:{
	   			req : "modifydiary",
	   			data : jsonobj
	   		},
	   		success : function(data){
	   			alert(data);
	   			window.location.href="diaryreader.do?diaryID=<%=diaryid%>";//?userID=세션
	   		}
   		});
   }
    
    
  //구글 지도
 
  
  var map =null;
  var marker =null;
  var startp = null;
  var endp =null;
  var addrArr = [];
  var stopover = [];
  var markers = [];
  var markerloc = [];
  var coordinates = <%=coordinates%>;
  function startMap(){
  map = new google.maps.Map(document.getElementById('googlemaps'), {
 		zoom: 6,
  		center: {lat: Math.floor(coordinates[1].latitude), lng: Math.floor(coordinates[1].longitude)}
  })
  
  for(var i =0 ;i<coordinates.length;i++){
	  var coo = coordinates[i];
	  if(coo.point == "start"){
		  startp=coo.region;
		  addrArr[0]= startp;
		  markerloc[0] = new google.maps.LatLng(coo.latitude,coo.longitude);
		  addMarker(map,markerloc[0],"start",0);
	  }else if(coo.point == "end"){
		  endp=coo.region;
		  addrArr[1] = endp;
		  markerloc[1] = new google.maps.LatLng(coo.latitude,coo.longitude);
		  addMarker(map,markerloc[1],"end",1);
	  }else if(coo.point == "stopover"){
		  stopover.push(address);
		  addrArr.concat(stopover);
	  }	
	
  }
  }
  function citytopoint(point){
	  initMap(point);
  }
  function modifybutton(point){
	   console.log(point);
	   var pointer = "#"+point;
	   var pointerb = pointer+"b";
	   if(point =='start'){
		  markerloc[0] = null;
	   }else if(point == 'end'){
		   markerloc[1] = null;
	   }
	   $(pointer).attr("disabled",false);
 	   $(pointerb).html('<button id="'+point+'button" type="button" class="btn btn-primary" onclick="citytopoint(\''+point+'\')">확인</button>');
  }
  
  
  function initMap(point) {
 	 var ace;
     if(point == undefined){
	   		map = new google.maps.Map(document.getElementById('googlemaps'), {
       		zoom: 6,
        	center: {lat: 36.397, lng: 127.644}
      });
     } else {
     	  var pointer = "#"+point;
     	  var address = $(pointer).val();
     	  if(point == "start"){//출발지는 무조건 1번
     		  startp = address;
     		  addrArr[0] = startp;
     		  ace =0;
     	  }
     	  else if (point == "end"){//도착지는 무조건 2번
     		  endp = address;
     	  	  addrArr[1] = endp;
     	  		ace=1;
     	  }else if (point == "stopover"){//나중에 경유지 만약에 추가할경우 대비해서
     		  stopover.push(address);
     	  	  addrArr.concat(stopover);
     	  	  
     	  }
     		  
      	  var geocoder = new google.maps.Geocoder();
        			geocodeAddress(geocoder, map,point,ace);
        			
     	  };
     }
    

    function geocodeAddress(geocoder, resultsMap,point,ace) {
          		
      		geocoder.geocode({'address': addrArr[ace]}, function(results, status) {
        			if (status === 'OK') { //잘 맞게 돌아오면		
       				var loc = results[0].geometry.location;//lat(),lng();
       				var addr = results[0].formatted_address.split(" ");
       				
       				console.log(results[0].formatted_address);
       				resultsMap.setCenter(loc);          			
       				console.log("iterator : " + ace);
            			if (markers[ace]){
            				markerloc[ace]=loc;
            				markers[ace].setPosition(loc);
            				
            			}else{
            				markerloc[ace]=loc;
          					addMarker(resultsMap,loc,point,ace);
            			}
            			var pointer = "#"+point;
            			var button = "#"+point+"b";
            			var jbutton = point+"modifybutton";
            			$(pointer).val(addr);
            			$(pointer).attr("disabled",true);
            			$(button).html('<button id="'+jbutton+'" type="button" class="btn btn-default" onclick="modifybutton(\''+point+'\')">수정</button>');
        			} else { //Error 날때
          			alert('Geocode was not successful for the following reason: ' + status);
        			}
      		});
    		}
	function addMarker(resultsMap,loc,point,iterator){
   		console.log("AddMarker : "+iterator);
   		markers[iterator] = new google.maps.Marker({
				map: resultsMap,
				position: loc,
				title:point
		});
   	
   	}
	
   	function setMapOnAll(map){
   		for (var i = 0;i<markers.length;i++){
   			markers[i].setMap(map);
   		}
   	}
   	
   	function showMarkers() {
        setMapOnAll(map);
      }
   	
		function clearMarkers(){
			console.log(markers)
			setMapOnAll(null);
		}
    	</script>
    	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBvJ_OC7o2tQfl9tKh6H0nNQhU-GAoYp3c&callback=startMap" async defer></script>
  </body>
</html>
