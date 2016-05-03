<%@ page contentType="application/vnd.ms-excel;charset=EUC-KR" %>
<%@page import="util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>

<%@page import="java.util.ArrayList"%>
<%@page import="board.model.BusinessDAO"%>
<%@page import="board.model.BusinessDTO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%
   //request.setCharacterEncoding("UTF-8");		post����϶�

   String filename = request.getParameter("title");
   response.setHeader("Content-Disposition", "attachment; filename="+filename+";");
   response.setHeader("Content-Description", "JSP Generated Data");
   
   /* 
   String title = request.getParameter("title");
    */
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
   
   BusinessDAO dao = new BusinessDAO();
   
   int totalcnt = dao.cntTotalMember(searchKeyword, checked);
   ArrayList<BusinessDTO> list = dao.selectBusinessListExcel(searchKeyword, pageno, totalcnt, checked);
   dao.closeConn();
   
%>


<h3>�������Ϻ�ȯ</h3>
<table border=1>
<thead>
<tr bgcolor="#CACACA">

<th style="text-align:center;">NO</th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�����<input type="checkbox"  
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){ %>checked="checked"<%}}}%>/></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��ü��<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){ %>checked="checked"<%}}}%>/></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){ %>checked="checked"<%}}}%>/></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����������<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){ %>checked="checked"<%}}}%>/></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("5")){ %>checked="checked"<%}}}%>/></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�����<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("6")){ %>checked="checked"<%}}}%>/></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��������<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("7")){ %>checked="checked"<%}}}%>/></th>
<th style="text-align:center;">�Է³�¥</th>
<th style="text-align:center;">������¥</th>
															
</tr>
<thead>
<%/*
<tr><td align='center' colspan='10'>��ȸ ���</td></tr>
<tr>
<td>null</td>
<td>null</td>
<td>null</td>
<td>null</td>
<td>null</td>
<td>null</td>
<td>null</td>
<td>null</td>
<td>null</td>
<td>null</td>
</tr>
*/%>

<tbody>
<%
if (list.size() > 0) {
	for (int i=0; i<list.size(); i++) {
		BusinessDTO vo = list.get(i);
%>

<tr>
<td style="text-align:center;"><%=vo.getBusiNum()%></td>
<td style="text-align:center;"><%=vo.getConstName()%></td>
<td style="text-align:center;"><%=vo.getBusiName()%></td>
<td style="text-align:center;"><%=vo.getBusiOpening()%></td>
<td style="text-align:center;"><%=vo.getBusiPrice()%></td>
<td style="text-align:center;"><%=vo.getBusiPercent()%></td>
<td style="text-align:center;"><%=vo.getBusiWay()%></td>
<td style="text-align:center;"><%=vo.getBusiArea()%></td>
<td style="text-align:center;"><%=vo.getCrtDate()%></td>
<td style="text-align:center;"><%=vo.getUdtDate()%></td>
</tr>
<%
   }
}
%>
</tbody>
</table>
