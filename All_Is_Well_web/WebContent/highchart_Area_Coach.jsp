<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<style>
	.highcharts-figure, .highcharts-data-table table {
    min-width: 360px; 
    max-width: 800px;
    margin: 1em auto;
}

.highcharts-data-table table {
	font-family: Verdana, sans-serif;
	border-collapse: collapse;
	border: 1px solid #EBEBEB;
	margin: 10px auto;
	text-align: center;
	width: 100%;
	max-width: 500px;
}
.highcharts-data-table caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}
.highcharts-data-table th {
	font-weight: 600;
    padding: 0.5em;
}
.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
    padding: 0.5em;
}
.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}
.highcharts-data-table tr:hover {
    background: #f1f7ff;
}


body{
	background-color: #000000;
}


</style>


<%@ include file="dbconn.jsp" %>

   <%! 
   float fDistance_5; String distance_5; 
   float fDistance_10; String distance_10;
  	float fDistance_15; String distance_15;
   float fDistance_20; String distance_20;
   
   float fSpeed_5; String speed_5; 
   float fSpeed_10; String speed_10;
  	float fSpeed_15; String speed_15;
   float fSpeed_20; String speed_20;
   
   float stamina; //처음 시작할 때는 10으로 시작
   float stamina_5; 
   float stamina_10;
   float stamina_15; 
   float stamina_20; 
   
   String id;
   
   %>
   
   <%   
   
      request.setCharacterEncoding("utf-8");
   	  String name = request.getParameter("name"); //이전 페이지에서 name이라는 변수에서 값 전달받음
      
      ResultSet rs = null;
      Statement stmt =null;
      
      ResultSet rs1 = null;
      Statement stmt1 =null;
      
      try{
    	  //첫 번째 쿼리문 
    	  String sql1="select id from playerSignUpInfo where name = '"+name+"'";
    	  stmt1 = conn.createStatement();
          rs1 = stmt1.executeQuery(sql1);
    	  
          while(rs1.next()){
        	  id = rs1.getString("id");
          }
          
    	  //두 번째 쿼리문
          // 이 파일은 영상 끝까지 돌려야 그래프 제대로 출려됨, 그래야 4번 단위로 체크한 값이 데이터로 들어감, 너무 짧게 파이썬 프로그램 돌리면 null 값이 다 들어가서 NullPointerException 뜸    
         String sql="select speed_5, speed_10, speed_15, speed_20, distance_5, distance_10, distance_15, distance_20 from " + id + " where play_id = '1'";
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
		      
         
         while(rs.next()){
                     
        	 speed_5 = rs.getString("speed_5");
        	 speed_10 = rs.getString("speed_10");
        	 speed_15 = rs.getString("speed_15");
        	 speed_20 = rs.getString("speed_20");
            distance_5 = rs.getString("distance_5");
            distance_10 = rs.getString("distance_10");
            distance_15 = rs.getString("distance_15");
            distance_20 = rs.getString("distance_20");
            
         }
         
    	 
    	
    	
      }catch (Exception e){
         e.printStackTrace();
         
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
      
      fSpeed_5 = Float.parseFloat(speed_5);
      fSpeed_10 = Float.parseFloat(speed_10);
      fSpeed_15 = Float.parseFloat(speed_15);
      fSpeed_20 = Float.parseFloat(speed_20);
      
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
      
</head>
<body>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/series-label.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>



<figure class="highcharts-figure">
    <div id="container"></div>
    <p class="highcharts-description">
        A chart showing multiple gauge series arcing around the center point,
        similar to the activity chart found on the Apple Watch. Each gauge has a
        custom icon, and the tooltip is positioned statically in the center.
    </p>


    <script type="text/javascript">
 // Uncomment to style it like Apple Watch
/***************************************************/    
    
    if (!Highcharts.theme) {
        Highcharts.setOptions({
            chart: {
                backgroundColor: 'black'
            },
            colors: ['#F62366', '#9DFF02', '#0CCDD6'],
            title: {
                style: {
                    color: 'silver'
                }
            },
            tooltip: {
                style: {
                    color: 'silver'
                }
            }
        });
    }
    // */
	
    
Highcharts.chart('container', {

    title: {
        text: 'Change of Stamina'
    },

    subtitle: {
        text: 'Source: thesolarfoundation.com'
    },

    yAxis: {
        title: {
            text: ''
        }
    },

    xAxis: {
        accessibility: {
            rangeDescription: 'Range: 2010 to 2017'
        }
    },

    legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle'
    },

    plotOptions: {
        series: {
            label: {
                connectorAllowed: false
            },
            pointStart: 0,
            pointInterval: 5
        }
    },

    series: [{
        name: 'Stamina',
        data: [100, <%= stamina_5 %>, <%= stamina_10 %>, <%= stamina_15 %>, <%= stamina_20 %>]
    }, {
        name: 'Amount of Activity per 5 minutes',
        data: [0, <%= fDistance_5 %>, <%= fDistance_10 %>, <%= fDistance_15 %>, <%= fDistance_20 %>]
    }, {
        name: 'Amount of Speed per 5 minutes',
        data: [0, <%= fSpeed_5 %>, <%= fSpeed_10 %>, <%= fSpeed_15 %>, <%= fSpeed_20 %>]
    }],

    responsive: {
        rules: [{
            condition: {
                maxWidth: 500
            },
            chartOptions: {
                legend: {
                    layout: 'horizontal',
                    align: 'center',
                    verticalAlign: 'bottom'
                }
            }
        }]
    }

});
    </script>
    
</figure>    

<div id = "container" style="width:100%; height:400px;"> </div>
</body>

</html>