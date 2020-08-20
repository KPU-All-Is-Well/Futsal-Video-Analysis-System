<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ page import="java.net.URLEncoder" %>
 <%@page import="java.sql.*"%>
<%@page import="java.util.*"%> 
<%@page import="java.lang.*"%> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%!
		Connection con = null;
 		PreparedStatement pstm = null;
	%>

	
	<%
		request.setCharacterEncoding("UTF-8");	 
	 	String idx = request.getParameter("idx");
	 	
	 	
	 	try{
	    //드라이버 호출, 커넥션 연결
	    Class.forName("com.mysql.jdbc.Driver").newInstance();
	        
	     
	    con = DriverManager.getConnection(
	                "jdbc:mysql://15.164.30.158:3306/AIWUserDB", "sk", "1234");
	        
	    String query = "delete from schedule where schedule_idx = ?"; //get data from ID table
	      
		pstm = con.prepareStatement(query);
		    
		pstm.setString(1, idx);
			
		pstm.execute();
		
		con.close();
		
		out.println("<script>");
        out.println("alert('일정을 삭제했습니다!')");
        out.println("location.href='schedule_list.jsp'");
        out.println("</script>");
		
	
	 	}catch(Exception e){
	 		
	 	}

	%>
	
	
	
</body>
</html>