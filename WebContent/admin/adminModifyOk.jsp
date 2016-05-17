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
	String adminEmail = URLDecoder.decode(StringUtil.nchk(request.getParameter("adminEmail"), ""),"UTF-8");
	String adminPhone = URLDecoder.decode(StringUtil.nchk(request.getParameter("adminPhone"), ""),"UTF-8");
	String adminRole = URLDecoder.decode(StringUtil.nchk(request.getParameter("adminRole"), "-1"),"UTF-8");
	int no = Integer.parseInt(StringUtil.nchk(request.getParameter("no"), "1"));

	int pageno = Integer.parseInt(StringUtil.nchk(request.getParameter("pageno"), "1"));
	String searchKeyword = URLDecoder.decode(StringUtil.nchk(request.getParameter("searchKeyword"),""),"UTF-8");
	String[] checked=request.getParameterValues("check");
	
	AdminDAO dao = new board.model.AdminDAO();
	AdminDTO dto = new board.model.AdminDTO();
	
	int result = 0;
	if(adminPw.equals("")|| adminPw == null){
		result = dao.updateAdmin(adminId, adminName, adminEmail, adminPhone, adminRole, no);
	}else{
		result = dao.updateAdmin(adminId, HashUtil.encryptPassword(adminId, adminPw), adminName, adminEmail, adminPhone, adminRole, no);
	}
	
	dao.closeConn();
	if(result > 0){ 
%>
		<script language=javascript>
			alert("수정 되었습니다.");
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
			alert("수정 실패했습니다.\n이미 존재하는 아이디입니다"); 
			location.href = "/admin/adminList.jsp"; 
		</script>
<%
	}
%>

