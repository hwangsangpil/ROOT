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

int totalcnt = dao.cntTotalMember(searchKeyword);

ArrayList<ConstructionDTO> list = dao.selectConstructionList(searchKeyword, pageno);

dao.closeConn();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>공고조회</title>
<%@ include file="../include/inc_header.jsp"%>
<script type="text/javascript">
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
	function memberView(no){
		location.href = "member_view.jsp?no=" + no + "&pageno="+<%=pageno%>;
	}
</script>
</head>
<body>
	<div style="min-width: 350px">
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
						<div class="page-title">공고 관리</div>
					</div>
					<ol class="breadcrumb page-breadcrumb pull-right">
						<li><i class="fa fa-home"></i>&nbsp;<a href="../first/first.jsp">Home</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active"><a href="#">공사</a>&nbsp;&nbsp;<i
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
												<div class="panel-heading">공사 목록</div>
												<div class="mbl"></div>
												<div class="col-lg-8">&nbsp;</div>
												<div class="col-lg-4">
													<div class="input-group">
													<span class="input-group-addon">
													<i class="fa fa-search"></i></span>
													<input type="text" id="searchKeyword" name="searchKeyword" placeholder="이름/아이디/폰번호" class="form-control" value="<%=searchKeyword%>"/>
													<span class="input-group-btn"><button type="button" class="btn btn-default" onclick="javascript:fnc_search()">검색</button>
													</span></div>
												</div>
												<div class="col-lg-12">&nbsp;</div>
												<div class="col-lg-12">&nbsp;</div>
												<div class="panel-body" style="overflow: auto;">
													<table class="table table-hover">
														<thead>
															<tr>
																<th style="text-align:center; width: 5%">NO</th>
																<td style="text-align:center; width: 5%">공고명</td>
																<td style="text-align:center; width: 5%">계약방법</td>
																<td style="text-align:center; width: 5%">지역제한</td>
																<td style="text-align:center; width: 5%">예가변동폭</td>
																<td style="text-align:center; width: 5%">투찰하한율</td>
																<td style="text-align:center; width: 5%">개찰일</td>
																<td style="text-align:center; width: 5%">공고기관</td>
																<td style="text-align:center; width: 5%">사정률</td>
																<td style="text-align:center; width: 5%">입력날짜</td>
															</tr>
														</thead>
														<tbody>
															<%
															if (list.size() > 0) {
																for (int i=0; i<list.size(); i++) {
																	ConstructionDTO vo = list.get(i);
																	%>
																<tr onclick="javascript:memberView(<%=vo.getConstNum() %>);" style="cursor: pointer;">
																	<td style="text-align:center"><%=vo.getConstNum() %></td>
																	<td><%=vo.getConstName() %></td>
																	<td><%=vo.getConstWay()%></td>
																	<td><%=vo.getConstArea()%></td>
																	<td><%=vo.getConstPrice()%></td>
																	<td><%=vo.getConstLower()%></td>
																	<td><%=vo.getConstOpening()%></td>
																	<td><%=vo.getConstInstitution()%></td>
																	<td><%=vo.getConstPercent()%></td>
																	<td><%=vo.getCrtDate()%></td>
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
