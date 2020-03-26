<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<style>
		#container {
	height: 500px;
}

.highcharts-figure, .highcharts-data-table table {
    min-width: 320px; 
    max-width: 700px;
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
            
         String sql="select walk, jog, sprint from " + id + " where play_id = '1'";
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
      
         
         while(rs.next()){
                     
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
      
</head>
<body>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/variable-pie.js"></script>
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
	//theme 색깔 적용
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
 // 차트 그리기 시작
 
    Highcharts.chart('container', {
        chart: {
            type: 'variablepie'
        },
        title: {
            text: 'The ratio of walk, jog and sprint while you played'
        },
        tooltip: {
            headerFormat: '',
            pointFormat: '<span style="color:{point.color}">\u25CF</span> <b> {point.name}</b><br/>' +
                'Area (square m): <b>{point.y}</b><br/>' +
                'Population density (people per square km): <b>{point.z}</b><br/>'
        },
        series: [{
            minPointSize: 10,
            innerSize: '20%',
            zMin: 0,
            name: 'countries',
            data: [{
                name: 'Walk',
                y: 505370,
                z: <%= Float.parseFloat(rWalk) %>
            }, {
                name: 'Jog',
                y: 551500,
                z: <%= Float.parseFloat(rJog) %>
            }, {
                name: 'Sprint',
                y: 312685,
                z: <%= Float.parseFloat(rSprint) %>
            }]
        }]
    });
    </script>
</figure>

</body>

</html>