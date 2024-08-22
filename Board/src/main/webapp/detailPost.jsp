<%@page import="java.sql.*"%>
<%@page import="DBPKG.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detail</title>
<script type="text/javascript" src="check.js"></script>
</head>
<body>
	<jsp:include page="header.jsp" />
	<section
		style="position: fixed; left: 0px; top: 60px; width: 100%; height: 100%; background-color: lightgray; line-height: 20px; padding-left: 20px;">

		<%
		// 데이터베이스 연결
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String mod_postno = request.getParameter("mod_postno"); // 글번호 받기

		try {
			conn = Util.getConnection(); // 데이터베이스 연결
			String sql = "SELECT postno ,title, membname, creationdate, content FROM post_tbl WHERE postno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mod_postno);
			rs = pstmt.executeQuery();

			if (rs.next()) {
		%>
		<h2 style="text-align: center">
			<b>게시글 상세 페이지</b>
		</h2>

		<table class="post-detail-table" border="1"
			style="width: 600px; margin: auto; background-color: white; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); text-align: center;">

			<!-- 제목, 작성자, 작성일자를 한 행에 배치 -->
			<tr>
				<th
					style="text-align: left; padding: 10px; background-color: #f0f0f0;">제목</th>
				<td style="padding: 10px;"><%=rs.getString("title")%></td>

				<th
					style="text-align: left; padding: 10px; background-color: #f0f0f0;">작성자</th>
				<td style="padding: 10px;"><%=rs.getString("membname")%></td>

				<th
					style="text-align: left; padding: 10px; background-color: #f0f0f0;">작성일자</th>
				<td style="padding: 10px;"><%=rs.getDate("creationdate")%></td>
			</tr>

			<!-- 내용은 별도의 행으로 나눔 -->
			<tr>
				<th
					style="text-align: cente; padding: 10px; background-color: #f0f0f0;"
					colspan="6">내용</th>
			</tr>
			<tr>
				<td colspan="6" style="padding: 10px;"><%=rs.getString("content")%></td>
			</tr>
		</table>

		<!-- 테이블 아래에 버튼 추가 -->
		<div style="display: flex; justify-content: center; margin-top: 20px;">
			<button
				onclick="location.href='modifyPost.jsp?mod_postno=<%=rs.getInt("postno")%>'"
				style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer; margin-right: 10px;">
				수정</button>

			<!-- 삭제 버튼:를 URL에 포함 -->
			<button onclick="return deletePost(<%=rs.getInt("postno")%>);"
				style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer;">
				삭제</button>
		</div>

		<%
		} else {
		out.println("<p>해당 게시글을 찾을 수 없습니다.</p>");
		}
		} catch (Exception e) {
		e.printStackTrace();
		} finally {
		if (rs != null)
		rs.close();
		if (pstmt != null)
		pstmt.close();
		if (conn != null)
		conn.close();
		}
		%>

	</section>

	<jsp:include page="footer.jsp" />

</body>
</html>