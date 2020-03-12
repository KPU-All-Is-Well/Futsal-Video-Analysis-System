
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


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

	<!--[if lt IE 9]>
		<script src="js/vendor/html5shiv.min.js"></script>
		<script src="js/vendor/respond.min.js"></script>
	<![endif]-->

</head> 

<style>
	body{
		background-color: #000000;
	}
</style>

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
                                <a href="teamDate_coach.jsp" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">My Data </a>
                              
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">My Video</a>
                                
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Calendar</a>
                                
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Coach Note</a>
                                
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
						<li><a href="#">Coach Note</a></li>
						
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
	
	
    <div id="wrapper">

		<!--
        <div id="home" class="video-section js-height-full">
            <div class="overlay"></div>
            <div class="home-text-wrapper relative container">
                <div class="home-message">
                    <img src="images/rsz_1biglogo.png" alt=""> 
                    <p>Welcome to All Is Well</p>
                    <div class="btn-wrapper">
                        <div class="text-center">
                            <a href="#" class="btn btn-primary">Sign In</a> &nbsp;<a href="#" class="btn btn-default">Sign Up</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        -->

            <div class="section footer" > <!-- section bgcolor noover  -->
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="tagline-message" >
                            <h3>Hello! we are All Is Well, we have brought together the best quality services, offers, projects for you!</h3>
                        </div>
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
        </div><!-- end section -->



<style> 	
#test_btn1
{ border-top-left-radius: 5px;
 border-bottom-left-radius: 5px;
  margin-right:-4px;   
  } 
#test_btn2
{ border-top-right-radius: 5px;
 border-bottom-right-radius: 5px;
  margin-left:-3px; 
  }
 #btn_group button
 {
  border: 1px solid skyblue;
  background-color: rgba(0,0,0,0);
   color: skyblue;
    padding: 5px; 
    } 
 #btn_group button:hover
 { color:white; 
 background-color: skyblue;
  } 
</style>
  
 <div id="btn_group" style="text-align:center"  >
 <a href="playerData_Coach.jsp"> <button id="test_btn1">Player Data </button></a> 
<a href="matchData_Coach.jsp"> <button id="test_btn2">Team Data </button></a>
</div>
 
 </html>

