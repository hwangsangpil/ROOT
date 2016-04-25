<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="board.model.ConstructionDTO"%>
<%@ page import="board.model.ConstructionDAO"%>
<%@ page import="util.StringUtil"%>
<%@page import="java.net.URLDecoder"%> 



<%
	request.setCharacterEncoding("UTF-8");
	
	int constructionNum = Integer.parseInt(StringUtil.nchk(request.getParameter("no"),"0"));
	int pageno = Integer.parseInt(StringUtil.nchk(request.getParameter("pageno"),"0"));
	int result = 0;
	//OtbMenuDao dao = new OtbMenuDao();
	ConstructionDAO dao = new ConstructionDAO();
	
	result = dao.deleteConstruction(constructionNum);
	if(result>0){
		
	}
		
	if(result > 0){ 
%>
		<script language=javascript>
			alert("삭제 되었습니다.");
			location.href = "/construction/constructionList.jsp";
		</script>
<%
	}else{
%>
		<script language=javascript>
			alert("삭제 실패했습니다."); 
			location.href = "/construction/constructionList.jsp"; 
		</script>
<%
	}
%>

