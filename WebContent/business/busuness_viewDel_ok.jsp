<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="board.model.BusinessDTO"%>
<%@ page import="board.model.BusinessDAO"%>
<%@ page import="util.StringUtil"%>
<%@page import="java.net.URLDecoder"%> 



<%
	request.setCharacterEncoding("UTF-8");
	
	int BusiNum = Integer.parseInt(StringUtil.nchk(request.getParameter("BusiNum"),"0"));
	int ConstNum = Integer.parseInt(StringUtil.nchk(request.getParameter("ConstNum"),"1"));
	int pageno = Integer.parseInt(StringUtil.nchk(request.getParameter("pageno"),"1"));
	int result = 0;
	//OtbMenuDao dao = new OtbMenuDao();
	BusinessDAO dao = new BusinessDAO();
	
	result = dao.deleteBusinessView(BusiNum);
	if(result>0){
		
	}
		
	if(result > 0){ 
%>
		<script language=javascript>
			alert("삭제 되었습니다.");
			location.href = "/business/business_view.jsp?ConstNum=" + <%=ConstNum%> + "&pageno="+<%=pageno%>;
		</script>
<%
	}else{
%>
		<script language=javascript>
			alert("삭제 실패했습니다."); 
			location.href = "/business/business_view.jsp"; 
		</script>
<%
	}
%>

