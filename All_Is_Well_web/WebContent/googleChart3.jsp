<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    

<html>
  <head>
  
	<%@ include file="dbconn.jsp" %>
   <%! String rId;
   String rWalk;
   String rJog;
   String rSprint;
   %>
   
   <%   
   
      request.setCharacterEncoding("utf-8");
      String id = (String)session.getAttribute("id");
      
      ResultSet rs = null;
      Statement stmt =null;
      
      try{
            
         String sql="select id, walk, jog, sprint from PlayInfo where id = '" + id + "'";
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
         //if(stmt != null)
         //   stmt.close();
         
         while(rs.next()){
                     
            rId = rs.getString("id");
            rWalk = rs.getString("walk");
            rJog = rs.getString("jog");
            rSprint = rs.getString("sprint");
            
         }
      
      }catch (SQLException ex){
         out.println("SQLException: "+ex.getMessage());
         
      }finally{
         
         if(rs != null)
            rs.close();
         if(stmt != null)
            stmt.close();
         if(conn != null)
            conn.close();
         
      }
      
     %>
      
     
      
     
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Walk', <%= Integer.parseInt(rWalk) %>],
          ['Jog', <%= Integer.parseInt(rJog) %>],
          ['Sprint', <%= Integer.parseInt(rSprint) %>],
        
        ]);

        var options = {
          title: 'My Activity Ratio',
          pieHole: 0.4,
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
        chart.draw(data, options);
      }
    </script>
  </head>
  <body>
    <div id="donutchart" style="width: 900px; height: 500px;"></div>
  </body>
</html>