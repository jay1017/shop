<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.review.ReviewDTO" %>
<%@ page import="shop.review.ReviewDAO" %>
<%@ page import="shop.member.MemberDTO" %>
<%@ page import="shop.member.MemberDAO" %>
<%@ page import="java.util.List" %>
<%
    request.setCharacterEncoding("UTF-8");
    String sid = (String) session.getAttribute("sid");
    int mnum = 0;
    
    if(sid != null) {
        MemberDAO mdao = new MemberDAO();
        MemberDTO mdto = mdao.getMidname(sid); 
        mnum = mdto.getMnum();
    }
    
    int gnum = Integer.parseInt(request.getParameter("gnum"));
    String pageNum = request.getParameter("pageNum");
    if(pageNum == null) pageNum = "1";
    
    int pageSize = 8;
    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    
    ReviewDAO rdao = ReviewDAO.getInstance();
    List<ReviewDTO> rlist = rdao.getReview(gnum, startRow, endRow);
    int rcount = rdao.reviewCount(gnum);
    
    int pageCount = (int) Math.ceil((double) rcount / pageSize);
    int startPage = ((currentPage - 1) / 10) * 10 + 1;
    int endPage = Math.min(startPage + 9, pageCount);
%>

<div class="review-list-container">
    <% if(rlist.isEmpty()) { %>
        <div class="no-reviews" style="text-align: center; padding: 40px; color: #666;">
            <p>아직 작성된 리뷰가 없습니다.</p>
        </div>
    <% } else { %>
        <% for(ReviewDTO review : rlist) { %>
            <div class="review-item" id="review-<%=review.getRnum()%>" style="padding: 20px; border-bottom: 1px solid #e0e0e0; margin-bottom: 20px;">
                <div class="review-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
                    <div class="reviewer-info">
                        <strong style="color: #333;"><%=review.getMname()%></strong>
                        <span style="color: #666; font-size: 14px; margin-left: 10px;">(<%=review.getMid()%>)</span>
                    </div>
                    <% if(sid != null && mnum == review.getMnum()) { %>
                        <div class="review-actions">
                            <button type="button" class="btn btn-sm btn-outline-primary" onclick="editReview(<%=review.getRnum()%>, '<%=review.getRcontent().replace("'", "\\'").replace("\n", "\\n").replace("\"", "\\\"").replace("\r", "")%>')">
                                수정
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-danger" onclick="deleteReview(<%=review.getRnum()%>,<%=review.getGnum() %>)" style="margin-left: 5px;">
                                삭제
                            </button>
                        </div>
                    <% } %>
                </div>
                
                <div class="review-content" id="content-<%=review.getRnum()%>">
                    <p style="margin: 0; line-height: 1.6; color: #555;"><%=review.getRcontent().replace("\n", "<br>")%></p>
                </div>
                
                <!-- 수정 폼 (기본적으로 숨김) -->
                <div class="review-edit-form" id="edit-form-<%=review.getRnum()%>" style="display: none; margin-top: 15px;">
                <textarea class="form-control" id="edit-content-<%=review.getRnum()%>" rows="3" style="margin-bottom: 10px;"><%=review.getRcontent()%></textarea>
                    <div style="text-align: right;">
                        <button type="button" class="btn btn-sm btn-secondary" onclick="cancelEdit(<%=review.getRnum()%>)">취소</button>
                        <button type="button" class="btn btn-sm btn-primary" onclick="saveEdit(<%=review.getRnum()%>)" style="margin-left: 5px;">저장</button>
                    </div>
                </div>
            </div>
        <% } %>
    <% } %>
    
    <!-- 페이징 -->
    <% if(pageCount > 1) { %>
        <div class="pagination-container" style="text-align: center; margin-top: 30px;">
            <div class="pagination" style="display: inline-block;">
                <% if(currentPage > 1) { %>
                    <a href="javascript:void(0)" onclick="loadReviewPage(<%=gnum%>, <%=currentPage-1%>)" style="display: inline-block; padding: 8px 12px; margin: 0 2px; text-decoration: none; border: 1px solid #ddd; color: #333;">이전</a>
                <% } %>
                
                <% for(int i = startPage; i <= endPage; i++) { %>
                    <% if(i == currentPage) { %>
                        <span style="display: inline-block; padding: 8px 12px; margin: 0 2px; background-color: #007bff; color: white; border: 1px solid #007bff;"><%=i%></span>
                    <% } else { %>
                        <a href="javascript:void(0)" onclick="loadReviewPage(<%=gnum%>, <%=i%>)" style="display: inline-block; padding: 8px 12px; margin: 0 2px; text-decoration: none; border: 1px solid #ddd; color: #333;"><%=i%></a>
                    <% } %>
                <% } %>
                
                <% if(currentPage < pageCount) { %>
                    <a href="javascript:void(0)" onclick="loadReviewPage(<%=gnum%>, <%=currentPage+1%>)" style="display: inline-block; padding: 8px 12px; margin: 0 2px; text-decoration: none; border: 1px solid #ddd; color: #333;">다음</a>
                <% } %>
            </div>
        </div>
    <% } %>
</div>

<script src="/shop/resources/js/reviewPagePro.js"></script>