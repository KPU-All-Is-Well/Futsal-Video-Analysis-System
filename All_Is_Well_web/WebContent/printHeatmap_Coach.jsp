<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%> 

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

	<!--[if lt IE 9]>
		<script src="js/vendor/html5shiv.min.js"></script>
		<script src="js/vendor/respond.min.js"></script>
	<![endif]-->

</head> 

<style>
	body{
    background-color: #000000; 
	}
        .shadow{
            width:50%;
            height:50%;
            margin:10% auto;
            overflow:hidden;
            border:1px solid black;
            background-color: #000000;
            
        }
         
        .shadow img{
            width:50%;
            height:50%;
            background-color: #000000;
            position:static;
            margin:auto;
            
            
            
        }
         
        .shadow img:hover{
            cursor:pointer;
            -webkit-transform:scale(1.1); /*  í¬ë¡¬ */
            -moz-transform:scale(1.1); /* FireFox */
            -o-transform:scale(1.1); /* Opera */
            transform:scale(1.1);
            transition: transform .35s;
            -o-transition: transform .35s;
            -moz-transition: transform .35s;
            -webkit-transition: transform .35s;
        }
        
        
       
		#container {
	max-width: 400px;
	margin: 0 auto;
}

.highcharts-figure, .highcharts-data-table table {
	min-width: 380px;    
	max-width: 600px;
    margin: 0 auto;
}

.highcharts-data-table table {
    font-family: Verdana, sans-serif;
    border-collapse: collapse;
    border: 1px solid #EBEBEB;
    margin: 10px auto;
    text-align: center;
    width: 100%;
    max-width: 500px;
}
.highcharts-data-table caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}
.highcharts-data-table th {
	font-weight: 600;
    padding: 0.5em;
}
.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
    padding: 0.5em;
}
.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}
.highcharts-data-table tr:hover {
    background: #f1f7ff;
}


</style>

<body class="left-menu"  >
    
    <div class="menu-wrapper">
        <div class="mobile-menu">
            <nav class="navbar navbar-inverse">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="index.html"><img src="images/logo-normal.png" alt=""></a>
                    </div>
                    <div id="navbar" class="navbar-collapse collapse">
                        <ul class="nav navbar-nav">
                            <li class="dropdown">
                                <a href="home_of_Coach.jsp" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Home </a>
                               
                            </li>
                            <li class="dropdown">
                                <a href="teamDate_coach.jsp" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">My Data </a>
                              
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">My Video</a>
                                
                            </li>
                            <li class="dropdown">
                                <a href="calendar/schedule_list.jsp" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Calendar</a>
                                
                            </li>
                            <li class="dropdown">
                                <a href="Feedback_coach.jsp" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Coach Note</a>
                                
                            </li>
                            <li><a href="#">Contact</a></li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                         
                        </ul>
                    </div><!--/.nav-collapse -->
                </div><!--/.container-fluid -->
            </nav>
        </div><!-- end mobile-menu --------------------------------------------------------------------->

        <header class="vertical-header">
            <div class="vertical-header-wrapper">
                <nav class="nav-menu">
                    <div class="logo">
                        <a href="index.html"><img src="images/rsz_1logo.png" alt=""> </a>
                    </div><!-- end logo -->

                    <div class="margin-block"></div>

                    <ul class="primary-menu">

						<!--Home ëª©ì°¨ -->
                        <li class="child-menu"><a href="home_of_Coach.jsp">Home</a>
                            
                        </li>

						 <!--My Data ëª©ì°¨ -->
                        <li class="teamData_coach.jsp"><a href="teamData_coach.jsp">Team Data </a>
                          
                        </li>

						<!--My Data ëª©ì°¨ -->
                        <li class="child-menu"><a href="#">My Video </a>
                            
                         
                        </li>

	      
					
						<!--Calendar ëª©ì°¨ -->	
						<li><a href="calendar/schedule_list.jsp">Calendar</a></li>

						<!--Coach Note ëª©ì°¨ -->	
						<li><a href="Feedback_coach.jsp">Coach Note</a></li>
						
						<!--Contact ëª©ì°¨: ëë¥´ë©´ íì ì ë³´ -->  
                        <li><a href="#">Contact</a></li>

                        <!--<li><a href="https://html.design">Download <i class="fa fa-shopping-bag"></i></a></li> -->
                    </ul>
                    
                    <div class="margin-block"></div>
					
					<!--
                    <div class="menu-search">
                        <form>
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="What you are looking?">
                                <button class="btn btn-primary"><i class="fa fa-search"></i></button>
                            </div>
                        </form>
                    </div>
					--> <!-- end menu-search -->

                    <div class="margin-block"></div>

					<!--
                    <div class="menu-social">
                        <ul class="list-inline text-center">
                            <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                            <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                            <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                            <li><a href="#"><i class="fa fa-instagram"></i></a></li>
                        </ul>
                    </div>--><!-- end menu -->

                </nav><!-- end nav-menu -->
            </div><!-- end vertical-header-wrapper -->
        </header><!-- end header -->
    </div><!-- end menu-wrapper -->
	
