<%@ page contentType="text/plain; charset=UTF-8" %>
<%@ page import="shop.review.*" %>
<%@ page import="shop.member.*" %>

<%
    request.setCharacterEncoding("UTF-8");
    
    int rnum = Integer.parseInt(request.getParameter("rnum"));
    String content = request.getParameter("rcontent");
    String sid = (String) session.getAttribute("sid");

    if (sid != null && content != null && !content.trim().isEmpty()) {
        ReviewDAO dao = ReviewDAO.getInstance();
        MemberDAO mdao = new MemberDAO();
        
        // 현재 로그인한 회원의 정보 가져오기
        MemberDTO mdto = mdao.getMidname(sid);
        int currentMnum = mdto.getMnum();
        
        // 해당 리뷰 정보 가져오기
        ReviewDTO dto = dao.getReviewByRnum(rnum); 
        
        if (dto != null && currentMnum == dto.getMnum()) {
            // 본인의 리뷰인 경우에만 수정 허용
            dto.setRcontent(content);
            boolean result = dao.updateReview(dto);
            
            if(result) {
                out.print("OK");
            } else {
                out.print("UPDATE_FAILED");
            }
        } else {
            out.print("NO_AUTH");
        }
    } else {
        out.print("INVALID_PARAM");
    }
%>