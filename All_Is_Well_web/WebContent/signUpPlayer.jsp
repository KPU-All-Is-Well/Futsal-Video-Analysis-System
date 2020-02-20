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
   
</head>
 
<body>
   

           <!-- 감독 모드: 아이디, 이름, 비밀번호, 메일, 팀명 -->     
      <div id="main">
         
         <div class="text-center">
            <div id="contents"> 
                   <form method="post" action="signUpPlayer_Process.jsp"> 
                      <div id="A"><p>이름 : <input type="text" name="name" style="text-align:center; width:100px" > </div>
                      <div id="A"><p>영어 이름 : <input type="text" name="en_name" style="text-align:center; width:100px" > </div>
                      <div id="B"><p>메일 : <input type="text" name="email" style="text-align:center; width:100px"> </div>
                      <div id="C"><p>팀명 : <input type="text" name="team" style="text-align:center; width:100px"> </div>
                      <div id="D"><p>아이디 : <input type="text" name="id" style="text-align:center; width:100px"> </div>
                      <div id="E"><p>비밀번호 : <input type="password" name="passwd" style="text-align:center; width:100px"> </div>
                      <div id="F"><p>키 : <input type="text" name="height" style="text-align:center; width:100px"> 몸무게 : <input type="text" name="weight" style="text-align:center; width:100px"> </div>
                      <div id="H"><p>나이 : <input type="text" name="age" style="text-align:center; width:100px"></div> <!-- 나이 97.11.06 으로 바꾸기 -->  
                      <div id="I">
                         <p>주포지션 : <select name = "mainPosition">
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
                                            
                      <div id="J">
                         부포지션 : <select name = "subPosition">
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

                     <div class="form-group">
                          <p><input type="submit" value="확인">
                        </div>
                   </form> 
            </div>
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
