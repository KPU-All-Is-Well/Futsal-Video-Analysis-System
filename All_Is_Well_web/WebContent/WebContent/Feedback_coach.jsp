<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script language = "javascript"> // 자바 스크립트 시작


/* function writeCheck()
  {
   var form = document.writeform;
   
   if( !form.match_name.value )   // form 에 있는 name 값이 없을 때
   {
    alert( "이름을 적어주세요" ); // 경고창 띄움
    form.match_name.focus();   // form 에 있는 name 위치로 이동
    return;
   }
   
   if( !form.passwd.value )
   {
    alert( "비밀번호를 적어주세요" );
    form.passwd.focus();
    return;
    
   }
   
  if( !form.player.value )
   {
    alert( "선수 이름을  적어주세요" );
    form.player.focus();
    return;
   }
 
  if( !form.feedback.value )
   {
    alert( "내용을 적어주세요" );
    form.feedback.focus();
    return;
   }
 
  form.submit();
  } */
 </script>



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

</head> 
<style>
	body{
		background-color: #000000;
	}
</style>

<body class="left-menu"  >
    <%@ include file="../dbconn.jsp" %>
    <div class="menu-wrapper">
        <header class="vertical-header">
            <div class="vertical-header-wrapper">
                <nav class="nav-menu">
                    <div class="logo">
                        <a href="index.html"><img src="images/rsz_1logo.png" alt=""> </a>
                    </div><!-- end logo -->

                    <div class="margin-block"></div>

                    <ul class="primary-menu">

						<!--Home  -->
                        <li class="child-menu"><a href="home_of_Coach.jsp">Home</a>
                            
                        </li>

						 <!--My Data -->
                        <li class="teamData_coach.jsp"><a href="teamData_coach.jsp">Team Data </a>
                          
                        </li>

						<!--My Data -->
                        <li class="child-menu"><a href="#">My Video </a>
                            
                         
                        </li>

	      
					
						<!--Calendar -->	
						<li><a href="#">Calendar</a></li>

						<!--Coach Note ¨ -->	
						<li><a href="Feedback_coach.jsp">Coach Note</a></li>
						
						<!--Contact  -->  
                        <li><a href="#">Contact</a></li>

                    </ul>
                    
                    <div class="margin-block"></div>
					
				

                    <div class="margin-block"></div>

					

                </nav><!-- end nav-menu -->
            </div><!-- end vertical-header-wrapper -->
        </header><!-- end header -->
    </div><!-- end menu-wrapper -->
	
<!------------------------------------------------------------- end left menu ------------------------------------------------------------------------->
	
	
    <div id="wrapper">

	
            

<!-------------------------------------------------------------------- 버튼 팀, 선수, 포지션 -------------------------------------------------------------------------->

<style> 	

</style>
  

 
 </html>

<!----------------------------------------------------------------------- DB에서 읽은 그래프 --------------------------------------------------------->
<section class="section parallax" data-stellar-background-ratio="0.1 ">

 
<table>
<form name=writeform method=post action="Feedback_coach_Process.jsp">
  <tr>
   <td>
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
     <tr style="text-align:center; font-size:20px;">
      <td>경기 피드백 </td>
       </tr>
    </table>
   <table>
     <tr>
      <td>&nbsp;</td>
      <td align="center">경기</td>
      <td><input name="match_title" size="50" maxlength="100"></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" ><td colspan="4"></td></tr>
    <tr>
      <td>&nbsp;</td>
      <td align="center">선수</td>
      <td><input name="feed_name" size="50" maxlength="50"></td>
      <td>&nbsp;</td>
     </tr>
      
     <tr height="1" ><td colspan="4"></td></tr>
     <tr>
      <td>&nbsp;</td>
      <td align="center">피드백 </td>
      <td><textarea name="memo" cols="51" rows="13"></textarea></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1"><td colspan="4"></td></tr>
     <tr height="1" ><td colspan="4"></td></tr>
     <tr height="1" ><td colspan="4"></td></tr>
    <tr>
      <td>&nbsp;</td>
      <td align="center">비밀번호</td>
      <td><input type="password" name="feed_passwd" size="50" maxlength="50"></td>
      <td>&nbsp;</td>
     </tr>
     <tr align="center">
      <td>&nbsp;</td>
      <td colspan="2">
      <input type=submit value="확인 " > 
	<input type=button value="취소" OnClick="javascript:history.back(-1)">
      <td>&nbsp;</td>
      </tr>
     
    </table>
    
    
   </td>
  </tr>
  </form>
 </table>
 

 
 </section>
 
<!--------------------------------------------------- end Content ------------------------------------------------------------------>


    <!-- -----------------------------------------------jQuery Files ------------------------------------------------------------------>
   

</body>
</html>
