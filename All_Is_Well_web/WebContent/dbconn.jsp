
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>dbconn.jsp</title>
</head>

<body>
	<%
		Connection conn = null;
		
		String url = "jdbc:mysql://192.168.103.36: 3306/AIWUserDB"; 
		String user = "sk";
		String password = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, password);
	
	%>
</body>
</html>