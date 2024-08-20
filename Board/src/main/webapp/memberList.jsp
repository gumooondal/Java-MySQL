<%@page import="java.sql.*"%>
<%@page import="DBPKG.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member</title>
</head>
<body>

	<jsp:include page="header.jsp" />
	
	<%
	int currentPage = 1;
	int data = 10;
	int totalPages = 0;
	

	// 요청 파라미터에서 페이지 번호를 가져옴
	if (request.getParameter("page") != null) {
		currentPage = Integer.parseInt(request.getParameter("page"));
	}

	int startIndex = (currentPage - 1) * data;

	Connection conn = null;
	Statement stmt = null;
	String grade = "";

	try {
		conn = Util.getConnection();
		stmt = conn.createStatement();

		// 전체 레코드 수를 가져오는 쿼리
		String countSql = "SELECT COUNT(*) FROM member_tbl";
		ResultSet countRs = stmt.executeQuery(countSql);
		int totalRecords = 0;
		if (countRs.next()) {
			totalRecords = countRs.getInt(1);
		}

		// totalPages 계산
		totalPages = (int) Math.ceil((double) totalRecords / data);

		// 실제 데이터를 가져오는 쿼리 (페이징 처리 적용)
		String sql = "SELECT * FROM member_tbl ORDER BY membno LIMIT " + startIndex + ", " + data;
		ResultSet rs = stmt.executeQuery(sql);
	%>
	
	<section
		style="position: fixed; left: 0px; top: 60px; width: 100%; height: 100%; background-color: lightgray; line-height: 20px; padding-left: 20px;">
		<h2 style="text-align: center">
			<b>회원목록 조회/수정</b>
		</h2>
		<form
			style="display: flex; align-items: center; justify-content: center; text-align: center;">
			<table border="1">
				<tr>
					<td>회원번호</td>
					<td>회원이름</td>
					<td>전화번호</td>
					<td>주소</td>
					<td>가입일자</td>
					<td>회원등급</td>
				</tr>
				<%
				while (rs.next()) {
					grade = rs.getString("grade");
					switch (grade) {
					case "A":
						grade = "우수회원";
						break;
					case "B":
						grade = "정회원";
						break;
					case "C":
						grade = "준회원";
						break;
					}
				%>
				<tr>
					<td><a
						href="modifyMemb.jsp?mod_membno=<%=rs.getInt("membno")%>"><%=rs.getInt("membno")%></a></td>
					<td><%=rs.getString("membname")%></td>
					<td><%=rs.getString("phone")%></td>
					<td><%=rs.getString("address")%></td>
					<td><%=rs.getDate("joindate")%></td>
					<td><%=grade%></td>
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

		<div style="text-align: center; margin-top: 20px;">
			<%
			if (currentPage > 1) {
			%>
			<a href="memberList.jsp?page=<%=currentPage - 1%>">이전</a>
			<%
			}
			%>

			<%
			for (int i = 1; i <= totalPages; i++) {
			%>
			<a href="memberList.jsp?page=<%=i%>"><%=i%></a>
			<%
			}
			%>

			<%
			if (currentPage < totalPages) {
			%>
			<a href="memberList.jsp?page=<%=currentPage + 1%>">다음</a>
			<%
			}
			%>
		</div>
	
	</section>

	<jsp:include page="footer.jsp" />

</body>
</html>