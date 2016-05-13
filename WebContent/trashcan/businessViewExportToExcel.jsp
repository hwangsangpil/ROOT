<%@ page contentType="application/vnd.ms-excel;charset=EUC-KR" %>

<%@page import="java.util.ArrayList"%>
<%@page import="board.model.BusinessDAO"%>
<%@page import="board.model.BusinessDTO"%>
<%@page import="util.StringUtil"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%
   //request.setCharacterEncoding("UTF-8");

   String filename = request.getParameter("title");
   response.setHeader("Content-Disposition", "attachment; filename="+filename+";");
   response.setHeader("Content-Description", "JSP Generated Data");
   
   
   //String title = request.getParameter("title");
   int ConstNum = Integer.parseInt(StringUtil.nchk(request.getParameter("ConstNum"), "1"));
   int pageno = Integer.parseInt(StringUtil.nchk(request.getParameter("pageno"), "1"));
  
   
   String[] checked=request.getParameterValues("check");
   
   
   
   String searchKeyword = URLDecoder.decode(StringUtil.nchk(request.getParameter("searchKeyword"),""),"UTF-8");
   
   System.out.println("excel constnum = "+ConstNum);
   System.out.println("excel pageno = "+pageno);
   System.out.println("excel searchKeyword = "+searchKeyword);
   if(checked != null){
		for(int i=0; i<checked.length;i++){
		System.out.println("excel checked["+i+"]:    "+checked[i]);
		}
	}
    
   BusinessDAO dao = new BusinessDAO();
   
   
   
   int totalcnt = dao.cntTotalMember(searchKeyword, checked);
   ArrayList<BusinessDTO> list = dao.selectBusinessListViewExcel(ConstNum,  pageno, searchKeyword, totalcnt, checked);
   dao.closeConn();
   
%>



<h3>�������Ϻ�ȯ</h3>
<table border=1>
<thead>
<tr bgcolor="#CACACA">

<th style="text-align:center;">NO</th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�����<input type="checkbox"  
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��ü��<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����������<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("5")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�����<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("6")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��������<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("7")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">�Է³�¥</th>
<th style="text-align:center;">������¥</th>
															
</tr>
<thead>
<tbody>
<%
if (list.size() > 0) {
	for (int i=0; i<list.size(); i++) {
		BusinessDTO dto = list.get(i);
      %>

<tr>
<td style="text-align:center;"><%=dto.getBusiNum()%></td>
<td style="text-align:center;"><%=dto.getConstName()%></td>
<td style="text-align:center;"><%=dto.getBusiName()%></td>
<td style="text-align:center;"><%=dto.getBusiOpening()%></td>
<td style="text-align:center;"><%=dto.getBusiPrice()%></td>
<td style="text-align:center;"><%=dto.getBusiPercent()%></td>
<td style="text-align:center;"><%=dto.getBusiWay()%></td>
<td style="text-align:center;"><%=dto.getBusiArea()%></td>
<td style="text-align:center;"><%=dto.getCrtDate()%></td>
<td style="text-align:center;"><%=dto.getUdtDate()%></td>
</tr>
<%
   }
}
%>
</tbody>
</table>