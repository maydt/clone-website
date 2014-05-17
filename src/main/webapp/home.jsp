<%@page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Trang chủ</title>
    <link rel="shortcut icon" type="image/x-icon"  href="/portal/favicon.ico" />
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="bootstrap/css/bootstrap-theme.css" />
    <style>
        .mainContent {
            background: url("background/background.jpg") no-repeat scroll 0 0;
            background-position: center;
            width: 940px;
            height: 538px;
        }

    </style>
    <script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/cloneweb.js"></script>
  </head>
  <body>
    <div class="container">
        <div class="mainContent">
        		<div id="msgError" style="display: none;" class="alert alert-danger"></div>
            <form id="mainForm" class="form-inline" role="form">
              <div class="form-group input-group-lg">
                <input type="text" class="form-control" id="domainName" name="domainName" placeholder="Nhập tên miền của bạn">
              </div>
              <button id="cloneWeb" class="btn btn-primary btn-lg">Tạo website mới</button>
            </form>
        </div>
        
        <div id="controlPopup" class="modal fade" data-keyboard="false" data-backdrop="static">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-body text-center">
				      	<div id="msgSuccess" class="form-group"><h2><span class="label label-success">Website của bạn đã được khởi tạo thành công</span></h2></div>
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