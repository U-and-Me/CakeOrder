<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.*" %>
<%@include file="dbconn.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String productIdf = request.getParameter("id");	

	String filename = "";
   String realFolder = "C:\\upload"; // 웹 애플리케이션상의 절대 경로
   int maxsize = 9 * 1024 * 1024; // 최대 업로드될 최대 크기 5MB
   String encType = "utf-8";
   
   MultipartRequest multi = new MultipartRequest(request, realFolder, maxsize, encType, new DefaultFileRenamePolicy());

   String productId = multi.getParameter("productId");
   String name = multi.getParameter("name");
   String unitPrice= multi.getParameter("unitPrice");
   String description = multi.getParameter("description");
   String unitsInStock = multi.getParameter("unitsInStock");
   
   Integer price;
   if(unitPrice.isEmpty())
      price = 0;
   else
      price = Integer.valueOf(unitPrice);
   
   long stock;
   if(unitsInStock.isEmpty())
      stock = 0;
   else
      stock = Long.valueOf(unitsInStock);       
   
   Enumeration files = multi.getFileNames(); // Enumeration files 에 파일 이름을 담는다
   String fname = (String) files.nextElement(); // files에 있는 파일 이름 가져오기
   String fileName = multi.getFilesystemName(fname); // 서버에 실제 저장된 파일 이름을 가져온다
   

   PreparedStatement pstmt = null;
   ResultSet rs = null;
   
   String sql = "SELECT * FROM product WHERE p_id = ?";
   pstmt = conn.prepareStatement(sql);
   pstmt.setString(1, productId);
   rs = pstmt.executeQuery();
   
   if(rs.next()){ 
	   if(fileName != null){
   			sql = "UPDATE product SET p_name=?, p_unitPrice=?, p_description=?, p_unitsInStock=?, p_fileName=? WHERE p_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setInt(2, price);
			pstmt.setString(3, description);
			pstmt.setLong(4, stock);
			pstmt.setString(5, fileName);
			pstmt.setString(6, productId);

			pstmt.executeUpdate(); // 쿼리 실행시키기
			
	   }else{
		    sql = "UPDATE product SET p_name=?, p_unitPrice=?, p_description=?, p_unitsInStock=? WHERE p_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setInt(2, price);
			pstmt.setString(3, description);
			pstmt.setLong(4, stock);
			pstmt.setString(5, productId);

			pstmt.executeUpdate(); // 쿼리 실행시키기
	   }
	}
   
    if(rs != null)
   		rs.close();
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();

	response.sendRedirect("editProduct.jsp?edit=update");
%>
