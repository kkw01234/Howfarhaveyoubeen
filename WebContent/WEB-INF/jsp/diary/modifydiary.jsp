<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>

  <head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin - Blank Page</title>

    <!-- Bootstrap core CSS-->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Page level plugin CSS-->
    <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin.css" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap-table.css"/>
    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
 	<!-- Custom scripts for all pages-->
    <script src="js/sb-admin.min.js"></script>
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

  <body id="page-top">

    <nav class="navbar navbar-expand navbar-dark bg-dark static-top">

      <a class="navbar-brand mr-1" href="index.html">Start Bootstrap</a>

      <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
        <i class="fas fa-bars"></i>
      </button>

<!-- Navbar Search -->
      <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
        <div class="input-group">
          <input type="text" class="form-control" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
          <div class="input-group-append">
            <button class="btn btn-primary" type="button">
              <i class="fas fa-search"></i>
            </button>
          </div>
        </div>
      </form>

      <!-- Navbar -->
      <ul class="navbar-nav ml-auto ml-md-0">
        <li class="nav-item dropdown no-arrow mx-1">
          <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-bell fa-fw"></i>
            <span class="badge badge-danger">9+</span>
          </a>
          <div class="dropdown-menu dropdown-menu-right" aria-labelledby="alertsDropdown">
            <a class="dropdown-item" href="#">Action</a>
            <a class="dropdown-item" href="#">Another action</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#">Something else here</a>
          </div>
        </li>
        <li class="nav-item dropdown no-arrow mx-1">
          <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-envelope fa-fw"></i>
            <span class="badge badge-danger">7</span>
          </a>
          <div class="dropdown-menu dropdown-menu-right" aria-labelledby="messagesDropdown">
            <a class="dropdown-item" href="#">Action</a>
            <a class="dropdown-item" href="#">Another action</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#">Something else here</a>
          </div>
        </li>
        <li class="nav-item dropdown no-arrow">
          <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-user-circle fa-fw"></i>
          </a>
          <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
            <a class="dropdown-item" href="loginpage.do">로그인</a>
            <a class="dropdown-item" href="register.do">회원가입</a>
            <a class="dropdown-item" href="forgot-password.do">아이디/비밀번호 찾기</a>
            <div class="dropdown-divider"></div><!-- 우선 삭제 안해놓을게 -->
            <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">Logout</a>
          </div>
        </li>
      </ul>

    </nav>

    <div id="wrapper">

      <!-- Sidebar -->
      <ul class="sidebar navbar-nav">
        <li class="nav-item active">
          <a class="nav-link" href="Index">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Mainpage</span>
          </a>
        </li>
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-fw fa-folder"></i>
            <span>다이어리</span>
          </a>
          <div class="dropdown-menu" aria-labelledby="pagesDropdown">
            <h6 class="dropdown-header">다이어리 쓰기:</h6>
            <a class="dropdown-item" href="#">항공권 인식</a>
            <a class="dropdown-item" href="#">항공권 없이 쓰기</a>
            <div class="dropdown-divider"></div>
            <h6 class="dropdown-header">나의 여행 다이어리:</h6>
            <a class="dropdown-item" href="diarylist.do">리스트</a>
            <a class="dropdown-item" href="diarylist.do">지도</a>
          </div>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="charts.html">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>공유하기</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="tables.html">
            <i class="fas fa-fw fa-table"></i>
            <span>공유된 다이어리 보기(한번 테스트용)</span></a>
        </li>
         <li class="nav-item">
          <a class="nav-link" href="charts.html">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>차트예시(우선 놔둠)</span></a>
        </li>
         <li class="nav-item">
          <a class="nav-link" href="tables.html">
            <i class="fas fa-fw fa-table"></i>
            <span>테이블이용예시</span></a>
        </li>
      </ul>

      <div id="content-wrapper">

        <div class="container-fluid">

          <!-- Breadcrumbs-->
          <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <a href="#">Dashboard</a>
            </li>
            <li class="breadcrumb-item active">Overview</li>
          </ol>

        

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

    <!-- Modal 미완성 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

    
		
   
<script>
	
	$(document).ready(function(){
		$('#back').click(function(){
			parent.history.back();
			return false;
		})
	})
	
		
	
	var ckcontent = null;
   ClassicEditor.create(document.querySelector('#editor'),{//CKEditor 사용할 수 있게
	   ckfinder:{
		uploadUrl :"ckeditorupload.do"
	   },   		
   }).then( editor => {
		ckdata=editor.getData();
   }).catch (err =>{
	   console.error(err.stack);
   }
   );
 
   var markerloc = [];
   function uploadDiary(){//uploadDiary Ajax로 넘김
    	var obj = new Object();
    	obj.diaryTitle=$('#diaryTitle').val();
	  	obj.user=$('#user').val();
	  	obj.date=$('#date').val();
	  	obj.startpoint=$('#start').val();
	  	obj.startplat=markerloc[0].lat();
	  	obj.startplng=markerloc[0].lng();
	  	obj.endpoint=$('#end').val();
	  	obj.endplat=markerloc[1].lat();
	  	obj.endplng=markerloc[1].lng();
    	obj.content=ckdata;
    	if(obj.diaryTitle =='' || obj.user == '' || obj.date =='' || obj.startpoint==''||obj.endpoint ==''||obj.content == ''){
    		alert("모두 입력해주세요");
    	}
    	if(startplat ==''||startplng==''||endplat==''||endplng==''){
    		alert("정확한 주소가 입력되지 않았습니다.");
    	}
    	var jsonobj=JSON.stringify(obj);
	    $.ajax({
	   		url : "ajaxdiary.do",
	   		type : "post",
	   		data:{
	   			req : "writediary",
	   			data : jsonobj
	   		},
	   		success : function(data){
	   			alert(data);
	   			window.location.href="diaryreader.do";//?userID=세션
	   		}
   		});
   }
   
   
   
   
   	
   var map =null;
   var marker =null;
   var startp = null;
   var endp =null;
   var addrArr = [];
   var stopover = [];
   var markers = [];
  
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
           			showMarkers();
        	  };
        }
       

       function geocodeAddress(geocoder, resultsMap,point,ace) {
         	/*
          	if(markers.length != 0)
    	   		clearMarkers();
         	*/
         	//console.log(markers);
         	//console.log(addrArr);
         
         	//console.log("길이 : "+addrArr.length);     		
         		geocoder.geocode({'address': addrArr[ace]}, function(results, status) {
           			if (status === 'OK') { //잘 맞게 돌아오면		
          				console.log(results);
           				var loc = results[0].geometry.location;//lat(),lng();
          				var addr = results[0].formatted_address.split(" ");
          				
          				console.log(results[0].formatted_address);
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
