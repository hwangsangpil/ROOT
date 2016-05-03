<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="board.model.ConstructionDTO"%>
<%@page import="board.model.ConstructionDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="util.StringUtil"%>
<%@page import="util.DateUtil"%>
<%
request.setCharacterEncoding("UTF-8");

int pageno = Integer.parseInt(StringUtil.nchk(request.getParameter("pageno"), "1"));
String searchKeyword = StringUtil.nchk(request.getParameter("searchKeyword"),"");

ConstructionDAO dao = new ConstructionDAO();

String[] checked=request.getParameterValues("check");

int totalcnt = dao.cntTotalMember(searchKeyword, checked);

ArrayList<ConstructionDTO> list = dao.selectConstructionList(searchKeyword, pageno, totalcnt, checked);
dao.closeConn();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>공고관리</title>
<%@ include file="../include/inc_header.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	$("#searchKeyword").focus();
});

	function down(){
    
    	location.href = "exportToExcel.jsp?title=constructionList.xls&pageno="+<%=pageno%>
    	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){%>+"&checked="+<%=checked[i]%><%}}}%>
    	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){%>+"&checked="+<%=checked[i]%><%}}}%>
    	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){%>+"&checked="+<%=checked[i]%><%}}}%>
    	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){%>+"&checked="+<%=checked[i]%><%}}}%>
    	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("5")){%>+"&checked="+<%=checked[i]%><%}}}%>
    	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("6")){%>+"&checked="+<%=checked[i]%><%}}}%>
    	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("7")){%>+"&checked="+<%=checked[i]%><%}}}%>
    	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("8")){%>+"&checked="+<%=checked[i]%><%}}}%>
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
		} */
		document.frm.submit();
	}
	
	function businessView(ConstNum){
		location.href = "../business/business_view.jsp?ConstNum=" + ConstNum;
	}
	
	function constructionDel(ConstNum){
		if (confirm("정말 삭제하시겠습니까??") == true){    //확인
			location.href = "construction_del_ok.jsp?ConstNum=" + ConstNum + "&pageno="+<%=pageno%>;
		}else{
			return;
		}
	}
	
	function constructionMod(ConstNum){
		if (confirm("정말 수정하시겠습니까??") == true){    //확인
			location.href = "constructionMod.jsp?ConstNum=" + ConstNum + "&pageno="+<%=pageno%>;
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
						<div class="page-title">공고관리</div>
					</div>
					<ol class="breadcrumb page-breadcrumb pull-right">
						<li><i class="fa fa-home"></i>&nbsp;<a href="/first/first.jsp">Home</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active"><a href="#">공고</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">공고관리</li>
					</ol>
					<div class="clearfix"></div>
				</div>
				<!--END TITLE & BREADCRUMB PAGE-->
				<!--BEGIN CONTENT-->
				<div class="page-content">
					<form name="frm" action="/construction/constructionList.jsp" method="post">
						<input type="hidden" name="pageno" value="<%=pageno%>">
						
						<div id="tab-general">
							<div class="row mbl">
								<div class="col-lg-12">
									<div class="row">
										<div class="col-lg-12">
											<div class="panel panel-yellow">
												<div class="panel-heading">공고목록</div>
												<div class="mbl"></div>
												<div class="col-lg-8">&nbsp;</div>
												<div class="col-lg-4">
													<div class="input-group">
													<span class="input-group-addon">
													<i class="fa fa-search"></i></span>
													<input type="text" id="searchKeyword" name="searchKeyword" placeholder="검색어를 입력하세요" class="form-control" value="<%=searchKeyword%>"/>
													<span class="input-group-btn"><button type="button" class="btn btn-default" onclick="javascript:fnc_search()">검색</button>
													</span></div>
												</div>
												<div class="col-lg-12">&nbsp;</div>
												<div class="col-lg-12">&nbsp;</div>
												<div class="panel-body" style="overflow: auto;">
													<table class="table table-hover">
														<thead>
															<tr>
																<td style="text-align:center; width: 50px;">NO</td>
																<td style="text-align:center; width: 200px;">공고명<input type="checkbox" id="check" name="check" value="1" 
																<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){ %>checked<%}}}%>/></td>
																<td style="text-align:center; width: 150px;">계약방법<input type="checkbox" id="check" name="check" value="2"
																<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){ %>checked<%}}}%>/></td>
																<td style="text-align:center; width: 150px;">지역제한<input type="checkbox" id="check" name="check" value="3"
																<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){ %>checked<%}}}%>/></td>
																<td style="text-align:center; width: 150px;">예가변동폭<input type="checkbox" id="check" name="check" value="4"
																<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){ %>checked<%}}}%>/></td>
																<td style="text-align:center; width: 150px;">투찰하한율<input type="checkbox" id="check" name="check" value="5"
																<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("5")){ %>checked<%}}}%>/></td>
																<td style="text-align:center; width: 150px;">개찰일<input type="checkbox" id="check" name="check" value="6"
																<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("6")){ %>checked<%}}}%>/></td>
																<td style="text-align:center; width: 150px;">공고기관<input type="checkbox" id="check" name="check" value="7"
																<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("7")){ %>checked<%}}}%>/></td>
																<td style="text-align:center; width: 150px;">사정률<input type="checkbox" id="check" name="check" value="8"
																<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("8")){ %>checked<%}}}%>/></td>
																<td style="text-align:center; width: 100px;">입력날짜</td>
																<td style="text-align:center; width: 100px;">수정날짜</td>
																<td style="text-align:center;">수정</td>
																<td style="text-align:center;">삭제</td>
															</tr>
														</thead>
														<tbody>
															<%
															if (list.size() > 0) {
																for (int i=0; i<list.size(); i++) {
																	ConstructionDTO vo = list.get(i);
																	%>
																<tr onclick="javascript:businessView(<%=vo.getConstNum() %>);" style="cursor: pointer;">
																	<td style="text-align:center;"><%=vo.getConstNum() %></td>
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
																	<td onclick="event.cancelBubble = true;"><button type="button" class="btn btn-primary" onclick="constructionMod(<%=vo.getConstNum()%>)">수정</button></td>
																	<td onclick="event.cancelBubble = true;"><button type="button" class="btn btn-primary" onclick="constructionDel(<%=vo.getConstNum()%>)">삭제</button></td>
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
