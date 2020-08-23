
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%> 
<%@page import="java.lang.*"%> 
<%@ page import="java.net.URLEncoder" %>

<%

Calendar cal = Calendar.getInstance();

 

String strYear = request.getParameter("year");
String strMonth = request.getParameter("month");

 

int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH);
int date = cal.get(Calendar.DATE);

 

if(strYear != null)

{

  year = Integer.parseInt(strYear);
  month = Integer.parseInt(strMonth);
 
}else{

 

}

//년도/월 셋팅

cal.set(year, month, 1);

 

int startDay = cal.getMinimum(java.util.Calendar.DATE);
int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
int newLine = 0;

 

//오늘 날짜 저장.

Calendar todayCal = Calendar.getInstance();
SimpleDateFormat sdf = new SimpleDateFormat("yyyMMdd");

int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));


%>

<html lang="ko">
<html class="no-js " lang="en">
<HEAD>
	
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
	
	
	
	
       <TITLE>스케줄 </TITLE>

       <meta http-equiv="content-type" content="text/html; charset=utf-8">
       <script type="text/javaScript" language="javascript"> 

       </script>

       <style TYPE="text/css">
	
             body {
			 background-color: #000000;
			 
             scrollbar-face-color: #F6F6F6;

             scrollbar-highlight-color: #bbbbbb;

             scrollbar-3dlight-color: #FFFFFF;

             scrollbar-shadow-color: #bbbbbb;

             scrollbar-darkshadow-color: #FFFFFF;

             scrollbar-track-color: #FFFFFF;

             scrollbar-arrow-color: #bbbbbb;

             margin-left:"0px"; margin-right:"0px"; margin-top:"0px"; margin-bottom:"0px";

             }
             

             td {font-family: "Times New Roman"; font-size: 9pt; color:#FFFFFF; font-weight: bolder}

             th {font-family: "Times New Roman"; font-size: 9pt; color:#000000; font-weight: bolder}

             select {font-family: "Times New Roman"; font-size: 9pt; color:#595959; font-weight: bolder}

             .divDotText {

             overflow:hidden;

             text-overflow:ellipsis;

             }


            
            A:link {  color:#1EA5FF; text-decoration:none; }

            A:visited {color:#1EA5FF; text-decoration:none;}

            A:active { color:red; text-decoration:none;}

            A:hover {color:red;text-decoration:none;}
            

 

       </style>

</HEAD>






<body class="left-menu"  >
    
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


<div ></div >
<div align=center style = "margin-top:100px; margin-left:200px;">
<form name="calendarFrm" id="calendarFrm" action="" method="post">

<DIV id="content" style="width:712px;">

 

<table width="110%" border="0" cellspacing="1" cellpadding="1" >

<tr>
		
       <td align ="right">
     		<a href="schedule_register.jsp" style = "font-weight: bolder; ">일정 등록</a>
       </td>



</tr>

</table>

<!--날짜 네비게이션  -->

<table width="110%" border="0" cellspacing="1" cellpadding="1" id="KOO" bgcolor="#193349" style="border:1px solid #193349; font-weight: bold;margin-top: 10px; ">

<tr>

<td height="60">

 

       <table width="100%" border="0" cellspacing="0" cellpadding="0">

       <tr>
             <td height="10">

             </td>
       </tr>



       <tr>
             <td align="center" style = "font-size:large;">

                    <a href="<c:url value='/CalendarExam2.jsp' />?year=<%=year-1%>&amp;month=<%=month%>" target="_self" style="color: white; font-weight: bolder">

                           <!-- <b>&lt;&lt;</b>이전해 -->

                    </a>

                    <%if(month > 0 ){ %>

                    <a href="<c:url value='/CalendarExam2.jsp' />?year=<%=year%>&amp;month=<%=month-1%>" target="_self" style="color: white; font-weight: bolder">

                           <b>&lt;</b><!-- 이전달 -->

                    </a>

                    <%} else {%>

                           <b>&lt;</b>

                    <%} %>

                    &nbsp;&nbsp;

                    <%=year%>년

                   

                    <%=month+1%>월

                    &nbsp;&nbsp;

                    <%if(month < 11 ){ %>

                    <a href="<c:url value='/CalendarExam2.jsp' />?year=<%=year%>&amp;month=<%=month+1%>" target="_self" style="color: white; font-weight: bolder">

                            <b>&gt;</b><!-- 다음달-->

                    </a>

                    <%}else{%>

                           <b>&gt;</b>

                    <%} %>

                    <a href="<c:url value='/CalendarExam2.jsp' />?year=<%=year+1%>&amp;month=<%=month%>" target="_self" style="color: white; font-weight: bolder">

                           <!-- 다음해<b>&gt;&gt;</b> -->

                    </a>

             </td>

       </tr>

       </table>

 

</td>

</tr>

</table>

<br>

<table border="0" cellspacing="1" cellpadding="1" bgcolor="000000" width = "110%">

<THEAD>

<TR bgcolor="#003246" height = "25px">

       <TD width='120px'>

       <DIV align="center"><font color="red">일</font></DIV>

       </TD>

       <TD width='120px'>

       <DIV align="center">월</DIV>

       </TD>

       <TD width='120px'>

       <DIV align="center">화</DIV>

       </TD>

       <TD width='120px'>

       <DIV align="center">수</DIV>

       </TD>

       <TD width='120px'>

       <DIV align="center">목</DIV>

       </TD>

       <TD width='120px'>

       <DIV align="center">금</DIV>

       </TD>

       <TD width='100px'>

       <DIV align="center"><font color="#529dbc">토</font></DIV>

       </TD>

</TR>

</THEAD>

<TBODY>

<TR>

<%!

	
	Connection con = null;
    ResultSet rs = null;
    String subject;
    String schedule_idx;
%>

<% 

//처음 빈공란 표시
for(int index = 1; index < start ; index++ )

{

  out.println("<TD >&nbsp;</TD>");

  newLine++;

}


for(int index = 1; index <= endDay; index++)

{

       String color = "";


       if(newLine == 0){          
    	   color = "RED";

       }else if(newLine == 6){   
    	   color = "#529dbc";

       }else{                     
    	   color = "#FFFFFF"; };

 

       String sUseDate = Integer.toString(year); 
       sUseDate += Integer.toString(month+1).length() == 1 ? "0" + Integer.toString(month+1) : Integer.toString(month+1);
       sUseDate += Integer.toString(index).length() == 1 ? "0" + Integer.toString(index) : Integer.toString(index);

 
       int iUseDate = Integer.parseInt(sUseDate);


       String backColor = "#00283C";

       if(iUseDate == intToday ) {

             backColor = "#576E77";

       }

       out.println("<TD valign='top' align='left' height='92px' bgcolor='"+backColor+"' nowrap>");

       %>

       <font color='<%=color%>'>

             <%=index %>

       </font>

 		

       <%
       Class.forName("com.mysql.jdbc.Driver").newInstance();

   	   con = DriverManager.getConnection("jdbc:mysql://15.164.30.158:3306/AIWUserDB", "sk", "1234");
       
	   //20200609 포맷임
       String compare_date = Integer.toString(iUseDate);
       
       //2020-06-09 포맷으로 만들기(db date 타입 데이터와 비교하기 위해)
       compare_date = compare_date.substring(0, 4) + "-"+compare_date.substring(4,6)+ "-"+compare_date.substring(6, 8);
       
       
       pageContext.setAttribute("compare_date", compare_date);
       
       out.println("<BR>");
       
       //만약에 db에 일정이 등록되어 있다면 차례대로 출력
       
       try{
       //1차 쿼리 -> name을 얻기 위한 
       String query = "select schedule_subject, schedule_idx from schedule where schedule_date = '"+ compare_date+"'"; 
   
       PreparedStatement pstm = con.prepareStatement(query);
       
       rs = pstm.executeQuery();
		
       int count =0;
   	
       	while(rs.next()){
          	
       		if(count == 0)
       			out.println("<BR>");
       		
          	subject = rs.getString("schedule_subject"); 
    		schedule_idx = rs.getString("schedule_idx"); 
          	%>
          	

          	<a href="schedule_read.jsp?schedule_idx=<%=URLEncoder.encode(schedule_idx, "UTF-8") %> ">                            
                    
          	<%
          	out.print(subject);
          	%>
          	
          	</a>
          	<% 
          	
          	out.println("<BR>");
          	count++;
       	}  

        
       }catch(Exception e){ //Null Pointer Exception 발생시 ArrayList에 추가 안 함(→  null인 곳을 참조하게 되므로)
     	  	//아무것도 x 
       }finally{
    	   if (con != null) {
               try {
                   con.close();
               } catch (Exception e) {
                   e.printStackTrace();
               }
           }
       }
          
		   
     
       
       
       
       
        %>
 		
 
          
       
       <%
       out.println("<BR>");
 

       //기능 제거 

       out.println("</TD>");
       newLine++;

       
       if(newLine == 7){

         out.println("</TR>");

         if(index <= endDay)
           out.println("<TR>");
         
         newLine=0;
       
       }

}

//마지막 공란 LOOP

while(newLine > 0 && newLine < 7)

{
  out.println("<TD>&nbsp;</TD>");
  newLine++;

}

%>

</TR>

 

</TBODY>

</TABLE>

</DIV>

</form>
</div>

</body>

</HTML>
