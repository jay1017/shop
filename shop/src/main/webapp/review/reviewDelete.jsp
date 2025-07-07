<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ page import="shop.review.*"%>
<%@ page import="shop.member.*"%>

<%
request.setCharacterEncoding("UTF-8");

int rnum = Integer.parseInt(request.getParameter("rnum"));
int gnum = Integer.parseInt(request.getParameter("gnum"));
String sid = (String) session.getAttribute("sid");

if (sid != null) {
    ReviewDAO dao = ReviewDAO.getInstance();
    MemberDAO mdao = new MemberDAO();

    // 로그인한 회원 정보
    MemberDTO mdto = mdao.getMidname(sid);
    int currentMnum = mdto.getMnum();

    // 삭제 대상 리뷰 정보
    ReviewDTO dto = dao.getReviewByRnum(rnum);

    if (dto != null && currentMnum == dto.getMnum()) {
        boolean result = dao.reviewDelete(gnum, currentMnum, rnum);

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
%>