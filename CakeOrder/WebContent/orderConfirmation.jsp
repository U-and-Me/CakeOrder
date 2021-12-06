<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cartId = session.getId();
	String shipping_cartId = "";
	String shipping_name = "";
	String shipping_shippingDate = "";
	String shipping_country = "";
	String shipping_zipCode = "";
	String shipping_addressName = "";

	Cookie[] cookies = request.getCookies();
	if(cookies != null){
		for(int i = 0; i<cookies.length; i++){
			Cookie thisCookie = cookies[i];
			String n = thisCookie.getName();
			if(n.equals("Shipping_cartId")) {
				shipping_cartId = URLDecoder.decode((thisCookie.getValue()), "UTF-8");
			}
			if(n.equals("Shipping_name")) {
				shipping_name = URLDecoder.decode((thisCookie.getValue()), "UTF-8");
			}
			if(n.equals("Shipping_shippingDate")) {
				shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()), "UTF-8");
			}
			if(n.equals("Shipping_country")) {
				shipping_country = URLDecoder.decode((thisCookie.getValue()), "UTF-8");
			}
			if(n.equals("Shipping_zipCode")) {
				shipping_zipCode = URLDecoder.decode((thisCookie.getValue()), "UTF-8");
			}
			if(n.equals("Shipping_addressName")) {
				shipping_addressName = URLDecoder.decode((thisCookie.getValue()), "UTF-8");
			}
		}
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
		<title>주문 정보</title>
	</head>
	<body style="background-color: #fcfbfa">
		<jsp:include page="menu.jsp"/>
			<div class="jumbotron" style="background-color: #ece2d9">
				<div class="container">
					<h1 class="display-3"> 주문정보</h1>
				</div>
			</div>
			
			<div class = "container col-8 alert alert-info" style="background-color: #f8eded">
				<div class="text-center">
					<h1>영수증</h1> 
					
				</div>
				<div class="row justify-content-between">
					<div class="col-4" align="left">
						<strong>배송주소</strong> <br> 
						성명: <% out.println(shipping_name); %> <br>
						우편번호: <% out.println(shipping_zipCode); %> <br>
						주소: <% out.println(shipping_addressName); %>(<% out.println(shipping_country); %>) <br>
					</div>
					<div class="col-4" align="right">
						<p> <em>배송일: <% out.println(shipping_shippingDate); %></em> </p>
					</div>
				</div>
				<div>
					<table class="table table-hover">
						<tr>
							<th class="text-center">제품</th>
							<th class="text-center">개수</th>
							<th class="text-center">가격</th>
							<th class="text-center">소계</th>
						</tr>
						<%
							int sum = 0;
						      
					      	PreparedStatement pstmt = null; // 쿼리문을 미리 준비
				       	  	ResultSet rs = null; // 쿼리에서 나오는 결과값을 저장
				       	  	String sql = "SELECT * FROM cart";
				       	  	pstmt = conn.prepareStatement(sql);
				       	  	rs = pstmt.executeQuery();
				       	  
				       	  	while(rs.next()){
				       	  		sum += rs.getInt("p_count") * rs.getInt("p_unitPrice");
						%>
						<tr>
							<td class="text-center"><em><%= rs.getString("p_name") %></em></td>
							<td class="text-center"><em><%= rs.getString("p_count")%></em></td>
							<td class="text-center"><em><%= rs.getString("p_unitPrice")%></em></td>
							<td class="text-center"><em><%= sum %></em></td>
						</tr>
						<%
							}
						%>
						<tr>
							<td></td>
							<td></td>
							<td class="text-right"><strong>총액 : </strong></td>
							<td class="text-center text-danger"><strong><%=sum %></strong></td>
						</tr>
					</table>
					
					<a href="./shippingInfo.jsp?cartId=<%= shipping_cartId%>" class ="btn" style="background-color: #d8caad; color: #433e35" role="button">이전</a>
					<a href="./thankCustomer.jsp" class="btn" style="background-color: #877f78; color: #ede5de" role="button">주문 완료</a>
					<a href="./checkOutCancelled.jsp" class="btn" style="background-color: #d8caad; color: #433e35" role="button">취소</a>					
				</div>
			</div>
	</body>
</html>