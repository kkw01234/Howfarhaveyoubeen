<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String diaryread = (String) request.getAttribute("diaryread");
    String diaryid =(String) request.getAttribute("diaryID");
    String coordinates = (String) request.getAttribute("coordinates");
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
	
  </head>
  
	<body>
	<jsp:include page="../main/layout.jsp" flush="false"></jsp:include>
        <div class="container-fluid">

          <!-- Page Content -->
		<div class="card mb-3">
			<div class="card-header">다이어리 읽기</div>
			<div class="card-body">
				<form>
					<div class="row">
						<div class="col-sm-2">
							<label for="diaryTitle" class="text-center">제목 : </label>
						</div>
						<div class="col-sm-10">
							<div id="diaryTitle"></div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<label for="user"> 이름 : </label>
							<div id="user"></div>
							<label for="date"> 날짜 : </label>
							<div id="date"></div>
							<label for="startpoint"> 출발지 : </label>
							<div class="row">
								<div class="col-sm-9">
									<div id="startpoint"></div>
								</div>
							</div>
							<label for="endpoint"> 도착지 : </label>
							<div class="row">
								<div class="col-sm-9">
									<div id="endpoint"></div>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="col-md-6">
								<div id="googlemaps"
									style="width: 300px; height: 300px; overflow: auto;"></div>
							</div>
						</div>
					</div>

				</form>
				<div id="editor"></div>
				<div class="text-right" id="useronlybutton">
				
				
					<!--  -->
				</div>
			</div>
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
  </body>
  <script>
  $('#modify').click(function(){
	  	document.location.href = "diarymodifier.do?diaryID=<%=diaryid%>";
	  })
  $('#back').click(function(){
			location.href = 'javascript:history.go(-1);';
	})
  </script>
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
    
    $(document).ready(function() {
		var diaryRead= <%=diaryread%>; //다이어리 디비 저장
		$('#diaryTitle').append(diaryRead.diaryTitle); //제목출력
		$('#user').append(diaryRead.userID); //작성자 출력
		var date = $('#date');
		var data = diaryRead.diaryDate;
		
		//console.log(formatdate2(data));
		$('#date').append(formatDate2(data));
		
		//$('#date').val(diaryRead.userID); //날짜 안됨 슈밤
		$('#startpoint').append(diaryRead.startPoint); //출발지 출력
		$('#endpoint').append(diaryRead.endPoint); //도착지 출력
		$('#editor').append(diaryRead.diaryContent); //내용 출력
		if(diaryRead.userID == '<%=request.getSession().getAttribute("userID")%>'){
			var a ='<div id="radioshare" class="btn-group" data-toggle="buttons">';
			a+='<label class="btn btn-primary btn-sm "><input type="radio" name="shared" id="shared" autocomplete="off" value="true" checked disabled> 공개</label> <label class="btn btn-primary btn-sm active">';
			a+='<input type="radio" name="shared" id="shared" autocomplete="off" value="false" checked disabled> 비공개 </label>';
			a +='</div><button type="button" class="btn btn-primary" id="modify">수정</button><button type="button" class="btn btn-default" id="back">뒤로</button>';
			$('#useronlybutton').html(a);
			if(diaryRead.share == true)
				$('input:radio[name="shared"]:radio[value=true]').prop('checked',true);
			else
				$('input:radio[name="shared"]:radio[value=false]').prop('checked',true);
		}
		
    });
	
    

</script>
<script>
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
  console.log(coordinates[1].latitude);
  console.log(coordinates[1].longitude);
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
  function addMarker(resultsMap,loc,point,iterator){
 		console.log("AddMarker : "+iterator);
 		markers[iterator] = new google.maps.Marker({
				map: resultsMap,
				position: loc,
				title:point
		});
 		console.log(markers);
 	}
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBvJ_OC7o2tQfl9tKh6H0nNQhU-GAoYp3c&callback=startMap" async defer></script>

</html>
