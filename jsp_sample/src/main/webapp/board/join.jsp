<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<form name="form" action="join-result.jsp">
		<div>
			<label>아이디 : <input name="userId"></label>
		</div>
		<div>
			<label>비밀번호 : <input name="pwd" type="password"></label>
		</div>
		<div>
			<label>이름 : <input name="name"></label>
		</div>
		<div>
			<input type="submit" value="회원가입" onclick="fnJoin()">
		</div>
	</form>
</body>
</html>
<script>
	function fnJoin() {
		let form = document.form;
		console.log(form.userId.value);
		if(form.userId.value.length < 1){
			alert("아이디를 입력해주세요.");
			return;
		}
		if(form.pwd.value.length < 1){
			alert("비밀번호를 입력해주세요.");
			return;
		}
		if(form.name.value.length < 1){
			alert("이름을 입력해주세요.");
			return;
		}
		form.submit();
	}
</script>
</body>
</html>