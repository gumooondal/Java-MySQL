<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
</head>
<body>

	<header style="position: fixed; left:0px; top: 0px; width: 100%; height: 40px; 
	background-color: blue; color: white; text-align: center; 
	line-height: 40px; font-size: 30px;">
		게시판 관리 프로그램 
	</header>

	<nav style="position: fixed; left:0px; top: 40px; width: 100%; height: 20px; 
				background-color:#D3B0F2; color: white; line-height: 20px; 
				padding-left: 20px;">
			<a href="join.jsp">회원등록</a> &nbsp &nbsp 
			<a href="memberList.jsp">회원목록조회/수정</a> &nbsp &nbsp 
			<a href="postList.jsp">게시글조회/수정</a> &nbsp &nbsp &nbsp &nbsp 
			<a href="index.jsp">홈으로</a>
	</nav>

</body>
</html>