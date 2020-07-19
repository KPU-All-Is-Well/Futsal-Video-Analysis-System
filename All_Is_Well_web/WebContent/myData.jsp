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

</head> 
<style>
	body{
		background-color: #000000;
	}
</style>

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

						<!--Home -->
                        <li class="child-menu"><a href="home.jsp">Home</a>
                            
                        </li>

						 <!--My Data  -->
                        <li class="myData.jsp"><a href="#">My Data </a>
                          
                        </li>

						<!--My Data-->
                        <li class="child-menu"><a href="#">My Video </a>
                         </li>

						<!--Calendar¨ -->	
						<li><a href="#">Calendar</a></li>

						<!--Coach Note  -->	
						<li><a href="#">Coach Note</a></li>
						
						<!--Contact  -->  
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
  
   div.relative { 
        position: relative;
        left:70px;
        top: 50px;
      }        
</style>

 <div id="wrapper"> 
 <div id="btn_group" style="text-align:center; ">
 <a href="playerData.jsp"> <button>My Data </button></a> 
<a href="teamData.jsp"> <button>Team Data </button></a>
</div>
 
 </html>

<!---------------------------------------------- DB에서 읽은 그래프 ---------------------------------------------------->

 <div id = "tmp"></div>

<div class= "relative" style="float: center;margin-top:100px;">
<iframe name="f3" src="highchart/highchart_Spyder.jsp" width="1200" height="500" scrolling="no" frameborder="no">
 </iframe>
</div>


<div style="float: center;">
<iframe name="f2" src="highchart/highchart_Gauge.jsp" width="1200" height="500" scrolling="no" frameborder="no">
 </iframe>
</div>
	
	
<div style="float: center;">
<iframe name="f5" src="highchart/highchart_Pie.jsp" width="1200" height="500" scrolling="no" frameborder="no">
 </iframe>
</div>

<div style="float:center;">
<iframe name="f1" src="highchart/highchart_Area.jsp" width="1300" height="500" scrolling="no" frameborder="no">
</iframe>
</div>

<div style="float: center;">
<iframe name="f4" src="printHeatmap.jsp" width="1200" height="700" scrolling="no" frameborder="no">
</iframe>
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