<!-- ë´ ê±°ë¦¬ ê·¸ëí -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<canvas id="example" >
    This text is displayed if your browser does not support HTML5 Canvas.
</canvas>
<script>
    var example = document.getElementById('example');
    var context = example.getContext('2d');
  //  context.fillStyle = 'red';
    //context.fillRect(30, 30, 50, 50);
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<div style="width:1200px; ">
  <canvas id="canvas"></canvas>
</div>


<script>
		
<% 
		
		Connection conn = null;
		
		String url = "jdbc:mysql://localhost:3306/AIWUserDB";
		String user = "root";
		String password = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, password);
		
		//ë¡ê·¸ì¸ íë©´ìì ID ë°ìì¤ê¸° 
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id"); //ë¡ê·¸ì¸ íë©´ìì id ê°ì ¸ì¤ê¸°
		
		
		
		//IDë¥¼ ê°ì§ê³  DBìì ì¿¼ë¦¬ ì¤ííê¸°
		ResultSet rs = null;
		Statement stmt =null;
		
		
		String sql="select id, distance_5, distance_10, distance_15, distance_20 from PlayInfo where id = '" + id + "'";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		while(rs.next()){
			
			String rId = rs.getString("id");
			String rDistance_5 = rs.getString("distance_5");
			String rDistance_10 = rs.getString("distance_10");
			String rDistance_15 = rs.getString("distance_15");
			String rDistance_20 = rs.getString("distance_20");
						
			if(id.equals(rId)){ // TT
				
				//String to Int 
				int intD_5 = Integer.parseInt(rDistance_5);
				int intD_10 = Integer.parseInt(rDistance_10);
				int intD_15 = Integer.parseInt(rDistance_15);
				int intD_20 = Integer.parseInt(rDistance_20);
		%>
			
				//Chart  
				new Chart(document.getElementById("canvas"), {
		    		type: 'line',
		    		data: {
		        		labels: ['5', '10', '15', '20'],
		        		datasets: [{
		            		label: 'Coverage',
		            		data: [ //ì´ ë¶ë¶ DBìì ì½ì´ì¬ ê²
		                		
		            			/*
		            			2,
		                		3,
		                		3,
		                		3
		                		*/
		                		
		            			'<%= intD_5 %>',
		            			'<%= intD_10 %>',
		            			'<%= intD_15 %>',
		            			'<%= intD_20 %>'
		            			
		                		
		                		
		            		],
		            		borderColor: "rgba(255, 201, 14, 1)",
		            		backgroundColor: "rgba(255, 201, 14, 0.5)",
		            		fill: true,
		            		lineTension: 0
		        		}]
		    		},
		    		options: {
		        		responsive: true,
		        		title: {
		            		display: true,
		            		text: 'Distance graph'
		        		},
		        		tooltips: {
		            		mode: 'index',
		            		intersect: false,
		        		},
		        		hover: {
		            		mode: 'nearest',
		            		intersect: true
		        		},
		        		scales: {
		            		xAxes: [{
		                		display: true,
		                		scaleLabel: {
		                    		display: true,
		                    		labelString: 'Time'
		                		}
		            		}],
		            		yAxes: [{
		                		display: true,
		                		ticks: {
		                    		suggestedMin: 0,
		                		},
		                		scaleLabel: {
		                    		display: true,
		                    		labelString: 'Distance'
		                		}
		            		}]
		        		}
		    		}
				});
				
				
				
				
			}
		
			
		<%			
			if(rs != null)
				rs.close();
			if(stmt != null)
				stmt.close();
			if(conn != null)
				conn.close();
			
		
		}

		%>	
	

			
</script>	

