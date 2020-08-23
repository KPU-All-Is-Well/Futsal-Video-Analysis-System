<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ page import="java.net.URLEncoder" %>


<!DOCTYPE html>
<html>
<html class="no-js " lang="en">
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
	<link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon" />
    <link rel="apple-touch-icon" href="../images/apple-touch-icon.png">
	
	<!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet"> 
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700" rel="stylesheet"> 

	<!-- Custom & Default Styles -->
	<link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/carousel.css">
    <link rel="stylesheet" href="../style.css"> 
    <link rel="stylesheet" href="schedule.css"> 

	<meta charset="UTF-8">
	<title>정보 수정</title>
	
	<style>
		body {
			 background-color: #000000;
		}
	</style>
	</style>
	
	
</head>
<body  class="left-menu">
	
	<div class="menu-wrapper">
      

        <header class="vertical-header">
            <div class="vertical-header-wrapper">
                <nav class="nav-menu">
                    <div class="logo">
                        <a href="../index.html"><img src="../images/rsz_1logo.png" alt=""> </a>
                    </div><!-- end logo -->

                    <div class="margin-block"></div>

                    <ul class="primary-menu">

						<!--Home -->
                        <li class="child-menu"><a href="../home.jsp">Home</a>
                            
                        </li>

						 <!--My Data  -->
                        <li class="myData.jsp"><a href="../myData.jsp">My Data </a>
                          
                        </li>

						<!--My Data-->
                        <li class="child-menu"><a href="#">My Video </a>
                         </li>

						<!--Calendar¨ -->	
						<li><a href="schedule_list.jsp">Calendar</a></li>

						<!--Coach Note  -->	
						<li><a href="#">Coach Note</a></li>
						
						<!--Contact  -->  
                        <li><a href="#">Contact</a></li>

                    </ul>
                    
                    <div class="margin-block"></div>
				
					<!-- end menu-search -->

                    <div class="margin-block"></div>


                </nav><!-- end nav-menu -->
            </div><!-- end vertical-header-wrapper -->
        </header><!-- end header -->
    </div><!-- end menu-wrapper -->
	
<!------------------------------------------------------------- end left menu ------------------------------------------------------------------------->
	
	<div></div>
	<div  align = center style = "margin-top:150px; margin-left:200px; ">
		<header style = "font-size: xx-large; font-weight: bold;  letter-spacing:5px;">일정수정</header>
		<%
			request.setCharacterEncoding("UTF-8");
		 	String idx = request.getParameter("idx"); 
		%>
		
		
		
		<form method="post" action="modify_Process.jsp?idx=<%=URLEncoder.encode(idx, "UTF-8") %>">
		<input type="hidden" name="schedule_idx" readonly value=<%= idx%> > 
		<!-- <input type="hidden" name="schedule_count" readonly value="${schedule.schedule_count}" >  -->
		
		<table>
			<tr><th>날짜</th><td><input type="text" name="schedule_date" placeholder="YYYY-MM-DD" style ="height:20px; width:295px;"></td></tr>
			<tr><th>제목</th><td><input type="text" name="schedule_subject" autofocus placeholder="입력하세요" style ="height:20px; width:295px;"></td></tr>
			<tr><th>설명</th><td><input type="text" name="schedule_desc" placeholder="입력하세요"  style ="height:170px; width:295px;"></td></tr>
			
		</table><br>
			<input type="submit" name="submit" value="완료" style = "margin-top:30px;margin-right:10px;font-weight:bold;">
			<input type="reset" name="reset" value="초기화" style = "font-weight:bold;">
		</form>
	</div>
</body>
</html>