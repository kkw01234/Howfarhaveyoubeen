<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <% 
 	String userID = (String) request.getAttribute("userID");
 	String ticket = (String) request.getAttribute("ticket");
 	String ocrdata =(String) request.getAttribute("ocrdata");
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


    <script src="js/bootstrap.min.js"></script>
    <script src="js/ckeditor.js"></script>
	<style>
	#map{
		height:100%;
	}
	.ck-rounded-corners .ck.ck-editor__main>.ck-editor__editable, .ck.ck-editor__main>.ck-editor__editable.ck-rounded-corners{
		width : 100%;
		height : 400px
	}
	</style>
  </head>
	<body>
	<jsp:include page="../main/layout.jsp" flush="false"></jsp:include>

      <div id="content-wrapper">

        <div class="container-fluid">

          <!-- Page Content -->
          <div class="card mb-3">
            <div class="card-header">
              	다이어리 쓰기</div>
            	<div class="card-body">
						<form>
  							<div class="row">
  									<div class="col-sm-2">
										<label for="diaryTitle" class="text-center">제목 : </label>
									</div>
      								<div class="col-sm-10">
      									<input type="text" class="form-control" id="diaryTitle" placeholder="제목"/>
  									</div>								
  							</div>
  							<div class="row">
  								<div class="col-md-6">
  										<label for="user"> 이름 : </label>
     				 					<input type="text" class="form-control" id="user" placeholder="사용자"/>
     				 					<label for="date"> 날짜 : </label>
   										<input type="date" class="form-control" id="date"/>
  									<label for="start"> 출발지 : </label>
  									<div class="row">
  										<div class="col-sm-9">
  											<input type="text" class="form-control" id="start" placeholder="출발지"/>
  										</div>
  										<div id="startb" class="col-sm-3">
  											<button id="startbutton" type="button" class="btn btn-primary" onclick="citytopoint('start')">확인</button>
  										</div>
  									</div>
  									<label for="end"> 도착지 : </label>
  									<div class="row">
  										<div  class="col-sm-9">
  											<input type="text" class="form-control" id="end" placeholder="도착지"/>
  										</div>
  										<div id="endb" class="col-sm-3">
  											<button id="endbutton" type="button" class="btn btn-primary" onclick="citytopoint('end')">확인</button>
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
	    				<div class="btn-group" id="radio" data-toggle="buttons">
						  <label class="btn btn-primary btn-sm ">
						    <input type="radio" name="shared" id="shared" autocomplete="off" value="true" > 공개
						  </label>
						  <label class="btn btn-primary btn-sm active">
						    <input type="radio" name="shared" id="shared" autocomplete="off" checked value="false"  > 비공개
						  </label>
  						</div>
 						<button type="button" class ="btn btn-primary" onclick="uploadDiary()">확인</button>
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
              <span>Copyright © Your Website 2018</span>
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
              <span aria-hidden="true">×</span>
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
	var theEditor = null;
	var ticket = <%=ticket%>;
	var markerloc = [];
	var map =null;
	var ocrdata=<%=ocrdata%>;
	
	
  
   function getDataFromTheEditor(){//CKEDITOR 값
	   return theEditor.getData();
   }
   
  
   function uploadDiary(){//uploadDiary
		
    	var obj = new Object();
    	obj.diaryTitle=$('#diaryTitle').val();
	  	obj.user=$('#user').val();
	  	obj.date=$('#date').val();
	  	obj.shared=$('#radio input:radio:checked').val();
	  	obj.startpoint=$('#start').val();
	  	obj.endpoint=$('#end').val();	  
    	obj.content=getDataFromTheEditor();
    	if(obj.diaryTitle =='' || obj.shared == '' ||obj.user==''|| obj.date == '' || obj.startpoint == '' || obj.endpoint == '' ||obj.content == ''){
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
	   		data:{
	   			req : "writediary",
	   			data : jsonobj
	   		},
	   		success : function(data){
	   			var d = data;
	   			alert(d[0]);
	   			if(d[0] =="Success")
	   				window.location.href="diaryreader.do?diaryID="+data[1];//?userID=세션
	   		}
   		});
   }
   
   
   
   
   	
  
   var marker =null;
   var startp = null;
   var endp =null;
   var addrArr = [];
   var stopover = [];
   var markers = [];
	
   $(document).ready(function(){
		$('#back').click(function(){
			parent.history.back();
			return false;
		
		})
		var userID = "<%=userID%>";
	        $('#user').attr('value',userID);
	        $('#user').attr('readonly', true);
		 ClassicEditor.create(document.querySelector('#editor'),{//CKEditor 사용할 수 있게
			   ckfinder:{
				uploadUrl :"ckeditorupload.do"
			   },   		
		   }).then( editor => {
				if(ticket !=null)
			   		editor.setData('<img src="'+ticket.ticket+'"><br>');
			   theEditor=editor;
				
		   }).catch (err =>{
			   console.error(err.stack);
		   }
		   );
		 
		
	})
	
	function ocrcomplete(){
	   if(ocrdata !=null){
			$('#start').val(ocrdata.start);
			$('#end').val(ocrdata.end);
			$('#start').attr("disabled",true);
			$('#end').attr("disabled",true);
			$('#startb').html('<button id="startmodifybutton" type="button" class="btn btn-default" onclick="modifybutton(\'start\')">수정</button>');
			$('#endb').html('<button id="endmodifybutton" type="button" class="btn btn-default" onclick="modifybutton(\'end\')">수정</button>');
	        	markerloc[0]=new google.maps.LatLng(ocrdata.startlat,ocrdata.startlng);
				markerloc[1]=new google.maps.LatLng(ocrdata.endlat,ocrdata.endlng);
				addMarker(map,markerloc[0],"start",0);
				addMarker(map,markerloc[1],"end",1);
				map.setCenter(markerloc[1]);
		}
   }
   	function citytopoint(point){
   		initMap(point);
   	}
     function initMap(point) {
    	 var ace;
    	
        if(point == undefined){
  	   		map = new google.maps.Map(document.getElementById('googlemaps'), {
          	zoom: 6,
           	center: {lat: 36.397, lng: 127.644}
         });
  	   	 ocrcomplete();
        } else{
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
           			//showMarkers();
        	  };
        }
       

       function geocodeAddress(geocoder, resultsMap,point,ace) {
         		geocoder.geocode({'address': addrArr[ace]}, function(results, status) {
           			if (status === 'OK') { //잘 맞게 돌아오면		
          				var loc = results[0].geometry.location;//lat(),lng();
          				var addr = results[0].formatted_address; // 11.28 코드 수정
          				
          				console.log(addr);
          				resultsMap.setCenter(loc);          			
          				console.log("iterator : " + ace);
               			if (markers[ace]){
               				//console.log("setPosition");
               				markerloc[ace]=loc;
               				markers[ace].setPosition(loc);
               				
               			}else{
               				//console.log("addMarker");
               				markerloc[ace]=loc;
             				addMarker(resultsMap,loc,point,ace);
             				//$(pointer).attr("disabled",true);
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
     
       
       	function addMarker(resultsMap,loc,point,iterator){
       		console.log("AddMarker : "+iterator);
       		markers[iterator] = new google.maps.Marker({
					map: resultsMap,
					position: loc,
					title:point
			});
       		console.log(markers);
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
	
    <!-- Google Map -->
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyChJu-iy9Vs1uUj-hufEP9yT8j86KNViZI&callback=initMap" async defer></script>
  </body>

</html>
