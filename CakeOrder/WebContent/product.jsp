<%@page import="dao.ProductRepository"%>
<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="exceptionNoProductId.jsp" %>
<jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<title>상품 상세 정보</title>
<script type="text/javascript">
	function addToCart(count){
		if(count <= 0){
			alert("상품이 모두 품절되었습니다.");
		}else if(confirm("상품을 장바구니에 추가하시겠습니까?")){
			document.addForm.submit();
		}else{
			document.addForm.reset();
		}
	}
</script>
</head>
<body style="background-color: #fcfbfa">
   <jsp:include page="menu.jsp" />
   <div class="jumbotron" style="background-color: #e7ddd3">
      <div class="container">
         <h1 class="display-3">상품 정보</h1>
      </div>
   </div>
   <%@ include file="dbconn.jsp" %>
   <%
	     String id = request.getParameter("id");
	      
	      PreparedStatement pstmt = null; // 쿼리문을 미리 준비
       	  ResultSet rs = null; // 쿼리에서 나오는 결과값을 저장
       	  String sql = "SELECT * FROM product WHERE p_id=?";
       	  pstmt = conn.prepareStatement(sql); 
       	  pstmt.setString(1, id);
       	  rs = pstmt.executeQuery();
       	  
       	  if(rs.next()){
       		int count = Integer.parseInt(rs.getString("p_unitsInStock"));
       	  
   %>
   <div class="container">
      <div class="row">
      	<div class="col-md-5">
      		<img src="C:/upload/<%= rs.getString("p_fileName")%>" style="width: 100%">
      	</div>
            <div class="col-md-6">
            <h3><%=rs.getString("p_name") %></h3>
            <p><%=rs.getString("p_description")%></p>
            <p> <b>상품 코드 </b><span class = "badge badge-danger">
            <%=rs.getString("p_id") %></span>
            <p><b>재고 수</b> : <%= rs.getString("p_unitsInStock") %>
            <p><b>가  격</b> : <%= rs.getInt("p_unitPrice") %>원
            <%
            	if(rs.getString("p_id").substring(0, 1).equals("A")){
            %>
            		<p><b>*원하시는 도안은 주문번호, 이름, 전화번호와 함께 이메일로 보내주세요</b>
            <%		
            	}
            %>
            <p><form name="addForm" action="./addCart.jsp?id=<%=rs.getString("p_id") %>" method="post">
            	<a href="#" class="btn" style="background-color: #433e35;  color: #ffffff" onclick="addToCart(<%=count %>)">상품 주문&raquo;</a>
            	<a href="./cart.jsp?id=<%=rs.getString("p_id") %>" class="btn" style="background-color: #877f78; color: #ede5de">장바구니 &raquo;</a>
               	<a href="./products.jsp" class="btn" style="background-color: #d8caad; color: #433e35">상품 목록&raquo;</a>
            </form>
            
         </div>
      </div>
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
   <%@ include file="footer.jsp" %>
</body>
</html>







