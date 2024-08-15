package DBPKG;

import java.sql.*;

public class Util{
	public static Connection getConnection() throws Exception {
	    // MySQL JDBC 드라이버를 로드합니다.
	    Class.forName("com.mysql.cj.jdbc.Driver");

	    // 데이터베이스 연결 URL, 사용자 이름, 비밀번호를 지정합니다.
	    String url = "jdbc:mysql://localhost:3306/board";
	    String user = "root";
	    String password = "12345678";

	    // 데이터베이스에 연결하고 Connection 객체를 반환합니다.
	    Connection con = DriverManager.getConnection(url, user, password);
	    return con;
	}
}