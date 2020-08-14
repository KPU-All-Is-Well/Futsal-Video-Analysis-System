<%@ page language="java" contentType="text/html; charset=EUC-KR"

    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>  
<%
	request.setCharacterEncoding("euc-kr");

	Class.forName("com.mysql.jdbc.Driver");	
	
	 String driverName="com.mysql.jdbc.Driver";
	 String url = "jdbc:mysql://localhost:3306/AIWUserDB";
		String id = "root";
		String pass = "zlzl153214@";
		
	String match_name = request.getParameter("match_name");
	String passwd = request.getParameter("passwd");
	String player = request.getParameter("player");
	String feedback = request.getParameter("feedback");
	
	try {	
		Connection conn = DriverManager.getConnection(url,id,pass);
		
		String sql = "INSERT INTO board_coach(match_name,player,feedback,passwd) VALUES(match_name,player,feedback,passwd)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, match_name);
		pstmt.setString(2, player);
		pstmt.setString(3, passwd);
		pstmt.setString(4, feedback);
		
		pstmt.execute();
		pstmt.close();
		
		conn.close();
} catch(SQLException e) {
	out.println( e.toString() );
	}
%>
  <script language=javascript>
   self.window.alert("입력한 글을 저장하였습니다.");
   location.href="list.jsp"; 

</script>



