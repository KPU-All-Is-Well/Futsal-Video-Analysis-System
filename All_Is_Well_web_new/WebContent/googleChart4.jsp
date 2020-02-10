<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    

<html>
  <head>
  
	<%@ include file="dbconn.jsp" %>
   <%! 
   Float fDistance_5; String distance_5; 
   Float fDistance_10; String distance_10;
   Float fDistance_15; String distance_15;
   Float fDistance_20; String distance_20;
   
   float stamina; //처음 시작할 때는 10으로 시작
   float stamina_5; 
   float stamina_10;
   float stamina_15; 
   float stamina_20; 
   
   %>
   
   <%   
   
      request.setCharacterEncoding("utf-8");
      String id = (String)session.getAttribute("id");
      
      ResultSet rs = null;
      Statement stmt =null;
      
      try{
            
         String sql="select distance_5, distance_10, distance_15, distance_20 from " + id + " where play_id = '1'";
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
      
         
         while(rs.next()){
                     
            distance_5 = rs.getString("distance_5");
            distance_10 = rs.getString("distance_10");
            distance_15 = rs.getString("distance_15");
            distance_20 = rs.getString("distance_20");
            
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
      
      fDistance_5 = Float.parseFloat(distance_5);
      fDistance_10 = Float.parseFloat(distance_10);
      fDistance_15 = Float.parseFloat(distance_15);
      fDistance_20 = Float.parseFloat(distance_20);
      
      //체력 변화 계산 알고리즘
      stamina = 100;
      stamina_5 = 0; 
      stamina_10 = 0;
      stamina_15 = 0; 
      stamina_20 = 0;
      
      
      stamina -= 10;
      stamina_5 = stamina;
      
      
      if(fDistance_5 > fDistance_10){
    	  stamina -= 20;
    	  stamina_10 = stamina;
      }else{
    	  //stamina -= 10;
    	  stamina_10 = stamina;
      }
      
      if(fDistance_10 > fDistance_15){
    	  stamina -= 20;
    	  stamina_15 = stamina;
      }else{
    	  //stamina -= 10;
    	  stamina_15 = stamina;
      }
      
      if(fDistance_15 > fDistance_20){
    	  stamina -= 20;
    	  stamina_20 = stamina;
      }else{
    	  //stamina -= 10;
    	  stamina_20 = stamina;
      }
      
      
      
      
     %>
      
    
     
     <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Minute', 'Amount of Activity', 'Stamina'],
          ['0',  0,      100],
          ['5',  <%= fDistance_5 %>,   <%= stamina_5 %>   ],
          ['10', <%= fDistance_10 %>,  <%= stamina_10 %>],
          ['15', <%= fDistance_15 %>,  <%= stamina_15 %>],
          ['20', <%= fDistance_20 %>,  <%= stamina_20 %>]
        ]);

        var options = {
          title: 'Change of your amount of activity and stamina',
          hAxis: {title: ' ',  titleTextStyle: {color: '#333'}},
          vAxis: {minValue: 0}
        };

        var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
     
    
  </head>
  <body>
    <div id="chart_div" style="width: 100%; height: 500px;"></div>
  </body>
</html>