<!------------------------------------------------------------- end left menu ------------------------------------------------------------------------->
	

<style> 	

#btn_group button
 {    
 border: 1px solid black;
  background-color: #090823;
   color: skyblue;
    padding: 18px; 
    margin-left: 8px;
    width:380px; font-size:large; font-weight:bold; font-family: sans-serif;
    border-top-left-radius: 10px;
 border-bottom-left-radius: 10px; 
  border-top-right-radius: 10px;
 border-bottom-right-radius: 10px;       
    
 } 
 #btn_group button:hover
 { color:white; 
 background-color: skyblue;
  } 
</style>
 
 <div id="wrapper"> 
 <div id= "temp"></div>
 <div id="btn_group" style="text-align:center;"   >
<a href="move2Profile.jsp"><button >Player </button> 
<a href="matchData_Coach.jsp"> <button>Match </button></a>
<a href="printHeatmap_Coach.jsp"> <button>Position </button></a>
</div>
 
 </html>

<!---------------------------------------------- DB에서 읽은 그래프 ---------------------------------------------------->
 
        

<body>
<%!
	String src="data:image/png;base64,"; 
	Connection conn = null;
	ResultSet rs = null;
    ResultSet rs2 = null;
    ResultSet rs3 = null;
    
  	//List를 배열로 바꿔 담을 공간
    String[] arrSrc; 
    String[] arrName;
    String[] arrPosition;
    String team; 

%>

<%
ArrayList<String> listSrc = new ArrayList<>(); //각 이미지마다 src를 담을 ArrayList  (지역변수)
ArrayList<String> listName = new ArrayList<>(); //각 이미지마다 name를 담을 ArrayList  (지역변수)
ArrayList<String> listPosition = new ArrayList<>(); //각 이미지마다 main position를 담을 ArrayList  (지역변수)
Statement stmt3 =null;

