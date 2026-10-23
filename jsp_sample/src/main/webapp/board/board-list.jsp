<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록</title>
<style>
    table, tr, td, th {
        border: 2px solid black;
        border-collapse: collapse;
        padding: 10px;
        text-align: center;
    }

    .page a {
        text-decoration: none;
        color: black;
        margin-right: 3px;
    }

    .active {
        font-weight: bold;
    }
</style>
</head>
<body>
    <%@ include file="../db.jsp"%>

    <h4 style="display: inline-block;">
        <%= session.getAttribute("sessionName") %>님이 접속 중 입니다
    </h4>
    <a href="login.jsp"><button type="button">로그아웃</button></a>

    <%
        /* 페이징에 사용할 변수 */
        String size = request.getParameter("size");
        String selectSize = size != null ? size : "";

        int pageSize = 5;
        int currentPage = 1;

        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        if (size != null && !size.equals("")) {
            pageSize = Integer.parseInt(size);
        }

        int offset = (currentPage - 1) * pageSize;

        // 전체 게시글 수 조회
        String cntQuery = "SELECT COUNT(*) AS TOTAL FROM TBL_BOARD";

        ResultSet cntRS = stmt.executeQuery(cntQuery);
        cntRS.next();

        int total = cntRS.getInt("TOTAL");
        int pageList = (int) Math.ceil((double) total / pageSize);

        // ★ 수정: 전체 페이지 범위를 벗어나지 않도록 처리
        if (pageList > 0 && currentPage > pageList) {
            currentPage = pageList;
            offset = (currentPage - 1) * pageSize;
        }

        if (currentPage < 1) {
            currentPage = 1;
            offset = 0;
        }
    %>

    <hr>
    <h2>게시글 목록</h2>
    <hr>

    <form name="form" action="board-list.jsp">
        <select name="size" onchange="fnSize()">
            <%
                int pageArr[] = {5, 10, 20, 50};

                for (int i = 0; i < pageArr.length; i++) {
            %>
                <option value="<%= pageArr[i] %>"
                    <%= (size == null && pageArr[i] == 5)
                        || selectSize.equals(Integer.toString(pageArr[i]))
                        ? "selected" : "" %>>
                    <%= pageArr[i] %>개씩
                </option>
            <%
                }
            %>
        </select>

        <hr>

        <%
            ResultSet rs = null;

            // ★ 수정: ORDER BY를 추가한 페이징 쿼리
            String query = "SELECT * FROM TBL_BOARD ORDER BY BOARDNO DESC";
            query += " OFFSET " + offset + " ROWS";
            query += " FETCH NEXT " + pageSize + " ROWS ONLY";

            String sessionRole =
                (String) session.getAttribute("sessionRole");
            String sessionId =
                (String) session.getAttribute("sessionId");

            rs = stmt.executeQuery(query);
        %>

        <table>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>조회수</th>
                <th>삭제</th>
            </tr>

            <%
                while (rs.next()) {
            %>
                <tr>
                    <td><%= rs.getString("BOARDNO") %></td>
                    <td>
                        <a href="javascript:;"
                           onclick="fnView(<%= rs.getString("BOARDNO") %>)">
                            <%= rs.getString("TITLE") %>
                        </a>
                    </td>
                    <td><%= rs.getString("USERID") %></td>
                    <td><%= rs.getString("CNT") %></td>
                    <td>
                        <%
                            if (sessionId != null
                                && (sessionId.equals(rs.getString("USERID"))
                                || "A".equals(sessionRole))) {
                        %>
                            <button type="button"
                                onclick="fnRemove(<%= rs.getString("BOARDNO") %>)">
                                삭제
                            </button>
                        <%
                            }
                        %>
                    </td>
                </tr>
            <%
                }
            %>
        </table>

        <div class="page">
            <%-- 이전 페이지 버튼 --%>
            <% if (currentPage > 1) { %>
                <a href="javascript:;" onclick="fnMove('prev')">◀</a>
            <% } %>

            <%-- ★ 수정: 현재 페이지에만 active 적용 --%>
            <%
                for (int i = 1; i <= pageList; i++) {
            %>
                <a href="javascript:;"
                   onclick="fnPage(<%= i %>)"
                   class="<%= currentPage == i ? "active" : "" %>">
                    <%= i %>
                </a>
            <%
                }
            %>

            <%-- 다음 페이지 버튼 --%>
            <% if (currentPage < pageList) { %>
                <a href="javascript:;" onclick="fnMove('next')">▶</a>
            <% } %>
        </div>

        <div>
            <a href="board-add.jsp">
                <button type="button">글쓰기</button>
            </a>
        </div>

        <input name="page" value="<%= currentPage %>" type="hidden">
    </form>
</body>
</html>

<script>
    function fnView(boardNo) {
        location.href = "board-view.jsp?boardNo=" + boardNo;
    }

    function fnRemove(boardNo) {
        if (!confirm("삭제?!")) {
            return;
        }

        location.href = "board-remove-result.jsp?boardNo=" + boardNo;
    }

    function fnSize() {
        let form = document.form;
        form.page.value = 1;
        form.submit();
    }

    function fnPage(page) {
        let form = document.form;
        form.page.value = page;
        form.submit();
    }

    function fnMove(v) {
        let form = document.form;

        form.page.value =
            v == "prev"
                ? <%= currentPage - 1 %>
                : <%= currentPage + 1 %>;

        form.submit();
    }
</script>