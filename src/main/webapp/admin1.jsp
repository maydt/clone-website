<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%
	
%>
<!DOCTYPE html>
<html>
  <head>
    <title>Quản trị</title>
    <link rel="shortcut icon" type="image/x-icon"  href="/portal/favicon.ico" />
    <link rel="stylesheet" href="/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="/bootstrap/css/bootstrap-theme.css" />
    <style>
    	.nav li a {
    		font-weight: bold;
    	}
    	.nav li a:hover {
    		cursor: pointer;
    		font-weight: bold;
    	}
    	.actionButton {
    		cursor: pointer;
    	}
    	.star {
		    color: #FE1010;
		    margin-left: 5px;
		    vertical-align: middle;
			}
			.mainContent {
				margin-top: 60px;
			}
    </style>
    <script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript">
    $(function(){
    	$("#navigation").delegate("li", "click", function(){
    		$("#navigation li").removeClass("active");
    		$(this).addClass("active");
    		$("div.tab-content").hide();
    		var id = $(this).attr("id");
    		$("div." + id).show();
    	});
    	
    	$("#saveLogo").click(function(){
    		uploadFile("logo");
			});
    	
    	$("#saveBanner").click(function(){
    		uploadFile("banner");
			});
    });
    
    function uploadFile(objId){
    	var formData = new FormData();
    	var file = $("#"+objId).val();
    	if(file=='') {
				showError("danger", $("#msgError"), "Bạn chưa chọn file để upload.");
		    return false;
			}
    	var uploadFile = document.getElementById(objId).files[0];
    	formData.append("file", uploadFile);
    	$.ajax({
				url : "/upload",
				contentType : false,
				processData: false,
				data : formData,
				method : "POST"
			}).done(function(data) {
				if (data.length > 0) {
					showError("success", $("#msgError"), "File "+data+" đã được upload.");
					setTimeout(function(){
						$("#msgError").fadeOut(3000);
				  },3000);
				} else {
					showError("danger", $("#msgError"), "Vấn đề xảy ra khi upload file, vui lòng thử lại sau.");
				}
			}).fail(function(jqxhr, textStatus, error) {
				showError("danger", $("#msgError"), "Vấn đề xảy ra khi upload file, vui lòng thử lại sau.");
			});
    }
    
    function showError(errorType, container, msg){
    	container.html(msg);
    	container.removeClass();
    	container.addClass("alert alert-" + errorType);
    	container.show();
    }
    </script>
  </head>
  <body>
  	<div class="container">
  	
	  	<nav role="navigation" class="navbar navbar-default navbar-inverse navbar-fixed-top">
				<div style="padding-top: 2px;" class="collapse navbar-collapse navbar-ex1-collapse">
					<ul style="margin-right: 20px;" class="nav navbar-nav navbar-right">
						<li><a><span class="glyphicon glyphicon-user"></span> Administrator</a></li>
						<li><a title='Đăng xuất' href="/logout"><span class="glyphicon glyphicon-off"></span></a></li>
					</ul>
				</div><!-- /.navbar-collapse -->
			</nav>
		
			<div class="mainContent">
	  	
		  		<input type="hidden" id="currentUser" name="currentUser" value="" />
			  	<ul class="nav nav-pills" id="navigation">
					  <li id="imageTab" class="active"><a>Quản lý ảnh</a></li>
					  <li id="menuTab"><a>Quản lý danh mục</a></li>
					  <li id="contactTab"><a>Quản lý thông tin liên hệ</a></li>
					  <li id="videoTab"><a>Quản lý video</a></li>
					  <li id="newsTab"><a>Quản lý tin tức</a></li>
					  <li id="footerTab"><a>Quản lý footer</a></li>
					</ul>
		
					<div class="container panel panel-default">
						<div id="msgError" style="display:none"></div>
						<div class="imageTab tab-content">
							<div style="border-bottom: 1px solid #DDD;" class="form-horizontal">
								<div class="form-group">
									<label class="col-md-3 control-label">Cập nhật ảnh Logo</label>
									<div class="col-md-5">
										<input type="file" class="fileHidden" onkeypress="return false;" id="logo" name="logo">
									</div>
									<div class="col-md-4">
										<button id="saveLogo" type="button" class="btn btn-primary btn-sm">Upload</button>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label">Cập nhật ảnh Banner</label>
									<div class="col-md-5">
										<input type="file" class="fileHidden" onkeypress="return false;" id="banner" name="banner">
									</div>
									<div class="col-md-4">
										<button id="saveBanner" type="button" class="btn btn-primary btn-sm">Upload</button>
									</div>
								</div>
							</div>
							<div class="form-horizontal" style="padding-top: 15px;">
								<div class="form-group">
									<label class="col-md-3 control-label">Cập nhật ảnh trang trí</label>
									<div class="col-md-5">
										<div class="row form-group">
											<div class="col-md-5">
												<input type="file" class="fileHidden" onkeypress="return false;" name="decor">
											</div>
											<div class="col-md-5">
												<input type="file" class="fileHidden" onkeypress="return false;" name="decor">
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<button id="saveAll" type="button" class="btn btn-primary btn-sm">Upload</button>
									</div>
								</div>
							</div>
						</div>
						
						<div class="menuTab tab-content">
							
						</div>
						<div class="contactTab tab-content">
						</div>
						<div class="videoTab tab-content">
						</div>
						<div class="newsTab tab-content">
						</div>
						<div class="footerTab tab-content">
						</div>
					</div>
	
			</div>
		</div>
  </body>
</html>