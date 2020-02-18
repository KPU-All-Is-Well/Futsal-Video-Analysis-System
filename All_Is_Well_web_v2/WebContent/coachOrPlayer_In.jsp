<!-- signIn.jsp -->
<%@ page contentType="text/html; charset=utf-8" %>
<html>

<head>

    <!-- Basic -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    
    <!-- Mobile Meta -->
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    
    <!-- Site Meta -->
    <title>coachOrPlayer.jsp</title>
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
</style>


<body>
	
	
 <!--  이미지 버튼 사용시
	<div class="linkArea">
	
		<a href="http://www.naver.com" onclick="alert('이전');return false;"> 
  		<img src="images/main/btn_event_prev.gif" alt="이전 이벤트 보기"/></a>
 		<a href="http://www.daum.net" onClick="alert('다음');">
  		<img src="images/main/btn_event_next.gif" alt="다음 이벤트 보기"/></a>
	
	</div>
 -->	
	
	
        
        
        <!--  배경음악 끊기지 않게...
		<frameset rows="100%,0%" frameborder=0 frame=0 border=0>
  		<frame src="welcome.jsp" marginwidth=0>
  		<frame align=left src="videos/video.mp4">
		</frameset>
		-->

	 <!-- 감독 모드: 아이디, 이름, 비밀번호, 메일, 팀명 -->     
		<div id="main">
			
			<div class="text-center">
				<div id="contents"> 
                	<form method="post" action="coachOrPlayer_In_Process.jsp"> 
                		
                		<input type="radio" name="role" value="선수">선수
                		<input type="radio" name="role" value="코치">코치
         				<div class="form-group">
              				<p><input type="submit" value="확인">
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

