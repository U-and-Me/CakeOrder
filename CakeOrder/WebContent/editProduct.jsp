<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<title>상품 편집</title>
<script type="text/javascript">
	function deleteConfirm(id) {
		if(confirm("해당 상품을 삭제합니다") == true){
			location.href = "./deleteProduct.jsp?id="+id;
		}else{
			return;
		}
	}
</script>
</head>
<%
	String edit = request.getParameter("edit");
%>
<body style="background-color: #fcfbfa">
	<jsp:include page="menu.jsp"/>
	<div class="jumbotron"  style="background-color: #ece2d9">
		<div class="container">
			<h1 class="display-3">상품편집</h1>
		</div>
	</div>
	<div class="container">
		<div class="row" align="center">
			<%@ include file="dbconn.jsp" %>
			<%
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				String sql = "SELECT * FROM product";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
			%>
			<div class="col-md-4">
				<img src="C:/upload/<%=rs.getString("p_fileName") %>" style="width:80%">
				<h3><%=rs.getString("p_name") %></h3>
				<p><%=rs.getString("p_description") %></p>
				<p><%=rs.getString("p_UnitPrice") %>원</p>
				<p><%
					if(edit.equals("update")){
					%>
						<a href="./updateProduct.jsp?id=<%=rs.getString("p_id")%>" class="btn" style="background-color: #d8caad; color: #765868; font-weight: bold;" role="button">수정 &raquo;</a>
				<%
					}else if(edit.equals("delete")){
				%>
				<a href="#" onclick="deleteConfirm('<%=rs.getString("p_id") %>')" class="btn" style="background-color: #d8caad; color: #765868; font-weight: bold;" role="button">삭제 &raquo;</a>
				<%
					}
				%>
			</div>
			<%
				}
				if(rs != null)
					rs.close();
				if(pstmt != null)
					pstmt.close();
				if(conn != null)
					conn.close();
			%>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jsp"/>
</body>
</html>