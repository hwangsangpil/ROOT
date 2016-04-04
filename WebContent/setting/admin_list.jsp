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
int totalcnt = dao.cntTotalAdmin();

ArrayList<AdminVO> list = dao.selectAdminList(searchKeyword, pageno);
dao.closeConn();	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>관리자 관리</title>
<%@ include file="../include/inc_header.jsp"%>
<script type="text/javascript">
	function fnc_view(no, pageno){
		location.href = "admin_view.jsp?no=" + no + "&pageno=" + pageno;
	}
	
	function pageLink(arg) {
		document.frm.pageno.value = arg;
		document.frm.submit();
	}
	
	function fnc_search(){
		var searchKeyword = document.getElementById("searchKeyword").value;
		
		if( searchKeyword.length == 0 ) {
			alert("검색어를 입력해주세요.");
			document.getElementById("searchKeyword").focus();
			return;
		}
		 
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
						<input type="hidden" name="pageno" value="1">
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
													<div class="input-group"><span class="input-group-addon"><i class="fa fa-search"></i></span><input type="text" id="searchKeyword" name="searchKeyword" placeholder="이름/아이디/이메일/폰번호" class="form-control"/><span class="input-group-btn"><button type="button" class="btn btn-default" onclick="javascript:fnc_search()">검색</button></span></div>
												</div>
												<div class="col-lg-12">&nbsp;</div>
												<div class="col-lg-12">&nbsp;</div>
												<div class="panel-body">
													<table class="table table-hover">
														<thead>
															<tr>
																<th style="text-align:center">NO</th>
																<th>관리자 이름</th>
																<th>아이디</th>
																<th>이메일</th>
																<th>폰번호</th>
																<th>생성일</th>
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
																	<td><%=StringUtil.NVL(vo.getAdminName()) %></td>
																	<td><%=StringUtil.NVL(vo.getAdminId()) %></td>
																	<td><%=StringUtil.NVL(vo.getAdminEmail()) %></td>
																	<td><%=StringUtil.NVL(vo.getAdminPhone()) %></td>
																	<td><%=vo.getCrtDate() %></td>
																</tr>
																
																<%
																}
															} else {
																out.println("<tr><td align='center' colspan='6'>조회 결과가 없습니다.</td></tr>");
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
												<div class="text-right pal"><button type="button" class="btn btn-primary" onclick="javascript:fnc_add(<%=pageno%>)">관리자 추가</button></div>
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
