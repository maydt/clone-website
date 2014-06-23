<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%  
    Boolean loginResult = (Boolean) request.getAttribute("login");
%>
<!DOCTYPE html>
<html>
  <head>
    <title>Đăng nhập</title>
    <link rel="shortcut icon" type="image/x-icon"  href="/portal/favicon.ico" />
    <link rel="stylesheet" href="css/login.css" />
    <script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
    <script type='text/javascript'>
    $(function(){
    	$("#username").focus();
    });
    function login() {
			document.loginForm.submit();                   
		}
    </script>
  </head>
  <body>
    <div class="uiLogin">
    	<div class="loginContainer">
	      <div class="loginHeader introBox">
				  <div class="userLoginIcon">Đăng nhập</div>
			   </div>
	      <div class="loginContent">
	      	<div class="titleLogin">
	      	<% if (loginResult != null && !loginResult.booleanValue()) { %>
						<div class="signinFail">Sai tên đăng nhập hoặc mật khẩu</div>
					<% } %>
					</div>
          <div class="centerLoginContent">
            <form name="loginForm" action="/login" method="post" style="margin: 0px;">

        				<input class="username" id="username" name="username" type="text" placeholder="Tên đăng nhập" onblur="this.placeholder = 'Tên đăng nhập'" onfocus="this.placeholder = ''"/>
        				<input class="password" id="UIPortalLoginFormControl" type="password" id="password" name="password" placeholder="Mật khẩu" onblur="this.placeholder = 'Mật khẩu'" onfocus="this.placeholder = ''"/>
        			    <a href="#" class="rememberTxt">Quên mật khẩu?</a>
        				<div id="UIPortalLoginFormAction" class="loginButton">
        					<button class="button" href="#" onclick="login();">Đăng nhập</button>
        				</div>
  		      </form>
          </div>
        </div>
    	</div>
    </div>
  </body>
</html>
