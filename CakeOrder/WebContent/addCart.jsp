<%@page import="java.util.ArrayList"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp" %>

<%
	String id = request.getParameter("id");
	if(id == null || id.trim().equals("")){
		response.sendRedirect("products.jsp");
		return;
	}
	String name = null;
	int price = 0;
	// product 테이블에서 아이디, 이름, 가격 조회
	PreparedStatement pstmt = null; // 쿼리문을 미리 준비
    ResultSet rs = null; // 쿼리에서 나오는 결과값을 저장
    
	String sql = "SELECT * FROM product WHERE p_id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();

	if (rs.next()) {
		rs.getString("p_id");
		name = rs.getString("p_name");
		price = rs.getInt("p_unitPrice");
	}

	
	// cart 테이블에서 id를 찾고 없으면 insert, 있으면 갯수를 1개 증가
	sql = "SELECT * FROM cart WHERE p_id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();
	
	if(rs.next()){
		int count = rs.getInt("p_count") + 1;
		sql = "UPDATE cart SET p_count=? WHERE p_id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, count);
		pstmt.setString(2, id);
		pstmt.executeUpdate();
	}else{
		sql = "insert into cart values(?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, name);
		pstmt.setInt(3, price);
		pstmt.setInt(4, 1);
		pstmt.executeUpdate();
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
    
    response.sendRedirect("product.jsp?id=" + id); // 원래 화면으로 복귀
%>
