<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Timer" %>
<%@ page import="java.util.TimerTask" %>
<%@ page import="java.sql.*" %>
    
<html>
<head>
	<title>Feedback_coach.jsp</title>
</head>

<body>
	<%@ include file="dbconn.jsp" %>
	
	<%
		request.setCharacterEncoding("utf-8");
		
		String match_title = request.getParameter("match_title");
		String feed_name = request.getParameter("feed_name");
		
		String memo = request.getParameter("memo");
		String feed_passwd = request.getParameter("feed_passwd");
	
		
		Statement stmt =null;
		
		
		try{
			//아이디, 이름, 비밀번호, 메일, 팀명	
			String sql = "INSERT INTO feed_table(match_title, feed_name, memo, feed_passwd) VALUES('" + match_title + "','" + feed_name + "','"+memo + "','" + feed_passwd + "')";
			stmt = conn.createStatement();
			stmt.executeUpdate(sql); 
			out.println("<script>");
			out.println("alert('피드백 등록이 되었습니다.감사합니다. ')");
			out.println("location.href='home.jsp'");
			out.println("</script>");
		
		}catch (SQLException ex){
			out.println("feed_table 테이블 삽입이 실패했습니다.<br>");  
			out.println("SQLException: "+ex.getMessage());
		}finally{
			if(stmt != null)
				stmt.close();
			if(conn != null)
				conn.close();
		}
		
	%>
	 
		
</body>
</html>