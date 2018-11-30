<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String diarylist = (String) request.getAttribute("diarylist");
	%>
<!DOCTYPE html>
<html lang="ko">

  <head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin - Blank Page</title>

    <link rel="stylesheet" href="css/bootstrap-table.css"/>

    
 
    
    
	
	<style>
	.filebox label {
	    display: inline-block;
	    padding: .5em .75em;
	    color: #999;
	    font-size: inherit;
	    line-height: normal;
	    vertical-align: middle;
	    background-color: #fdfdfd;
	    cursor: pointer;
	    border: 1px solid #ebebeb;
	    border-bottom-color: #e2e2e2;
	    border-radius: .25em;
	    width:100%;
	    max-width:100%;
	}
 
	.filebox input[type="file"] {  /* 파일 필드 숨기기 */
	    position: absolute;
	    width: 1px;
	    height: 1px;
	    padding: 0;
	    margin: -1px;
	    overflow: hidden;
	    clip:rect(0,0,0,0);
	    border: 0;
	}
</style>

  </head>
	<body>
	<jsp:include page="../main/layout.jsp" flush="false"></jsp:include>

      <div id="content-wrapper">
        <div class="container-fluid">
        <br>
         <!-- Page Content -->
          <div id="main" class="wrapper style1">
				<div class="container">
					<header class="major">
							<h2>항공권 인식</h2>
							<p>아래의 업로드 버튼을 클릭하여 항공권을 인식해주세요.</p>
					</header>
					
				<section>
				
					<form name="form" id="form" action="imageupload.do" method="post" enctype="multipart/form-data" autocomplete="off">
 					   <div class="filebox" >
      				  <label for="cma_file">사진 인증샷 업로드</label>
    				    <input type="file" name="imagefile" id="cma_file" accept="image/*" capture="camera" onchange="getThumbnailPrivew(this,$('#cma_image'))" />
     				    <button id="submit1" type="submit" class="btn btn-primary">인식</button>
    			  
    			    <br /><br />
   				      
   				      <div id="cma_image" style="width:100%;max-width:100%;height:auto; object-fit: contain; border:1px solid #000;display:none;"></div>
   						
  					  </div>
					</form>				
				</section>
				</div>
        </div>
       
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
	<!-- Custom scripts for all pages-->
    <script src="js/bootstrap.min.js"></script>
    <script>
	var image=null;
	function getThumbnailPrivew(html, $target) {
	    if (html.files && html.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $target.css('display', '');
	            //$target.css('background-image', 'url(\"' + e.target.result + '\")'); // 배경으로 지정시
	            $target.html('<img src="' + e.target.result + '" border="0" alt=""style="max-width:inherit" />');
	        	image = e.target.result;
	        }
	        reader.readAsDataURL(html.files[0]);
	    }
	}
	
	$('#submit1').click(function(){
		//console.log(image);
		if(image == null){
			alert("사진을 업로드 해주세요!!!!");

		}
	})
	</script>

   
  </body>

</html>
