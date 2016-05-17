<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="board.model.AdminDTO"%>
<%@ page import="board.model.AdminDAO"%>
<%@ page import="util.StringUtil"%>
<%@ page import="util.HashUtil" %>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	String adminName = URLDecoder.decode(StringUtil.nchk(request.getParameter("adminName"), ""),"UTF-8");
	String adminId = URLDecoder.decode(StringUtil.nchk(request.getParameter("adminId"), ""),"UTF-8");
	String adminPw = StringUtil.nchk(request.getParameter("adminPw"), "");
	String adminPhone = URLDecoder.decode(StringUtil.nchk(request.getParameter("adminPhone"), ""),"UTF-8");
	String adminEmail = URLDecoder.decode(StringUtil.nchk(request.getParameter("adminEmail"), ""),"UTF-8");
	//String branchCode = URLDecoder.decode(StringUtil.nchk(request.getParameter("branchCode"), "000"),"UTF-8");
	String adminRole = URLDecoder.decode(StringUtil.nchk(request.getParameter("adminRole"), "-1"),"UTF-8");

	int pageno = Integer.parseInt(StringUtil.nchk(request.getParameter("pageno"), "1"));
	String searchKeyword = URLDecoder.decode(StringUtil.nchk(request.getParameter("searchKeyword"),""),"UTF-8");
	String[] checked=request.getParameterValues("check");
	
	AdminDAO dao = new AdminDAO();
	AdminDTO dto = new AdminDTO();
	
	int result = 0;
	
	result = dao.insertAdmin(adminId, HashUtil.encryptPassword(adminId, adminPw), adminName, adminPhone, adminEmail, adminRole);
	dao.closeConn();
	if(result > 0){ 
%>
		<script language=javascript>
			alert("등록되었습니다.");
			location.href = "/admin/adminList.jsp?pageno="+<%=pageno%>
			<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){%>+"&check="+<%=checked[i]%><%}}}%>
			<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){%>+"&check="+<%=checked[i]%><%}}}%>
			<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){%>+"&check="+<%=checked[i]%><%}}}%>
			<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){%>+"&check="+<%=checked[i]%><%}}}%>
				+"&searchKeyword="+encodeURI(encodeURIComponent("<%=searchKeyword%>"));
		</script>
<%
	}else{
%>
		<script language=javascript>
			alert("등록 실패했습니다.\n이미존재하는 아이디입니다."); 
			location.href = "/admin/adminList.jsp"; 
		</script>
<%
	}
%>

