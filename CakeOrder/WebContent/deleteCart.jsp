<%@page import="java.util.ArrayList"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp" %>
<%
	String id = request.getParameter("cartId");
	if(id == null || id.trim().equals("")){
		response.sendRedirect("cart.jsp");
		return;
	}
    
    PreparedStatement pstmt = null; // 쿼리문을 미리 준비
    
 	String sql = "DELETE FROM cart";
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();
		

	if(pstmt != null)
		pstmt.close();
	if(conn != null)
		conn.close();
	
	response.sendRedirect("cart.jsp"); // 원래 화면으로 복귀

%>