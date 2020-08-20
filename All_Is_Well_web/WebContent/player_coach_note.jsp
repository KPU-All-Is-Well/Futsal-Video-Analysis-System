<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@page import="java.sql.*" %>
    <%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>

<title>Insert title here</title>
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


<style>
	body{
		background-color: #000000;
	}
	  table {
    width: 100%;
    border: 1px solid #444444;
  }
	/* table{
	margin-left:auto;
	margin-right:auto;
	top:100px;
	font-size:20px"
	width:400px;
	height: 200px;
	border:1px solid;
	}  */
	
	table,tr,td{
	border:1px solid;
	}
</style>
</head>
<body class="left-menu"  >
    <%@ include file="dbconn.jsp" %>
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
                        <li class="child-menu"><a href="home.jsp">Home</a>
                            
                        </li>

						 <!--My Data -->
                        <li class="mMdata.jsp"><a href="teamData_coach.jsp">My Data </a>
                          
                        </li>

						<!--My Data -->
                        <li class="child-menu"><a href="#">My Video </a>
                            
                         
                        </li>

	      
					
						<!--Calendar -->	
						<li><a href="calendar/schedule_list.jsp">Calendar</a></li>

						<!--Coach Note ¨ -->	
						<li><a href="player_coach_note.jsp">Coach Note</a></li>
						
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
	
	<%!
	//이름
	String match_title;
	String feed_name;
	String memo;
	
	String[] arr_match_title;
	String[] arr_feed_name;
	String[] arr_memo;
%>
 <%
 ArrayList<String> list_match_title = new ArrayList<>(); //각 이미지마다 src를 담을 ArrayList  (지역변수)
 ArrayList<String> list_feed_name = new ArrayList<>(); //각 이미지마다 name를 담을 ArrayList  (지역변수)
 ArrayList<String> list_memo = new ArrayList<>();
 Statement stmt3=null;
 
 	request.setCharacterEncoding("UTF-8");
 
	 String name = request.getParameter("name"); 
	 
	
	 Connection con = null;
	 ResultSet rs = null;
	 ResultSet rs2 = null;
	 
	    feed_name = (String)session.getAttribute("id");//로그인한 선수 id 받아와서 저장 
	   
       try {
        //드라이버 호출, 커넥션 연결
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        
     
        con = DriverManager.getConnection(
                "jdbc:mysql://15.164.30.158:3306/AIWUserDB", "sk", "1234");
        
        String query = "select feed_name, match_title, memo from feed_table where feed_name = '"+ feed_name+"'"; //get data from ID table      
        
        PreparedStatement pstm = con.prepareStatement(query);
        
        rs = pstm.executeQuery();

	  
	     
	   while(rs.next()){
           
       	match_title=rs.getString("match_title");
       	feed_name=rs.getString("feed_name");
       	memo=rs.getString("memo");
       	
          try{
          
       	   list_match_title.add(match_title);
       	   list_feed_name.add(feed_name);
       	   list_memo.add(memo);
       	 
       	}catch(Exception e){ //Null Pointer Exception 발생시 ArrayList에 추가 안 함(→  null인 곳을 참조하게 되므로)
     	  	//아무것도 x 
       	}finally{
       
       	}	
           
       }//end while
        
       arr_match_title = list_match_title.toArray(new String[list_match_title.size()]); //arraySrc(리스트)) -> arrSrc(배열)
       arr_feed_name = list_feed_name.toArray(new String[list_feed_name.size()]); //arraySrc(리스트)) -> arrSrc(배열)
       arr_memo = list_memo.toArray(new String[list_memo.size()]); //arraySrc(리스트)) -> arrSrc(배열)

 
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
	
	
	
    <div id="wrapper">

<section class="section parallax" data-stellar-background-ratio="0.1 "style="padding:300px">

 <div >
<table style="border:1px solid; width:600px; height:200px; border:1px solid; font-size:px">
		  <tr style="font-size:30px; border:1px solid; text-align:center">
		    <th style="border:1px solid">player</th> <th style="border:1px solid">match</th><th style="border:1px solid">feedback</th>
		  </tr>
		  
<% 		  for(int i=0;i<list_feed_name.size();i++){
%>
		 <tr style="border:1px solid">
			<td style="font-size:20px"><%= arr_feed_name[i]%></td> <td style="font-size:13px"><%= arr_match_title[i]%></td><td><%= arr_memo[i]%></td>
		</tr>
		<%} %>
		

 </table>
 </div>

 </section>

<!--------------------------------------------------- end Content ------------------------------------------------------------------>


    <!-- -----------------------------------------------jQuery Files ------------------------------------------------------------------>
   

</body>
</html>
