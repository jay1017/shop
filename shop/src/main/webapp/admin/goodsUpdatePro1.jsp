<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="shop.admin.GoodsImageDTO"%>
<%@ page import="shop.admin.GoodsImageDAO"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
</head>
<body>
	<%
		String serverPath = config.getServletContext().getRealPath("resources/image");
		int max = 1024 * 1024 * 10;
		String enc = "UTF-8";
		DefaultFileRenamePolicy df = new DefaultFileRenamePolicy();
		MultipartRequest mr = new MultipartRequest(request, serverPath, max, enc, df);
	
		GoodsImageDTO dto = new GoodsImageDTO();
		GoodsImageDAO dao = GoodsImageDAO.getDAO();
		
		int gnum = Integer.parseInt(mr.getParameter("gnum"));
		int ginum = Integer.parseInt(mr.getParameter("ginum"));
		int gonum = Integer.parseInt(mr.getParameter("gonum")); 
		
		String giname = mr.getFilesystemName("giname");
		String gidetail1 = mr.getFilesystemName("gidetail1");
		String gidetail2 = mr.getFilesystemName("gidetail2");
		String gidetail3 = mr.getFilesystemName("gidetail3");
		
		dto.setGinum(ginum);
		
		if(giname != null) {
			String type = mr.getContentType("giname");
			String fileType = type.split("/")[0];
			
			if(!fileType.equals("image")) {
				mr.getFile("giname").delete();
			} else {
				dto.setGiname(giname);
			}
		}
		
		if(gidetail1 != null) {
			String type = mr.getContentType("gidetail1");
			String fileType = type.split("/")[0];
			
			if(!fileType.equals("image")) {
				mr.getFile("gidetail1").delete();
			} else {
				dto.setGidetail1(gidetail1);
			}
		}
		
		if(gidetail2 != null) {
			String type = mr.getContentType("gidetail2");
			String fileType = type.split("/")[0];
			
			if(!fileType.equals("image")) {
				mr.getFile("gidetail2").delete();
			} else {
				dto.setGidetail2(gidetail2);
			}
		}
		
		if(gidetail3 != null) {
			String type = mr.getContentType("gidetail3");
			String fileType = type.split("/")[0];
			
			if(!fileType.equals("image")) {
				mr.getFile("gidetail3").delete();
			} else {
				dto.setGidetail3(gidetail3);
			}
		}
		
		int result = dao.update(dto); 
		
		if(result == 1) { %>
		<script>
			alert("저장 하였습니다.");
			window.location="/shop/admin/goodsUpdate2.jsp?ginum=<%=ginum%>&gnum=<%=gnum%>&gonum=<%=gonum%>";
		</script>
		<% } else { %>
			<script>
				alert("저장에 실패하였습니다.");
			</script>
		<% } %>
</body>
</html>