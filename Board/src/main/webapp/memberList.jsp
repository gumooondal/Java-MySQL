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
		<section
		style="position: fixed; left:0px; top: 60px; width: 100%; height: 100%; 
			   background-color: lightgray; line-height: 20px; padding-left: 20px;">
		<h2 style="text-align: center">
			<b>회원목록 조회/수정</b>
		</h2>
		<form style="display:flex; align-items:center; justify-content:center; text-align:center;">
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
Connection conn = null;
Statement stmt = null;
String grade="";

try{
	conn = Util.getConnection();
	stmt = conn.createStatement();
	String sql = "SELECT * FROM member_tbl ORDER BY membno";
	ResultSet rs = stmt.executeQuery(sql);
	while(rs.next()){
		grade = rs.getString("grade");
		switch(grade){
		case "A" : 
			grade ="우수회원";
			break;
		case "B" : 
			grade ="정회원";
			break;
		case "C" : 
			grade ="준회원";
			break;
		}
%>
				<tr>
					<td><a href="modifyMemb.jsp?mod_membno=<%=rs.getInt("membno") %>"><%=rs.getInt("membno") %></a></td>
					<td><%=rs.getString("membname") %></td>
					<td><%=rs.getString("phone") %></td>
					<td><%=rs.getString("address") %></td>
					<td><%=rs.getDate("joindate") %></td>
					<td><%=grade %></td>
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