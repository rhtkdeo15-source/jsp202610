<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 게시글 번호, 제목, 내용, 작성자, 작성일 출력 -->
	<%@ include file="../db.jsp"%>
	<%
		String sessionRole = (String) session.getAttribute("sessionRole");
		String sessionId = (String) session.getAttribute("sessionId");
		ResultSet rs = null;
		String boardNo = request.getParameter("boardNo");
		String query = "SELECT * FROM TBL_BOARD WHERE BOARDNO = " + boardNo;
		String updateQuery = "UPDATE TBL_BOARD SET CNT = CNT + 1 WHERE BOARDNO = " + boardNo;
		
		//System.out.println(updateQuery);
		stmt.executeUpdate(updateQuery);
		
		rs = stmt.executeQuery(query);
		
		if(rs.next()){
	%>
			<div>번호 : <%= rs.getString("BOARDNO") %> | 조회수 : <%= rs.getString("CNT") %></div>
			<div>제목 : <%= rs.getString("TITLE") %></div>
			<div>내용 : <%= rs.getString("CONTENTS") %></div>
			<div>작성자 : <%= rs.getString("USERID") %></div>
			<div>작성일 : <%= rs.getString("UDATETIME") %></div>
	<%
		}else{
			
	%>
		<div>해당 게시글이 없습니다.</div>
		<a href="board-list.jsp"><button>되돌아가기</button></a>
	<%
		}
		
	%>
	<div>
		<%
			if(sessionId.equals(rs.getString("USERID")) || sessionRole.equals("A")){
		%>
				<input type="button" value="수정" onclick="fnEdit()">
				<input type="button" value="삭제" onclick="fnRemove()">
		<%		
			}
		%>	
	</div>
	
</body>
</html>
<script>
	function fnRemove() {
		if(!confirm("삭제?!")){
			return;
		}
		location.href = "board-remove-result.jsp?boardNo="+<%=boardNo%>
	}
	function fnEdit() {
		location.href = "board-edit.jsp?boardNo="+<%=boardNo%>
	}
</script>













