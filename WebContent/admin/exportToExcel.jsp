<%@ page contentType="application/vnd.ms-excel;charset=EUC-KR" %>

<%@page import="java.util.ArrayList"%>
<%@page import="board.model.AdminDAO"%>
<%@page import="board.model.AdminDTO"%>
<%@page import="util.StringUtil"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%
   //request.setCharacterEncoding("UTF-8");

   String filename = request.getParameter("title");
   response.setHeader("Content-Disposition", "attachment; filename="+filename+";");
   response.setHeader("Content-Description", "JSP Generated Data");
   
   
   //String title = request.getParameter("title");
   
   int pageno = Integer.parseInt(StringUtil.nchk(request.getParameter("pageno"), "1"));
   
   String[] checked=request.getParameterValues("check");
   String searchKeyword = URLDecoder.decode(StringUtil.nchk(request.getParameter("searchKeyword"),""),"UTF-8");
   
   AdminDAO dao = new AdminDAO();
   
   
   
   int totalcnt = dao.cntTotalAdmin(searchKeyword, checked);
   ArrayList<AdminDTO> list = dao.selectAdminListExcel(searchKeyword, pageno, totalcnt, checked);
   dao.closeConn();
   
%>



<h3>�������Ϻ�ȯ</h3>
<table border=1>
<thead>
<tr bgcolor="#CACACA">

<th style="text-align:center;">NO</th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������ �̸�<input type="checkbox"  
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���̵�<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�̸���<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����ȣ<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("5")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">������</th>
<th style="text-align:center;">������</th>
															
</tr>
<thead>
<tbody>
<%
if (list.size() > 0) {
	for (int i=0; i<list.size(); i++) {
		AdminDTO dto = list.get(i);
      %>

<tr>
<td style="text-align:center;"><%=dto.getSeqNo() %></td>
<td style="text-align:center;"><%=dto.getAdminName()%></td>
<td style="text-align:center;"><%=dto.getAdminId()%></td>
<td style="text-align:center;"><%=dto.getAdminEmail()%></td>
<td style="text-align:center;"><%=dto.getAdminPhone()%></td>
<td style="text-align:center;"><%=dto.getAdminRole()%></td>
<td style="text-align:center;"><%=dto.getCrtDate() %></td>
<td style="text-align:center;"><%=dto.getUdtDate() %></td>
</tr>
<%
   }
}
%>
</tbody>
</table>