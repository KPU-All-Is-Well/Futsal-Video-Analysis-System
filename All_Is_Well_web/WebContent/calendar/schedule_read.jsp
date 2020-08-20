<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ page import="java.net.URLEncoder" %>
 <%@page import="java.sql.*"%>
<%@page import="java.util.*"%> 
<%@page import="java.lang.*"%> 

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
	<title>일정 정보</title>
	<link rel="stylesheet" href="schedule.css" type="text/css"></link>

</head>
<body class="left-menu"  >

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
	
	<div align=center style = "margin-top:100px;">
		<%!
		 
		String date;
		String subject;
		String desc;
		String count;
		 
		String idx;
		 
		
		Connection con = null;
		ResultSet rs = null;
		
		%>
		
		
	<%
		
		request.setCharacterEncoding("UTF-8");
	 
		idx = request.getParameter("schedule_idx"); 

	       try {
	        //드라이버 호출, 커넥션 연결
	        Class.forName("com.mysql.jdbc.Driver").newInstance();
	        
	     
	        con = DriverManager.getConnection(
	                "jdbc:mysql://15.164.30.158:3306/AIWUserDB", "sk", "1234");
	        
	        String query = "select schedule_subject, schedule_desc, schedule_count, schedule_date  from schedule where schedule_idx = '"+ idx+"'";
	            
	        
	        
	        PreparedStatement pstm = con.prepareStatement(query);
	        
	        rs = pstm.executeQuery();


	        while(rs.next()){
	           
	        
	           
	           try{
	           
	        	   subject=rs.getString("schedule_subject");
	        	   desc=rs.getString("schedule_desc");
	        	   count=rs.getString("schedule_count");
	        	   date = rs.getString("schedule_date");
	              
	        	   
	        	 
	        	}catch(Exception e){ //Null Pointer Exception 발생시 ArrayList에 추가 안 함(→  null인 곳을 참조하게 되므로)
	      	  	//아무것도 x 
	        	}finally{
	        
	        	}	
	            
	        }//end while
	        

	 
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        if (con != null) {
	            try {
	                con.close();
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }
	 
	    }
		
	%>
		
		
		<table>
			<tr><th> 날짜 </th><td><%= date%></td></tr>
		    <tr><th> 제목 </th><td><%= subject%></td></tr>
			<tr><th style ="height:50px"> 설명 </th><td><%= desc%></td></tr>
			<tr><th> 조회수 </th><td><%= count%></td></tr>
		</table><br>
		
		<!-- <c:url value="/schedule/modify?schedule_idx=${schedule.schedule_idx}" var="url"/><a href="${url}"><button id="test_btn1">수정</button> -->
		<a href="schedule_modify.jsp?idx=<%=URLEncoder.encode(idx, "UTF-8") %>"><button id="test_btn1">수정</button> </a>
		<a href="schedule_delete.jsp?idx=<%=URLEncoder.encode(idx, "UTF-8") %>"><button id="test_btn1">삭제</button> </a>
		<a href="schedule_list.jsp" ><button id="test_btn1">캘린더</button> </a>
		
		
	</div>
</body>
</html>