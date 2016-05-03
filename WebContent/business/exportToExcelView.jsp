<%@ page contentType="application/vnd.ms-excel;charset=UTF-8" %>

<%@page import="java.util.ArrayList"%>
<%@page import="board.model.BusinessDAO"%>
<%@page import="board.model.BusinessDTO"%>
<%@page import="util.StringUtil"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%
   request.setCharacterEncoding("UTF-8");

   String file_name = request.getParameter("title");
   response.setHeader("Content-Disposition", "attachment; filename="+file_name+";");
   response.setHeader("Content-Description", "JSP Generated Data");
   
   
   String title = request.getParameter("title");
   int ConstNum = Integer.parseInt(StringUtil.nchk(request.getParameter("ConstNum"), "1"));
   int pageno = Integer.parseInt(StringUtil.nchk(request.getParameter("pageno"), "1"));
  
   
   String[] checked=request.getParameterValues("checked");
   
   
   
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



<html>
<head>
<title>엑셀파일변환</title>
</head>
<body bgcolor=white>
<table border=1>
<tr bgcolor="#CACACA">

<th style="text-align:center;">NO</th>
<th style="text-align:center;">공고명<input type="checkbox"  
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">업체명<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">개찰일<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">예가변동폭<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">사정률<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("5")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">계약방법<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("6")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">지역제한<input type="checkbox" 
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("7")){ %>checked="checked"<%}}}%>></th>
<th style="text-align:center;">입력날짜</th>
<th style="text-align:center;">수정날짜</th>
															
</tr>
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
<%
if (list.size() > 0) {
	for (int i=0; i<list.size(); i++) {
		BusinessDTO vo = list.get(i);
      %>

<tr>
<td><%=vo.getBusiNum()%></td>
<td><%=vo.getConstName()%></td>
<td><%=vo.getBusiName()%></td>
<td><%=vo.getBusiOpening()%></td>
<td><%=vo.getBusiPrice()%></td>
<td><%=vo.getBusiPercent()%></td>
<td><%=vo.getBusiWay()%></td>
<td><%=vo.getBusiArea()%></td>
<td><%=vo.getCrtDate()%></td>
<td><%=vo.getUdtDate()%></td>
</tr>
<%
   }
}else{
   System.out.println("<tr><td align='center' colspan='9'>조회 결과가 없습니다.</td></tr>");
}
%>
</table>
</body>
</html>