<%@page import="java.sql.*"%>
<%@page import="DBPKG.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>post</title>
</head>
<script type="text/javascript" src="check.js"></script>
<body>

    <jsp:include page="header.jsp" />
    <%
    int currentPage = 1; // 현재 페이지 번호
    int dataPerPage = 10; // 페이지당 게시글 수
    int totalPages = 0; // 총 페이지 수
    String searchKeyword = ""; // 검색어

    // 페이지 번호가 요청 파라미터에 있으면 그 값을 사용
    if (request.getParameter("page") != null) {
        currentPage = Integer.parseInt(request.getParameter("page"));
    }

    // 검색어가 요청 파라미터에 있으면 그 값을 사용
    if (request.getParameter("searchKeyword") != null) {
        searchKeyword = request.getParameter("searchKeyword");
    }

    // 페이지네이션을 위한 시작 인덱스 계산
    int startIndex = (currentPage - 1) * dataPerPage;

    Connection conn = null;
    Statement stmt = null;

    try {
        conn = Util.getConnection();
        stmt = conn.createStatement();

        // 검색어가 있는지 확인하여 조건에 따라 전체 게시글 수 쿼리 작성
        String countSql = "SELECT COUNT(*) FROM post_tbl";
        if (!searchKeyword.isEmpty()) {
            countSql += " WHERE title LIKE '%" + searchKeyword + "%' OR membname LIKE '%" + searchKeyword + "%'";
        }

        // 전체 게시글 수를 가져오는 쿼리
        ResultSet countRs = stmt.executeQuery(countSql);
        int totalRecords = 0;
        if (countRs.next()) {
            totalRecords = countRs.getInt(1);
        }

        // 총 페이지 수 계산
        totalPages = (int) Math.ceil((double) totalRecords / dataPerPage);

        // 검색어가 있으면 해당 검색어가 포함된 게시글만 가져오도록 쿼리 작성
        String sql = "SELECT * FROM post_tbl";
        if (!searchKeyword.isEmpty()) {
            sql += " WHERE title LIKE '%" + searchKeyword + "%' OR membname LIKE '%" + searchKeyword + "%'";
        }
        sql += " ORDER BY postno DESC LIMIT " + startIndex + ", " + dataPerPage;

        // 현재 페이지에 해당하는 게시글만 가져오는 쿼리 실행
        ResultSet rs = stmt.executeQuery(sql);
    %>
    <section
        style="position: fixed; left: 0px; top: 60px; width: 100%; height: 100%; background-color: lightgray; line-height: 20px; padding-left: 20px;">
        <h2 style="text-align: center">
            <b>게시글 조회/수정</b>
        </h2>
        <form style="display: flex; align-items: center; justify-content: center; text-align: center;">
            <table border="1">
                <tr>
                    <td>글번호</td>
                    <td style="width:300px">제목</td>
                    <td>작성자</td>
                    <td>작성일</td>
                </tr>
                <%
                while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("postno") %></td>
                    <td><a href="detailPost.jsp?mod_postno=<%= rs.getInt("postno") %>"><%= rs.getString("title") %></a></td>
                    <td><%= rs.getString("membname") %></td>
                    <td><%= rs.getDate("creationdate") %></td>
                </tr>
                <%
                }
                %>
            </table>
        </form>
        <%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stmt != null)
                stmt.close();
            if (conn != null)
                conn.close();
        }
        %>

        <!-- 페이지 네비게이션 및 검색 폼 추가 -->
        <div style="text-align: center; margin-top: 20px;">
            <%
            int displayPages = 10; // 표시할 페이지 번호 개수
            int startPage = Math.max(1, currentPage - displayPages / 2); // 표시 시작 페이지
            int endPage = Math.min(totalPages, startPage + displayPages - 1); // 표시 끝 페이지

            // "이전" 링크
            if (currentPage > 1) {
            %>
            <a href="postList.jsp?page=<%= currentPage - 1 %>&searchKeyword=<%= searchKeyword %>">이전</a>
            <%
            }

            // 첫 페이지 링크
            if (startPage > 1) {
            %>
            <a href="postList.jsp?page=1&searchKeyword=<%= searchKeyword %>">1</a>
            <%
                if (startPage > 2) {
            %>
            <span>...</span>
            <%
                }
            }

            // 페이지 번호 링크
            for (int i = startPage; i <= endPage; i++) {
            %>
            <a href="postList.jsp?page=<%= i %>&searchKeyword=<%= searchKeyword %>" <%= (i == currentPage) ? "style='font-weight:bold;'" : "" %>><%= i %></a>
            <%
            }

            // 마지막 페이지 링크
            if (endPage < totalPages) {
            %>
            <span>...</span>
            <a href="postList.jsp?page=<%= totalPages %>&searchKeyword=<%= searchKeyword %>"><%= totalPages %></a>
            <%
            }

            // "다음" 링크
            if (currentPage < totalPages) {
            %>
            <a href="postList.jsp?page=<%= currentPage + 1 %>&searchKeyword=<%= searchKeyword %>">다음</a>
            <%
            }
            %>
        </div>

        <!-- 검색 창 추가 -->
        <div style="text-align: center; margin-top: 20px;">
            <form action="postList.jsp" method="get">
                <input type="text" name="searchKeyword" placeholder="검색어 입력" value="<%= (request.getParameter("searchKeyword") != null) ? request.getParameter("searchKeyword") : "" %>"/>
                <input type="submit" value="검색"/>
            </form>
        </div>
    </section>
    <jsp:include page="footer.jsp" />

</body>

</html>