<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.util.ArrayList"%>
<%@page import="board.model.AdminDao"%>
<%@page import="board.model.AdminVO"%>
<%@page import="util.StringUtil"%>
<%@page import="util.DateUtil"%>
<%
request.setCharacterEncoding("UTF-8");

int pageno = Integer.parseInt(StringUtil.nchk(request.getParameter("pageno"), "1"));
String searchKeyword = StringUtil.nchk(request.getParameter("searchKeyword"),"");

AdminDao dao = new AdminDao();
 
 String[] checked=request.getParameterValues("check");
int totalcnt = dao.cntTotalAdmin(searchKeyword, checked);

ArrayList<AdminVO> list = dao.selectAdminList(searchKeyword, pageno, totalcnt, checked);
dao.closeConn();	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>관리자 관리</title>
<%@ include file="../include/inc_header.jsp"%>
<script type="text/javascript">
function down(){
	location.href = "exportToExcel.jsp?title=adminList.xlsx&pageno="+<%=pageno%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){%>+"&checked="+encodeURI(encodeURIComponent("<%=checked[i]%>"))<%}}}%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){%>+"&checked="+encodeURI(encodeURIComponent("<%=checked[i]%>"))<%}}}%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){%>+"&checked="+encodeURI(encodeURIComponent("<%=checked[i]%>"))<%}}}%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){%>+"&checked="+encodeURI(encodeURIComponent("<%=checked[i]%>"))<%}}}%>
			+"&searchKeyword="+encodeURI(encodeURIComponent("<%=searchKeyword%>"));
}

	function fnc_view(no, pageno){
		location.href = "admin_view.jsp?no=" + no + "&pageno=" + pageno;
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
	
	function fnc_add(arg){
		location.href = "/setting/admin_add.jsp?pageno=" + arg;
	}
</script>
</head>
<body>
	<div>
		<!--BEGIN TOPBAR-->
		<%@ include file="../include/inc_top.jsp"%>
		<!--END TOPBAR-->
		<div id="wrapper">
			<!--BEGIN SIDEBAR MENU-->
			<jsp:include page="../include/inc_left_menu.jsp">
			<jsp:param value="setting" name="menuId"/>
			</jsp:include>
			<!--END SIDEBAR MENU-->
			<div id="page-wrapper">
				<!--BEGIN TITLE & BREADCRUMB PAGE-->
				<div id="title-breadcrumb-option-demo" class="page-title-breadcrumb">
					<div class="page-header pull-left">
						<div class="page-title">관리자 관리</div>
					</div>
					<ol class="breadcrumb page-breadcrumb pull-right">
						<li><i class="fa fa-home"></i>&nbsp;<a href="/first/first.jsp">Home</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active"><a href="#">설정</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">관리자 관리</li>
					</ol>
					<div class="clearfix"></div>
				</div>
				<!--END TITLE & BREADCRUMB PAGE-->
				<!--BEGIN CONTENT-->
				<div class="page-content">
					<form name="frm" action="/setting/admin_list.jsp" method="post">
						<input type="hidden" name="pageno" value="<%=pageno%>">
						<div id="tab-general">
							<div class="row mbl">
								<div class="col-lg-12">
									<div class="row">
										<div class="col-lg-12">
											<div class="panel panel-yellow">
												<div class="panel-heading">관리자 목록</div>
												<div class="mbl"></div>
												<div class="col-lg-8">&nbsp;</div>
												<div class="col-lg-4">
													<div class="input-group">
													<span class="input-group-addon">
													<i class="fa fa-search"></i></span>
													<input type="text" id="searchKeyword" name="searchKeyword" placeholder="이름/아이디/이메일/폰번호" class="form-control" value="<%=searchKeyword%>"/>
													<span class="input-group-btn"><button type="button" class="btn btn-default" onclick="javascript:fnc_search()">검색</button></span></div>
												</div>
												<div class="col-lg-12">&nbsp;</div>
												<div class="col-lg-12">&nbsp;</div>
												<div class="panel-body">
													<table class="table table-hover">
														<thead>
															<tr>
																<th style="text-align:center">NO</th>
																<th>관리자 이름<input type="checkbox" id="check" name="check" value="1" 
																<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){ %>checked<%}}}%> /></th>
																<th>아이디<input type="checkbox" id="check" name="check" value="2" 
																<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){ %>checked<%}}}%> /></th>
																<th>이메일<input type="checkbox" id="check" name="check" value="3" 
																<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){ %>checked<%}}}%> /></th>
																<th>폰번호<input type="checkbox" id="check" name="check" value="4" 
																<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){ %>checked<%}}}%> /></th>
																<th>생성일</th>
																<th>수정일</th>
															</tr>
														</thead>
														<tbody>
															<%
															if (list.size() > 0) {
																for (int i=0; i<list.size(); i++) {
																	AdminVO vo = list.get(i);
																	if(vo.getAdminId().equals("admin")){
																		continue;
																	}
																	%>
																<tr style="cursor: pointer;" onclick="javascript:fnc_view('<%=vo.getSeqNo()%>','<%=pageno%>')">
																	<td style="text-align:center"><%=vo.getSeqNo() %></td>
																	<td><%=vo.getAdminName() %></td>
																	<td><%=vo.getAdminId()%></td>
																	<td><%=vo.getAdminEmail()%></td>
																	<td><%=vo.getAdminPhone()%></td>
																	<td><%=vo.getCrtDate()%></td>
																	<td><%=vo.getUdtDate()%></td>
																</tr>
																
																<%
																}
															} else {
																out.println("<tr><td align='center' colspan='7'>조회 결과가 없습니다.</td></tr>");
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
												<div class="text-right pal">
												<button type="button" class="btn btn-primary" onclick="javascript:fnc_add(<%=pageno%>)">관리자 추가</button>
												<button type="button" class="btn btn-primary" onclick="javascript:down()">엑셀 다운로드</button>
												</div>
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
