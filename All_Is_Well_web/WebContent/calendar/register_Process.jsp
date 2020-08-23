<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Timer" %>
<%@ page import="java.util.TimerTask" %>
<%@ page import="java.sql.*" %>
    
<html>
<head>
 
</head>

<body>
   <%@ include file="../dbconn.jsp" %>
   
   <%
      request.setCharacterEncoding("utf-8");
      
      String date = request.getParameter("schedule_date");
      String subject = request.getParameter("schedule_subject");
      String desc = request.getParameter("schedule_desc");
    
      
      Statement stmt =null;
      
      
      try{
         //아이디, 이름, 비밀번호, 메일, 팀명   
         String sql = "INSERT INTO schedule(schedule_subject, schedule_desc, schedule_date) VALUES('" + subject + "','" + desc + "','"+date + "')";
         stmt = conn.createStatement();
         stmt.executeUpdate(sql); 
         out.println("<script>");
         out.println("alert('일정 추가에 성공하셨습니다!')");
         out.println("location.href='schedule_list.jsp'");
         out.println("</script>");
      
      }catch (SQLException ex){
         out.println("schedule 테이블 삽입에 실패했습니다.<br>");  
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