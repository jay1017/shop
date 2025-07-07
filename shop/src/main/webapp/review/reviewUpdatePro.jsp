<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page import="shop.review.*"%>
<%@ page import="shop.member.*"%>

<%
request.setCharacterEncoding("UTF-8");

try {
    String rnumStr = request.getParameter("rnum");
    String rcontent = request.getParameter("rcontent");
    String sid = (String) session.getAttribute("sid");
    
    // 파라미터 검증
    if (rnumStr == null || rnumStr.trim().isEmpty()) {
        out.print("INVALID_PARAMETER");
        return;
    }
    
    if (rcontent == null || rcontent.trim().isEmpty()) {
        out.print("EMPTY_CONTENT");
        return;
    }
    
    int rnum = Integer.parseInt(rnumStr);
    
    if (sid != null) {
        ReviewDAO dao = ReviewDAO.getInstance();
        MemberDAO mdao = new MemberDAO();

        // 로그인한 회원 정보
        MemberDTO mdto = mdao.getMidname(sid);
        int currentMnum = mdto.getMnum();

        // 수정 대상 리뷰 정보
        ReviewDTO dto = dao.getReviewByRnum(rnum);

        if (dto != null && currentMnum == dto.getMnum()) {
            // 리뷰 수정 실행
            boolean result = dao.reviewUpdate(rnum, rcontent);  

            if (result) {
                out.print("OK");
            } else {
                out.print("FAIL");
            }
        } else {
            out.print("NO_PERMISSION");
        }
    } else {
        out.print("NOT_LOGGED_IN"); 
    }
} catch (NumberFormatException e) {
    out.print("INVALID_NUMBER");
} catch (Exception e) {
    out.print("ERROR: " + e.getMessage());
}
%>