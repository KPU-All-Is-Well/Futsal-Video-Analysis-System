<!-- chartjs_line.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<html>
<body>

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

   <%@ include file="dbconn.jsp" %>
   <%! String rId;
   String rDistance_5;
   String rDistance_10;
   String rDistance_15;
   String rDistance_20;
   %>
   
   <%
      request.setCharacterEncoding("utf-8");
      String id = (String)session.getAttribute("id");
      
      ResultSet rs = null;
      Statement stmt =null;
      
      try{
            
         String sql="select id, distance_5, distance_10, distance_15, distance_20 from PlayInfo where id = '" + id + "'";
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
         //if(stmt != null)
         //   stmt.close();
         
         while(rs.next()){
                     
            rId = rs.getString("id");
            rDistance_5 = rs.getString("distance_5");
            rDistance_10 = rs.getString("distance_10");
            rDistance_15 = rs.getString("distance_15");
            rDistance_20 = rs.getString("distance_20");
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
   <h2><%=rDistance_5%>
   <%=rDistance_10%>
   <%=rDistance_15%>
   <%=rDistance_20%></h2>
   


<script>
new Chart(document.getElementById("canvas"), {
    type: 'line',
    data: {
        labels: ['5', '10', '15', '20'],
        datasets: [{
            label: 'Coverage',
            data: [
               <%=rDistance_5%>,
               <%=rDistance_10%>,
               <%=rDistance_15%>,
               <%=rDistance_20%>
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

</script>


</body>
</html>