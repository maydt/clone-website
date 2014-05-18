$(function(){
	$(document).ready(function(){
		$('.bxslider').bxSlider();
	});
	
	myCounter = setInterval(function () {
	    $(".bx-controls-direction a.bx-next").click();
	}, 5000);
	
	$("#cloneWeb").click(function(){
		
		var domainName = $("#domainName").val();
		if (domainName.length == 0) {
			$("#msgError").text("Hãy nhập tên miền của bạn.");
			$("#msgError").show();
			return false;
		}
		var regex = /^[\w-\.]+$/;
		if (!regex.test(domainName)) {
			$("#msgError").text("Tên miền chỉ được chứa các ký tự chữ cái, chữ số, gạch ngang và dấu chấm.");
			$("#msgError").show();
			return false;
		}
		
		$(this).text("Khởi tạo...");
		$(this).attr("disabled", true);
		var serializedData = $("#mainForm").serialize();
		
		$.ajax({
			url: "/cloneweb",
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
				$("#msgError").text("Không thể khởi tạo website mới tại thời điểm này, vui lòng thử lại sau.");
    			$("#msgError").show();
			}
			$("#cloneWeb").text("Tạo website mới");
    		$("#cloneWeb").attr("disabled", false);
		})
		.error(function (jqXHR, textStatus, error) {
			var err = textStatus + ', ' + error;
			console.log("Transaction Failed: " + err);
			$("#msgError").text("Không thể khởi tạo website mới tại thời điểm này, vui lòng thử lại sau.");
			$("#msgError").show();
			$("#cloneWeb").text("Tạo website mới");
    		$("#cloneWeb").attr("disabled", false);
		});
	});
});
