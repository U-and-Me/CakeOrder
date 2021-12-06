<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<%
	String id = request.getParameter("id");
	String cartId = session.getId();
%>
<title>장바구니</title>
</head>
<body style="background-color: #fcfbfa">
	<jsp:include page="menu.jsp" />
	<div class="jumbotron" style="background-color: #ece2d9">
		<div class="container">
			<h1 class="display-3">장바구니</h1>
		</div>	
	</div>
	<div class="container">
		<div class="row">
			<table width="100%">
				<tr>
					<td align="left"><a href="./deleteCart.jsp?cartId=<%= cartId%>" class="btn" style="background-color: #d8caad; color: #433e35">삭제하기</a></td>
					<td align="right"><a href="./shippingInfo.jsp?cartId=<%=cartId %>" class="btn" style="background-color: #877f78; color: #f4efeb">주문하기</a></td>
				</tr>
			</table>
		</div>
		<div style="padding-top : 50px">
			<table class="table table-hover">
				<tr>
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
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
					<td><%= rs.getString("p_name") %></td> <!-- 상품 -->
					<td><%= rs.getInt("p_unitPrice") %></td> <!-- 가격 -->
					<td><%= rs.getInt("p_count") %></td> <!-- 수량 -->
					<td><%= rs.getInt("p_count") * rs.getInt("p_unitPrice") %></td> <!-- 총액 -->
					<td><a href="./removeCart.jsp?id=<%= rs.getString("p_id") %>" class="badge badge-danger">삭제</a></td>
				</tr>
				<%
		       	  	}
		       	  	
		       	 	if(rs != null){
		          		rs.close();
		         	 }
		          	if(pstmt != null){
		          		pstmt.close();
		          	}
		          	if(conn != null){
		          		conn.close();
		         	}
				%>
				<tr>
					<th></th>
					<th></th>
					<th>총액</th>
					<th><%= sum %></th>
					<th></th>
				</tr>
			</table>
			<a href="./products.jsp" class="btn" style="background-color: #433e35;  color: #ffffff; font-weight: bold">&laquo;쇼핑 계속하기</a>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>







