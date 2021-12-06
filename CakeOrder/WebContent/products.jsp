<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<title>상품 목록</title>
</head>
<body style="background-color: #fcfbfa">
   	<jsp:include page="menu.jsp" />
   <div class="jumbotron" style="background-color: #ece2d9">
      <div class="container">
         <h1 class="display-3">상품 목록</h1>
      </div>
   </div>
   <div class="container">
      <div class="row" align="center">
		 <%@ include file="dbconn.jsp" %>
         <%
            PreparedStatement pstmt = null; // 쿼리문을 미리 준비
         	ResultSet rs = null; // 쿼리에서 나오는 결과값을 저장
         	String sql = "SELECT * FROM product";
         	pstmt = conn.prepareStatement(sql); 
         	rs = pstmt.executeQuery();
         	
         	while(rs.next()){
         %>
         <div class="col-md-4">
            <img src="C:/upload/<%=rs.getString("p_fileName") %>" style="width: 80% ">
            <h4><%=rs.getString("p_name") %></h4>
            <p><%=rs.getString("p_description") %></p>
            <p><%=rs.getString("p_UnitPrice") %>원</p>
            <p><a href="./product.jsp?id=<%=rs.getString("p_id") %>
               "class="btn" role="button" style="background-color: #d8caad; color: #765868"> 상세 정보&raquo;</a></p>
         </div>
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
      </div>
   </div>
   <jsp:include page="footer.jsp" />
</body>
</html>