<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  %>
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
   String rspeed; float fSpeed;
   String rpower; float fPower;
   String rendurance; float fEndurance;
   String rtechnic; float fTechnic;
   String rpass; float fPass;
   String rshooting; float fShooting;
   
   %>
   
    <%   
   
     request.setCharacterEncoding("utf-8");
     String name = request.getParameter("name"); //이전 페이지에서 name이라는 변수에서 값 전달받음
     
      ResultSet rs = null;
      Statement stmt =null;
      
      try{
         
    	   	  
         //String sql="select speed, power, endurance, technic, pass, shooting from playerSignUpInfo where id = '"+ id + "'";
         String sql="select speed, power, endurance, technic, pass, shooting from playerSignUpInfo where name = '"+name+"'";
         
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
         
          
         
         while(rs.next()){	
        	 
           rspeed = rs.getString("speed");
           rpower=rs.getString("power");
           rendurance=rs.getString("endurance");
           rtechnic=rs.getString("technic");
           rpass=rs.getString("pass");
           rshooting = rs.getString("shooting");            
         }
         
         fSpeed = Float.parseFloat(rspeed);
         fPower= Float.parseFloat(rpower);
         fEndurance= Float.parseFloat(rendurance);
         fTechnic= Float.parseFloat(rtechnic);
         fPass= Float.parseFloat(rpass);
         fShooting= Float.parseFloat(rshooting);
     
      
      }catch (Exception e){
         
         
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

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<figure class="highcharts-figure">
    <div id="container"></div>
    <p class="highcharts-description">
        A spiderweb chart or radar chart is a variant of the polar chart.
        Spiderweb charts are commonly used to compare multivariate data sets,
        like this demo using six variables of comparison.
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
                    color: 'white'
                }
            },
            tooltip: {
                style: {
                    color: 'white'
                }
            }
        });
    }	 
 // 차트 그리기 시작
 
 
   Highcharts.chart('container', {

    chart: {
        polar: true,
        type: 'line'
    },
    accessibility: {
        description: 'A spiderweb chart compares the allocated budget against actual spending within an organization. The spider chart has six spokes. Each spoke represents one of the 6 departments within the organization: sales, marketing, development, customer support, information technology and administration. The chart is interactive, and each data point is displayed upon hovering. The chart clearly shows that 4 of the 6 departments have overspent their budget with Marketing responsible for the greatest overspend of $20,000. The allocated budget and actual spending data points for each department are as follows: Sales. Budget equals $43,000; spending equals $50,000. Marketing. Budget equals $19,000; spending equals $39,000. Development. Budget equals $60,000; spending equals $42,000. Customer support. Budget equals $35,000; spending equals $31,000. Information technology. Budget equals $17,000; spending equals $26,000. Administration. Budget equals $10,000; spending equals $14,000.'
    },
    title: {
        text: '<%=name%>',
        x: -80
    },
    pane: {
        size: '80%'
    },

    xAxis: {
        categories: ['Pass', 'Shooting', 'Endurance', 'Speed',
            'Power', 'Technic'],
        tickmarkPlacement: 'on',
        lineWidth: 0
    },

    yAxis: {
        gridLineInterpolation: 'polygon',
        lineWidth: 0,
        min: 0
    },

    tooltip: {
        shared: true,
        pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y:.0f}</b><br/>'

    },

    legend: {
        align: 'right',
        verticalAlign: 'middle',
        layout: 'vertical'
    },

    series: [{
        name: '2018/2019 season',
       
        data: [<%=fPass%> , <%=fShooting%>, <%=fEndurance%>, <%=fSpeed%>, <%=fPower%>, <%=fTechnic%>],
        
        pointPlacement: 'on'
    }],
  
    responsive: {
        rules: [{
            condition: {
                maxWidth: 500
            },
            chartOptions: {
                legend: {
                	
                	
                    align: 'center',
                    verticalAlign: 'bottom',
                    layout: 'horizontal'
                },
                pane: {
                    size: '70%'
                }
            }
        }]
    }

});

    </script>
</figure>

</body>

</html>