<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="counter" class="count.CounterBean" scope ="application"/>
	<jsp:setProperty name ="counter" property="newVisit" value="1" />
	
	

	<%
	 	int count = counter.getVisitCount();
	%>
	<h3> 이 페이지에 
	<%= count %>번째로 방문하셨습니다.
	</h3>
	
	
	
	
	
</body>
</html>