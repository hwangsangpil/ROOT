<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="board.model.AdminVO"%>
<%@ page import="board.model.AdminDao"%>
<%@ page import="util.StringUtil"%>
<%@ page import="util.HashUtil" %>
<%@page import="java.net.URLDecoder"%> 
<%
	request.setCharacterEncoding("UTF-8");
	
	int no = Integer.parseInt(StringUtil.nchk(request.getParameter("no"), "1"));
				
	AdminDao dao = new AdminDao();
	
	int result = 0;
	
	result = dao.deleteAdmin(no);
	dao.closeConn();
	if(result > 0){ 
%>
		<script language=javascript>
			alert("삭제 되었습니다.");
			location.href = "/setting/admin_list.jsp";
		</script>
<%
	}else{
%>
		<script language=javascript>
			alert("삭제 실패했습니다."); 
			location.href = "/setting/admin_list.jsp"; 
		</script>
<%
	}
%>

