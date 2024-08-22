<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="DBPKG.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyMember</title>
<script type="text/javascript" src="check.js"></script>
<%
Connection conn = null;
Statement stmt = null;
int mod_membno = Integer.parseInt(request.getParameter("mod_membno"));
String membname ="";
String phone ="";
String address ="";
Date joindate;
String grade="";
String joindateStr = "";

try{
	conn = Util.getConnection(); //DB연결 
	stmt = conn.createStatement(); //sql 실행하기 위한 변수 생성 
	// SQL 쿼리를 문자열로 작성합니다.
	String sql = "SELECT * FROM member_tbl WHERE membno = " + mod_membno;

	// 쿼리를 실행합니다.
	ResultSet rs = stmt.executeQuery(sql);

	rs.next();
	mod_membno = rs.getInt("membno");
	membname = rs.getString("membname");
	phone = rs.getString("phone");
	address = rs.getString("address");
	joindate = rs.getDate("joindate");
	
	SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
	joindateStr = transFormat.format(joindate);
	
	grade = rs.getString("grade");

			
} catch(Exception e){
	e.printStackTrace(); //단계별로 에러를 출력해서 전체 에러 발생 경로를 출력.
}
%>
</head>
<body>
</head>
<body>

	<jsp:include page="header.jsp" />
	
	<section style="position:fixed; top:60px; width:100%; 
					height:100%; background-color:lightgray; 
					line-height:20px; padding-left:20px;">
		<h2 style="text-align: center">
			<b>게시판 회원 정보 수</b>			
		</h2>
		<form method="post" action="action.jsp" name="frm" style="display:flex; align-items:center; justify-content:center; text-align:center;">
			<input type="hidden" name="mode" value="modify">
			<table border="1">
				<tr>
					<td>회원번호(자동발생)</td>
					<td><input type="text" name="membno" value="<%= mod_membno %>"readonly></td>
				</tr>
				<tr>
					<td>회원이름</td>
					<td><input type="text" name="membname" value="<%=membname %>"></td>
				</tr>
				<tr>
					<td>회원전화</td>
					<td><input type="text" name="phone" value="<%=phone %>"></td>
				</tr>
				<tr>
					<td>회원주소</td>
					<td><input type="text" name="address" value="<%=address %>"></td>
				</tr>
				<tr>
					<td>가입일자</td>
					<td><input type="text" name="joindate" value="<%=joindateStr %>"></td>
				</tr>
				<tr>
					<td>회원등급[A:우수회원, B:정회원, C:준회원]</td>
					<td><input type="text" name="grade" value="<%=grade %>"></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="수정" onclick="return modify()"> &nbsp&nbsp&nbsp&nbsp
						<input type="button" value="조회" onclick="return memberSearch()">
					</td>
				</tr>
			</table>
		</form>
	</section>
	
	<jsp:include page="footer.jsp" />
</body>
</html>