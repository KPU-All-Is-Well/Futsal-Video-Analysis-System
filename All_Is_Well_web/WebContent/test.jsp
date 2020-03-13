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



      
</head>
<body>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<figure class="highcharts-figure">
    <div id="container"></div>
    <p class="highcharts-description">
       
    </p>
 

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
    
    float float1 =0; float float2 = 2; float float3 = 0; float float4 = 0;
    

   %>
   
    <%
   
    
    try {
        //드라이버 호출, 커넥션 연결
        //Class.forName("com.mysql.jdbc.Driver").newInstance();
        Class.forName(" com.mysql.cj.jdbc.Driver").newInstance();
      
     
        con = DriverManager.getConnection(
                "jdbc:mysql://15.164.30.158:3306/AIWUserDB?autoReconnect=true&amp;serverTimezone=UTC", "sk", "1234");
        
       
        
       
       
        //1차 쿼리 -> name을 얻기 위한 
        String query = "select id, name from playerSignUpInfo"; //get data from ID table
    
        PreparedStatement pstm = con.prepareStatement(query);
        
        rs = pstm.executeQuery();

       
        
        //2차 쿼리
        while(rs.next()){
           
           String name = rs.getString("name"); //이름
           String id = rs.getString("id"); //id
           arrayName.add(name); //이름 List에 추가 
           
           
            //쿼리문 2번째
           String query2 = "select totalDistance from " + id+ " where play_id = '1'"; //id 테이블 
           out.println(query2);

           PreparedStatement pstm2 = con.prepareStatement(query2);
            
            rs2 = pstm2.executeQuery();
           	
           
            
            if(rs2.next()){
                float totalDistance = rs2.getFloat("totalDistance"); //최고 스피드
                
                //추가함
               	Float wTotalDistance = new Float(totalDistance); //maxSpeed는 Float 래퍼 클래스여야 함 -> //float 자료형을 Float 래퍼 클래스로  변환

     			arrayList.add(wTotalDistance); 
     			
     			
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


  <script type="text/javascript">
	//theme 색깔 적용
	    if (!Highcharts.theme) {
        Highcharts.setOptions({
            chart: {
                backgroundColor: 'black'
            },
            colors: ['#239ef6', '#9DFF02', '#0CCDD6','#ff0fff','#f0ffff','#ffff0f','#fddddd'],
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
 
  // Create the chart
Highcharts.chart('container', {
    chart: {
        type: 'column'
    },
    title: {
        text: '평균 뛴 거리 랭킹 '
    },
    subtitle: {
        text: '</a>'
    },
    accessibility: {
        announceNewData: {
            enabled: true
        }
    },
    xAxis: {
        type: 'category'
    },
    yAxis: {
        title: {
            text:'M( 미터 )'
        }

    },
    legend: {
        enabled: false
    },
    plotOptions: {
        series: {
            borderWidth: 0,
            dataLabels: {
                enabled: true,
                format: '{point.y:.1f}'
            }
        }
    },

    tooltip: {
        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}</b> <br/>'
    },

    series: [
        {
            name: "Player",
            colorByPoint: true,
            data: [
                {
                    name: 'sally',
                    y: <%= float1 %>,
                    drilldown: "sally"
                },
                
                {
                    name:  "ally",
                    y: <%= float2 %>,
                    drilldown:  'ally'
                },
                {
                    name:  "lly",
                    y: <%= float3 %>,
                    drilldown: "lly"
                },
                {
                    name:  "y",
                    y: <%= float4 %>,
                    drilldown:  "y"
                }
            ]
        }
    ],
    drilldown: {
        series: [
            {
                name: "Son",
                id: "Son",
                data: [
                    [
                        "v65.0",
                        0.1
                    ],
                    [
                        "v64.0",
                        1.3
                    ],
                    [
                        "v63.0",
                        53.02
                    ],
                    [
                        "v62.0",
                        1.4
                    ],
                    [
                        "v61.0",
                        0.88
                    ],
                    [
                        "v60.0",
                        0.56
                    ],
                    [
                        "v59.0",
                        0.45
                    ],
                    [
                        "v58.0",
                        0.49
                    ],
                    [
                        "v57.0",
                        0.32
                    ],
                    [
                        "v56.0",
                        0.29
                    ],
                    [
                        "v55.0",
                        0.79
                    ],
                    [
                        "v54.0",
                        0.18
                    ],
                    [
                        "v51.0",
                        0.13
                    ],
                    [
                        "v49.0",
                        2.16
                    ],
                    [
                        "v48.0",
                        0.13
                    ],
                    [
                        "v47.0",
                        0.11
                    ],
                    [
                        "v43.0",
                        0.17
                    ],
                    [
                        "v29.0",
                        0.26
                    ]
                ]
            },
            {
                name: "Firefox",
                id: "Firefox",
                data: [
                    [
                        "v58.0",
                        1.02
                    ],
                    [
                        "v57.0",
                        7.36
                    ],
                    [
                        "v56.0",
                        0.35
                    ],
                    [
                        "v55.0",
                        0.11
                    ],
                    [
                        "v54.0",
                        0.1
                    ],
                    [
                        "v52.0",
                        0.95
                    ],
                    [
                        "v51.0",
                        0.15
                    ],
                    [
                        "v50.0",
                        0.1
                    ],
                    [
                        "v48.0",
                        0.31
                    ],
                    [
                        "v47.0",
                        0.12
                    ]
                ]
            },
            {
                name: "Internet Explorer",
                id: "Internet Explorer",
                data: [
                    [
                        "v11.0",
                        6.2
                    ],
                    [
                        "v10.0",
                        0.29
                    ],
                    [
                        "v9.0",
                        0.27
                    ],
                    [
                        "v8.0",
                        0.47
                    ]
                ]
            },
            {
                name: "Safari",
                id: "Safari",
                data: [
                    [
                        "v11.0",
                        3.39
                    ],
                    [
                        "v10.1",
                        0.96
                    ],
                    [
                        "v10.0",
                        0.36
                    ],
                    [
                        "v9.1",
                        0.54
                    ],
                    [
                        "v9.0",
                        0.13
                    ],
                    [
                        "v5.1",
                        0.2
                    ]
                ]
            },
            {
                name: "Edge",
                id: "Edge",
                data: [
                    [
                        "v16",
                        2.6
                    ],
                    [
                        "v15",
                        0.92
                    ],
                    [
                        "v14",
                        0.4
                    ],
                    [
                        "v13",
                        0.1
                    ]
                ]
            },
            {
                name: "Opera",
                id: "Opera",
                data: [
                    [
                        "v50.0",
                        0.96
                    ],
                    [
                        "v49.0",
                        0.82
                    ],
                    [
                        "v12.1",
                        0.14
                    ]
                ]
            }
        ]
    }
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