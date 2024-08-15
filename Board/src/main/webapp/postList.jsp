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
<body>


	<jsp:include page="header.jsp" />
		<section
		style="position: fixed; left:0px; top: 60px; width: 100%; height: 100%; 
			   background-color: lightgray; line-height: 20px; padding-left: 20px;">
		<h2 style="text-align: center">
			<b>게시글 조회/수정</b>
		</h2>
		<form style="display:flex; align-items:center; justify-content:center; text-align:center;">
			<table border="1">
				<tr>
					<td>글번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
					<td colspan="2">비고</td>
				</tr>
<%
Connection conn = null;
Statement stmt = null;
String grade="";

try{
	conn = Util.getConnection();
	stmt = conn.createStatement();
	String sql = "SELECT * FROM post_tbl ORDER BY membno";
	ResultSet rs = stmt.executeQuery(sql);
	while(rs.next()){

%>
				<tr>
					<td><%=rs.getInt("postno") %></td>
					<td><a href="detailPost.jsp?mod_postno=<%=rs.getInt("postno") %>"><%=rs.getString("title") %></a></td>
					<td><%=rs.getString("membname") %></td>
					<td><%=rs.getDate("creationdate") %></td>
					<td><a href="modifyPost.jsp?mod_postno=<%=rs.getInt("postno") %>">수정</a></td>
					<td><a href="deletePost.jsp?mod_postno=<%=rs.getInt("postno") %>">삭제</a></td>
				</tr>
<%
	}
}

catch(Exception e){
	e.printStackTrace();
}
%>
			</table>
		</form>
		</section>
	<jsp:include page="footer.jsp" />
	
</body>
</html>