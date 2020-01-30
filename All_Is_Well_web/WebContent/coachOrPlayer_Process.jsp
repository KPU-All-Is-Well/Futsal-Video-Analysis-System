<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>coachOrPlayer_Process</title>
</head>
<body>
		<%
			request.setCharacterEncoding("UTF-8");
			String role = request.getParameter("role");
			if(role.equals("코치")){
		%>	
		<jsp:include page = "signUp.jsp" flush = "true" />
		<%
			}else if(role.equals("선수")){
		%>
		<jsp:include page = "signUpPlayer.jsp" flush = "true" />
		<%
			}
		%>
		
		
		
</body>
</html>