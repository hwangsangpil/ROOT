<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="board.model.AdminDTO"%>
<%@ page import="board.model.AdminDAO"%>
<%@ page import="util.StringUtil"%>
<%@ page import="util.HashUtil" %>
<%@ page import="util.Constant" %>
<%@page import="java.net.URLDecoder"%> 


<%
	request.setCharacterEncoding("UTF-8");
	String memberId = URLDecoder.decode(StringUtil.nchk(request.getParameter("id"), ""),"UTF-8");
	String memberPwd = URLDecoder.decode(StringUtil.nchk(request.getParameter("password"), ""),"UTF-8");
	String memberName = URLDecoder.decode(StringUtil.nchk(request.getParameter("name"), ""),"UTF-8");
	String memberPhone = URLDecoder.decode(StringUtil.nchk(request.getParameter("phone"), ""),"UTF-8");
	String memberEmail = URLDecoder.decode(StringUtil.nchk(request.getParameter("email"), ""),"UTF-8");
	//String branchCode = URLDecoder.decode(StringUtil.nchk(request.getParameter("branchCode"), "000"),"UTF-8");
	String memberRole = URLDecoder.decode(StringUtil.nchk(request.getParameter("role"), "-1"),"UTF-8");
	/* 
	System.out.println("memberId = "+ memberId);
	System.out.println("memberPwd = "+ memberPwd);
	System.out.println("memberName = "+ memberName);
	System.out.println("memberPhone = "+ memberPhone);
	System.out.println("memberEmail = "+ memberEmail);
	 */
	int result = 0;
	int optionResult =0;
	AdminDAO dao = new AdminDAO();
	
	result = dao.insertAdmin(memberId, HashUtil.encryptPassword(memberId,memberPwd), memberName, memberPhone, memberEmail, memberRole);

	if(result > 0){ 
%>
		<script language=javascript>
			alert("등록되었습니다.");
			location.href = "/index.jsp";
		</script>
<%
	}else{
%>
		<script language=javascript>
			alert("등록 실패했습니다.\n이미존재하는 아이디입니다."); 
			location.href = "/index.jsp"; 
		</script>
<%
	}
%>

