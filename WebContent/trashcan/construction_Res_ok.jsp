<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="board.model.ConstructionDTO"%>
<%@ page import="board.model.ConstructionDAO"%>
<%@ page import="board.model.BusinessDAO"%>
<%@ page import="util.StringUtil"%>
<%@page import="java.net.URLDecoder"%> 
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	int ConstNum = Integer.parseInt(StringUtil.nchk(request.getParameter("ConstNum"),"0"));
	int pageno = Integer.parseInt(StringUtil.nchk(request.getParameter("pageno"),"0"));
	String searchKeyword = URLDecoder.decode(StringUtil.nchk(request.getParameter("searchKeyword"),""),"UTF-8");
	String[] checked=request.getParameterValues("check");
	
	int result = 0;
	int viewcnt = 0;
	int viewResult = 0;
	BusinessDAO busiDAO = new BusinessDAO();
	
	//OtbMenuDao dao = new OtbMenuDao();
	ConstructionDAO dao = new ConstructionDAO();
	result = dao.restoreConstruction(ConstNum);
	
	if(result > 0){ 
%>
		<script language=javascript>
			alert("복구 되었습니다.");
			location.href = "/trashcan/constructionDelList.jsp?pageno="+<%=pageno%>
			<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){%>+"&check="+<%=checked[i]%><%}}}%>
			<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){%>+"&check="+<%=checked[i]%><%}}}%>
			<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){%>+"&check="+<%=checked[i]%><%}}}%>
			<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){%>+"&check="+<%=checked[i]%><%}}}%>
			<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("5")){%>+"&check="+<%=checked[i]%><%}}}%>
			<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("6")){%>+"&check="+<%=checked[i]%><%}}}%>
			<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("7")){%>+"&check="+<%=checked[i]%><%}}}%>
			<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("8")){%>+"&check="+<%=checked[i]%><%}}}%>
					+"&searchKeyword="+encodeURI(encodeURIComponent("<%=searchKeyword%>"));                                                   
		</script>
<%
	}else{
%>
		<script language=javascript>
			alert("복구 실패했습니다."); 
			location.href = "/trashcan/constructionDelList.jsp"; 
		</script>
<%
	}
%>

