<%@page import="java.sql.*"%>
<%@page import="DBPKG.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>action</title>
</head>
<body>

<%
    String mode = request.getParameter("mode");
    if (mode == null) {
        mode = ""; // 기본값 설정 또는 적절한 처리를 추가합니다.
    }
    
    String membname = request.getParameter("membname");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String grade = request.getParameter("grade");
    String membno = request.getParameter("membno"); // 회원 번호, 수정할 때 필요

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        conn = Util.getConnection();
        String sql = "";

        switch (mode) {
            case "insert":
                // INSERT 쿼리
                sql = "INSERT INTO member_tbl(membname, phone, address, joindate, grade) VALUES (?, ?, ?, NOW(), ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, membname);
                pstmt.setString(2, phone);
                pstmt.setString(3, address);
                pstmt.setString(4, grade);
                break;

            case "modify":
                // UPDATE 쿼리
                sql = "UPDATE member_tbl SET membname = ?, phone = ?, address = ?, grade = ? WHERE membno = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, membname);
                pstmt.setString(2, phone);
                pstmt.setString(3, address);
                pstmt.setString(4, grade);
                pstmt.setString(5, membno); // 수정할 회원 번호
                break;

            default:
                throw new IllegalArgumentException("Invalid mode: " + mode);
        }

        int result = pstmt.executeUpdate(); // 쿼리 실행

        if (result > 0) {
            // 회원 정보가 성공적으로 추가 또는 수정되었으면 memberList.jsp로 리다이렉트
            response.sendRedirect("memberList.jsp");
        } else {
            out.println("회원 정보 " + (mode.equals("insert") ? "추가" : "수정") + "에 실패했습니다.");
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>



</body>
</html>