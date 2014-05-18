$(function(){
	$("#navigation").delegate("li", "click", function(){
		var id = $(this).attr("id");
		$("#msgForm").hide();
		if (id.indexOf("userlist") != -1) document.getElementById("userForm").reset();
		$("#navigation li").removeClass("active");
		$(this).addClass("active");
		$("div.tab-content").hide();
		$("div." + id).show();
	});
	
	$("#updateUserButton").click(function(){
		$("#msgModalUpdate").hide();
		var userId = $("#currentUser").val();
		var serializedData = $("#udpateUserForm").serialize();
		$.ajax({
		url: "/update?username="+userId,
		dataType: "text",
		contentType: "application/x-www-form-urlencoded",
		data: serializedData,
		type: "POST"
	})
	.success(function (data) {
		if (data.indexOf("true") != -1) {
			$("#updateUserModal").modal("hide");
		} else {
			showError("danger", $("#msgModalUpdate"), "Không thể cập nhật thông tin người dùng tại thời điểm này, vui lòng thử lại sau.");
		}
	})
	.error(function (jqXHR, textStatus, error) {
		var err = textStatus + ', ' + error;
		console.log("Transaction Failed: " + err);
		showError("danger", $("#msgModalUpdate"), "Không thể cập nhật thông tin người dùng tại thời điểm này, vui lòng thử lại sau.");
	});
	});
	
	$("[name=updateUser]").click(function(){
		var currentUser = $(this).parent().parent().attr("id");
		$("#currentUser").val(currentUser);
		document.getElementById("udpateUserForm").reset();
		$("#updateUserModal").modal("show");
	});
	
	$("[name=deleteUser]").click(function(){
		$("#msgForm").hide();
		var currentUser = $(this).parent().parent();
		var confirmation = confirm("Bạn có chắc muốn xóa người dùng này?");
		if (confirmation == true) {
		  var userId = currentUser.attr("id");
		  currentUser.remove();
       		$.ajax({
       			url: "/admin?username="+userId,
       			dataType: "text",
       			type: "DELETE"
       		})
       		.success(function (data) {
       			if (data.indexOf("true") == -1) {
       				showError("danger", $("#msgForm"), "Tạm thời không thể xóa " + userId + ", vui lòng thử lại sau.");
       			}
       		})
       		.error(function (jqXHR, textStatus, error) {
       			var err = textStatus + ', ' + error;
       			console.log("Transaction Failed: " + err);
       			showError("danger", $("#msgForm"), "Tạm thời không thể xóa " + userId + ", vui lòng thử lại sau.");
       		});
		} else {
		  // Do nothing
		} 
	});

	$(".userlist").delegate(".resetPassword", "click", function(){
		var currentUser = $(this).parent().parent().attr("id");
		$("#currentUser").val(currentUser);
		document.getElementById("changePasswordForm").reset();
		$("#resetPassword").modal("show");
	});

	$("#savePassword").click(function() {
		$("#msgModal").hide();
		var userId = $("#currentUser").val();
		var newPassword = $.trim($("#newPassword").val());
		var confirmPassword = $.trim($("#renewPassword").val());
		if (newPassword != confirmPassword) {
			showError("danger", $("#msgModal"), "Xác nhận mật khẩu chưa đúng.");
		} else {
			var seriablizedData = $("#changePasswordForm").serialize();
			$.ajax({
       			url: "/update?username="+userId,
       			dataType: "text",
       			contentType: "application/x-www-form-urlencoded",
       			data: seriablizedData,
       			type: "POST"
       		})
       		.success(function (data) {
       			if (data.indexOf("true") != -1) {
       				$("#resetPassword").modal("hide");
       			} else {
       				showError("danger", $("#msgModal"), "Không thể cập nhật thông tin mật khẩu tại thời điểm này, vui lòng thử lại sau.");
       			}
       		})
       		.error(function (jqXHR, textStatus, error) {
       			var err = textStatus + ', ' + error;
       			console.log("Transaction Failed: " + err);
       			showError("danger", $("#msgModal"), "Không thể cập nhật thông tin mật khẩu tại thời điểm này, vui lòng thử lại sau.");
       		});
		}
	});
	
	$("#addUser").click(function(){
		$("#msgForm").hide();
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
		$("#username").focus();
		return false;
	}
		
		$(this).attr("disabled", true);
		
		var serializedData = $("#userForm").serialize();
		
	$.ajax({
		url: "/admin",
		dataType: "text",
		contentType: "application/x-www-form-urlencoded",
		data: serializedData,
		type: "POST"
	})
	.success(function (data) {
		if (data.indexOf("true") != -1) {
			showError("success", $("#msgForm"), "Tạo người dùng mới thành công.");
			setTimeout(function(){
				$("#msgForm").fadeOut(3000);
			  },3000);
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
