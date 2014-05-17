<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.web.bds.model.User"%>
<%@ page import="com.web.bds.model.UserManage"%>
<%@ page import="java.util.List"%>
<%
	UserManage userManage = new UserManage();
	List<User> results = userManage.getAllUsers();
	String usersHtml = "";
	if (results.size() > 0) {
		for (User user : results){
			usersHtml += "<tr id='" + user.getUsername() +"'><td>" + user.getUsername() + "</td>";
			usersHtml += "<td>" + user.getFullname() + "</td>";
			usersHtml += "<td>" + user.getBirthday() + "</td>";
			usersHtml += "<td>" + user.getEmail() + "</td>";
			usersHtml += "<td>" + user.getPhone() + "</td>";
			usersHtml += "<td>" + user.getCreatedDate() + "</td>";
			usersHtml += "<td></td>"; // Website
			usersHtml += "<td><a title='Cập nhật' class='actionButton'><span class='glyphicon glyphicon-edit'></span></a>&nbsp;&nbsp;";
			usersHtml += "<a title='Đổi mật khẩu' class='actionButton resetPassword'><span class='glyphicon glyphicon-lock'></span></a>&nbsp;&nbsp;";
			usersHtml += "<a title='Xóa' class='actionButton'><span class='glyphicon glyphicon-trash'></span></a>";
			usersHtml += "</td></tr>";
		}
	}
