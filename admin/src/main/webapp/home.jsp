<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%
	// Check login info
	String userName = null;
	Cookie[] cookies = request.getCookies();
	if(cookies !=null){
		for(Cookie cookie : cookies){
  		if(cookie.getName().equals("user")) userName = cookie.getValue();
		}
	}
	if(userName == null) response.sendRedirect("/index.jsp?initialURI=%2Fhome.jsp");
%>
<!DOCTYPE html>
<html>
  <head>
    <title>Trang chủ</title>
    <link rel="shortcut icon" type="image/x-icon"  href="/portal/favicon.ico" />
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="bootstrap/css/bootstrap-theme.css" />
    <link rel="stylesheet" href="css/slider.css" />
    <style>
        .mainContent {
            margin-top: 60px;
        }

    </style>
    <script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    <script src="js/jquery.bxslider.js"></script>
    <script type="text/javascript" src="js/cloneweb.js"></script>
  </head>
  <body>
    <div class="container">
    
      <nav role="navigation" class="navbar navbar-default navbar-inverse navbar-fixed-top">
				<div style="padding-top: 2px;" class="collapse navbar-collapse navbar-ex1-collapse">
					<ul style="margin-right: 20px;" class="nav navbar-nav navbar-right">
						<li><a><span class="glyphicon glyphicon-user"></span> <%=userName %></a></li>
						<li><a title='Đăng xuất' href="/logout"><span class="glyphicon glyphicon-off"></span></a></li>
					</ul>
				</div><!-- /.navbar-collapse -->
			</nav>
    
        <div class="mainContent">
        		<div id="msgError" style="display: none;" class="alert alert-danger"></div>
        		<div style="z-index:1000; position: fixed; top: 400px; left: 300px;">
	            <form id="mainForm" class="form-inline" role="form">
	              <div class="form-group input-group-lg">
	                <input type="text" class="form-control" id="domainName" name="domainName" placeholder="Nhập tên miền của bạn">
	              </div>
	              <button id="cloneWeb" type="button" class="btn btn-primary btn-lg">Tạo website mới</button>
	            </form>
	          </div>
            
            <ul class="bxslider">
						  <li><img src="background/slide1.jpg" /></li>
						  <li><img src="background/slide2.jpg" /></li>
						  <li><img src="background/slide3.jpg" /></li>
						  <li><img src="background/slide4.jpg" /></li>
						</ul>
        </div>
        
        <div id="controlPopup" class="modal fade" data-keyboard="false" data-backdrop="static">
				  <div class="modal-dialog">
				    <div class="modal-content">
					    <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				        <div id="msgSuccess" class="form-group">
				        	<h2><span class="label label-success">Website của bạn đã được khởi tạo thành công</span></h2>
				        </div>
				      </div>
				      <div class="modal-body text-center">
				        <a id="yourWebsite" href="#" target="_blank" class="btn btn-info btn-lg">Truy cập website của bạn</a>&nbsp;&nbsp;
				        <a id="yourAdminPage" href="#" target="_blank" class="btn btn-warning btn-lg">Truy cập trang quản trị</a>
				        <div style="margin-top: 15px; cursor: pointer;"><a data-dismiss="modal" aria-hidden="true">Về trang chủ</a></div>
				      </div>
				    </div><!-- /.modal-content -->
				  </div><!-- /.modal-dialog -->
				</div><!-- /.modal -->
    </div>
  </body>
</html>