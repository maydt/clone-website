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
    	
    	$("#saveAll").click(function(){
    		var formData = new FormData();
    		var inputs = document.getElementsByName("decor");
    		if (inputs.length == 1) {
   				showError("danger", $("#msgError"), "Bạn chưa chọn file để upload.");
   	    	return false;
    		}
    		$.each(inputs, function(index, element) {
    			var file = element.files[0];
    			if (file) {
		    		formData.append("decor"+index, file);
    			}
    		});
    		ajaxUpload(formData);
			});
    	
			$("#illustration").delegate("input[name='decor']", "change", function() {
				var file = $(this).val();
				var ext = getFileExtension(file);
 	    	var regexImageFile = /^(gif|jpeg|jpg|png)$/i;
 	    	if(!regexImageFile.test(ext)) {
 	    		showError("danger", $("#msgError"), "Định dạng file không đúng.");
 	    		$("#saveAll").attr("disabled", true);
 	    	} else {
 	    		$("#msgError").hide();
 	    		$("#saveAll").attr("disabled", false);
					var trash = $(this).parent().next();
					trash.show();
					var container = $("#illustration");
					var html = '<div class="row form-group"><div class="col-md-9">';
					html += '<input type="file" class="fileHidden" onkeypress="return false;" name="decor"></div>';
					html += '<div class="col-md-3" style="display: none;"><a name="deleteImage" title="Thêm ảnh" class="btn btn-default btn-sm">';
					html += '<span class="glyphicon glyphicon-trash"></span></a></div></div>';
					container.append(html);
 	    	}
			});
			
			$("#illustration").delegate("a[name='deleteImage']", "click", function() {
				$(this).parent().parent().remove();
			});
    	
    });
    
    function uploadFile(objId){
    	var formData = new FormData();
    	
    	// Check if file is selected
    	var file = $("#"+objId).val();
    	if(file=='') {
				showError("danger", $("#msgError"), "Bạn chưa chọn file để upload.");
		    return false;
			}
    	var uploadFile = document.getElementById(objId).files[0];
    	
    	// Check extension of file is valid
    	var fileName = uploadFile.name ? uploadFile.name : uploadFile;
    	var ext = getFileExtension(fileName);
    	var regexImageFile = /^(gif|jpeg|jpg|png)$/i;
    	if(!regexImageFile.test(ext)) {
    		showError("danger", $("#msgError"), "Định dạng file không đúng.");
		    return false;
      }
    	
    	formData.append(objId, uploadFile);
    	ajaxUpload(formData);
    }
    
    function getFileExtension(fileName) {
   	  if(fileName != null && fileName != undefined) {
   	    return fileName.split('.').pop();
   	  }
   	}
    
    function ajaxUpload(formData){
    	$.ajax({
				url : "/upload",
				contentType : false,
				processData: false,
				data : formData,
				method : "POST"
			}).done(function(data) {
				if (data.length > 0) {
					showError("success", $("#msgError"), "File upload thành công.");
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
										<input type="file" class="fileHidden" id="logo" name="logo" />
									</div>
									<div class="col-md-4">
										<button id="saveLogo" type="button" class="btn btn-primary btn-sm">Upload</button>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label">Cập nhật ảnh Banner</label>
									<div class="col-md-5">
										<input type="file" class="fileHidden" id="banner" name="banner" />
									</div>
									<div class="col-md-4">
										<button id="saveBanner" type="button" class="btn btn-primary btn-sm">Upload</button>
									</div>
								</div>
							</div>
							<div class="form-horizontal" style="padding-top: 15px;">
								<div class="form-group">
									<label class="col-md-3 control-label">Cập nhật ảnh trang trí</label>
									<div id="illustration" class="col-md-5">
										<div class="row form-group">
											<div class="col-md-9">
												<input type="file" class="fileHidden" name="decor" />
											</div>
											<div class="col-md-3" style="display: none;">
												<a name="deleteImage" title="Xóa" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-trash"></span></a>
											</div>
										</div>
									</div>
									<div class="col-md-4" style="margin-top: 6px;">
										<button id="saveAll" type="button" class="btn btn-primary btn-sm">Upload</button>
									</div>
								</div>
							</div>
						</div>
						
						<div class="menuTab tab-content">
							
						</div>
						
						<div class="contactTab tab-content" style="display: none;">
							<div style="border-bottom: 1px solid #DDD; margin: 0px 50px" class="form-horizontal">
								<table class="table table-hover">
									<thead>
										<tr>
											<th>Thông tin liên hệ</th>
											<th>Thao tác</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td><strong>Hotline</strong>: 098723435456</td>
											<td><a name="deleteContact" title="Xóa" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-trash"></span></a></td>
										</tr>
										<tr>
											<td><strong>Điện thoại</strong>: 098723435456</td>
											<td><a name="deleteContact" title="Xóa" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-trash"></span></a></td>
										</tr>
									</tbody>
								</table>
							</div>
						
							<div class="form-horizontal" style="margin-top: 30px;">
								<div class="form-group">
									<label for="contactTitle" class="col-md-4 control-label">Tiêu đề</label>
									<div class="col-md-6">
										<input type="text" class="form-control" id="contactTitle" name="contactTitle" placeholder="Tiêu đề">
									</div>
								</div>
								<div class="form-group">
									<label for="contactContent" class="col-md-4 control-label">Nội dung</label>
									<div class="col-md-6">
										<input type="text" class="form-control" id="contactContent" name="contactContent" placeholder="Nội dung">
									</div>
								</div>
								<div class="form-group">
							    <div class="col-sm-offset-5">
							      <button type="button" class="btn btn-primary" id="addContact">Thêm liên hệ</button>
							    </div>
							  </div>
							</div>
						</div>
						
						<div class="videoTab tab-content">
						</div>
						
						<div class="newsTab tab-content">
						</div>
						
						<div class="footerTab tab-content" style="display: none;">
							<div style="border-bottom: 1px solid #DDD;" class="form-horizontal">
								<div class="text-center form-group">
									<label>Công ty LANDJSC</label>
									<p>Copyright © 2014. All rights reserved. Fax: 123456789 - Email: support@landjsc.com</p>
								</div>
							</div>
						
							<div class="form-horizontal" style="margin-top: 30px;">
								<div class="form-group">
									<label for="footerTitle" class="col-md-4 control-label">Tiêu đề</label>
									<div class="col-md-6">
										<input type="text" class="form-control" id="footerTitle" name="footerTitle" placeholder="Tiêu đề">
									</div>
								</div>
								<div class="form-group">
									<label for="footerContent" class="col-md-4 control-label">Nội dung</label>
									<div class="col-md-6">
										<textarea name="footerContent" id="footerContent" rows="3" class="form-control" placeholder="Nội dung"></textarea>
									</div>
								</div>
								<div class="form-group">
							    <div class="col-sm-offset-5">
							      <button type="button" class="btn btn-primary" id="editFooter">Thay footer</button>
							    </div>
							  </div>
							</div>
						</div>
					</div>
	
			</div>
		</div>
  </body>
</html>