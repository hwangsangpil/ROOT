<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="board.model.ConstructionDTO"%>
<%@ page import="board.model.ConstructionDAO"%>
<%@ page import="util.StringUtil"%>
<%@ page import="util.HashUtil" %>
<%@ page import="util.Constant" %>
<%@page import="java.net.URLDecoder"%> 

<%@page import="java.io.*"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.awt.Image"%>
<%@page import="com.sun.jimi.core.Jimi"%>
<%@page import="com.sun.jimi.core.JimiUtils"%>

<%
	request.setCharacterEncoding("UTF-8");
	String constName = StringUtil.nchk(request.getParameter("constName"),"");
	String constWay = StringUtil.nchk(request.getParameter("constWay"),"");
	String constArea = StringUtil.nchk(request.getParameter("constArea"),"");
	String constPrice = StringUtil.nchk(request.getParameter("constPrice"),"");
	String constLower = StringUtil.nchk(request.getParameter("constLower"),"");
	String constOpening = StringUtil.nchk(request.getParameter("constOpening"),"");
	String constInstitution = StringUtil.nchk(request.getParameter("constInstitution"),"");
	String constPercent = StringUtil.nchk(request.getParameter("constPercent"),"");
	
	int ConstNum = Integer.parseInt(StringUtil.nchk(request.getParameter("ConstNum"), "1"));
	int pageno = Integer.parseInt(StringUtil.nchk(request.getParameter("pageno"), "1"));
	System.out.println("Mod ConstNum:   "+ConstNum);
	System.out.println("Mod pageno:   "+pageno);	
	ConstructionDAO dao = new ConstructionDAO();
	ConstructionDTO dto = new ConstructionDTO();
		
	int result = 0;
		
	result = dao.updateConstruction(ConstNum, constWay, constArea, constPrice, constLower, constOpening, constInstitution, constPercent);
		
	dao.closeConn();
	
	if(result > 0){ 
%>
		<script language=javascript>
			alert("수정 되었습니다.");
			location.href = "/construction/constructionList.jsp?pageno="+<%=pageno%>;
		</script>
<%
	}else{	
%>		
		<script language=javascript>
			alert("수정에 실패하였습니다.\n이미 존재하는 공고명 입니다."); 
			location.href = "/construction/constructionList.jsp"; 
		</script>
<%
	}
%>

