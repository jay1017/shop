<%@ page contentType="text/plain; charset=UTF-8" %>
<%@ page import="shop.review.*" %>
<%@ page import="shop.member.*" %>

<%
    int rnum = Integer.parseInt(request.getParameter("rnum"));
    int gnum = Integer.parseInt(request.getParameter("gnum"));
    String sid = (String) session.getAttribute("sid");

    if (sid != null) {
        ReviewDAO dao = ReviewDAO.getInstance();
        MemberDAO mdao = new MemberDAO();
        
        // 현재 로그인한 회원의 정보 가져오기
        MemberDTO mdto = mdao.getMidname(sid);
        int currentMnum = mdto.getMnum();
        
        // 해당 리뷰 정보 가져오기
        ReviewDTO dto = dao.getReviewByRnum(rnum); 
        
        if (dto != null && currentMnum == dto.getMnum()) {
            // 본인의 리뷰인 경우에만 삭제 허용
            boolean result = dao.reviewDelete(gnum, currentMnum, rnum);
            
            if(result) {
                out.print("OK");
            } else {
                out.print("DELETE_FAILED");
            }
        } else {
            out.print("NO_AUTH");
        }
    } else {
        out.print("NOT_LOGGED_IN");
    }
%>