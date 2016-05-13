<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="board.model.AdminDTO"%>
<%@ page import="board.model.AdminDAO"%>
<%@ page import="util.StringUtil"%>
<%@ page import="util.CookieBox"%>
<%@ page import="util.HashUtil" %>
<%@ page import="java.util.*" %>

<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");
//out.println(id,password);
	AdminDAO dao = new board.model.AdminDAO();
	AdminDTO dto = new board.model.AdminDTO();

	dto = dao.loginAdmin(id, HashUtil.encryptPassword(id,password));
	
	String memseq = String.valueOf(dto.getSeqNo());
	dao.closeConn();
	if( dto.getSeqNo() == 0) {
%>
	<script language="javascript">
		alert("아이디와 비밀번호를 확인후 다시 로그인해주세요.");
		history.back();
	</script>	
<%	
	}else{
		response.addCookie(CookieBox.createCookie("LOGIN", "SUCCESS", "/", -1));
		response.addCookie(CookieBox.createCookie("ID", id, "/", -1));
		response.addCookie(CookieBox.createCookie("MEM_SEQ", memseq, "/", -1));
		response.addCookie(CookieBox.createCookie("ROLE", Integer.toString(dto.getAdminRole()), "/", -1));
		
		response.sendRedirect("/home/home.jsp");
	}
%>

