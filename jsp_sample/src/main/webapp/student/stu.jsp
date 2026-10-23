<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../db.jsp"%>

    <%
        String paramDept1 = request.getParameter("dept1");
        String paramDept2 = request.getParameter("dept2");
        String paramDept3 = request.getParameter("dept3");

        String dept1Query = "SELECT * FROM DEPARTMENT " +
                            "WHERE PART IS NULL " +
                            "ORDER BY DEPTNO ASC";

        ResultSet rs = stmt.executeQuery(dept1Query);
    %>
    <form name="form" action="area.jsp">
		<div>
			<select name="dname" onchange="fnSelect()">
			<option value="">:: 선택 ::</option>
				<%
					while(rs.next()){
						String dname = rs.getString("DNAME");
						String selected = paramDept1 != null && dname.equals(paramDept1) ? "selected" : "";
				%>
					<option value="<%= dname %>"<%= selected %>><%= dname %></option>
				<%
					}
				%>
			</select>
		</div>
	</form>
</body>
</html>