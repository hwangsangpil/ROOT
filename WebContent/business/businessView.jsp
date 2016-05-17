<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.util.ArrayList"%>
<%@page import="board.model.BusinessDTO"%>
<%@page import="board.model.BusinessDAO"%>
<%@page import="util.StringUtil"%>
<%@page import="util.DateUtil"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%
request.setCharacterEncoding("UTF-8");

int ConstNum = Integer.parseInt(StringUtil.nchk(request.getParameter("ConstNum"), "1"));
int pageno = Integer.parseInt(StringUtil.nchk(request.getParameter("pageno"), "1"));

BusinessDAO dao = new BusinessDAO();

String[] checked=request.getParameterValues("check");
String searchKeyword = URLDecoder.decode(StringUtil.nchk(request.getParameter("searchKeyword"),""),"UTF-8");

int totalcnt = dao.viewCntTotalMember(searchKeyword, ConstNum, checked);

ArrayList<BusinessDTO> list = dao.businessView(ConstNum, pageno, searchKeyword, totalcnt, checked);
dao.closeConn();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>참여 업체관리</title>
<%@ include file="../include/inc_header.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	$("#searchKeyword").focus();
});

function down(){
	location.href = "exportToExcelView.jsp?title=businessViewList.xls&pageno="+<%=pageno%>+"&ConstNum="+<%=ConstNum%>
    	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){%>+"&check="+<%=checked[i]%><%}}}%>
    	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){%>+"&check="+<%=checked[i]%><%}}}%>
    	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){%>+"&check="+<%=checked[i]%><%}}}%>
    	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){%>+"&check="+<%=checked[i]%><%}}}%>
    	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("5")){%>+"&check="+<%=checked[i]%><%}}}%>
    	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("6")){%>+"&check="+<%=checked[i]%><%}}}%>
    	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("7")){%>+"&check="+<%=checked[i]%><%}}}%>
			+"&searchKeyword="+encodeURI(encodeURIComponent("<%=searchKeyword%>"));
}

function pageLink(arg) {
	document.frm.pageno.value = arg;
	document.frm.submit();
}

function fnc_search(){
	var searchKeyword = document.getElementById("searchKeyword").value;
	
	/* if( searchKeyword.length == 0 ) {
		alert("검색어를 입력해주세요.");
		document.getElementById("searchKeyword").focus();
		return;
	}
	  */
	document.frm.submit();
}

function businessDel(BusiNum){
	if (confirm("정말 삭제하시겠습니까??") == true){    //확인
		location.href = "busunessViewDelOk.jsp?BusiNum=" + BusiNum + "&pageno="+<%=pageno%>+"&ConstNum="+<%=ConstNum%>
		<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){%>+"&check="+<%=checked[i]%><%}}}%>
		<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){%>+"&check="+<%=checked[i]%><%}}}%>
		<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){%>+"&check="+<%=checked[i]%><%}}}%>
		<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){%>+"&check="+<%=checked[i]%><%}}}%>
		<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("5")){%>+"&check="+<%=checked[i]%><%}}}%>
		<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("6")){%>+"&check="+<%=checked[i]%><%}}}%>
		<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("7")){%>+"&check="+<%=checked[i]%><%}}}%>
				+"&searchKeyword="+encodeURI(encodeURIComponent("<%=searchKeyword%>"));
	}else{
		return;
	}
}

function businessMod(BusiNum){
	if (confirm("정말 수정하시겠습니까??") == true){    //확인
		location.href = "businessViewMod.jsp?BusiNum=" + BusiNum + "&pageno="+<%=pageno%>+"&ConstNum="+<%=ConstNum%>
		<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){%>+"&check="+<%=checked[i]%><%}}}%>
		<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){%>+"&check="+<%=checked[i]%><%}}}%>
		<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){%>+"&check="+<%=checked[i]%><%}}}%>
		<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){%>+"&check="+<%=checked[i]%><%}}}%>
		<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("5")){%>+"&check="+<%=checked[i]%><%}}}%>
		<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("6")){%>+"&check="+<%=checked[i]%><%}}}%>
		<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("7")){%>+"&check="+<%=checked[i]%><%}}}%>
				+"&searchKeyword="+encodeURI(encodeURIComponent("<%=searchKeyword%>"));
	}else{
		return;
	}
}



