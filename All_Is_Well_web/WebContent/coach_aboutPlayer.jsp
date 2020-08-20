<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js " lang="en">
<head>
    <!-- Basic -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    
    <!-- Mobile Meta -->
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
    <!-- Site Meta -->
    <title>All is Well</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="author" content="">
    
    <!-- Site Icons --> <!-- 브라우저 창 위에 보이는 아이콘 -->
	<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
    <link rel="apple-touch-icon" href="images/apple-touch-icon.png">
	
	<!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet"> 
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700" rel="stylesheet"> 

	<!-- Custom & Default Styles -->
	<link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/carousel.css">
    <link rel="stylesheet" href="style.css">
<style> 	

#btn_group button
 {    
 border: 1px solid black;
  background-color: #090823;
   color: skyblue;
    padding: 18px; 
    margin-left: 8px;
    width:380px; font-size:large; font-weight:bold; font-family: sans-serif;
    border-top-left-radius: 10px;
 border-bottom-left-radius: 10px; 
  border-top-right-radius: 10px;
 border-bottom-right-radius: 10px;       
    
 } 
 #btn_group button:hover
 { color:white; 
 background-color: skyblue;
  } 
  
 img.relative { 
        position: relative;
        left:150px;
        top: 100px;
      }      
      
 div.relative { 
        position: relative;
        left:600px;
        top: -500px;
      }     
      
   table {
   	
    width: 40%;
    border-top: 1.2px solid #F62366;
    border-collapse: collapse;
  
  }
  th, td {
    border-bottom: 1.2px solid #F62366;
 	text-align:center;
 	padding: 8px;
 	
  }
  
  body{
		background-color: #000000;
	}
	
	
	
</style>
</head> 


<body class="left-menu"  >
    <div class="menu-wrapper">
        <header class="vertical-header">
            <div class="vertical-header-wrapper">
                <nav class="nav-menu">
                    <div class="logo">
                        <a href="index.html"><img src="images/rsz_1logo.png" alt=""> </a>
                    </div><!-- end logo -->

                    <div class="margin-block"></div>

                    <ul class="primary-menu">

						<!--Home  -->
                        <li class="child-menu"><a href="home_of_Coach.jsp">Home</a>
                            
                        </li>

						 <!--My Data-->
                        <li class="teamData_coach.jsp"><a href="teamData_coach.jsp">Team Data </a>
                          
                        </li>

						<!--My Data -->
                        <li class="child-menu"><a href="#">My Video </a>
                            
                         
                        </li>

	      
					
						<!--Calendar-->	
						<li><a href="#">Calendar</a></li>

						<!--Coach Note-->	
						<li><a href="#">Coach Note</a></li>
						
						<!--Contact-->  
                        <li><a href="#">Contact</a></li>

                    </ul>
                    
                    <div class="margin-block"></div>
					
				
			 <!-- end menu-search -->

                    <div class="margin-block"></div>

                </nav><!-- end nav-menu -->
            </div><!-- end vertical-header-wrapper -->
        </header><!-- end header -->
    </div><!-- end menu-wrapper -->
	
<!------------------------------------------------------------- end left menu ------------------------------------------------------------------------->


<div id="wrapper">  
<div id="btn_group" style="text-align:center"  >
<a href="playerData_Coach.jsp"> <button id="test_btn1">Player</button></a> 
<a href="matchData_Coach.jsp"> <button id="test_btn2">Match </button></a>
<a href="printHeatmap_Coach.jsp"> <button id="test_btn3">Position </button></a>
</div>
 <img src="images/player.png" class="relative" >
 <%@ page import="java.net.URLEncoder" %>
 <%@page import="java.sql.*"%>
<%@page import="java.util.*"%> 
<%@page import="java.lang.*"%> 
<%!
	String en_name; //이름
	String height;
	String weight;
	String age;
	String team;	
	String mainPosition; //메인 포지션

