 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.util.*"%> 
<%@page import="java.lang.*"%> 

<html>
<head>
<style>
	#container {
    height: 800px; 
}

.highcharts-figure, .highcharts-data-table table {
    min-width: 320px; 
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
    
    //ArrayList(리스트) 
    ArrayList<Float> arrList_avg = new ArrayList<>(); //스피드 담을 ArrayList
    ArrayList<Float> arrList_max = new ArrayList<>(); //스피드 담을 ArrayList
    ArrayList<Float> arrList_dist = new ArrayList<>(); //스피드 담을 ArrayList
    ArrayList<Float> arrList_calorie = new ArrayList<>(); //스피드 담을 ArrayList
    ArrayList<Float> arrList_walk = new ArrayList<>(); //스피드 담을 ArrayList
    ArrayList<Float> arrList_jog = new ArrayList<>(); //스피드 담을 ArrayList
    ArrayList<Float> arrList_sprint = new ArrayList<>(); //스피드 담을 ArrayList
    ArrayList<String> arrList_name = new ArrayList<>(); //이름 담을 ArrayList
    
    //Array(배열) -> Float 래퍼 클래스 객체들을 담을 배열
    Float[] arr_avg;    Float[] arr_max;    Float[] arr_dist;		Float[] arr_calorie;
    Float[] arr_walk;    Float[] arr_jog;	Float[] arr_sprint;
   
    String[] arr_name;
    
    float f1_avg; float f2_avg; float f3_avg; float f4_avg;
    float f1_max; float f2_max; float f3_max; float f4_max;
    float f1_dist; float f2_dist; float f3_dist; float f4_dist;
    float f1_calorie; float f2_calorie; float f3_calorie; float f4_calorie;
    float f1_walk; float f2_walk; float f3_walk; float f4_walk;
    float f1_jog; float f2_jog; float f3_jog; float f4_jog;
    float f1_sprint; float f2_sprint; float f3_sprint; float f4_sprint;
    

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
           arrList_name.add(name); //이름 List에 추가 
           
           
            //쿼리문 2번째
           String query2 = "select avgSpeed, maxSpeed, totalDistance, calorie, walk, jog, sprint from " + id+ " where play_id = '1'"; //id 테이블 
           
           PreparedStatement pstm2 = con.prepareStatement(query2);
            
            rs2 = pstm2.executeQuery();
           	
           
            
            if(rs2.next()){
                float avgSpeed = rs2.getFloat("avgSpeed"); 	float maxSpeed = rs2.getFloat("maxSpeed"); 
                float totalDistance = rs2.getFloat("totalDistance"); float calorie = rs2.getFloat("calorie"); 
                float walk = rs2.getFloat("walk"); 	float jog = rs2.getFloat("jog"); 
                float sprint = rs2.getFloat("sprint"); 
                
                //추가함
               	Float wAvgSpeed = new Float(avgSpeed); //maxSpeed는 Float 래퍼 클래스여야 함 -> //float 자료형을 Float 래퍼 클래스로  변환
               	Float wMaxSpeed = new Float(maxSpeed);   Float wTotalDistance = new Float(totalDistance);
               	Float wCalorie = new Float(calorie);		Float wWalk = new Float(walk);
               	Float wJog = new Float(jog);	Float wSprint = new Float(sprint);
               	
       
     			arrList_avg.add(wAvgSpeed); arrList_max.add(wMaxSpeed);
     			arrList_dist.add(wTotalDistance); arrList_calorie.add(wCalorie);
     			arrList_walk.add(wWalk);	arrList_jog.add(wJog);
     			arrList_sprint.add(wSprint);
     			
     			
            }       
                      
        }
        
        
      	//arrList_max(리스트) -> arr_max(배열)
        arr_avg = arrList_avg.toArray(new Float[arrList_avg.size()]);        arr_max = arrList_max.toArray(new Float[arrList_max.size()]);
        arr_dist = arrList_dist.toArray(new Float[arrList_dist.size()]);        arr_calorie = arrList_calorie.toArray(new Float[arrList_calorie.size()]);
        arr_walk = arrList_walk.toArray(new Float[arrList_walk.size()]);        arr_jog = arrList_jog.toArray(new Float[arrList_jog.size()]);
        arr_sprint = arrList_sprint.toArray(new Float[arrList_sprint.size()]);
      
      	arr_name = arrList_name.toArray(new String[arrList_name.size()]); //arrList_name(리스트)) -> arr_name(배열)
        
        //Float 래퍼 클래스 -> float 자료형으로 auto unboxing
        f1_max = arr_max[0];		f2_max = arr_max[1];   f3_max = arr_max[2];   f4_max = arr_max[3];
        f1_avg = arr_avg[0];		f2_avg = arr_avg[1];   f3_avg = arr_avg[2];   f4_avg = arr_avg[3];
        f1_dist = arr_dist[0];		f2_dist = arr_dist[1];   f3_dist = arr_dist[2];   f4_dist = arr_dist[3];
        f1_calorie = arr_calorie[0];		f2_calorie = arr_calorie[1];   f3_calorie = arr_calorie[2];   f4_calorie = arr_calorie[3];
        f1_walk = arr_walk[0];		f2_walk = arr_walk[1];   f3_walk = arr_walk[2];   f4_walk = arr_walk[3];
        f1_jog = arr_jog[0];		f2_jog = arr_jog[1];   f3_jog = arr_jog[2];   f4_jog = arr_jog[3];
        f1_sprint = arr_sprint[0];		f2_sprint = arr_sprint[1];   f3_sprint = arr_sprint[2];   f4_sprint = arr_sprint[3];
        
    
 
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
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
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
        type: 'packedbubble',
        height: '100%'
    },
    title: {
        text: '선수 전체 데이터'
    },
    tooltip: {
        useHTML: true,
        pointFormat: '<b>{point.name}:</b> {point.value} <sub> </sub>'
    },
    plotOptions: {
        packedbubble: {
            minSize: '30%',
            maxSize: '120%',
            zMin: 0,
            zMax: 1000,
            layoutAlgorithm: {
                splitSeries: false,
                gravitationalConstant: 0.02
            },
            dataLabels: {
                enabled: true,
                format: '{point.name}',
                filter: {
                    property: 'y',
                    operator: '>',
                    value: 250
                },
                style: {
                    color: 'black',
                    textOutline: 'none',
                    fontWeight: 'normal'
                }
            }
        }
    },
    series: [{
        name: "<%=arr_name[0] %>",
        data: [{
            name: 'Average Speed',
            value: <%= f1_avg %>
        }, {
            name: 'Max Speed',
            value: <%= f1_max %>
        },
        {
            name: "Total Distance",
            value: <%= f1_dist %>
        },
        {
            name: "Calorie",
            value: <%= f1_calorie %>
        },
        {
            name: "Ratio of Walk",
            value: <%= f1_walk %>
        },
        {
            name: "Ratio of Jog",
            value: <%= f1_jog %>
        },
        {
            name: "Ratio of Sprint",
            value: <%= f1_sprint %>
        }]
    }, {
        name: "<%=arr_name[1] %>",
        data: [{
            name: "Average Speed",
            value: <%= f2_avg %>
        },
        {
            name: "Max Speed",
            value: <%= f2_max %>
        },
        {
            name: "Total Distance",
            value: <%= f2_dist %>
        },
        {
            name: "Calorie",
            value: <%= f2_calorie %>
        },
        {
            name: "Ratio of Walk",
            value: <%= f2_walk %>
        },
        {
            name: "Ratio of Jog",
            value: <%= f2_jog %>
        },
        {
            name: "Ratio of Sprint",
            value: <%= f2_sprint %>
        }]
    }, {
        name: "<%=arr_name[2] %>",
        data: [{
            name: "Average Speed",
            value: <%= f3_avg %>
        },
        {
            name: "Max Speed",
            value: <%= f3_max %>
        },
        {
            name: "Total Distance",
            value: <%= f3_dist %>
        },
        {
            name: "Calorie",
            value: <%= f3_calorie %>
        },
        {
            name: "Ratio of Walk",
            value: <%= f3_walk %>
        },
        {
            name: "Ratio of Jog",
            value: <%= f3_jog %>
        },
        {
            name: "Ratio of Sprint",
            value: <%= f3_sprint %>
        }]
    }, {
        name: "<%=arr_name[3] %>",
        data: [{
            name: "Average Speed",
            value: <%= f4_avg %>
        },
        {
            name: "Max Speed",
            value: <%= f4_max %>
        },
        {
            name: "Total Distance",
            value: <%= f4_dist %>
        },
        {
            name: "Calorie",
            value: <%= f4_calorie %>
        },
        {
            name: "Ratio of Walk",
            value: <%= f4_walk %>
        },
        {
            name: "Ratio of Jog",
            value: <%= f4_jog %>
        },
        {
            name: "Ratio of Sprint",
            value: <%= f4_sprint %>
        }]
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