</script>
</head>
<body>
	<div style="min-width: 300px">
		<!--BEGIN TOPBAR-->
		<%@ include file="../include/inc_top.jsp"%>
		<!--END TOPBAR-->
		<div id="wrapper">
			<!--BEGIN SIDEBAR MENU-->
			<%@ include file="../include/inc_left_menu.jsp"%>
			<!--END SIDEBAR MENU-->
			<div id="page-wrapper">
				<!--BEGIN TITLE & BREADCRUMB PAGE-->
				<div id="title-breadcrumb-option-demo" class="page-title-breadcrumb">
					<div class="page-header pull-left">
						<div class="page-title">참여 업체관리</div>
					</div>
					<ol class="breadcrumb page-breadcrumb pull-right">
						<li><i class="fa fa-home"></i>&nbsp;<a href="/home/home.jsp">Home</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active"><a href="#">업체</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">참여 업체관리</li>
					</ol>
					<div class="clearfix"></div>
				</div>
				<!--END TITLE & BREADCRUMB PAGE-->
				<!--BEGIN CONTENT-->
				<div class="page-content">
					<form name="frm" action="/business/businessView.jsp"+<%=pageno%>; method="post">
						<input type="hidden" name="ConstNum" value="<%=ConstNum%>">
						<input type="hidden" name="pageno" value="<%=pageno%>">
						<div id="tab-general">
							<div class="row mbl">
								<div class="col-lg-12">
									<div class="row">
										<div class="col-lg-12">
											<div class="panel panel-yellow">
												<div class="panel-heading">참여 업체목록</div>
												<div class="mbl"></div>
												<div class="col-lg-8">&nbsp;</div>
												<div class="col-lg-4">
													<div class="input-group">
													<span class="input-group-addon">
													<i class="fa fa-search"></i></span>
													<input type="text" id="searchKeyword" name="searchKeyword" tabindex="1" placeholder="검색어를 입력하세요" class="form-control" value="<%=searchKeyword%>" />
													<span class="input-group-btn"><button type="button" class="btn btn-default" onclick="javascript:fnc_search()">검색</button>
													</span></div>
												</div>
												<div class="col-lg-12">&nbsp;</div>
												<div class="col-lg-12">&nbsp;</div>
												<div class="panel-body" style="overflow:auto;">
													<table class="table table-hover">
														<thead>
															<tr>
																<th style="text-align:center; width: 50px;">NO</th>
																<th style="text-align:center; width: 200px;">공고명<input type="checkbox" id="check" name="check" value="1" 
																<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){ %>checked<%}}}%> /></th>
																<th style="text-align:center; width: 200px;">업체명<input type="checkbox" id="check" name="check" value="2" 
																<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){ %>checked<%}}}%> /></th>
																<th style="text-align:center; width: 150px;">개찰일<input type="checkbox" id="check" name="check" value="3" 
																<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){ %>checked<%}}}%> /></th>
																<th style="text-align:center; width: 200px;">사정률<input type="checkbox" id="check" name="check" value="5" 
																<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("5")){ %>checked<%}}}%> /></th>
																<th style="text-align:center; width: 200px;">예가변동폭<input type="checkbox" id="check" name="check" value="4" 
																<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){ %>checked<%}}}%> /></th>
																<th style="text-align:center; width: 150px;">계약방법<input type="checkbox" id="check" name="check" value="6" 
																<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("6")){ %>checked<%}}}%> /></th>
																<th style="text-align:center; width: 150px;">지역제한<input type="checkbox" id="check" name="check" value="7" 
																<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("7")){ %>checked<%}}}%> /></th>
																<th style="text-align:center; width: 100px;">입력날짜</th>
																<th style="text-align:center; width: 100px;">수정날짜</th>
																<th style="text-align:center;">수정</th>
																<th style="text-align:center;">삭제</th>													
																</tr>
														</thead>
														<tbody>
															<%
															if (list.size() > 0) {
																for (int i=0; i<list.size(); i++) {
																	BusinessDTO dto = list.get(i);
																	%>
																<tr style="cursor: pointer;">
																	<td style="text-align:center;"><%=dto.getBusiNum()%></td>
																	<td style="text-align:center;"><%=dto.getConstName()%></td>
																	<td style="text-align:center;"><%=dto.getBusiName()%></td>
																	<td style="text-align:center;"><%=dto.getBusiOpening()%></td>
																	<td style="text-align:center;"><%=dto.getBusiPercent()%></td>
																	<td style="text-align:center;"><%=dto.getBusiPrice()%></td>
																	<td style="text-align:center;"><%=dto.getBusiWay()%></td>
																	<td style="text-align:center;"><%=dto.getBusiArea()%></td>
																	<td style="text-align:center;"><%=dto.getCrtDate()%></td>
																	<td style="text-align:center;"><%=dto.getUdtDate()%></td>
																	<td onclick="event.cancelBubble = true;"><button type="button" class="btn btn-primary" <%if("전체관리자".equals(role)){%>onclick="businessMod(<%=dto.getBusiNum()%>)"<%}else{%>onclick="alert('<%=role%>는 권한이없습니다')"<%}%>>수정</button></td>
																	<td onclick="event.cancelBubble = true;"><button type="button" class="btn btn-primary" <%if("전체관리자".equals(role)){%>onclick="businessDel(<%=dto.getBusiNum()%>)"<%}else{%>onclick="alert('<%=role%>는 권한이없습니다')"<%}%>>삭제</button></td>
																</tr>
																
																<%
																}
															}else{
																out.println("<tr><td align='center' colspan='9'>조회 결과가 없습니다.</td></tr>");
															}
															%>
														</tbody>
													</table>
												</div>
												<jsp:include page="../include/inc_paging.jsp">
													<jsp:param name="totalRecord" value="<%=totalcnt%>"/>
													<jsp:param name="pageNo" value="<%=pageno%>"/>
													<jsp:param name="rowCount" value="10"/> 
													<jsp:param name="pageGroup" value="10"/>
												</jsp:include>
												<div class="text-right pal"><button type="button" class="btn btn-primary" onclick="javascript:down()">엑셀 다운로드</button></div>
											</div>
										</div>
									</div>
	
	
								</div>
	
							</div>
						</div>
					</form>
				</div>
				<!--END CONTENT-->
				<!--BEGIN FOOTER-->
				<%@ include file="../include/inc_footer.jsp"%>
				<!--END FOOTER-->
			</div>
			<!--END PAGE WRAPPER-->
		</div>
	</div>
</body>
</html>
