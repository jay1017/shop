<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="shop.review.*" %>
<%@ page import="shop.member.*" %>
<%
    String sid = (String) session.getAttribute("sid");
    int gnum = Integer.parseInt(request.getParameter("gnum"));
    int pageNum = Integer.parseInt(request.getParameter("pageNum"));
    int pageSize = 5;
    int startRow = (pageNum - 1) * pageSize + 1;
    int endRow = pageNum * pageSize;

    ReviewDAO dao = ReviewDAO.getInstance();
    List<ReviewDTO> list = dao.getReview(gnum, startRow, endRow);
    int totalCount = dao.reviewCount(gnum);
    int pageCount = (int) Math.ceil(totalCount / (double) pageSize);
    
    // 회원 정보 가져오기
    MemberDAO mdao = new MemberDAO();
    int currentMnum = 0;
    if(sid != null) {
        MemberDTO mdto = mdao.getMidname(sid);
        currentMnum = mdto.getMnum();
    }
%>

<% if(list.size() > 0) { %>
    <% for (ReviewDTO dto : list) { %>
        <div class="review-item" id="review-<%=dto.getRnum()%>" style="border-bottom: 1px solid #eee; padding: 15px 0;">
            <strong><%=dto.getMname()%> (@<%=dto.getMid()%>)</strong>
            <br>
            <div id="rcontent-<%=dto.getRnum()%>" style="margin:10px 0; line-height: 1.5;"><%=dto.getRcontent()%></div>

            <% if (sid != null && currentMnum == dto.getMnum()) { %>
                <div style="margin-top: 10px;">
                    <button onclick="enableEdit(<%=dto.getRnum()%>)" class="primary-btn" style="margin-right: 10px; padding: 5px 10px; font-size: 12px;">수정</button>
                    <button onclick="deleteReview(<%=dto.getRnum()%>, <%=dto.getGnum()%>)" class="primary-btn" style="padding: 5px 10px; font-size: 12px; background-color: #dc3545;">삭제</button>
                </div>
            <% } %>
        </div>
    <% } %>
<% } else { %>
    <div style="text-align: center; padding: 50px 0; color: #999;">
        <p>등록된 리뷰가 없습니다.</p>
    </div>
<% } %>

<% if(pageCount > 1) { %>
    <div class="review-pagination" style="text-align: center; margin-top: 30px;">
        <% for (int i = 1; i <= pageCount; i++) { %>
            <button onclick="loadReviewPage(<%= gnum %>, <%= i %>)" 
                    class="<%= i == pageNum ? "primary-btn" : "secondary-btn" %>" 
                    style="margin: 0 5px; padding: 8px 15px; border: none; cursor: pointer;">
                <%= i %>
            </button>
        <% } %>
    </div>
<% } %>

<script>
function enableEdit(rnum) {
    const contentDiv = document.getElementById("rcontent-" + rnum);
    const original = contentDiv.innerText;
    contentDiv.innerHTML = `
        <textarea id="editArea-${rnum}" rows="4" style="width: 100%; padding: 10px; border: 1px solid #ddd;">${original}</textarea>
        <div style="margin-top: 10px;">
            <button onclick="updateReview(${rnum})" class="primary-btn" style="margin-right: 10px; padding: 5px 10px; font-size: 12px;">저장</button>
            <button onclick="cancelEdit(${rnum}, '${original}')" class="secondary-btn" style="padding: 5px 10px; font-size: 12px;">취소</button>
        </div>
    `;
}

function cancelEdit(rnum, original) {
    const contentDiv = document.getElementById("rcontent-" + rnum);
    contentDiv.innerHTML = original;
}

function updateReview(rnum) {
    const content = document.getElementById("editArea-" + rnum).value;
    if(content.trim() === '') {
        alert('내용을 입력해주세요.');
        return;
    }
    
    const formData = new URLSearchParams();
    formData.append("rnum", rnum);
    formData.append("rcontent", content);

    fetch("/shop/review/reviewUpdatePro.jsp", {
        method: "POST",
        body: formData,
    })
    .then(response => response.text())
    .then(data => {
        if (data.trim() === "OK") {
            alert('리뷰가 수정되었습니다.');
            const gnum = <%= gnum %>;
            const pageNum = <%= pageNum %>;
            loadReviewPage(gnum, pageNum);
        } else {
            alert('리뷰 수정에 실패했습니다.');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('오류가 발생했습니다.');
    });
}

function deleteReview(rnum, gnum) {
    if (!confirm("정말 삭제하시겠습니까?")) return;

    fetch("/shop/review/reviewDelete.jsp?rnum=" + rnum + "&gnum=" + gnum, {
        method: "GET"
    })
    .then(response => response.text())
    .then(data => {
        if (data.trim() === "OK") {
            alert('리뷰가 삭제되었습니다.');
            const pageNum = <%= pageNum %>;
            loadReviewPage(gnum, pageNum);
        } else {
            alert('리뷰 삭제에 실패했습니다.');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('오류가 발생했습니다.');
    });
}
</script>