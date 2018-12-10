   <!-- Sticky Footer -->
<%if(session.getAttribute("userID")== null) {%>
	<style>
	#footer{
		width:100%;
	}
	</style>
<%} %>
        <footer id="footer" class="sticky-footer" style="width:100%">
          <div class="container my-auto">
            <div class="copyright text-center my-auto">
              <span>Copyright © Kyonggi Univ. Computer Science Web Service Project</span>
              <br>
              <span>Made by Kim Keon Wook, Kim Tae Hyung, Kim Ju Yong</span>
            </div>
          </div>
        </footer>

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fas fa-angle-up"></i>
    </a>
