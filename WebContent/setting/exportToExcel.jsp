<%@ page contentType="application/vnd.ms-excel;charset=UTF-8" %>

<%@page import="java.util.ArrayList"%>
<%@page import="board.model.AdminDao"%>
<%@page import="board.model.AdminVO"%>
<%@page import="util.StringUtil"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%
   request.setCharacterEncoding("UTF-8");

   String file_name = request.getParameter("title");
   response.setHeader("Content-Disposition", "attachment; filename="+file_name+";");
   response.setHeader("Content-Description", "JSP Generated Data");
   
   
   String title = request.getParameter("title");
   
   int pageno = Integer.parseInt(StringUtil.nchk(request.getParameter("pageno"), "1"));
  
   
   String[] checked=request.getParameterValues("checked");
   
   
   
   String searchKeyword = URLDecoder.decode(StringUtil.nchk(request.getParameter("searchKeyword"),""),"UTF-8");
   
   
   System.out.println("excel pageno = "+pageno);
   System.out.println("excel searchKeyword = "+searchKeyword);
   if(checked != null){
		for(int i=0; i<checked.length;i++){
		System.out.println("excel checked["+i+"]:    "+checked[i]);
		}
	}
   
   AdminDao dao = new AdminDao();
   
   
   
   int totalcnt = dao.cntTotalAdmin(searchKeyword, checked);
   ArrayList<AdminVO> list = dao.selectAdminListExcel(searchKeyword, pageno, totalcnt, checked);
   dao.closeConn();
   
%>



<html>
<head>
<title>엑셀파일변환</title>
</head>
<body bgcolor=white>
<table border=1>
<tr bgcolor="#CACACA">

<th style="text-align:center;">NO</th>
<th style="text-align:center;">관리자 이름<input type="checkbox"  
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">아이디<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">이메일<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">폰번호<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">생성일</th>
<th style="text-align:center;">수정일</th>
															
</tr>
<tr>
<td>null</td>
<td>null</td>
<td>null</td>
<td>null</td>
<td>null</td>
<td>null</td>
<td>null</td>
</tr>
<%
if (list.size() > 0) {
	for (int i=0; i<list.size(); i++) {
		AdminVO vo = list.get(i);
      %>

<tr>
<td><%=vo.getSeqNo() %></td>
<td><%=vo.getAdminName()%></td>
<td><%=vo.getAdminId()%></td>
<td><%=vo.getAdminEmail()%></td>
<td><%=vo.getAdminPhone()%></td>
<td><%=vo.getCrtDate() %></td>
<td><%=vo.getUdtDate() %></td>
</tr>
<%
   }
}else{
   System.out.println("<tr><td align='center' colspan='7'>조회 결과가 없습니다.</td></tr>");
}
%>
</table>
</body>
</html>