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
            text: '걷고 뛴 비율 '
        },
        tooltip: {
            headerFormat: '',
            pointFormat: '<span style="color:{point.color}">\u25CF</span> <b> {point.name}</b><br/>' +
                '<b>{point.z}</b>%'
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