try{
	 //드라이버 호출, 커넥션 연결
	 Class.forName("com.mysql.jdbc.Driver").newInstance();


	 conn = DriverManager.getConnection(
     "jdbc:mysql://15.164.30.158:3306/AIWUserDB", "sk", "1234");

      request.setCharacterEncoding("utf-8");
      
	  // 감독이 속한 팀 정보 가져오기
	  String coach_id = (String)session.getAttribute("id"); // 사용자가 로그인 할 때, 적은 정보를 가져오겠다.
      String sql3 =  "select team from coachSignUpInfo where id = '" + coach_id + "'";
 	  stmt3 = conn.createStatement();
      rs3 = stmt3.executeQuery(sql3); 
      
      
      while(rs3.next()){
     	team = rs3.getString("team");
      }
      
      
      
     //1차 쿼리 -> id와, name을 얻기 위한 
     
     String query = "select mainPosition, id, name from playerSignUpInfo where team = '"+team+"'"; //get data from ID table
    
      PreparedStatement pstm = conn.prepareStatement(query);
        
      rs = pstm.executeQuery();
     
      
      //2차 쿼리 시작
      while(rs.next()){
    	  String mainPosition = rs.getString("mainPosition"); //메인 포지션
    	  String name = rs.getString("name"); //이름
          String id = rs.getString("id"); //id
         // String team = rs.getString("team"); //team
          
          
          
          try{ //Null Pointer Exception 
        	  //회원가입 테이블에 id가 존재하지만 분석이 안 되어 id 테이블이 존재하지 않는 경우 예외처리
        	  
          
          //2차 쿼리문
          String query2="select result_heatmap from "+ id + " where play_id = '1'";
        
          PreparedStatement pstm2 = conn.prepareStatement(query2);
          String encordingImg = "";
          
          rs2 = pstm2.executeQuery();
          //if(stmt != null)
          //   stmt.close();
          
          while(rs2.next()){  
             encordingImg = rs2.getString("result_heatmap");
          }
          
          listName.add(name); 
          listPosition.add(mainPosition); 
          src = src + encordingImg;
          listSrc.add(src);
          src = "data:image/png;base64,"; //src 초기화
          
          }catch(Exception e){
        	  //아무것도 x
          }finally{
        	  
          }
          
      }
      
      arrSrc = listSrc.toArray(new String[listSrc.size()]); //arraySrc(리스트)) -> arrSrc(배열)
      arrName = listName.toArray(new String[listName.size()]); //arraySrc(리스트)) -> arrSrc(배열)
      arrPosition = listPosition.toArray(new String[listPosition.size()]); //arraySrc(리스트)) -> arrSrc(배열)

     
}catch (Exception e) {
    e.printStackTrace();
} finally {
    if (conn != null) {
        try {
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
      
    
%>

<div id ="tmp"></div>
<div  style = "text-align:center; margin-top:70px" >
<div  style=color:white>
 <!-- 포지션별로 정렬해서 출력하는 알고리즘 -->
 
	<% 
	
		for(int i=0; i < listSrc.size() ; i++){			
			//출력
	%>
			
	<% 		
			if(i !=  listSrc.size() && arrPosition[i] != null){	//null일 경우는 이미 출력했다는 경우
	%>
			<div > <!-- 포지션은 파란색으로 강조 -->
				<h2 style="color:skyblue; margin-top : 50px"><br><%=arrPosition[i]%></h2>
			</div>
				<h3 style=color:white><br><%=arrName[i]%></h3>
				<img src=<%=arrSrc[i]%> style="width:400px">
	<% 
				for(int j=i+1; j < listSrc.size() ; j++){
							
						if(arrPosition[i].equals(arrPosition[j])){ 
	%>					
							 <!-- 포지션 같다면 포지션명은 출력 생략 -->
							<h3 style="color:white; margin-top : 50px"><br ><%=arrName[j]%></h3>
							<img src=<%=arrSrc[j]%> style="width:400px" >
						
	<% 				
							// 동일한 string 값을 갖는 인덱스를 찾으면 null로 초기화
							arrPosition[j] = null; //
						}
				}
			
			}
			
		}
		arrSrc = null;
		
	%>	

</div>
</div>
</body>
<!-- </section> -->


 
<!--------------------------------------------------- end Content ------------------------------------------------------------------>


    <!-- -----------------------------------------------jQuery Files ------------------------------------------------------------------>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/carousel.js"></script>
    <script src="js/parallax.js"></script>
    <script src="js/rotate.js"></script>
    <script src="js/custom.js"></script>
    <script src="js/masonry.js"></script>
    
    <script src="js/masonry-4-col.js"></script>
    <!-- VIDEO BG PLUGINS -->
    <script src="videos/libs/swfobject.js"></script> 
    <script src="videos/libs/modernizr.video.js"></script> 
    <script src="videos/libs/video_background.js"></script> 
    <script>
        jQuery(document).ready(function($) {
            var Video_back = new video_background($("#home"), { 
                "position": "absolute", //Follow page scroll
                "z-index": "-1",        //Behind everything
                "loop": true,           //Loop when it reaches the end
                "autoplay": true,       //Autoplay at start
                "muted": true,          //Muted at start
                "mp4":"videos/video.mp4" ,     //Path to video mp4 format
                "video_ratio": 1.7778,              // width/height -> If none provided sizing of the video is set to adjust
                "fallback_image": "images/dummy.png",   //Fallback image path
                "priority": "html5"             //Priority for html5 (if set to flash and tested locally will give a flash security error)
            });
        });
    </script>

</body>
</html>
</element>
</html>