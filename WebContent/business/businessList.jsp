<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="board.model.BusinessDTO"%>
<%@page import="board.model.BusinessDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="util.StringUtil"%>
<%@page import="util.DateUtil"%>
<%
request.setCharacterEncoding("UTF-8");

int pageno = Integer.parseInt(StringUtil.nchk(request.getParameter("pageno"), "1"));
String searchKeyword = StringUtil.nchk(request.getParameter("searchKeyword"),"");

BusinessDAO dao = new BusinessDAO();

int totalcnt = dao.cntTotalMember(searchKeyword);

ArrayList<BusinessDTO> list = dao.selectBusinessList(searchKeyword, pageno);

dao.closeConn();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>업체관리</title>
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
	
	function businessDel(no){
		if (confirm("정말 삭제하시겠습니까??") == true){    //확인
			location.href = "busuness_del_ok.jsp?no=" + no + "&pageno="+<%=pageno%>;
		}else{
			return;
		}
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
						<div class="page-title">업체관리</div>
					</div>
					<ol class="breadcrumb page-breadcrumb pull-right">
						<li><i class="fa fa-home"></i>&nbsp;<a href="/first/first.jsp">Home</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active"><a href="#">업체</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">업체관리</li>
					</ol>
					<div class="clearfix"></div>
				</div>
				<!--END TITLE & BREADCRUMB PAGE-->
				<!--BEGIN CONTENT-->
				<div class="page-content">
					<form name="frm" action="/business/businessList.jsp" method="post">
						<input type="hidden" name="pageno" value="<%=pageno%>">
						<div id="tab-general">
							<div class="row mbl">
								<div class="col-lg-12">
									<div class="row">
										<div class="col-lg-12">
											<div class="panel panel-yellow">
												<div class="panel-heading">업체관리</div>
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
												<div class="panel-body" style="overflow:auto;">
													<table class="table table-hover">
														<thead>
															<tr>
																<th style="text-align:center; width: 5%">NO</th>
																<td style="text-align:center; width: 5%">업체명</td>
																<td style="text-align:center; width: 5%">개찰일</td>
																<td style="text-align:center; width: 5%">예가변동폭</td>
																<td style="text-align:center; width: 5%">사정률</td>
																<td style="text-align:center; width: 5%">계약방법</td>
																<td style="text-align:center; width: 5%">지역제한</td>
																<td style="text-align:center; width: 5%">입력날짜</td>
																<td style="text-align:center; width: 5%">수정</td>
																<td style="text-align:center; width: 5%">삭제</td>
															</tr>
														</thead>
														<tbody>
															<%
															if (list.size() > 0) {
																for (int i=0; i<list.size(); i++) {
																	BusinessDTO vo = list.get(i);
																	%>
																<tr onclick="javascript:memberView(<%=vo.getBusiNum()%>);" style="cursor: pointer;">
																	<td style="text-align:center"><%=vo.getBusiNum()%></td>
																	<td><%=vo.getBusiName()%></td>
																	<td><%=vo.getBusiOpening()%></td>
																	<td><%=vo.getBusiPrice()%></td>
																	<td><%=vo.getBusiPercent()%></td>
																	<td><%=vo.getBusiWay()%></td>
																	<td><%=vo.getBusiArea()%></td>
																	<td><%=vo.getCrtDate()%></td>
																	<td onclick="event.cancelBubble = true;"><button type="button" class="btn btn-primary" onclick="">수정</button></td>
																	<td onclick="event.cancelBubble = true;"><button type="button" class="btn btn-primary" onclick="businessDel(<%=vo.getBusiNum()%>)">삭제</button></td>
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
