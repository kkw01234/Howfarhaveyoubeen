﻿<!-- Sidebar -->
<% String index = (String) request.getAttribute("index"); %>

		<ul class="sidebar navbar-nav" id="sidebar">
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="pagesDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-fw fa-folder"></i> <span>여행 기록</span>
			</a>
				<div class="dropdown-menu" aria-labelledby="pagesDropdown">
					<a class="dropdown-item" href="imageuploadpage.do">항공권 인식</a> <a
						class="dropdown-item" href="diarywriter.do">항공권 없이 쓰기</a>
				</div></li>
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="pagesDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-fw fa-folder"></i> <span>나의 여행기</span>
			</a>
				<div class="dropdown-menu" aria-labelledby="pagesDropdown">
					<a class="dropdown-item" href="diarylist.do">리스트</a> <a
						class="dropdown-item" href="diarymaplist.do">지도</a>
				</div></li>
			<li class="nav-item"><a class="nav-link" href="shareddiarypage.do?seq=1"> <i
					class="fas fa-fw fa-chart-area"></i> <span>친구 여행기</span>
			</a></li>
		</ul>
		

<script>
	var index =<%=index%>;
	if(index == "index"){
		$("#sidebar").css("background-color","transparent");
	}else
		$('#sidebar').css("background-color","#343a40");

</script>