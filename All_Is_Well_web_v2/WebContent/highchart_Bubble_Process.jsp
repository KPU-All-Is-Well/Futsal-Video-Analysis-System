<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="org.json.JSONObject"%>
<%
    //커넥션 선s언
    Connection con = null;
    try {
        //드라이버 호출, 커넥션 연결
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        
        /*
        con = DriverManager.getConnection(
                "jdbc:mysql://192.168.103.149:3306/AIWUserDB", "sk", "1234");
 		*/
 		
 		
 		con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/AIWUserDB", "root", "1234");
        
        
        //ResultSet : 쿼리문에 대한 반환값
        ResultSet rs = null;
        ResultSet rs2 = null;
 
        //DB에서 뽑아온 데이터(JSON) 을 담을 객체. 후에 responseObj에 담기는 값
        List barlist = new LinkedList();
 
        //String id = (String)session.getAttribute("id");
         
       
        //1차 쿼리 -> name을 얻기 위한 
        String query = "select id, name from playerSignUpInfo"; //get data from ID table
    
        PreparedStatement pstm = con.prepareStatement(query);
        
        rs = pstm.executeQuery();

        /******************************************************************************************/
        
        //ajax에 반환할 JSON 생성
        JSONObject responseObj = new JSONObject();
        JSONObject barObj = null;
        
        //소수점 2번째 이하로 자름
        DecimalFormat f1 = new DecimalFormat("");
        //rs의 다음값이 존재할 경우
        
        
        /******************************************************************************************/
       
        
        
        //2차 쿼리
        while(rs.next()){
        	
        	String name = rs.getString("name"); //이름
            String id = rs.getString("id"); //id 
        	
            //쿼리문 2번째
        	String query2 = "select maxSpeed, totalDistance from " + id+ " where play_id = '1'"; //id 테이블 
        	
        	PreparedStatement pstm2 = con.prepareStatement(query2);
            
            rs2 = pstm2.executeQuery();
           
            if(rs2.next()){
            	float totalDistance = rs2.getFloat("totalDistance"); //총 거리
                float maxSpeed = rs2.getFloat("maxSpeed"); //최고 스피드
               	
                
                barObj = new JSONObject();
                barObj.put("name", name); 
                barObj.put("totalDistance", totalDistance);
                barObj.put("maxSpeed", maxSpeed);
                
                barlist.add(barObj);
     
            }       
                   	
        }
        
        responseObj.put("barlist", barlist);
        out.print(responseObj.toString());
        
 
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