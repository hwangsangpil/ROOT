<%@ page contentType="application/vnd.ms-excel;charset=UTF-8" %>

<%@page import="java.util.ArrayList"%>
<%@page import="board.model.ConstructionDAO"%>
<%@page import="board.model.ConstructionDTO"%>
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
   String searchKeyword = URLDecoder.decode(StringUtil.nchk(request.getParameter("searchKeyword"),""),"UTF-8");
   
   
   System.out.println("pageno = "+pageno);
   System.out.println("searchKeyword2 = "+searchKeyword); 
  
   
   ConstructionDAO dao = new ConstructionDAO();
   String[] checked=request.getParameterValues("check");
   int totalcnt = dao.cntTotalMember(searchKeyword, checked);
   ArrayList<ConstructionDTO> list = dao.selectMemberListExcel(searchKeyword);
   dao.closeConn();
   
%>



<html>
<head>
<title>엑셀파일변환</title>
</head>
<body bgcolor=white>
<table border=1>
<tr bgcolor="#CACACA">
<th style="text-align:center; width: 5%">NO</th>
<th style="text-align:center; width: 5%">공고명<input type="checkbox" id="check" name="check" value="1" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){ %>checked<%}}}%> /></th>
<th style="text-align:center; width: 5%">계약방법<input type="checkbox" id="check" name="check" value="2"
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){ %>checked<%}}}%>/></th>
<th style="text-align:center; width: 5%">지역제한<input type="checkbox" id="check" name="check" value="3"
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){ %>checked<%}}}%>/></th>
<th style="text-align:center; width: 5%">예가변동폭<input type="checkbox" id="check" name="check" value="4"
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){ %>checked<%}}}%>/></th>
<th style="text-align:center; width: 5%">투찰하한율<input type="checkbox" id="check" name="check" value="5"
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("5")){ %>checked<%}}}%>/></th>
<th style="text-align:center; width: 5%">개찰일<input type="checkbox" id="check" name="check" value="6"
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("6")){ %>checked<%}}}%>/></th>
<th style="text-align:center; width: 5%">공고기관<input type="checkbox" id="check" name="check" value="7"
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("7")){ %>checked<%}}}%>/></th>
<th style="text-align:center; width: 5%">사정률<input type="checkbox" id="check" name="check" value="8"
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("8")){ %>checked<%}}}%>/></th>
<th style="text-align:center; width: 5%">입력날짜</tH>
<th style="text-align:center; width: 5%">수정날짜</th>
</tr>
<%
if (list.size() > 0) {
   for (int i=0; i<list.size(); i++) {
      ConstructionDTO vo = list.get(i);
      %>   
<tr>
<td><%=vo.getConstNum() %></td>
<td><%=vo.getConstName() %></td>
<td><%=vo.getConstWay() %></td>
<td><%=vo.getConstArea() %></td>
<td><%=vo.getConstPrice()%></td>
<td><%=vo.getConstLower()%></td>
<td><%=vo.getConstOpening()%></td>
<td><%=vo.getConstInstitution()%></td>
<td><%=vo.getConstPercent()%></td>
<td><%=vo.getCrtDate()%></td>
<td><%=vo.getUdtDate()%></td>
</tr>
<%
   }
}else{
   out.println("<tr><td align='center' colspan='9'>조회 결과가 없습니다.</td></tr>");
}
%>
</table>
</body>
</html>