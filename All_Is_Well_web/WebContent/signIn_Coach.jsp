
<%@ page contentType="text/html; charset=utf-8" %>
<html>

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
    
	
    <!-- Site Icons -->
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
	form{
		margin: 0 auto;
		width: 250px;
	}
	td,tr{
padding:8;
}
</style>


<body>
	
	<div id="main">
		<div id="contents" > 
			<form action="signIn_Coach_Process.jsp" method = "get">
			<table>
             <tr>
             <td>Id</td> <td><input type="text"  name="id"  style="border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"></td>            
               	</tr>
               	<tr>
               	<td>Password</td>
               	<td><input type="password"  name="passwd" style="border: 1px solid; border-radius: 8px; background:rgba(140,140,140,0.5)"></td>
               	     
               	<tr>
               	<div class="form-group">
               		<div class="text-center">
               		<td colspan="2"><input type="submit" value="Next" style=" width:270px; border: 1px solid; border-radius: 8px;  background:rgba(140,140,140,0.5)"></div></td>
              
               		</div>
               	</div>
               	</tr>
               	   </table>
             </form> 
		</div> 
	
	</div>

	
        
        <!--  배경음악 끊기지 않게...
		<frameset rows="100%,0%" frameborder=0 frame=0 border=0>
  		<frame src="welcome.jsp" marginwidth=0>
  		<frame align=left src="videos/video.mp4">
		</frameset>
		-->


     
        
     <!-- -----------------------------------------------jQuery Files ------------------------------------------------------------------>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/carousel.js"></script>
    <script src="js/parallax.js"></script>
    <script src="js/rotate.js"></script>
    <script src="js/custom.js"></script>
    <script src="js/masonry.js"></script>
    <script src="js/masonry-4-col.js"></script>
    
    


    
</body>
</html>

