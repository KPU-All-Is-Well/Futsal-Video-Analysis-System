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
      String idx = request.getParameter("idx"); 
      
      PreparedStatement pstmt = null;
      
      try{
         //아이디, 이름, 비밀번호, 메일, 팀명   
         String sql = "UPDATE schedule SET schedule_subject = ?, schedule_desc = ?, schedule_date = ? WHERE schedule_idx = ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, subject);
		 pstmt.setString(2, desc);			
		 pstmt.setString(3, date);
		 pstmt.setString(4, idx);
		 
		 int cnt = pstmt.executeUpdate(); 


         
         out.println("<script>");
         out.println("alert('일정 수정하셨습니다!')");
         out.println("location.href='schedule_list.jsp'");
         out.println("</script>");
      
      }catch (SQLException ex){
         out.println("schedule 테이블 수정에 실패했습니다.<br>");  
         out.println("SQLException: "+ex.getMessage());
      }finally{
         if(pstmt != null)
        	 pstmt.close();
         if(conn != null)
            conn.close();
      }
      
   %>
    
      
</body>
</html>