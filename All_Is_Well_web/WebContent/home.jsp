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

<!--ì¼ìª½ ëª©ì°¨ -->
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
                                <a href="main.jsp" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Home </a>
                               
                            </li>
                            <li class="dropdown">
                                <a href="myData.jsp" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">My Data </a>
                              
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
                        <li class="child-menu"><a href="home.jsp">Home </a>
                          

						<!--My Data ëª©ì°¨ -->
                        <li class="child-menu"><a href="myData.jsp">My Data</a>
                          
                        </li>

						<!--My Data ëª©ì°¨ -->
                        <li class="child-menu"><a href="#">My Video</a>
                           
                                
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
                            <h3><mark class="rotate">안녕하세요  &nbsp;, Bonjour&nbsp;&nbsp;, Hello&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</mark>   we are All Is Well, we have brought together the best quality services, offers, projects for you!</h3>
                        </div>
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
        </div><!-- end section -->

      
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

        <section class="section">
            <div class="container">
                <div class="section-title text-center">
                    <h3>Summary</h3>
                    <p>자신의 스텟을 확인해보세요 </p>
                </div><!-- end title -->

                <div id="owl-01" class="owl-carousel owl-theme owl-theme-01">
                    <div class="item">
                        <img src="images/upload/linegragh.png" alt="" class="img-responsive">
                        <div class="magnifier">
                            <div class="magni-desc">
                                <h4>
                                    <a href="chartjs_line.html">Detail </a>
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
            </div><!-- end container -->
        </section>

  <section class="section lb nopadtop noover">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-12">
                        <div class="service-box m30">
                            <i class="flaticon-monitor"></i>
                            <h3>Outstanding design</h3>
                            <p>Designed to be flexible according to all your needs. Create your site with all module position.</p>
                        </div>
                    </div><!-- end col -->

                    <div class="col-lg-4 col-md-12">
                        <div class="service-box m30">
                            <i class="flaticon-technology"></i>
                            <h3>Responsive Layout</h3>
                            <p>Genius template can be easily viewed on any mobile device. Smoothly responsive.</p>
                        </div>
                    </div><!-- end col -->

                    <div class="col-lg-4 col-md-12">
                        <div class="service-box m30">
                            <i class="flaticon-gears"></i>
                            <h3>Easy to use</h3>
                            <p>The modules we have prepared are simple to use. No code information is needed.</p>
                        </div>
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
        </section><!-- end section -->

        <section class="section parallax" data-stellar-background-ratio="0.6" style="background-image:url('images/upload/1920_1080.jpg');">
            <div class="container">
                <div class="section-title light-color text-center">
                    <h3>Working Process</h3>
                    <p>Maecenas sit amet tristique turpis. Quisque porttitor eros quis leo pulvinar, at hendrerit sapien iaculis. Donec consectetur accumsan arcu, sit amet fringilla ex ultricies.</p>
                </div><!-- end title -->

                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="process-box">
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
                        <div class="process-box">
                            <div class="process-front text-center">
                                <i class="flaticon-computer"></i>
                                <h3>We start project</h3>
                            </div><!-- end front -->

                            <div class="process-end text-center">
                                <h3>Result</h3>
                                <p>Quisque porttitor eros quis leo pulvinar, at hendrerit sapien iaculis.</p>
                            </div><!-- end end -->
                        </div><!-- end process -->
                    </div><!-- end col -->

                    <div class="col-lg-3 col-md-6">
                        <div class="process-box">
                            <div class="process-front text-center">
                                <i class="flaticon-people"></i>
                                <h3>We showcase work</h3>
                            </div><!-- end front -->

                            <div class="process-end text-center">
                                <h3>Result</h3>
                                <p>Quisque porttitor eros quis leo pulvinar, at hendrerit sapien iaculis.</p>
                            </div><!-- end end -->
                        </div><!-- end process -->
                    </div><!-- end col -->

                    <div class="col-lg-3 col-md-6">
                        <div class="process-box">
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

        <section class="section lb">
            <div class="container">
                <div class="section-title text-center">
                    <h3>Latest News</h3>
                    <p>Maecenas sit amet tristique turpis. Quisque porttitor eros quis leo pulvinar, at hendrerit sapien iaculis. Donec consectetur accumsan arcu.</p>
                </div><!-- end title -->

                <div class="row text-center">
                    <div class="col-lg-4 col-md-12">
                        <div class="blog-box">
                            <div class="post-media">
                                <a href="#"><img src="images/upload/blog_01.jpg" alt="" class="img-responsive"></a>
                            </div><!-- end media -->

                            <div class="blog-desc">
                                <h4><a href="#">The most suitable web design</a></h4>
                                <p>Praesent at suscipit ligula. Suspendisse pre neque, quis suscipit enim. sed maximus, mia auctor.</p>
                            </div><!-- end blog-desc -->

                            <div class="post-meta">
                                <ul class="list-inline">
                                    <li><a href="#">21 March 2017</a></li>
                                    <li><a href="#">by HTML Design</a></li>
                                    <li><a href="#">14 Share</a></li>
                                </ul>
                            </div><!-- end post-meta -->
                        </div><!-- end blog -->
                    </div><!-- end col -->

                    <div class="col-lg-4 col-md-12">
                        <div class="blog-box">
                            <div class="post-media">
                                <a href="#"><img src="images/upload/blog_02.jpg" alt="" class="img-responsive"></a>
                            </div><!-- end media -->

                            <div class="blog-desc">
                                <h4><a href="#">The most suitable web design</a></h4>
                                <p>Sed suscipit neque in erat posuere tristique aliquam porta vestibulum. Cras placerat tincidunt. </p>
                            </div><!-- end blog-desc -->

                            <div class="post-meta">
                                <ul class="list-inline">
                                    <li><a href="#">20 March 2017</a></li>
                                    <li><a href="#">by HTML Design</a></li>
                                    <li><a href="#">11 Share</a></li>
                                </ul>
                            </div><!-- end post-meta -->
                        </div><!-- end blog -->
                    </div><!-- end col -->

                    <div class="col-lg-4 col-md-12">
                        <div class="blog-box">
                            <div class="post-media">
                                <a href="#"><img src="images/upload/blog_03.jpg" alt="" class="img-responsive"></a>
                            </div><!-- end media -->

                            <div class="blog-desc">
                                <h4><a href="#">Design for all mobile devices</a></h4>
                                <p>Suspendisse scelerisque ex ac mattis molestie vel enim ut massa placerat faucibus sed ut dui vivamus. </p>
                            </div><!-- end blog-desc -->

                            <div class="post-meta">
                                <ul class="list-inline">
                                    <li><a href="#">19 March 2017</a></li>
                                    <li><a href="#">by HTML Design</a></li>
                                    <li><a href="#">44 Share</a></li>
                                </ul>
                            </div><!-- end post-meta -->
                        </div><!-- end blog -->
                    </div><!-- end col -->
                </div><!-- end row -->
            </div>
        </section>    

        <section class="section bgcolor">
            <div class="container">
                <a href="#">
                <div class="row callout">
                    <div class="col-md-4 text-center">
                        <h3><sup>$</sup>49.99</h3>
                        <h4>Start your awesome project today!</h4>
                    </div><!-- end col -->

                    <div class="col-md-8">
                        <p class="lead">Limited time offer! Your Agency profile will be added to our "Agencies" directory as well. </p>
                    </div>
                </div><!-- end row -->
                </a>
            </div><!-- end container -->  
        </section>
        
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
<!-- 이건 지워주세요  -->