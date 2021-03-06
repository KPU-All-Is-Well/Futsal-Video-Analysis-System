<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.util.*"%> 
<%@page import="java.lang.*"%> 



<!doctype html>
<!--[if IE 9]> <html class="no-js ie9 fixed-layout" lang="en"> <![endif]-->
<!--[if gt IE 9]><!--> <html class="no-js " lang="en"> <!--<![endif]-->
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


</head> 

<style>
	body{
		background-color: #000000;
	}
</style>

<%@ include file="dbconn.jsp" %>

   <%! 

   ArrayList<String> arrayName = new ArrayList<>(); //이름 담을 ArrayList
   ArrayList<String> arrayId = new ArrayList<>(); //id 담을 ArrayList
   ArrayList<String> arrayPosition = new ArrayList<>(); //포지션 담을 ArrayList
   String[] arrName; //List를 배열로 바꿔 담을 공간
   String[] arrPosition;
   String[] arrId;
   String team;
   
   %>
   
   <%   
      arrayName.clear();
	  arrayId.clear();
      arrayPosition.clear();
      request.setCharacterEncoding("utf-8");
      String id = (String)session.getAttribute("id"); // 사용자가 로그인 할 때, 적은 정보를 가져오겠다.
      
      ResultSet rs2 = null;
      Statement stmt2 =null;
      
      ResultSet rs1 = null;
      Statement stmt1 =null;
      
      try{
         
    	  // ① 로그인한 감독의 팀명 받아오기
    	 String sql1 =  "select team from coachSignUpInfo where id = '" + id + "'";
    	 stmt1 = conn.createStatement();
         rs1 = stmt1.executeQuery(sql1); 
    	 
         while(rs1.next()){
        	 team = rs1.getString("team");
         }
         
    	  // ② 감독이 관리하는 팀의 팀원들 List에 담기 
         String sql2="select id, name, mainPosition from playerSignUpInfo where team = '"+ team + "'";
         stmt2 = conn.createStatement();
         rs2 = stmt2.executeQuery(sql2);
      
         
         while(rs2.next()){
                     
        	String name = rs2.getString("name");
            String position = rs2.getString("mainPosition");
            String DBid = rs2.getString("id"); 
            arrayId.add(DBid); //id List에 추가
            arrayName.add(name); //이름 List에 추가
        	arrayPosition.add(position); //포지션 List에 추가
         }
         
         arrName = arrayName.toArray(new String[arrayName.size()]); //arrayName(리스트)) -> arrName(배열)
         arrPosition = arrayPosition.toArray(new String[arrayPosition.size()]); //arrayPosition(리스트)) -> arrPosition(배열)
         arrId = arrayId.toArray(new String[arrayId.size()]); //arrayPosition(리스트)) -> arrPosition(배열)
      
      }catch (SQLException ex){
         out.println("SQLException: "+ex.getMessage());
         
      }finally{
         
         if(rs2 != null)
            rs2.close();
         if(stmt2 != null)
            stmt2.close();
         if(conn != null)
            conn.close();
         
      }
      
     %>


<body class="left-menu"  >

    
    <div class="menu-wrapper">
        <div class="mobile-menu">
            <nav class="navbar navbar-inverse">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="index.html"><img src="images/logo-normal.png" alt=""></a>
                    </div>
                    <div id="navbar" class="navbar-collapse collapse">
                        <ul class="nav navbar-nav">
                            <li class="dropdown">
                                <a href="home_of_Coach.jsp" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Home </a>
                               
                            </li>
                            <li class="dropdown">
                                <a href="teamDate_coach.jsp" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Team Data </a>
                              
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">My Video</a>
                                
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Calendar</a>
                                
                            </li>
                            <li class="dropdown">
                                <a href="Feedback_coach.jsp" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Coach Note</a>
                                
                            </li>
                            <li><a href="#">Contact</a></li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                         
                        </ul>
                    </div><!--/.nav-collapse -->
                </div><!--/.container-fluid -->
            </nav>
        </div><!-- end mobile-menu --------------------------------------------------------------------->

        <header class="vertical-header">
            <div class="vertical-header-wrapper">
                <nav class="nav-menu">
                    <div class="logo">
                        <a href="index.html"><img src="images/rsz_1logo.png" alt=""> </a>
                    </div><!-- end logo -->

                    <div class="margin-block"></div>

                    <ul class="primary-menu">

						<!--Home ëª©ì°¨ -->
                        <li class="child-menu"><a href="home_of_Coach.jsp">Home</a>
                            
                        </li>

						 <!--My Data ëª©ì°¨ -->
                        <li class="teamData_coach.jsp"><a href="teamData_coach.jsp">Team Data </a>
                          
                        </li>

						<!--My Data ëª©ì°¨ -->
                        <li class="child-menu"><a href="#">My Video </a>
                            
                         
                        </li>

	      
					
						<!--Calendar ëª©ì°¨ -->	
						<li><a href="#">Calendar</a></li>

						<!--Coach Note ëª©ì°¨ -->	
						<li><a href="Feedback_coach.jsp">Coach Note</a></li>
						
						<!--Contact ëª©ì°¨: ëë¥´ë©´ íì ì ë³´ -->  
                        <li><a href="#">Contact</a></li>

                        <!--<li><a href="https://html.design">Download <i class="fa fa-shopping-bag"></i></a></li> -->
                    </ul>
                    
                    <div class="margin-block"></div>
					
					<!--
                    <div class="menu-search">
                        <form>
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="What you are looking?">
                                <button class="btn btn-primary"><i class="fa fa-search"></i></button>
                            </div>
                        </form>
                    </div>
					--> <!-- end menu-search -->

                    <div class="margin-block"></div>

					<!--
                    <div class="menu-social">
                        <ul class="list-inline text-center">
                            <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                            <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                            <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                            <li><a href="#"><i class="fa fa-instagram"></i></a></li>
                        </ul>
                    </div>--><!-- end menu -->

                </nav><!-- end nav-menu -->
            </div><!-- end vertical-header-wrapper -->
        </header><!-- end header -->
    </div><!-- end menu-wrapper -->
	
