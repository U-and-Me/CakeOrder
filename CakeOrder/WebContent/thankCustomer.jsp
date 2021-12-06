<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<title>주문 완료</title>
<%@ include file="dbconn.jsp" %>
</head>
<body style="background-color: #fcfbfa">
	<%
		String shipping_cartId = "";
		String shipping_name = "";
		String shipping_shippingDate = "";
		String shipping_country = "";
		String shipping_zipCode = "";
		String shipping_addressName = "";
		
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null){
			for(int i = 0; i < cookies.length; i++){
				Cookie thisCookie = cookies[i];
				String n = thisCookie.getName();
				if(n.equals("Shipping_cartId"))
					shipping_cartId = URLDecoder.decode((thisCookie.getValue()), "utf-8");
				if(n.equals("Shipping_shippingDate"))
					shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			}
		}
	%>
	<jsp:include page="menu.jsp"/>
	<div class="jumbotron" style="background-color: #ece2d9">
			<div class="container">
				<h1 class="display-3">주문 완료</h1>
			</div>
	</div>
	<div class="container">
		<h2 class="alert" style="background-color: #f8eded">주문해주셔서 감사합니다.</h2>
		<p> 주문은 <% out.println(shipping_shippingDate); %>에 배송될 예정입니다.
		<p> 주문번호 : <% out.println(shipping_cartId); %>
	</div>
	<div class="container">
		<p><a href="./products.jsp" class="btn" style="background-color: #877f78; color: #ede5de">&laquo; 상품목록</a>
	</div>
</body>
</html>

<%
	PreparedStatement pstmt = null; // 쿼리문을 미리 준비
	ResultSet rs = null; // 쿼리에서 나오는 결과값을 저장
	
	String sql = "SELECT * FROM cart";
	pstmt = conn.prepareStatement(sql); 
 	rs = pstmt.executeQuery();
 	
 	ArrayList<String> Id = new ArrayList<String>();
 	
 	while(rs.next()){
 		Id.add(rs.getString("p_id"));
 	}

	sql = "DELETE FROM cart";
	pstmt = conn.prepareStatement(sql);
	pstmt.executeUpdate();
	
	
	while(!Id.isEmpty()){
		sql = "SELECT * FROM product WHERE p_id=?";
		pstmt = conn.prepareStatement(sql); 
		pstmt.setString(1, Id.get(0));
 		rs = pstmt.executeQuery();
 		
 		while(rs.next()){
 			int count = rs.getInt("p_unitsInStock") - 1;
 			
 			sql = "UPDATE product SET p_unitsInStock=? WHERE p_id=?";
 	 		pstmt = conn.prepareStatement(sql);
 	 		pstmt.setInt(1, count);
 	 		pstmt.setString(2, Id.get(0));

 	 		pstmt.executeUpdate(); // 쿼리 실행시키
 		}
		Id.remove(0);
	}
 	
	if(pstmt != null)
		pstmt.close();
	if(conn != null)
		conn.close();
%>

<%
	session.invalidate();
	
	for(int i = 0; i < cookies.length; i++){
		Cookie thisCookie = cookies[i];
		String n = thisCookie.getName();
		
		if(n.equals("Customer_Id"))
			thisCookie.setMaxAge(0);
		if(n.equals("Customer_name"))
			thisCookie.setMaxAge(0);
		if(n.equals("Customer_PhoneNumber"))
			thisCookie.setMaxAge(0);
		if(n.equals("Customer_country"))
			thisCookie.setMaxAge(0);
		if(n.equals("Customer_zipCode"))
			thisCookie.setMaxAge(0);
		if(n.equals("Customer_addressName"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_cartId"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_name"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_shippingDate"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_country"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_zipCode"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_address"))
			thisCookie.setMaxAge(0);
		
		response.addCookie(thisCookie);
		
	}
%>