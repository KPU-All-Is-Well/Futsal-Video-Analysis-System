<!-- main.jsp -->
<%@ page contentType="text/html; charset=utf-8" %>

<!doctype html>
<!--[if IE 9]> <html class="no-js ie9 fixed-layout" lang="en"> <![endif]-->
<!--[if gt IE 9]><!--> <html class="no-js " lang="en"> <!--<![endif]-->
<head>
<meta http-equiv="Content-Type" content="text/html;charset=euc-kr;">
    <!-- Basic -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    
    <!-- Mobile Meta -->
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <!-- viewport를 성정할 것이며, 그 설정값은 content=""에 있다, device-width는 모바일 기기의 너비에 맞춘다.  유저의 크기 확대 no -->
    
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

<!--  -->
<body class="left-menu">
    
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
                                <a href="teamData_coach.jsp" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Team Data </a>
                              
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">My Video</a>
                                
                            </li>
                            <li class="dropdown">
                                <a href="calendar/schedule_list.jsp" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Calendar</a>
                                
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
        </div>
        
        <!-- end mobile-menu ------------------------------------------------------------------------------->

        <header class="vertical-header">
            <div class="vertical-header-wrapper">
                <nav class="nav-menu">
                    <div class="logo">
                        <a href="index.html"><img src="images/rsz_1logo.png" alt=""> </a>
                    </div><!-- end logo -->

                    <div class="margin-block"></div>

                    <ul class="primary-menu">

						<!--Home ëª©ì°¨ -->
                        <li class="child-menu"><a href="home_of_Coach.jsp">Home </a>
                          

						<!--My Data ëª©ì°¨ -->
                        <li class="child-menu"><a href="teamData_coach.jsp">Team Data</a>
                          
                        </li>

						<!--My Data ëª©ì°¨ -->
                        <li class="child-menu"><a href="#">Team Video</a>
                           
                                
                        </li>

					
						<!--Calendar ëª©ì°¨ -->	
						<li><a href="calendar/schedule_list.jsp">Calendar</a></li>

						<!--Coach Note ëª©ì°¨ -->	
						<li><a href="Feedback_coach.jsp">Coach Note</a></li>
						
						<!--Contact ëª©ì°¨: ëë¥´ë©´ íì ì ë³´ -->  
                        <li><a href="#">Contact</a></li>

                        <!--<li><a href="https://html.design">Download <i class="fa fa-shopping-bag"></i></a></li> -->
                    </ul>
                    
                    <div class="margin-block"></div>

                    <div class="margin-block"></div>

		

                </nav><!-- end nav-menu -->
            </div><!-- end vertical-header-wrapper -->
        </header><!-- end header -->
    </div><!-- end menu-wrapper -->
	
