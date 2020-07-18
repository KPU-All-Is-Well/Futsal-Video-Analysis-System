<!-- 코치 전용 회원가입 화면 -->
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

	
</head>
 
<body>
	

           <!-- 감독 모드: 아이디, 이름, 비밀번호, 메일, 팀명 -->     
		<div id="main">
			
			<div class="text-center">
				<div id="contents"> 
                	<form method="post" action="signUp_Process.jsp"> 
                		
                		<div style="padding-right:225px"><p>Name</div>
                		<div id="A"> <input type="text" name="name" style="border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"> </div>
                		
                		<div style="margin-top:12px;padding-right:220px"><p>E-mail</div>
                		<div id="B"><input type="text" name="email" style="border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"> </div>
                		
                		<div style="margin-top:12px;padding-right:228px"><p>Team</div>
                		<div id="C"><input type="text" name="team" style="border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"> </div>
                		
                		<div style="margin-top:12px;padding-right:252px"><p>ID</div>
                		<div id="D"><input type="text" name="id" style="border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"> </div>
                		
                		<div style="margin-top:12px;padding-right:200px"><p>Password</div>
                		<div id="E"><input type="password" name="passwd" style="border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"></div>
         				
         				<div class="form-group">
              				<div style="margin-top:25px;"><p><input type="submit" value="Next" style="margin-top:20px; width:290px; border: 1px solid; border-radius: 8px;  background:rgba(140,140,140,0.5)"></div>
               			</div>
             		</form> 
				</div>
			</div>
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
  
    
    
</body>
</html>

