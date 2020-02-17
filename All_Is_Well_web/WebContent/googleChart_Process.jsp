<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="org.json.JSONObject"%>
<%
    //커넥션 선언
    Connection con = null;
    try {
        //드라이버 호출, 커넥션 연결
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        con = DriverManager.getConnection(
                "jdbc:mysql://192.168.103.36:3306/AIWUserDB", "sk", "1234");
 
        //ResultSet : 쿼리문에 대한 반환값
        ResultSet rs = null;
 
        //DB에서 뽑아온 데이터(JSON) 을 담을 객체. 후에 responseObj에 담기는 값
        List barlist = new LinkedList();
 
        String id = (String)session.getAttribute("id");
        
        String query = "select totalDistance, maxSpeed from" + id; //get data from ID table
        String query2 = "select name from PlayerSignUpInfo where id = "+ id;
        
        PreparedStatement pstm = con.prepareStatement(query);
        PreparedStatement pstm2 = con.prepareStatement(query2);
        
        rs = pstm.executeQuery();
        
        //ajax에 반환할 JSON 생성
        JSONObject responseObj = new JSONObject();
        JSONObject barObj = null;
        
        //소수점 2번째 이하로 자름
        DecimalFormat f1 = new DecimalFormat("");
        //rs의 다음값이 존재할 경우
        while (rs.next()) {
            String name = rs.getString("name");  //name으로 바꿔보기 name도 외래키로 하여 
            float totalDistance = rs.getFloat("totalDistance");
            float maxSpeed = rs.getFloat("maxSpeed");
            barObj = new JSONObject();
            barObj.put("name", id); 
            barObj.put("totalDistance", totalDistance);
            barObj.put("maxSpeed", maxSpeed);
            barlist.add(barObj);
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