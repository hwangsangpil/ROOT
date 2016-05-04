<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="board.model.AdminVO"%>
<%@ page import="board.model.AdminDao"%>
<%@ page import="util.StringUtil"%>
<%@ page import="util.HashUtil" %>
<%@ page import="util.Constant" %>
<%@page import="java.net.URLDecoder"%> 


<%
	request.setCharacterEncoding("UTF-8");
	String memberId = StringUtil.nchk(request.getParameter("id"),"");
	String memberPwd = StringUtil.nchk(request.getParameter("password"),"");
	String memberName = StringUtil.nchk(request.getParameter("name"),"");
	String memberPhone = StringUtil.nchk(request.getParameter("phone"),"");
	String memberEmail = StringUtil.nchk(request.getParameter("email"),"");
	String branchCode = URLDecoder.decode(StringUtil.nchk(request.getParameter("branchCode"), "000"),"UTF-8");
	int memberRole = Integer.parseInt(StringUtil.nchk(request.getParameter("role"),""));
	/* 
	System.out.println("memberId = "+ memberId);
	System.out.println("memberPwd = "+ memberPwd);
	System.out.println("memberName = "+ memberName);
	System.out.println("memberPhone = "+ memberPhone);
	System.out.println("memberEmail = "+ memberEmail);
	 */
	int result = 0;
	int optionResult =0;
	AdminDao dao = new AdminDao();
	
	result = dao.insertAdmin(memberId, HashUtil.encryptPassword(memberId,memberPwd), memberName, memberPhone, memberEmail, memberRole,branchCode);

	if(result > 0){ 
%>
		<script language=javascript>
			alert("등록되었습니다.");
			location.href = "/login.jsp";
		</script>
<%
	}else{
%>
		<script language=javascript>
			alert("등록 실패했습니다.\n이미존재하는 아이디입니다."); 
			location.href = "/login.jsp"; 
		</script>
<%
	}
%>

