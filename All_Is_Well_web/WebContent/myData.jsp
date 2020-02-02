<!-- main.jsp -->
<%@ page contentType="text/html; charset=utf-8" %>

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

<!-- -------------------------------------------------------------------------mobile menu ---------------------------------------------------------------------------->
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
                                <a href="home.jsp" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Home <span class="fa fa-angle-down"></span></a>
                                <!--  
                                <ul class="dropdown-menu">
                                    <li><a href="#">Menu Example 01</a></li>
                                    <li><a href="#">Menu Example 02</a></li>
                                    <li><a href="#">Menu Example 03</a></li>
                                    <li><a href="#">Menu Example 04</a></li>
                                    <li><a href="#">Menu Example 05</a></li>
                                    <li><a href="#">Menu Example 06</a></li>
                                </ul>
                                -->
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Pages <span class="fa fa-angle-down"></span></a>
                                <!-- 
                                <ul class="dropdown-menu">
                                    <li><a href="#">Menu Example 01</a></li>
                                    <li><a href="#">Menu Example 02</a></li>
                                    <li><a href="#">Menu Example 03</a></li>
                                    <li><a href="#">Menu Example 04</a></li>
                                    <li><a href="#">Menu Example 05</a></li>
                                    <li><a href="#">Menu Example 06</a></li>
                                </ul>
                                 -->
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Portfolio <span class="fa fa-angle-down"></span></a>
                                <!--
                                <ul class="dropdown-menu">
                                
                                    <li><a href="#">Menu Example 01</a></li>
                                    <li><a href="#">Menu Example 02</a></li>
                                    <li><a href="#">Menu Example 03</a></li>
                                    <li><a href="#">Menu Example 04</a></li>
                                    <li><a href="#">Menu Example 05</a></li>
                                    <li><a href="#">Menu Example 06</a></li>
                                </ul>
                                -->
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Shop <span class="fa fa-angle-down"></span></a>
                                <!--
                                <ul class="dropdown-menu">
                                    <li><a href="#">Menu Example 01</a></li>
                                    <li><a href="#">Menu Example 02</a></li>
                                    <li><a href="#">Menu Example 03</a></li>
                                    <li><a href="#">Menu Example 04</a></li>
                                    <li><a href="#">Menu Example 05</a></li>
                                    <li><a href="#">Menu Example 06</a></li>
                                </ul>
                                -->
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Blog <span class="fa fa-angle-down"></span></a>
                                <!--
                                <ul class="dropdown-menu">
                                    <li><a href="#">Menu Example 01</a></li>
                                    <li><a href="#">Menu Example 02</a></li>
                                    <li><a href="#">Menu Example 03</a></li>
                                    <li><a href="#">Menu Example 04</a></li>
                                    <li><a href="#">Menu Example 05</a></li>
                                    <li><a href="#">Menu Example 06</a></li>
                                </ul>
                                -->
                            </li>
                            <li><a href="#">Contact</a></li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="https://html.design">Download <i class="fa fa-shopping-bag"></i></a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div><!--/.container-fluid -->
            </nav>
        </div>
        
<!-------------------------------------------------------------------------- end mobile-menu ---------------------------------------------------------------------------->

<!---------------------------------------------------------------------------- web-menu -------------------------------------------------------------------------------->
        
        <header class="vertical-header">
            <div class="vertical-header-wrapper">
                <nav class="nav-menu">
                    <div class="logo">
                        <a href="index.html"><img src="images/rsz_1logo.png" alt=""> </a>
                    </div><!-- end logo -->

                    <div class="margin-block"></div>

                    <ul class="primary-menu">
                        
                        
                        <!--Home -->	
						<li><a href="home.jsp">Home</a></li>
                        
                        <!--Home -->	
						<li><a href="myData.jsp">myData</a></li>

						<!-- My Video menu lists -->
                        <li class="child-menu"><a href="myVideo.jsp">My Video <i class="fa fa-angle-right"></i></a>
                            <div class="sub-menu-wrapper">
                                <ul class="sub-menu center-content">
                                    <li><a href="#">Menu Example 01 <i class="fa fa-angle-right"></i></a> 
                                        <!-- 
                                        <div class="subsub-menu-wrapper">  
                                            <ul class="subsub-menu center-content">
                                                <li><a href="#">Menu Example 01</a></li>
                                                <li><a href="#">Menu Example 02</a></li>
                                                <li><a href="#">Menu Example 03</a></li>
                                            </ul>
                                        </div>
                                         -->
                                    </li>
                                    <li><a href="#">Menu Example 02 <i class="fa fa-angle-right"></i></a> 
                                        <div class="subsub-menu-wrapper">  
                                        	 <!-- 
                                            <ul class="subsub-menu center-content">
                                                <li><a href="#">Menu Example 01</a></li>
                                                <li><a href="#">Menu Example 02</a></li>
                                                <li><a href="#">Menu Example 03</a></li>
                                            </ul>
                                             -->
                                        </div>
                                    </li>
                                    <li><a href="#">Menu Example 03 <i class="fa fa-angle-right"></i></a> 
                                        <!--
                                        <div class="subsub-menu-wrapper">  
                                            <ul class="subsub-menu center-content">
                                                <li><a href="#">Menu Example 01</a></li>
                                                <li><a href="#">Menu Example 02</a></li>
                                                <li><a href="#">Menu Example 03</a></li>
                                            </ul>
                                        </div>
                                        -->
                                    </li>
                                   
                                </ul>
                            </div>
                        </li>

					
						<!--Calendar -->	
						<li><a href="calendar.jsp">Calendar</a></li>

						<!--Coach Note -->	
						<li><a href="coachNote.jsp">Coach Note</a></li>
						
						<!--Contact -->  
                        <li><a href="contact.jsp">Contact</a></li>


                    </ul>
                    
                    <div class="margin-block"></div>
					

                </nav><!-- end nav-menu -->
            </div><!-- end vertical-header-wrapxper -->
        </header><!-- end header -->
    </div><!-- end menu-wrapper -->
	
