<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, shop.review.ReviewDAO, shop.review.ReviewDTO" %>

<%
    int gnum = Integer.parseInt(request.getParameter("gnum"));
    int pagenum = Integer.parseInt(request.getParameter("page"));
 	
    int pageSize = 8;
    int startRow = (pagenum - 1) * pageSize + 1;
    int endRow = pagenum * pageSize;

    ReviewDAO rdao = ReviewDAO.getInstance();
    List<ReviewDTO> rlist = rdao.getReview(gnum, startRow, endRow);
    int rcount = rdao.reviewCount(gnum);

    int pageCount = rcount / pageSize + (rcount % pageSize == 0 ? 0 : 1);
    int pageBlock = 5;
    int startPage = ((pagenum - 1) / pageBlock) * pageBlock + 1;
    int endPage = startPage + pageBlock - 1;
    if (endPage > pageCount) endPage = pageCount;
%>

<% if (rlist != null && !rlist.isEmpty()) {
    for (ReviewDTO dto : rlist) {
        int rnum = dto.getRnum();
        String mname = dto.getMname();
%>
    <div id="review-<%= rnum %>">
        <strong><%= mname %></strong><br>
        <div style="white-space: pre-wrap; padding: 10px; border: 1px solid #ccc; font-size: 16px;">
            <p><%= dto.getRcontent() %></p>
        </div>
    </div>
<%  }
} else { %>
    <p>등록된 리뷰가 없습니다.</p>
<% } %>

<div class="text-center mt-4">
    <% if (startPage > pageBlock) { %>
        <a href="javascript:review(<%= gnum %>, <%= startPage - 1 %>)">◀ 이전</a>
    <% } %>
    <% for (int i = startPage; i <= endPage; i++) { %>
        <% if (i == pagenum) { %>
            <strong>[<%= i %>]</strong>
        <% } else { %>
            <a href="javascript:review(<%= gnum %>, <%= i %>)">[<%= i %>]</a>
        <% } %>
    <% } %>
    <% if (endPage < pageCount) { %>
        <a href="javascript:review(<%= gnum %>, <%= endPage + 1 %>)">다음 ▶</a>
    <% } %>
</div>

