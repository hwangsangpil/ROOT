<%@ page contentType="application/vnd.ms-excel;charset=UTF-8" %>

<%@page import="java.util.ArrayList"%>
<%@page import="dao.MemberDao"%>
<%@page import="vo.MemberVO"%>
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
   String startDate = StringUtil.nchk(request.getParameter("startDate"),"");
   String endDate = StringUtil.nchk(request.getParameter("endDate"),"");
   
   System.out.println("pageno = "+pageno);
   System.out.println("searchKeyword2 = "+searchKeyword); 
  
   System.out.println("startDate = "+startDate);
   System.out.println("endDate = "+endDate);
   
   MemberDao dao = new MemberDao();
   int totalcnt = dao.cntTotalMember(searchKeyword,startDate,endDate);
   ArrayList<MemberVO> list = dao.selectMemberListExcel(searchKeyword,startDate,endDate);
   dao.closeConn();
   
%>



<html>
<head>
<title>엑셀파일변환</title>
</head>
<body bgcolor=white>
<table border=1>
<tr bgcolor="#CACACA">
<th style="text-align:center;">No</th>
<th style="text-align:center;">아이디</th>
<th style="text-align:center;">이름</th>
<th style="text-align:center;">전화번호</th>
<th style="text-align:center;">회원등급</th>
<th style="text-align:center;">생년월일</th>
<th style="text-align:center;">성별</th>
<th style="text-align:center">생성일</th>
</tr>
<%
if (list.size() > 0) {
   for (int i=0; i<list.size(); i++) {
      MemberVO vo = list.get(i);
      %>   
<tr>
<td><%=vo.getSeqNo() %></td>
<td><%=StringUtil.NVL(vo.getMemberId()) %></td>
<td><%=StringUtil.NVL(vo.getMemberName()) %></td>
<td><%=StringUtil.NVL(vo.getMemberPhone()) %></td>
<td>
<%
 if(vo.getMemberGrade() == 1){
  out.print("OTB MEMBER");
 }else if(vo.getMemberGrade() == 2){
  out.print("OTB MASTER MEMBER");
 }
%>
</td>
<td><%=vo.getMemberBirth() %></td>
<td><%=vo.getMemberSex() %></td>
<td><%=vo.getCrtDate() %></td>
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