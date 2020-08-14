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

	 <style>
 #wrap{
            width:530px;
            margin-left:auto; 
            margin-right:auto;
            text-align:center;
        }
        
        table{
            margin-left:auto; 
            margin-right:auto;
            border:3px solid skywhite
        }
        
        td,tr{
            border:1px solid skywhite;
            padding:5;
      	  }
        input{
        margin-left:50px;
        }
        select
        {
          margin-left:50px;
          
        }

</style>
	
</head>
 
<body>
	

           <!-- 감독 모드: 아이디, 이름, 비밀번호, 메일, 팀명 -->     
		<div id="main">
		 <div class="text-center">
				<div id="contents"> 
                	<form method="post" action="signUp_Process.jsp"> 
                		<table>
                		<tr>
                		<td>ID</td>
                		<td><input type="text" name="id" style="border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"> </td>
                		</tr>
                		<tr>
                		<td>Password</td>
                		<td><input type="password" name="passwd" style="border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"></td>
         				</tr>
                		<tr>
                		<td>Name</td>
                		<td><input type="text" name="name" style="border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"> </td>
                		</tr>
                		<tr>
                		<td>E-mail</td>
                		
                		<td><input type="text" name="email" style="border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"> </td>
                		<tr>
                		<td>Team</td>
                	    <td><input type="text" name="team" style="border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"> </td>
                		
         				<tr>
         				<div class="form-group">
              				<td colspan="3"><div style="margin-top:25px;"><p><input type="submit" value="Next" style="margin-top:20px; width:250px; border: 1px solid; border-radius: 8px;  background:rgba(140,140,140,0.5)"></td>
               			</div>
               			</tr>
               			</table>
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

