<%@ page contentType="application/vnd.ms-excel;charset=EUC-KR" %>

<%@page import="java.util.ArrayList"%>
<%@page import="board.model.ConstructionDAO"%>
<%@page import="board.model.ConstructionDTO"%>
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
  
   
   String[] checked=request.getParameterValues("checked");
   
   
   
   String searchKeyword = URLDecoder.decode(StringUtil.nchk(request.getParameter("searchKeyword"),""),"UTF-8");
   
   /* 
   System.out.println("excel pageno = "+pageno);
   System.out.println("excel searchKeyword = "+searchKeyword);
   if(checked != null){
		for(int i=0; i<checked.length;i++){
		System.out.println("excel checked["+i+"]:    "+checked[i]);
		}
	}
    */
   ConstructionDAO dao = new ConstructionDAO();
   
   
   
   int totalcnt = dao.cntTotalMember(searchKeyword, checked);
   ArrayList<ConstructionDTO> list = dao.selectConstructionListExcel(searchKeyword, pageno, totalcnt, checked);
   dao.closeConn();
   
%>



<h3>�������Ϻ�ȯ</h3>
<table border=1>
<thead>
<tr bgcolor="#CACACA">

<th style="text-align:center;">NO</th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�����<input type="checkbox"  
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�����<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��������<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����������<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����������<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("5")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("6")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("7")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("8")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">�Է³�¥</th>
<th style="text-align:center;">������¥</th>
															
</tr>
<thead>
<tbody>
<%
if (list.size() > 0) {
   for (int i=0; i<list.size(); i++) {
      ConstructionDTO vo = list.get(i);
      %>

<tr>
<td style="text-align:center;"><%=vo.getConstNum()%></td>
<td style="text-align:center;"><%=vo.getConstName()%></td>
<td style="text-align:center;"><%=vo.getConstWay()%></td>
<td style="text-align:center;"><%=vo.getConstArea()%></td>
<td style="text-align:center;"><%=vo.getConstPrice()%></td>
<td style="text-align:center;"><%=vo.getConstLower()%></td>
<td style="text-align:center;"><%=vo.getConstOpening()%></td>
<td style="text-align:center;"><%=vo.getConstInstitution()%></td>
<td style="text-align:center;"><%=vo.getConstPercent()%></td>
<td style="text-align:center;"><%=vo.getCrtDate()%></td>
<td style="text-align:center;"><%=vo.getUdtDate()%></td>
</tr>
<%
   }
}
%>
</tbody>
</table>
