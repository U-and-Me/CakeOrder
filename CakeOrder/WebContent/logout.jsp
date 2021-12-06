<%@ page contentType="text/html; charset=utf-8" %>

<%
	session.invalidate();
	response.sendRedirect("addProduct.jsp"); // 로그아웃 했을 때 addProduct.jsp로 이동함
%>