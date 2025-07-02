<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="mdto" class="shop.member.MemberDTO" />
<jsp:setProperty property="*" name="mdto" />
<jsp:useBean id="mdao" class="shop.member.MemberDAO" />

<%
	String id = request.getParameter("mid");
	String phone = request.getParameter("mphone");
	if(id.equals(mdao.getId(id))){%> <%-- 가입된 아이디가 있을때 --%>
		<script>
			alert("이미 가입된 아이디가 있습니다");
			history.go(-1);
		</script>
	<%}else if(phone.equals(mdao.getPhone(phone))){%> <%--가입된 전화번호가 있을때 --%>
		<script>
			alert("이미 가입한 번호가 있습니다 확인해주세요.");
			window.location = "/shop/member/loginForm.jsp";
		</script>
	<%}else{%>
		<%
			mdao.InputMember(mdto); //memberform에서 받은 값을 db에 저장
		%>		
			<script>
				alert("가입하셨습니다.");
				window.location="/shop/member/loginForm.jsp";
			</script>
	<%} %>




