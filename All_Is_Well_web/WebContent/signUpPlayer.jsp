<!-- 선수 전용 회원가입 화면 -->
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
        
        td{
            border:1px solid skywhite
            
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
                   <form method="post" action="signUpPlayer_Process.jsp"> 
                   	
                   		<div style="padding-right:150px">
                        <div><p>Name</div>
                  	    <div id="A"> <input type="text" name="name" style="width:140px;border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"> </div>
 						</div>
						
						<div> 				
                        <div><p>English Name</div>            
                        <div id="B"> <input type="text" name="en_name" style="width:140px; border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"> </div>
						</div>
          
                    
                      <div style="margin-top:12px;padding-right:228px"><p>Team</div>
                	  <div id="C"><input type="text" name="team" style="border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"> </div>
						
						<div style="margin-top:12px;padding-right:200px"><p>Age</div>
                		<div id="E"><input type="text" name="age" style="border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"></div>
         				 
						<div style="margin-top:12px;padding-right:252px"><p>Height</div>
                	   <div id="D"><input type="text" name="height" style="width:140px;border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"> </div>
                		
                		<div style="margin-top:12px;padding-right:200px"><p>Weight</div>
                		<div id="E"><input type="text" name="weight" style="width:140px;border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"></div>
         				
         				
         				<div style="margin-top:12px;padding-right:200px"><p>Main Position</div>
                		
						<div id = "mp">                		
                          <select name = "mainPosition"  style="border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)">
                            <option value = "골키퍼">골키퍼(GK)</option>
                            <option value = "센터백">센터백(CB)</option>
                            <option value = "스위퍼">스위퍼(SW)</option>
                            <option value = "풀백">풀백(LWB/RWB)</option>
                            <option value = "윙백">윙백(LWB/RWB)</option>
                            <option value = "중앙 미드필더">중앙 미드필더(CM)</option>
                            <option value = "수비형 미드필더">수비형 미드필더(DM)</option>
                            <option value = "공격형 미드필더">공격형 미드필더(AM)</option>
                            <option value = "윙어">윙어(LM/RM)</option>
                        <option value = "중앙 공격수">중앙 공격수(CF)</option>
                        <option value = "세컨드 스트라이커">세컨드 스트라이커(ST)</option>
                        <option value = "윙어">윙어(LW/RW)</option>                         
                         </select>
                          </div>      
                      
                      
                         <div style="margin-top:12px;padding-right:200px"><p>Sub Position</div>
                       		<div id="sp">
                          <select name = "subPosition" style="border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)">
                         
                            <option value = "골키퍼">골키퍼(GK)</option>
                            <option value = "센터백">센터백(CB)</option>
                            <option value = "스위퍼">스위퍼(SW)</option>
                            <option value = "풀백">풀백(LWB/RWB)</option>
                            <option value = "윙백">윙백(LWB/RWB)</option>
                            <option value = "중앙 미드필더">중앙 미드필더(CM)</option>
                            <option value = "수비형 미드필더">수비형 미드필더(DM)</option>
                            <option value = "공격형 미드필더">공격형 미드필더(AM)</option>
                            <option value = "윙어">윙어(LM/RM)</option>
                        <option value = "중앙 공격수">중앙 공격수(CF)</option>
                        <option value = "세컨드 스트라이커">세컨드 스트라이커(ST)</option>
                        <option value = "윙어">윙어(LW/RW)</option>                         
                         </select>
                      	</div>
         				
						
                      <div style="margin-top:12px;padding-right:252px"><p>ID</div>
                	  <div id="D"><input type="text" name="id" style="border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"> </div>
                		
                	  <div style="margin-top:12px;padding-right:200px"><p>Password</div>
                	  <div id="E"><input type="password" name="passwd" style="border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"></div>
                	  
                	    <div style="margin-top:12px;padding-right:220px"><p>E-mail</div>
                      <div id="B"> <input type="text" name="email" style="border: 1px solid; border-radius: 8px;background:rgba(140,140,140,0.5)"> </div>
                      

                        <div style="margin-top:25px;"><p><input type="submit" value="Next" style="margin-top:20px; width:290px; border: 1px solid; border-radius: 8px;  background:rgba(140,140,140,0.5)"></div>
    
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
