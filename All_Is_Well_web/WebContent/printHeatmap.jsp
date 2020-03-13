
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
        .shadow{
            width:50%;
            height:50%;
            margin:10% auto;
            overflow:hidden;
            border:1px solid black;
            background-color: #000000;
            
        }
         
        .shadow img{
            width:50%;
            height:50%;
            background-color: #000000;
            position:absolute;
            margin:auto;
            top:0; bottom:0; left:0; right:0;
            
        }
         
        .shadow img:hover{
            cursor:pointer;
            -webkit-transform:scale(1.1); /*  크롬 */
            -moz-transform:scale(1.1); /* FireFox */
            -o-transform:scale(1.1); /* Opera */
            transform:scale(1.1);
            transition: transform .35s;
            -o-transition: transform .35s;
            -moz-transition: transform .35s;
            -webkit-transition: transform .35s;
        }
        
        
       
		#container {
	max-width: 400px;
	margin: 0 auto;
}

.highcharts-figure, .highcharts-data-table table {
	min-width: 380px;    
	max-width: 600px;
    margin: 0 auto;
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



</style>


<body>
<%! String src="data:image/png;base64,"; %>

<%
      request.setCharacterEncoding("utf-8");
      

     String id = (String)session.getAttribute("id");
     //String id = "messi";
      
      String query="select result_heatmap from "+ id + " where play_id = '1'";
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

 
<div  style = text-align:center >
<div  style=color:white>

<h1><br>heatmap</h1>
</div>
</div>

<div class="shadow">
   <img src=<%=src%>>
</div>

</body>
</html>