%>

 <%
 	request.setCharacterEncoding("UTF-8");
 
	 String name = request.getParameter("name"); 
	 
	
	 Connection con = null;
	 ResultSet rs = null;
	 ResultSet rs2 = null;
	 

       try {
        //드라이버 호출, 커넥션 연결
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        
     
        con = DriverManager.getConnection(
                "jdbc:mysql://15.164.30.158:3306/AIWUserDB", "sk", "1234");
        
        String query = "select en_name, height, weight, age, team, mainPosition from playerSignUpInfo where name = '"+ name+"'"; //get data from ID table
            
        
        
        PreparedStatement pstm = con.prepareStatement(query);
        
        rs = pstm.executeQuery();


        while(rs.next()){
           
        
           
           try{
           
        	   en_name = rs.getString("en_name"); //이름
               height=rs.getString("height");
               weight=rs.getString("weight");
               age=rs.getString("age");
               team = rs.getString("team");
               mainPosition = rs.getString("mainPosition"); //메인 포지션
        	   
        	 
        	}catch(Exception e){ //Null Pointer Exception 발생시 ArrayList에 추가 안 함(→  null인 곳을 참조하게 되므로)
      	  	//아무것도 x 
        	}finally{
        
        	}	
            
        }//end while
        

 
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (con != null) {
            try {
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
 
    }
    
    
    
    
 %>
<div class="relative">

<iframe name="f1" src="highchart/highchart_Spyder_Coach.jsp?name=<%=URLEncoder.encode(name, "UTF-8") %>" width="550" height="500" scrolling="no" frameborder="no"></iframe>

<!--이름 키 몸무게  나이 팀 포지션  -->

<div style = " position: relative; right: 50px; ">
	<table>
		<tr>
			<td>Name</td>  <td> Team</td> <td> Position</td><td>Height</td> <td>Weight</td> <td> Age</td>
		</tr>
		<tr>
			<td><%= en_name%></td> <td><%= team%></td><td><%= mainPosition%></td><td><%= height%>cm</td> <td><%= weight%>kg</td> <td><%= age%></td>   
		</tr>
	</table>
</div>

</div>

<section class="section parallax" data-stellar-background-ratio="0.1 ">
<!-- 선수들 간 데이터 비교 -->
<div style="float:left;">
<iframe name="f6" src="highchart/highchart_3D.jsp" width="370" height="420" scrolling="no" frameborder="no">
 </iframe>
</div>

<div style="float: left;">
<iframe name="f5" src="highchart/highchart_Distance_Rank.jsp" width="370" height="420" scrolling="no" frameborder="no">
 </iframe>
</div>

<div style="float: left;">
<iframe name="f6" src="highchart/highchart_Column.jsp" width="370" height="420" scrolling="no" frameborder="no">
 </iframe>
</div>

<div style="float: left;">
<iframe name="f6" src="highchart/highchart_Column_avg.jsp" width="370" height="420" scrolling="no" frameborder="no">
 </iframe>
</div>



<div style="float: left;">
<iframe name="f6" src="highchart/highchart_BasicBar.jsp" width="370" height="420" scrolling="no" frameborder="no">
 </iframe>
</div>

<div style="float: left;">
<iframe name="f6" src="highchart/highchart_Fixed.jsp" width=370" height="420" scrolling="no" frameborder="no">
 </iframe>
</div>

<!-- 개인 데이터  -->
<div style="float: left;">
<iframe name="f6" src="highchart/highchart_Area_Coach.jsp?name=<%=URLEncoder.encode(name, "UTF-8") %>" width=370" height="420" scrolling="no" frameborder="no">
</iframe>
</div>


<div style="float: left;">
<iframe name="f6" src="highchart/highchart_Gauge_Coach.jsp?name=<%=URLEncoder.encode(name, "UTF-8") %>" width=370" height="420" scrolling="no" frameborder="no">
 </iframe>
</div>

<div style="float: left;">
<iframe name="f6" src="highchart/highchart_Pie_Coach.jsp?name=<%=URLEncoder.encode(name, "UTF-8") %>" width=370" height="420" scrolling="no" frameborder="no">
 </iframe>
</div>
 </section>          
 </div>
 </html>                
 
<!--------------------------------------------------- end Content ------------------------------------------------------------------>
</div>
    <!-- -----------------------------------------------jQuery Files ------------------------------------------------------------------>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/carousel.js"></script>
    <script src="js/parallax.js"></script>
    <script src="js/rotate.js"></script>
    <script src="js/custom.js"></script>
    <script src="js/masonry.js"></script>
    
    <script src="js/masonry-4-col.js"></script>
    <!-- VIDEO BG PLUGINS -->
    <script src="videos/libs/swfobject.js"></script> 
    <script src="videos/libs/modernizr.video.js"></script> 
    <script src="videos/libs/video_background.js"></script> 
    <script>
        jQuery(document).ready(function) {
            var Video_back = new video_background($("#home"), { 
                "position": "absolute", //Follow page scroll
                "z-index": "-1",        //Behind everything
                "loop": true,           //Loop when it reaches the end
                "autoplay": true,       //Autoplay at start
                "muted": true,          //Muted at start
                "mp4":"videos/video.mp4" ,     //Path to video mp4 format
                "video_ratio": 1.7778,              // width/height -> If none provided sizing of the video is set to adjust
                "fallback_image": "images/dummy.png",   //Fallback image path
                "priority": "html5"             //Priority for html5 (if set to flash and tested locally will give a flash security error)
            });
        });
    </script>

</body>
</html>