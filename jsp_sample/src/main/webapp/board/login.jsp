<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="login-result.jsp">
		<div>
			<label>아이디 : <input name="userId"></label>
		</div>
		<div>
			<label>비밀번호 : <input name="pwd" type="password"></label>
		</div>
		<div>
			<input type="submit" value="로그인">
			<input type="button" value="검증 하고 전달" onclick="fnLogin()">
		</div>
	</form>
</body>
</html>
<script>
	function fnLogin() {
		let form = document.form;
	}
</script>