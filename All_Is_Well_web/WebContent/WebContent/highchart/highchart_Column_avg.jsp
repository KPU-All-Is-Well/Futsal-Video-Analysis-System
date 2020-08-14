 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.util.*"%> 
<%@page import="java.lang.*"%> 

<html>
<head>
<style>
	#container {
    height: 400px; 
}

.highcharts-figure, .highcharts-data-table table {
    min-width: 310px; 
    max-width: 800px;
    margin: 1em auto;
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

	<%! 
	
	Connection con = null;
	ResultSet rs = null;
    ResultSet rs2 = null;
    List barlist = new LinkedList();
    
    //추가함 List -> Array(배열)
    ArrayList<Float> arrayList = new ArrayList<>(); //스피드 담을 ArrayList
    ArrayList<String> arrayName = new ArrayList<>(); //이름 담을 ArrayList
    
    Float[] array; //Float 래퍼 클래스 객체들을 담을 배열
    String[] arrName; //List를 배열로 바꿔 담을 공간
    
    float float1; float float2; float float3; float float4;
    

   %>
   
    <%   
   
    //Connection con = null;
    try {
        //드라이버 호출, 커넥션 연결
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        
     
        con = DriverManager.getConnection(
                "jdbc:mysql://15.164.30.158:3306/AIWUserDB", "sk", "1234");
        
       
        
       
       
        //1차 쿼리 -> name을 얻기 위한 
        String query = "select id, name from playerSignUpInfo"; //get data from ID table
    
        PreparedStatement pstm = con.prepareStatement(query);
        
        rs = pstm.executeQuery();

       
        
        //2차 쿼리
        while(rs.next()){
           
           String name = rs.getString("name"); //이름
           String id = rs.getString("id"); //id
           
           try{
           
            //쿼리문 2번째
           String query2 = "select avgSpeed from " + id+ " where play_id = '1'"; //id 테이블 
           
           PreparedStatement pstm2 = con.prepareStatement(query2);
            
            rs2 = pstm2.executeQuery();
           	
           
            
            if(rs2.next()){
                float avgSpeed = rs2.getFloat("avgSpeed"); //최고 스피드
                
                //추가함
               	Float wAvgSpeed = new Float(avgSpeed); //maxSpeed는 Float 래퍼 클래스여야 함 -> //float 자료형을 Float 래퍼 클래스로  변환
				
               	arrayName.add(name); //이름 List에 추가 
     			arrayList.add(wAvgSpeed); 
     			
     			
            }       
        }catch(Exception e){ //Null Pointer Exception 발생시 ArrayList에 추가 안 함(→  null인 곳을 참조하게 되므로)
      	  	//아무것도 x 
        }finally{
        
        }	
            
        }
        
        array = arrayList.toArray(new Float[arrayList.size()]); //arrayList(리스트) -> array(배열)
        arrName = arrayName.toArray(new String[arrayName.size()]); //arrayName(리스트)) -> arrName(배열)
        
        //Float 래퍼 클래스 -> float 자료형으로 auto unboxing
        float1 = array[0];
        float2 = array[1];
        float3 = array[2];
        float4 = array[3];

    
 
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
      
</head>
<body>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<figure class="highcharts-figure">
    <div id="container"></div>
    <p class="highcharts-description">
    
    </p>




  <script type="text/javascript">
	//theme 색깔 적용
	    if (!Highcharts.theme) {
        Highcharts.setOptions({
            chart: {
                backgroundColor: 'black'
            },
            colors: ['#239ef6', '#9DFF02', '#0CCDD6','#ff0fff','#f0ffff','#ffff0f'],
            title: {
                style: {
                    color: 'white'
                }
            },
            tooltip: {
                style: {
                    color: 'black'
                }
            }
        });
    }	 
 // 차트 그리기 시작
 
   Highcharts.chart('container', {
    chart: {
        type: 'column'
    },
    title: {
        text: '선수 평균 스피드 랭킹 '
    },
    subtitle: {
        text: ''
    },
    xAxis: {
        type: 'category',
        labels: {
            rotation: -45,
            style: {
                fontSize: '13px',
                fontFamily: 'Verdana, sans-serif'
            }
        }
    },
    yAxis: {
        min: 0,
        title: {
            text: 'Average Speed (km/s)'
        }
    },
    legend: {
        enabled: false
    },
    tooltip: {
        pointFormat: '평균 스피드 : <b>{point.y:.1f} km/s</b> '
    },
    
    series: [{
        name: 'Population',
        data: [
            ["<%=arrName[0] %>", <%= float1 %>], 
            ["<%=arrName[1] %>", <%= float2 %>],
            ["<%=arrName[2] %>", <%= float3 %>],
            ["<%=arrName[3] %>", <%= float4 %>],
       
          
            
        ],
        dataLabels: {
            enabled: true,
            rotation: -90,
            color: '#FFFFFF',
            align: 'right',
            format: '{point.y:.1f}', // one decimal
            y: 10, // 10 pixels down from the top
            style: {
                fontSize: '13px',
                fontFamily: 'Verdana, sans-serif'
            }
        }
    }]
});
    </script>
</figure>

</body>

</html><html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
   body{
      background-color: #000000;
   }
</style>
<body>

</body>
</html>