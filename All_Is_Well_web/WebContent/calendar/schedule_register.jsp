<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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


	<meta charset="UTF-8">
	<title>스케줄 등록</title>
	<link rel="stylesheet" href="schedule.css" type="text/css"></link>
	
	<style>
	header
	{
		margin:20px 10px 40px 10px; 
		font-family:"Times New Roman","Times New Roman";
		font-size:50px;
		text-shadow:3px 3px 8px gray;
		text-align:center;
	}

	body {
	    color: #87CEEB;
	    font-family: 'Times New Roman', 'Times New Roman', 'Times New Roman';
	    background-color: #090823;
	}

	table {
		border-collapse: collapse;
	}

	th, td {
		font-size: 10pt;
		border: 1.5px solid #090823;
		height: 30px;
		padding: 5px;
		color: white;
		background-color: #003246;
	}
		
	
	</style>
	
	
	
</head>
<body class="left-menu">

	<div class="menu-wrapper">
      

        <header class="vertical-header">
            <div class="vertical-header-wrapper">
                <nav class="nav-menu">
                    <div class="logo">
                        <a href="index.html"><img src="../images/rsz_1logo.png" alt=""> </a>
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

	<div align=center  style = "margin-top:100px;">
		<header>일정 등록</header>
		<form method="post" action="register_Process.jsp"> 	
		<table>	
			<tr><th>날짜</th><td><input type="text" name="schedule_date"  placeholder="YYYY-MM-DD"></td></tr>
			<tr><th>일정</th><td><input type="text" name="schedule_subject" autofocus placeholder="입력하세요"></td></tr>
			<tr><th>설명</th><td><input type="text" name="schedule_desc" placeholder="입력하세요"  style ="height:50px" ></td></tr>
			
		</table><br>
		
			<input type="submit" name="submit" value="완료" >
			<input type="reset" name="reset" value="초기화" >
		
		</form>
	</div>
</body>
</html>