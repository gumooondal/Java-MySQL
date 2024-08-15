<%@page import="java.sql.*"%>
<%@page import="DBPKG.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join</title>
<script type="text/javascript" src="check.js"></script>
<%
Connection conn = null;
Statement stmt = null;
int membno = 0;

try{
	conn = Util.getConnection(); //DB연결 
	stmt = conn.createStatement(); //sql 실행하기 위한 변수 생성 
	// SQL 쿼리를 문자열로 작성합니다.
	String sql = "SELECT MAX(membno) + 1 AS membno FROM member_tbl";

	// 쿼리를 실행합니다.
	ResultSet rs = stmt.executeQuery(sql);

	// 결과를 처리합니다.
	if (rs.next()) {
	    membno = rs.getInt("membno");
	    System.out.println("Next Member Number: " + membno);
	} 
			
} catch(Exception e){
	e.printStackTrace(); //단계별로 에러를 출력해서 전체 에러 발생 경로를 출력.
}
%>
</head>
<body>

	<jsp:include page="header.jsp" />
	
	<section style="position:fixed; left:0px; top:60px; width:100%; 
					height:100%; background-color:lightgray; 
					line-height:20px; padding-left:20px;">
		<h2 style="text-align: center">
			<b>게시판 회원 등록</b>			
		</h2>
		<form name="frm" style="display:flex; align-items:center; justify-content:center; text-align:center;">
			<table border="1">
				<tr>
					<td>회원번호(자동발생)</td>
					<td><input type="text" name="membno" value="<%= membno %>"readonly></td>
				</tr>
				<tr>
					<td>회원이름</td>
					<td><input type="text" name="membname"></td>
				</tr>
				<tr>
					<td>회원전화</td>
					<td><input type="text" name="phone"></td>
				</tr>
				<tr>
					<td>회원주소</td>
					<td><input type="text" name="address"></td>
				</tr>
				<tr>
					<td>가입일자</td>
					<td><input type="text" name="joindate"></td>
				</tr>
				<tr>
					<td>회원등급[A:우수회원, B:정회원, C:준회원]</td>
					<td><input type="text" name="grade" value="C" readonly></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="등록" onclick="return joinCheck()"> &nbsp&nbsp&nbsp&nbsp
						<input type="button" value="조회" onclick="return memberSearch()">
					</td>
				</tr>
			</table>
		</form>
	</section>
	
	<jsp:include page="footer.jsp" />

</body>
</html>