<!------------------------------------------------------------- end left menu ------------------------------------------------------------------------->
	

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
  
  .card{
    	border-top-left-radius: 10px;
 	border-bottom-left-radius: 10px; 
  	border-top-right-radius: 10px;
 	border-bottom-right-radius: 10px; 
 	border:1px solid black;
  
  }
  
  
</style>
  

 <div id="wrapper">  
 <div id="btn_group" style="text-align:center; "   >

<a href="move2Profile.jsp"><button>Player </button>
<a href="matchData_Coach.jsp"> <button >Match </button></a>
<a href="printHeatmap_Coach.jsp"> <button >Position </button></a>
</div>
 
 </html>

<!----------------------------------------------선수들의 개인 프로필 출력 ---------------------------------------------------->

  <%@ page import="java.net.URLEncoder" %>

	
	 <div id = "tmp"></div>	
      <div class="container" style="margin-top:100px;">
            <div class="row">
           
               
               <%
               for(int i=0; i <arrId.length ; i++){
            	   
            	   if(i%3 == 1 && i != 1){
            	%>   
            			<div id = "tmp"></div>
 						<div class="col-sm-6 col-lg-3" style="margin-top : 60px;" >
            		<%
            	   	}else{
            	%>	
               			<div class="col-sm-6 col-lg-3">
               <%
            	   }
               %>
                  <div class="single_team_member single-home-blog">
                     <div class="card" >
                        <img  src="images/team/<%=arrId[i] %>.png"  class="card-img-top" alt="blog" style="width: auto; height: 400px;">
                        <div class="card-body">
                           <div class="tean_content">
                              <a href="#" class="blog_item_date">
                                 
                              </a>
                              <a href="coach_aboutPlayer.jsp?name=<%=URLEncoder.encode(arrName[i], "UTF-8") %> ">                            
                                 <h5 class="card-title" ><%=arrName[i] %></h5>
                              </a>
                              <p style = "font-weight:bold; font-family: sans-serif;"><%=arrPosition[i] %></p>
                           </div>
                           <div class="tean_right_content">
                              <div class="header_social_icon">
                                
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
               
               <%
               }//end for
               //}//end if
        
              
               %>
              
         </div>
      </section>
      <!-- about part start-->
      <!-- player info part start-->
      <section class="player_info section_padding">
         <div class="container">
            <div class="row">
               <div class="player_info_item owl owl-carousel">
                  <div class="player_info_iner">
                     <div class="row align-items-center">
                        <div class="col-md-6 col-xl-5">
                           <div class="player_info_img">
                              <img src="images/about.png" alt="">
                           </div>
                        </div>
                        <div class="col-md-6 offset-xl-1 col-xl-5">
                           <div class="player_info_text">
                              <h3>Jequline Dodge</h3>
                              <p>Together won't fowl you fish living in signs open which seed Face it above male in him his subdue spirit deep given. Won't forth don't cattle was were second fruitful. Together won't fowl Together won't fowl you fish living in signs open which seed Face it above male in him his subdue spirit deep given. Won't forth don't cattle was were second fruitful.</p>
                              <a href="#" class="">Swords Club</a> <img src="images/club_logo.png" alt="">
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="player_info_iner">
                     <div class="row align-items-center">
                        <div class="col-md-6 col-xl-5">
                           <div class="player_info_img">
                              <img src="images/about.png" alt="">
                           </div>
                        </div>
                        <div class="col-md-6 offset-xl-1 col-xl-5">
                           <div class="player_info_text">
                              <h3>Jequline Dodge</h3>
                              <p>Together won't fowl you fish living in signs open which seed Face it above male in him his subdue spirit deep given. Won't forth don't cattle was were second fruitful. Together won't fowl Together won't fowl you fish living in signs open which seed Face it above male in him his subdue spirit deep given. Won't forth don't cattle was were second fruitful.</p>
                              <a href="#" class="">Swords Club</a> <img src="images/club_logo.png" alt="">
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>








                      
 
<!--------------------------------------------------- end Content ------------------------------------------------------------------>


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
        jQuery(document).ready(function($) {
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