%>
<!DOCTYPE html>
<html>
  <head>
    <title>Quản trị</title>
    <link rel="shortcut icon" type="image/x-icon"  href="/portal/favicon.ico" />
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="bootstrap/css/bootstrap-theme.css" />
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
    </style>
    <script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript">
    	$(function(){
    		$("#navigation").delegate("li", "click", function(){
    			$("#navigation li").removeClass("active");
    			$(this).addClass("active");
    			$("div.tab-content").hide();
    			var id = $(this).attr("id");
    			$("div." + id).show();
    		});

    		$(".userlist").delegate(".resetPassword", "click", function(){
    			var currentUser = $(this).parent().parent().attr("id");
    			$("#currentUser").val(currentUser);
    			$("#resetPassword").modal("show");
    		});

    		$("#savePassword").click(function() {
    			$("#msgModal").hide();
    			var newPassword = $.trim($("#newPassword").val());
    			var confirmPassword = $.trim($("#renewPassword").val());
    			if (newPassword != confirmPassword) {
    				showError("danger", $("#msgModal"), "Xác nhận mật khẩu chưa đúng.");
    			} else {
    				// TODO submit to reset password
    			}
    		});
    		
    		$("#addUser").click(function(){
    			$("#addUserForm").submit(function(event) {
       			if (event.preventDefault) event.preventDefault();
       		});
    			
    			var username = $("#username").val();
    			var password = $("#password").val();
    			if ((username.length == 0) || (password.length == 0)) {
    				showError("danger", $("#msgForm"), "Tên truy cập và mật khẩu là bắt buộc.");
    				if (password.length == 0) $("#password").focus();
    				if (username.length == 0) $("#username").focus();
    				return false;
    			}
    			
    			var regex = /^[\w-_\.]+$/;
    			if (!regex.test(username)) {
       			showError("danger", $("#msgForm"), "Tên truy cập chỉ được chứa các ký tự chữ cái, chữ số, gạch ngang, gạch dưới và dấu chấm.");
       			return false;
       		}
    			
    			$(this).attr("disabled", true);
    			
    			var serializedData = $("#addUserForm").serialize();
        		
       		$.ajax({
       			url: "/admin",
       			dataType: "text",
       			contentType: "application/x-www-form-urlencoded",
       			data: serializedData,
       			type: "POST"
       		})
       		.success(function (data) {
       			if (data.indexOf("true") != -1) {
       				$("#controlPopup").modal("show");
       				$("#yourWebsite").attr("href", "/" + domainName);
       				$("#yourAdminPage").attr("href", "/" + domainName + "/admin");
       			} else {
       				showError("danger", $("#msgForm"), data);
       			}
           	$("#addUser").attr("disabled", false);
       		})
       		.error(function (jqXHR, textStatus, error) {
       			var err = textStatus + ', ' + error;
       			console.log("Transaction Failed: " + err);
       			showError("danger", $("#msgForm"), "Không thể tạo người dùng tại thời điểm này, vui lòng thử lại sau.");
         		$("#addUser").attr("disabled", false);
       		});
    		});
    	});

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
  		<input type="hidden" id="currentUser" name="currentUser" value="" />
	  	<ul class="nav nav-pills" id="navigation">
		  <li id="userlist" class="active"><a>Danh sách người dùng</a></li>
		  <li id="addUserForm"><a>Thêm người dùng</a></li>
		</ul>

		<div class="container panel panel-default">
			<div class="userlist tab-content">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>Tên truy cập</th>
							<th>Họ và tên</th>
							<th>Ngày sinh</th>
							<th>Email</th>
							<th>Điện thoại</th>
							<th>Ngày tạo</th>
							<th>Website</th>
							<th>Thao tác</th>
						</tr>
					</thead>
					<tbody>
						<%=usersHtml %>
					</tbody>
				</table>
			</div>


			<div class="addUserForm tab-content" style="display: none; width: 90%">
				<form class="form-horizontal" id="addUserForm" role="form">
					<div id="msgForm" style="display:none"></div>
				  <div class="form-group">
				    <label for="username" class="col-sm-2 control-label">Tên truy cập</label>
				    <div class="col-sm-5">
				      <input type="text" class="form-control" id="username" name="username" placeholder="Tên truy cập">
				      <span class="star">*</span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="password" class="col-sm-2 control-label">Mật khẩu</label>
				    <div class="col-sm-5">
				      <input type="password" class="form-control" id="password" name="password" placeholder="Mật khẩu">
				      <span class="star">*</span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="fullname" class="col-sm-2 control-label">Họ và tên</label>
				    <div class="col-sm-9">
				      <input type="text" class="form-control" id="fullname" name="fullname" placeholder="Họ và tên">
				    </div>
				  </div>
				  <div class="form-group">
				  	<label class="col-sm-2 control-label">Giới tính</label>
				    <div class="col-sm-9">
				      <select id="gender" name="gender">
							  <option value="male">Nam</option>
							  <option value="female">Nữ</option>
							</select>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="birthday" class="col-sm-2 control-label">Ngày sinh</label>
				    <div class="col-sm-9">
				      <input type="text" class="form-control" id="birthday" name="birthday" placeholder="Ngày sinh">
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="email" class="col-sm-2 control-label">Email</label>
				    <div class="col-sm-9">
				      <input type="email" class="form-control" id="email" name="email" placeholder="Email">
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="phone" class="col-sm-2 control-label">Điện thoại</label>
				    <div class="col-sm-9">
				      <input type="text" class="form-control" id="phone" name="phone"  placeholder="Điện thoại">
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="address" class="col-sm-2 control-label">Địa chỉ</label>
				    <div class="col-sm-9">
				      <input type="text" class="form-control" id="address" name="address" placeholder="Địa chỉ">
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="col-sm-offset-2 col-sm-9">
				      <button type="submit" class="btn btn-primary" id="addUser">Thêm</button>
				    </div>
				  </div>
				</form>

			</div>
		</div>

		<div id="resetPassword" class="modal fade">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		        <h4 class="modal-title">Đổi mật khẩu</h4>
		      </div>
		      <div class="modal-body">
		      	<div id="msgModal" style="display: none;"></div>
		        <form class="form-horizontal" role="form">
				  <div class="form-group">
				    <label for="newPassword" class="col-sm-4 control-label">Mật khẩu mới</label>
				    <div class="col-sm-6">
				      <input type="password" class="form-control" id="newPassword" placeholder="Mật khẩu mới">
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="renewPassword" class="col-sm-4 control-label">Xác nhận</label>
				    <div class="col-sm-6">
				      <input type="password" class="form-control" id="renewPassword" placeholder="Xác nhận mật khẩu mới">
				    </div>
				  </div>
				</form>

		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Hủy</button>
		        <button id="savePassword" type="button" class="btn btn-primary">Lưu lại</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
	</div>
  </body>
</html>