<!---------------------------------------------- DB에서 읽은 그래프 ---------------------------------------------------->
  
      
 <section class="ftco-section">
			<div class="container">
				<div class="row">
					<div class="col-md-8">
	          <div class="heading-section ftco-animate">
	          	<span class="subheading">Game Report</span>
	            <h2 class="mb-4">Baseball Game Reports 2019</h2>
	          </div>
	          <div class="row">
	          	<div class="col-md-12">
	          		<div class="scoreboard scoreboard-2 slash">
			          	<div class="divider ftco-animate text-center mb-4"><span>Mon. June 3, 2019; Baseball Champions League</span></div>
			          	<div class="sport-team-wrap ftco-animate">
			          		<span class="vs">vs</span>
				          	<div class="d-sm-flex mb-4">
					          	<div class="sport-team d-flex align-items-center">
				          			<div class="img logo" style="background-image: url(images/team-1.jpg);"></div>
												<div class="text-center px-1 px-md-3 desc">
													<h3 class="score win"><span>12</span></h3>
													<h4 class="team-name">Phoenix</h4>
												</div>
					          	</div>
					          	<div class="sport-team d-flex align-items-center">
				          			<div class="img logo order-sm-last" style="background-image: url(images/team-2.jpg);"></div>
												<div class="text-center px-1 px-md-3 desc">
													<h3 class="score lost"><span>8</span></h3>
													<h4 class="team-name">Mighty Falcons</h4>
												</div>
					          	</div>
				          	</div>
			          	</div>
			          	<div class="text-center ftco-animate">
				          	<p class="mb-0"><a href="#" class="btn btn-black">More Details</a></p>
				          </div>
			          </div>
	          	</div>
	          	<div class="col-md-12">
	          		<div class="scoreboard scoreboard-2 slash">
			          	<div class="divider ftco-animate text-center mb-4"><span>Mon. June 3, 2019; Baseball Champions League</span></div>
			          	<div class="sport-team-wrap ftco-animate">
			          		<span class="vs">vs</span>
				          	<div class="d-sm-flex mb-4">
					          	<div class="sport-team d-flex align-items-center">
				          			<div class="img logo" style="background-image: url(images/team-3.jpg);"></div>
												<div class="text-center px-1 px-md-3 desc">
													<h3 class="score win"><span>12</span></h3>
													<h4 class="team-name">Phoenix</h4>
												</div>
					          	</div>
					          	<div class="sport-team d-flex align-items-center">
				          			<div class="img logo order-sm-last" style="background-image: url(images/team-4.jpg);"></div>
												<div class="text-center px-1 px-md-3 desc">
													<h3 class="score lost"><span>8</span></h3>
													<h4 class="team-name">Mighty Falcons</h4>
												</div>
					          	</div>
				          	</div>
			          	</div>
			          	<div class="text-center ftco-animate">
				          	<p class="mb-0"><a href="#" class="btn btn-black">More Details</a></p>
				          </div>
			          </div>
	          	</div>
	          	<div class="col-md-12">
	          		<div class="scoreboard scoreboard-2 slash">
			          	<div class="divider ftco-animate text-center mb-4"><span>Mon. June 3, 2019; Baseball Champions League</span></div>
			          	<div class="sport-team-wrap ftco-animate">
			          		<span class="vs">vs</span>
				          	<div class="d-sm-flex mb-4">
					          	<div class="sport-team d-flex align-items-center">
				          			<div class="img logo" style="background-image: url(images/team-5.jpg);"></div>
												<div class="text-center px-1 px-md-3 desc">
													<h3 class="score win"><span>12</span></h3>
													<h4 class="team-name">Phoenix</h4>
												</div>
					          	</div>
					          	<div class="sport-team d-flex align-items-center">
				          			<div class="img logo order-sm-last" style="background-image: url(images/team-6.jpg);"></div>
												<div class="text-center px-1 px-md-3 desc">
													<h3 class="score lost"><span>8</span></h3>
													<h4 class="team-name">Mighty Falcons</h4>
												</div>
					          	</div>
				          	</div>
			          	</div>
			          	<div class="text-center ftco-animate">
				          	<p class="mb-0"><a href="#" class="btn btn-black">More Details</a></p>
				          </div>
			          </div>
	          	</div>
	          	<div class="col-md-12">
	          		<div class="scoreboard scoreboard-2 slash">
			          	<div class="divider ftco-animate text-center mb-4"><span>Mon. June 3, 2019; Baseball Champions League</span></div>
			          	<div class="sport-team-wrap ftco-animate">
			          		<span class="vs">vs</span>
				          	<div class="d-sm-flex mb-4">
					          	<div class="sport-team d-flex align-items-center">
				          			<div class="img logo" style="background-image: url(images/team-3.jpg);"></div>
												<div class="text-center px-1 px-md-3 desc">
													<h3 class="score win"><span>12</span></h3>
													<h4 class="team-name">Phoenix</h4>
												</div>
					          	</div>
					          	<div class="sport-team d-flex align-items-center">
				          			<div class="img logo order-sm-last" style="background-image: url(images/team-6.jpg);"></div>
												<div class="text-center px-1 px-md-3 desc">
													<h3 class="score lost"><span>8</span></h3>
													<h4 class="team-name">Mighty Falcons</h4>
												</div>
					          	</div>
				          	</div>
			          	</div>
			          	<div class="text-center ftco-animate">
				          	<p class="mb-0"><a href="#" class="btn btn-black">More Details</a></p>
				          </div>
			          </div>
	          	</div>
	          </div>
	          <div class="row mt-5">
		          <div class="col text-center">
		            <div class="block-27">
		              <ul>
		                <li><a href="#">&lt;</a></li>
		                <li class="active"><span>1</span></li>
		                <li><a href="#">2</a></li>
		                <li><a href="#">3</a></li>
		                <li><a href="#">4</a></li>
		                <li><a href="#">5</a></li>
		                <li><a href="#">&gt;</a></li>
		              </ul>
		            </div>
		          </div>
		        </div>
	        </div>
					<div class="col-md-4 sidebar">
						<div class="sidebar-box">
	            <h2 class="mb-4">Latest Video</h2>
							<div class="img d-flex align-items-center justify-content-center py-5" style="background-image: url(images/victory.jpg); width: 100%;">
								<p class="text-center mb-0 py-5">
									<a href="https://vimeo.com/45830194" class="icon-video-2 popup-vimeo d-flex justify-content-center align-items-center mr-3">
		    						<span class="ion-ios-play"></span>
		    					</a>
		    					<small style="color: rgba(255,255,255,1); font-size: 16px;">Watch Highlights</small>
	    					</p>
							</div>
						</div>
						<div class="sidebar-box">
	            <h2 class="mb-4">League Table</h2>
	            <table class="table table-league">
						    <thead>
						      <tr>
						        <th>Team</th>
						        <th>G</th>
						        <th>P</th>
						      </tr>
						    </thead>
						    <tbody>
						      <tr>
						        <td>Knights Warrior</td>
						        <td>14</td>
						        <td>24</td>
						      </tr>
						      <tr>
						        <td>Mighty Falcons</td>
						        <td>14</td>
						        <td>24</td>
						      </tr>
						      <tr>
						        <td>Germany Baseball</td>
						        <td>14</td>
						        <td>24</td>
						      </tr>
						      <tr>
						        <td>Colorado</td>
						        <td>14</td>
						        <td>24</td>
						      </tr>
						      <tr>
						        <td>Florida CLub</td>
						        <td>14</td>
						        <td>24</td>
						      </tr>
						      <tr>
						        <td>Miami Club</td>
						        <td>14</td>
						        <td>24</td>
						      </tr>
						      <tr>
						        <td>Toronto Team</td>
						        <td>14</td>
						        <td>24</td>
						      </tr>
						    </tbody>
						  </table>
						</div>
						<div class="sidebar-box">
	            <h2 class="mb-4">Top Scores</h2>
	            <div class="row">
	            	<div class="col-md-6 top-score pb-4 mb-1">
			    				<div class="img" style="background-image: url(images/staff-1.jpg);"></div>
			    				<div class="text text-center">
			    					<h3 class="mb-0">David Scott</h3>
			    					<span class="score">12 games / 10 goals</span>
			    				</div>
		    				</div>
		    				<div class="col-md-6 top-score pb-4 mb-1">
			    				<div class="img" style="background-image: url(images/staff-2.jpg);"></div>
			    				<div class="text text-center">
			    					<h3 class="mb-0">David Scott</h3>
			    					<span class="score">12 games / 10 goals</span>
			    				</div>
		    				</div>
		    				<div class="col-md-6 top-score pb-4 mb-1">
			    				<div class="img" style="background-image: url(images/staff-3.jpg);"></div>
			    				<div class="text text-center">
			    					<h3 class="mb-0">David Scott</h3>
			    					<span class="score">12 games / 10 goals</span>
			    				</div>
		    				</div>
		    				<div class="col-md-6 top-score pb-4 mb-1">
			    				<div class="img" style="background-image: url(images/staff-4.jpg);"></div>
			    				<div class="text text-center">
			    					<h3 class="mb-0">David Scott</h3>
			    					<span class="score">12 games / 10 goals</span>
			    				</div>
		    				</div>
	            </div>
						</div>
					</div>
				</div>
			</div>
		</section>






                      
 
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
</element>