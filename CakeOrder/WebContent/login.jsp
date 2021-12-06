<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<title>login</title>
</head>
<body style="background-color: #fcfbfa">
	<jsp:include page="menu.jsp" />

	<div class="jumbotron" style="background-color: #ece2d9">
		<div class="container">
			<h1 class="display-3">로그인</h1>
		</div>	
	</div>
	
	<div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
			<h3 class="form-signin-heading">Please sign in</h3>
			<%
				String error = request.getParameter("error");
				if(error != null){
					out.println("<div class='alert alert-danger'>");
					out.println("아이디와 비밀번호를 확인해주세요");
					out.println("</div>");
				}
			%>
			<form class="form-signin" action="j_security_check" method="post">
				<div class="form-group"> <!-- 아이디 입력부분 -->
					<label for="inputUserName" class="sr-only">
						User Name
					</label>
					<input type="text" class="form-control" placeholder="ID" name="j_username" required autofocus>
				</div>
				<div class="form-group"> <!-- 비밀번호 입력부분 -->
					<label for="inputPassword" class="sr-only">
						PassWord
					</label>
					<input type="password" class="form-control" placeholder="Password" name="j_password" required>
				</div>	
				<button class="btn btn btn-lg" style="background-color: #d8caad; color: #765868; font-weight: bold;" type="submit">로그인</button> <!-- 로그인 버튼 -->	
			</form>
		</div>
	</div>

	<%@ include file="footer.jsp" %>	
</body>
</html>
