 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.util.*"%> 
<%@page import="java.lang.*"%> 

<html>
<head>
<style>
.highcharts-figure, .highcharts-data-table table {
    min-width: 310px; 
    max-width: 800px;
    margin: 1em auto;
}

#container {
    height: 400px;
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
    ArrayList<Float> arrayList2 = new ArrayList<>(); //총 뛴 거리 담을 ArrayList
    ArrayList<String> arrayName = new ArrayList<>(); //이름 담을 ArrayList
    
    Float[] array; //Float 래퍼 클래스 객체들을 담을 배열
    Float[] array2; //Float 래퍼 클래스 객체들을 담을 배열
    String[] arrName; //List를 배열로 바꿔 담을 공간
    
    float float1; float float2; float float3; float float4;
    float float1_; float float2_; float float3_; float float4_;
    

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
           String query2 = "select totalDistance, maxSpeed from " + id+ " where play_id = '1'"; //id 테이블 
           
           PreparedStatement pstm2 = con.prepareStatement(query2);
            
            rs2 = pstm2.executeQuery();
           	
           
            
            if(rs2.next()){
                float totalDistance = rs2.getFloat("totalDistance"); //총 뛴 거리
                float maxSpeed = rs2.getFloat("maxSpeed"); //최고 스피드
                
                //추가함
                Float wTotalDistance = new Float(totalDistance); //totalDistance Float 래퍼 클래스여야 함 -> //float 자료형을 Float 래퍼 클래스로  변환
               	Float wMaxSpeed = new Float(maxSpeed); //maxSpeed는 Float 래퍼 클래스여야 함 -> //float 자료형을 Float 래퍼 클래스로  변환
				
               	arrayName.add(name); //이름 List에 추가 
     			arrayList.add(wMaxSpeed);
     			arrayList2.add(wTotalDistance);	
     			
            }
            
           }catch(Exception e){ //Null Pointer Exception 발생시 ArrayList에 추가 안 함(→  null인 곳을 참조하게 되므로)
         	  	//아무것도 x 
           }finally{
           
           }
                      
        }
        
        array = arrayList.toArray(new Float[arrayList.size()]); //arrayList(리스트) -> array(배열)
        array2 = arrayList2.toArray(new Float[arrayList2.size()]); //arrayList(리스트) -> array(배열)
        arrName = arrayName.toArray(new String[arrayName.size()]); //arrayName(리스트)) -> arrName(배열)
        
        //Float 래퍼 클래스 -> float 자료형으로 auto unboxing
        float1 = array[0];
        float2 = array[1];
        float3 = array[2];
        float4 = array[3];
        
        float1_ = array2[0];
        float2_ = array2[1];
        float3_ = array2[2];
        float4_ = array2[3];

    
 
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
        type: 'bar'
    },
    title: {
        text: ' 최고 속력과 뛴거리 랭킹 '
    },
    subtitle: {
        text: ''
    },
    xAxis: {
        categories: ["<%=arrName[0] %>", "<%=arrName[1] %>", "<%=arrName[2] %>", "<%=arrName[3] %>"],
        title: {
            text: null
        }
    },
    yAxis: {
        min: 0,
        title: {
            text: 'km/h',
            align: 'high'
        },
        labels: {
            overflow: 'justify' 
        }
    },
    tooltip: {
        valueSuffix: ' millions'
    },
    plotOptions: {
        bar: {
            dataLabels: {
                enabled: true
            }
        }
    },
    legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'top',
        x: -40,
        y: 80,
        floating: true,
        borderWidth: 1,
        backgroundColor:
            Highcharts.defaultOptions.legend.backgroundColor || '#FFFFFF',
        shadow: true
    },
    credits: {
        enabled: false
    },
    series: [{
        name: 'Max Speed',
        data: [ <%= float1 %>, <%= float2 %>, <%= float3 %>, <%= float4 %>]
    }, {
        name: 'Total Distance',
        data: [ <%= float1_ %>, <%= float2_ %>, <%= float3_ %>, <%= float4_ %>]
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