<!------------------------------------------------------------- end left menu ------------------------------------------------------------------------->
	
	
    <div id="wrapper">



        <div class="section footer" > <!-- section bgcolor noover  -->
            <div class="container"> 
                <div class="row">
                    <div class="col-md-12">
                        <div class="tagline-message" >
                            <h3><mark class="rotate">안녕하세요  &nbsp;, Bonjour&nbsp;&nbsp;, Hello&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</mark>   we are All Is Well, we have brought together the best quality services, offers, projects for you!</h3>
                        </div>
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
        </div><!-- end section -->

       



        <section class="section parallax" data-stellar-background-ratio="0.1 " style="background-image:url('images/upload/1920_1080(8).jpg');">
            <div class="container">
                <div class="section-title light-color text-center">
                    <h3>All is well </h3>
                    <h1 style="color:gray; font-size: 16px;">Welcome to <strong>All is well</strong> analysis program </h1>
                </div><!-- end title -->

                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="process-box" OnClick="location.href ='AT_Distance.jsp'" style="cursor:pointer;">			
                        		<!-- 버튼에 링크 거는 법 -->
                        		
                            <div class="process-front text-center">
                                <i class="flaticon-lightbulb-idea"></i>
                                <h3>We plan properly</h3>
                            </div><!-- end front -->

                            <div class="process-end text-center">
                                <h3>Result</h3>
                                <p>Quisque porttitor eros quis leo pulvinar, at hendrerit sapien iaculis.</p>
                            </div><!-- end end -->
                        </div><!-- end process -->
                    </div><!-- end col -->

                    <div class="col-lg-3 col-md-6">
                        <div class="process-box" OnClick="location.href ='AT_Distance.jsp'" style="cursor:pointer;">
                            <div class="process-front text-center">
                                <i class="flaticon-computer"></i>
                                <h3>Exactly anlysis program</h3>
                            </div><!-- end front -->

                            <div class="process-end text-center">
                                <h3>Result</h3>
                                <p>Quisque porttitor eros quis leo pulvinar, at hendrerit sapien iaculis.</p>
                            </div><!-- end end -->
                        </div><!-- end process -->
                    </div><!-- end col -->

                    <div class="col-lg-3 col-md-6">
						<div class="process-box" OnClick="location.href ='AT_Distance.jsp'" style="cursor:pointer;">	
                            <div class="process-front text-center">
                                <i class="flaticon-people"></i>
                                <h3>We can access simply</h3>
                            </div><!-- end front -->

                            <div class="process-end text-center">
                                <h3>Result</h3>
                                <p>Quisque porttitor eros quis leo pulvinar, at hendrerit sapien iaculis.</p>
                            </div><!-- end end -->
                        </div><!-- end process -->
                    </div><!-- end col -->

                    <div class="col-lg-3 col-md-6">
                        <div class="process-box" OnClick="location.href ='AT_Distance.jsp'" style="cursor:pointer;">	
                            <div class="process-front text-center">
                                <i class="flaticon-smiley"></i>
                                <h3>You'll be happy</h3>
                            </div><!-- end front -->

                            <div class="process-end text-center">
                                <h3>Result</h3>
                                <p>Quisque porttitor eros quis leo pulvinar, at hendrerit sapien iaculis.</p>
                            </div><!-- end end -->
                        </div><!-- end process -->
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
        </section>

        
        <!-- ---------------------- -->
          <section class="section lb nopadtop noover">
            <div class="container">
                <div class="row">  <!-- 가로로 쌓기  -->
                    <div class="col-lg-4 col-md-12"> <!-- 열-md-열 크기  -->
                        <div class="service-box m30">
                            <i class="flaticon-monitor"></i>
                            <h3>Easy to access homepage </h3>
                            <p>PC환경에서 쾌적한 데이터 분석 가능! </p>
                        </div>
                    </div><!-- end col -->

                    <div class="col-lg-4 col-md-12">
                        <div class="service-box m30">
                            <i class="flaticon-technology"></i>
                            <h3>Can use mobile phone</h3>
                            <p>스마트폰에서도 만나실 수 있습니다! </p>
                        </div>
                    </div><!-- end col -->

                    <div class="col-lg-4 col-md-12">
                        <div class="service-box m30">
                            <i class="flaticon-gears"></i>
                            <h3>Easy to use</h3>
                            <p>직관적인 인터페이스로 누구나 사용 가능! </p>
                        </div>
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
        </section><!-- end section -->
          
        
		<!------------------------------------------------------- footer ---------------------------------------------------------------->
        <footer class="section footer">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-12">
                        <div class="widget clearfix">
                            <div class="newsletter-widget">
                                <p>You can opt out of our newsletters at any time.<br> See our <a href="#">privacy policy</a>.</p>
                                <form class="form-inline" role="search">
                                    <div class="form-1">
                                        <input type="text" class="form-control" placeholder="Enter email here..">
                                        <button type="submit" class="btn btn-primary"><i class="fa fa-paper-plane-o"></i></button>
                                    </div>
                                </form>
                            </div><!-- end newsletter -->
                        </div><!-- end widget -->
                    </div><!-- end col -->

                    <div class="col-lg-2 col-md-4">
                        <div class="widget clearfix">
                            <div class="list-widget">   
                                <ul>
                                    <li><a href="page-about.html">About us</a></li>
                                    <li><a href="page-about-me.html">About me</a></li>
                                    <li><a href="page-services.html">Our Services</a></li>
                                    <li><a href="page-team.html">Our Team</a></li>
                                    <li><a href="page-contact-01.html">Contact us</a></li>
                                </ul>
                            </div><!-- end list-widget -->
                        </div><!-- end widget -->
                    </div><!-- end col -->

                    <div class="col-lg-2 col-md-4">
                        <div class="widget clearfix">
                            <div class="list-widget">   
                                <ul>
                                    <li><a href="page-contact-02.html">Get In Touch</a></li>
                                    <li><a href="page-faqs.html">FAQ's</a></li>
                                    <li><a href="page-testimonials.html">Testimonials</a></li>
                                    <li><a href="page-elements-html">Elements</a></li>
                                    <li><a href="page-404.html">Not Found</a></li>
                                </ul>
                            </div><!-- end list-widget -->
                        </div><!-- end widget -->
                    </div><!-- end col -->

                    <div class="col-lg-2 col-md-4">
                        <div class="widget clearfix">
                            <div class="list-widget">   
                                <ul>
                                    <li><a href="shop-checkout.html">Checkout</a></li>
                                    <li><a href="shop-cart.html">Shopping Cart</a></li>
                                    <li><a href="shop-account.html">My Account</a></li>
                                    <li><a href="shop-login.jsp">Login / Register</a></li>
                                </ul>
                            </div><!-- end list-widget -->
                        </div><!-- end widssget -->
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
        </footer><!-- end footer -->

		<!--------------------------------------------------------- copyrights-------------------------------------------------- -->
        <div class="section copyrights">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-3">
                        <div class="cop-logo">
                            <img src="images/rsz_1logo.png" alt="">
                        </div>
                    </div>
                    <div class="col-lg-9 col-md-9 text-right">
                        <div class="cop-links">
                            <ul class="list-inline">
                                &copy; 2020 All is Well 
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div><!-- end wrapper -->

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