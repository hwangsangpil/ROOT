<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="board.model.AdminVO"%>
<%@ page import="board.model.AdminDao"%>
<%@ page import="util.StringUtil"%>
<%@ page import="util.HashUtil" %>
<%@page import="java.net.URLDecoder"%> 
<%
	request.setCharacterEncoding("UTF-8");
	
	String adminName = URLDecoder.decode(StringUtil.nchk(request.getParameter("adminName"), ""),"UTF-8");
	String adminId = URLDecoder.decode(StringUtil.nchk(request.getParameter("adminId"), ""),"UTF-8");
	String adminPw = StringUtil.nchk(request.getParameter("adminPw"), "");
	String adminPhone = URLDecoder.decode(StringUtil.nchk(request.getParameter("adminPhone"), ""),"UTF-8");
	String adminEmail = URLDecoder.decode(StringUtil.nchk(request.getParameter("adminEmail"), ""),"UTF-8");
	String branchCode = URLDecoder.decode(StringUtil.nchk(request.getParameter("branchCode"), "000"),"UTF-8");
	int adminRole = Integer.parseInt(StringUtil.nchk(request.getParameter("adminRole"), "0"));
				
	AdminDao dao = new AdminDao();
	AdminVO vo = new AdminVO();
	
	int result = 0;
	
	result = dao.insertAdmin(adminId, HashUtil.encryptPassword(adminId, adminPw), adminName, adminPhone, adminEmail, adminRole, branchCode);
	dao.closeConn();
	if(result > 0){ 
%>
		<script language=javascript>
			alert("등록되었습니다.");
			location.href = "/setting/admin_list.jsp";
		</script>
<%
	}else{
%>
		<script language=javascript>
			alert("등록 실패했습니다."); 
			location.href = "/setting/admin_list.jsp"; 
		</script>
<%
	}
%>

