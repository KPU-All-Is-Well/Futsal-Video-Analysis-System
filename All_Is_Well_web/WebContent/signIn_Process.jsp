<%@ page contentType="text/html; charset=UTF-8"%>
    
<html>
<head>
	<title>signUp_Process.jsp</title>
</head>

<body>
	<%@ include file="dbconn.jsp" %>
	
	<%
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");

		/*
			'디비 데이터'와 '입력 데이터' 비교
			로그인 성공시  -> 메인 페이지
			로그인 실패시 -> alert 창만 띄우기
		*/
		
		ResultSet rs = null;
		Statement stmt =null;
		
		
		try{
				
			String sql = "select id, passwd from CoachSignUpInfo where id =  '" + id + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			//if(stmt != null)
			//	stmt.close();
			
			while(rs.next()){
				
				String rId = rs.getString("id");
				String rPasswd = rs.getString("passwd");
							
				if(id.equals(rId) && passwd.equals(rPasswd)){ // TT
					out.println("<script>");
					out.println("alert('로그인 되었습니다. All Is Well에 오신 것을 진심으로 환영합니다.')");
					out.println("location.href='main.jsp'");
					out.println("</script>");	
				}/*else{ // TF, FT, FF 
					out.println("<script>");
					out.println("alert('일치하는 비밀번호가 없습니다. ')");
					out.println("location.href='welcome.jsp'");
					out.println("</script>");
				}*/
			
			}
			
			if(!rs.next()){ // TF, FT, FF 
				out.println("<script>");
				out.println("alert('존재하지 않는 아이디 또는 비밀번호 입니다. ')");
				out.println("location.href='welcome.jsp'");
				out.println("</script>");
			}
			
				
		
		}catch (SQLException ex){
			out.println("SQLException: "+ex.getMessage());
			
		}finally{
			
			if(rs != null)
				rs.close();
			if(stmt != null)
				stmt.close();
			if(conn != null)
				conn.close();
			
		}
		
	%>
	 
		
</body>
</html>