<!------------------------------------------------------------- end web menu ------------------------------------------------------------------------->
	
	
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

<!--  
        <div class="section footer" > 
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="tagline-message" >
                            <h3><mark class="rotate">안녕하세요  &nbsp;, Bonjour&nbsp;&nbsp;, Hello&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</mark>   we are All Is Well, we have brought together the best quality services, offers, projects for you!</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
-->

		<jsp include page = "googleChart.html" flush = "true" />   
		
      
<!-- 
        <section class="section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-7 col-md-12">
                        <div class="text-widget">
                            <h3>Powerful template features</h3>

                            <p>Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla nunc dui, tristique in <a href="#">semper vel</a>, congue sed ligula. Nam dolor ligula, faucibus id sodales in, auctor fringill torquent per conubia nostra.</p>

                            <div class="clearfix"></div>

                            <div class="row">
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 first">
                                    <ul class="check">
                                        <li>Custom Shortcodes</li>
                                        <li>Visual Page Builder</li>
                                        <li>Unlimited Shortcodes</li>
                                        <li>Responsive Theme</li>
                                        <li>Tons of Layouts</li>
                                    </ul>end check
                                </div>end col-lg-4
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                    <ul class="check">
                                        <li>Font Awesome Icons</li>
                                        <li>Pre-Defined Colors</li>
                                        <li>AJAX Transitions</li>
                                        <li>High Quality Support</li>
                                        <li>Unlimited Options</li>
                                    </ul>end check    
                                </div>end col-lg-4
                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 last">
                                    <ul class="check">
                                        <li>Shopping Layouts</li>
                                        <li>Pre-Defined Fonts</li>
                                        <li>Changers</li>
                                        <li>Footer Styles</li>
                                        <li>Header Styles</li>
                                    </ul>end check
                                </div>end col-lg-4 
                            </div>end row      
                        </div>end widget
                    </div>end col-lg-6
                </div>end row
            </div>end container
            <div class="perspective-image hidden-sm hidden-xs hidden-md"> 
                <img src="images/upload/p1.jpg" alt="" class="img-responsive">
            </div>
        </section>

 -->
      <!--   <div class="section bgcolor noover">
            <div class="container-fluid">
                <div class="client-box">
                    <img src="images/upload/client_01.png" alt="" class="img-responsive">
                </div>end col

                <div class="client-box">
                    <img src="images/upload/client_02.png" alt="" class="img-responsive">
                </div>end col

                <div class="client-box">
                    <img src="images/upload/client_03.png" alt="" class="img-responsive">
                </div>end col

                <div class="client-box">
                    <img src="images/upload/client_04.png" alt="" class="img-responsive">
                </div>end col

                <div class="client-box">
                    <img src="images/upload/client_05.png" alt="" class="img-responsive">
                </div>end col
            </div>end container
        </div>end section
 -->

		<!-- 
        <section class="section">
            <div class="container">
                <div class="section-title text-center">
                    <h3>Summary</h3>
                    <p>자신의 스텟을 확인해보세요 </p>
                </div>

                <div id="owl-01" class="owl-carousel owl-theme owl-theme-01">
                    <div class="item">
                        <img src="images/upload/linegragh.png" alt="" class="img-responsive">
                        <div class="magnifier">
                            <div class="magni-desc">
                                <h4>
                                    <a href="chartjs_line.jsp">Detail </a>
                                    <small>in: websites</small>
                                </h4>
                                <a class="goitem" href="#"><i class="fa fa-link"></i></a>
                            </div>
                        </div>
                    </div>

                    <div class="item">
                        <img src="images/upload/work_04.jpg" alt="" class="img-responsive">
                        <div class="magnifier">
                            <div class="magni-desc">
                                <h4>
                                    <a href="#">CSS3 Animation</a>
                                    <small>in: animations</small>
                                </h4>
                                <a class="goitem" href="#"><i class="fa fa-link"></i></a>
                            </div>
                        </div>
                    </div>

                    <div class="item">
                        <img src="images/upload/work_01.jpg" alt="" class="img-responsive">
                        <div class="magnifier">
                            <div class="magni-desc">
                                <h4>
                                    <a href="#">Mockup Template</a>
                                    <small>in: mockups</small>
                                </h4>
                                <a class="goitem" href="#"><i class="fa fa-link"></i></a>
                            </div>
                        </div>
                    </div>

                    <div class="item">
                        <img src="images/upload/work_02.jpg" alt="" class="img-responsive">
                        <div class="magnifier">
                            <div class="magni-desc">
                                <h4>
                                    <a href="#">Mockup Template</a>
                                    <small>in: css3</small>
                                </h4>
                                <a class="goitem" href="#"><i class="fa fa-link"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>        
-->
		
		
        
        
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