<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Timer" %>
<%@ page import="java.util.TimerTask" %>
<%@ page import="java.sql.*" %>
    
<html>
<head>
	<title>signUp_Process.jsp</title>
</head>

<body>
	<%@ include file="dbconn.jsp" %>
	
	<%
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String passwd = request.getParameter("passwd");
		String email = request.getParameter("email");
		String team = request.getParameter("team");
		
		Statement stmt =null;
		
		
		try{
			//아이디, 이름, 비밀번호, 메일, 팀명	
			String sql = "INSERT INTO CoachSignUpInfo(id, name, passwd, email, team) VALUES('" + id + "','" + name + "','"+passwd + "','" + email + "','" + team +"')";
			stmt = conn.createStatement();
			stmt.executeUpdate(sql); 
			out.println("<script>");
			out.println("alert('회원가입에 성공했습니다. All Is Well에 오신 것을 진심으로 환영합니다.')");
			out.println("location.href='welcome.jsp'");
			out.println("</script>");
		
		}catch (SQLException ex){
			out.println("CoachSignUpInfo 테이블 삽입이 실패했습니다.<br>");  
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