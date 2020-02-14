
    <%@ include file="dbconn.jsp" %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<style>
body{
	background-color: #000000;
}
</style>
<body>




<%! String src="data:image/png;base64,"; %>

<%
      request.setCharacterEncoding("utf-8");
      

	  //String id = (String)session.getAttribute("id");
	  String id = "messi";
      
      String query="select result_heatmap from "+ id;
      ResultSet rs = null;
      PreparedStatement pstm = conn.prepareStatement(query);
      String encordingImg = "";
      
      try{
    	 
         rs = pstm.executeQuery();
         //if(stmt != null)
         //   stmt.close();
         
         while(rs.next()){  
            encordingImg = rs.getString("result_heatmap");
         }
      
      }catch (SQLException ex){
         out.println("SQLException: "+ex.getMessage());
         
      }finally{
         
         if(rs != null)
            rs.close();
         if(pstm != null)
            pstm.close();
         if(conn != null)
            conn.close();
         
      }
      src = src + encordingImg;
%>
<p><img src=<%=src%>>

</body>
</html>