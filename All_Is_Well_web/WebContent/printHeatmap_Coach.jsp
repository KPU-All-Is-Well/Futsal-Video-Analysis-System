<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
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


<body>
<%!
	String src="data:image/png;base64,"; 
	Connection conn = null;
	ResultSet rs = null;
    ResultSet rs2 = null;
    
  	//List를 배열로 바꿔 담을 공간
    String[] arrSrc; 
    String[] arrName;
    String[] arrPosition;

%>

<%
ArrayList<String> listSrc = new ArrayList<>(); //각 이미지마다 src를 담을 ArrayList  (지역변수)
ArrayList<String> listName = new ArrayList<>(); //각 이미지마다 name를 담을 ArrayList  (지역변수)
ArrayList<String> listPosition = new ArrayList<>(); //각 이미지마다 main position를 담을 ArrayList  (지역변수)

try{
	 //드라이버 호출, 커넥션 연결
	 Class.forName("com.mysql.jdbc.Driver").newInstance();


	 conn = DriverManager.getConnection(
     "jdbc:mysql://15.164.30.158:3306/AIWUserDB", "sk", "1234");

      request.setCharacterEncoding("utf-8");
      

     //쿼리 1차, 2차로 나누어야 함 
     
     //1차 쿼리 -> id와, name을 얻기 위한 
      String query = "select mainPosition, id, name from playerSignUpInfo"; //get data from ID table
    
      PreparedStatement pstm = conn.prepareStatement(query);
        
      rs = pstm.executeQuery();
     
      
      //2차 쿼리 시작
      while(rs.next()){
    	  String mainPosition = rs.getString("mainPosition"); //메인 포지션
    	  String name = rs.getString("name"); //이름
          String id = rs.getString("id"); //id
          
          
          
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


<div  style = text-align:center >
<div  style=color:white>
 <!-- 포지션별로 정렬해서 출력하는 알고리즘 -->
 
	<% 
	
		for(int i=0; i < listSrc.size() ; i++){			
			//출력
	%>
			
	<% 		
			if(i !=  listSrc.size() && arrPosition[i] != null){	//null일 경우는 이미 출력했다는 경우
	%>
			<div  style=color:blue> <!-- 포지션은 파란색으로 강조 -->
				<h2><br><%=arrPosition[i]%></h2>
			</div>
				<h3><br><%=arrName[i]%></h3>
				<img src=<%=arrSrc[i]%>>
	<% 
				for(int j=i+1; j < listSrc.size() ; j++){
							
						if(arrPosition[i].equals(arrPosition[j])){ 
	%>					
							 <!-- 포지션 같다면 포지션명은 출력 생략 -->
							<h3><br><%=arrName[j]%></h3>
							<img src=<%=arrSrc[j]%>>	
						
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
</html>