<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="board.model.ConstructionDTO"%>
<%@ page import="board.model.ConstructionDAO"%>
<%@ page import="board.model.BusinessDTO"%>
<%@ page import="board.model.BusinessDAO"%>
<%@ page import="util.StringUtil"%>
<%@ page import="util.HashUtil" %>
<%@ page import="util.Constant" %>
<%@page import="java.io.*"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.awt.Image"%>
<%@page import="com.sun.jimi.core.Jimi"%>
<%@page import="com.sun.jimi.core.JimiUtils"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%
	request.setCharacterEncoding("UTF-8");

	String busiName = StringUtil.nchk(request.getParameter("busiName"),"");
	String busiOpening = StringUtil.nchk(request.getParameter("bisiOpening"),"");
	String busiPrice = StringUtil.nchk(request.getParameter("busiPrice"),"");
	String busiPercent = StringUtil.nchk(request.getParameter("busiPercent"),"");
	String busiWay = StringUtil.nchk(request.getParameter("busiWay"),"");
	String busiArea = StringUtil.nchk(request.getParameter("busiArea"),"");
	
	int BusiNum = Integer.parseInt(StringUtil.nchk(request.getParameter("BusiNum"), "1"));
	int pageno = Integer.parseInt(StringUtil.nchk(request.getParameter("pageno"), "1"));
	
	String[] checked=request.getParameterValues("check");
	String searchKeyword = URLDecoder.decode(StringUtil.nchk(request.getParameter("searchKeyword"),""),"UTF-8");
	
	BusinessDAO dao = new BusinessDAO();
	BusinessDTO dto = new BusinessDTO();
		
	int result = 0;
		
	result = dao.updateBusiness(BusiNum, busiName, busiOpening, busiPrice, busiPercent, busiWay, busiArea);
		
	dao.closeConn();
	
	if(result > 0){ 
%>
		<script language=javascript>
			alert("수정 되었습니다.");
			location.href = "/business/businessList.jsp?pageno="+<%=pageno%>
			<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){%>+"&check="+<%=checked[i]%><%}}}%>
			<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){%>+"&check="+<%=checked[i]%><%}}}%>
			<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){%>+"&check="+<%=checked[i]%><%}}}%>
			<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){%>+"&check="+<%=checked[i]%><%}}}%>
			<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("5")){%>+"&check="+<%=checked[i]%><%}}}%>
			<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("6")){%>+"&check="+<%=checked[i]%><%}}}%>
			<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("7")){%>+"&check="+<%=checked[i]%><%}}}%>
					+"&searchKeyword="+encodeURI(encodeURIComponent("<%=searchKeyword%>"));
					</script>
<%
	}else{	
%>		
		<script language=javascript>
			alert("수정에 실패하였습니다.\n이미 해당 공사에 참여한 업체명 입니다."); 
			location.href = "//business/businessList.jsp"; 
		</script>
<%
	}
%>

