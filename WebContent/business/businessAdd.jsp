<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="util.StringUtil"%>
<%@page import="util.DateUtil"%>
<%@page import="util.Constant"%>
<%@page import="board.model.ConstructionDTO"%>
<%@page import="board.model.ConstructionDAO"%>
<%

request.setCharacterEncoding("UTF-8");
ConstructionDAO dao = new ConstructionDAO();
ArrayList<ConstructionDTO> list = new ArrayList<ConstructionDTO>();

list = dao.selectConstructionList();

%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>업체등록</title>
<%@ include file="/include/inc_header.jsp"%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#constNum").focus();
});

function checkForm() {
var busiName = document.getElementById("busiName").value;
	
	if($( "#constNum" ).val() == -1){
		alert("공고명 카테고리를 선택해 주세요.");
		return;
	}
	if( busiName.length == 0 ) {
		alert("업체명을 입력해주세요.");
		document.getElementById("busiName").focus();
		return;
	}
	registForm.submit();
}

function hitEnterKey(e){
	  if(e.keyCode == 13){
		  checkForm();
	  }else{
		  e.keyCode == 0;
	 	  return;
	  }
	} 

</script>
</head>
<body>
	<div>
		<!--BEGIN TOPBAR-->
		<%@ include file="/include/inc_top.jsp"%>
		<!--END TOPBAR-->
		<div id="wrapper">
			<!--BEGIN SIDEBAR MENU-->
			<%@ include file="/include/inc_left_menu.jsp"%>
			<!--END SIDEBAR MENU-->
			<div id="page-wrapper">
				<!--BEGIN TITLE & BREADCRUMB PAGE-->
				<div id="title-breadcrumb-option-demo" class="page-title-breadcrumb">
					<div class="page-header pull-left">
						<div class="page-title">업체등록</div>
					</div>
					<ol class="breadcrumb page-breadcrumb pull-right">
						<li><i class="fa fa-home"></i>&nbsp;<a href="/first/first.jsp">Home</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active"><a href="#">업체</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">업체등록</li>
					</ol>
					<div class="clearfix"></div>
				</div>
				<!--END TITLE & BREADCRUMB PAGE-->
				<!--BEGIN CONTENT-->
				<div class="page-content">
					<div id="tab-general">
						<div class="row mbl">
							<!-- 등록폼 -->
							<div class="col-lg-8">
								<div class="panel panel-green">
	                                <div class="panel-heading">업체등록</div>
	                                <div class="panel-body pan">
	                                    <form action="/business/businessAdd_ok.jsp" id="registForm" name="frm" method="post" enctype="multipart/form-data">
	                                    	<div class="form-body pal">
												<div class="form-group">
													<select name="constNum" id="constNum" class="form-control" tabindex="1" onKeypress="hitEnterKey(event)">
														<option value="-1">공고 선택</option>
														<%
															for(int i = 0; i<list.size(); i++){
																ConstructionDTO dto = new ConstructionDTO();
																dto = list.get(i);
															
														%>
														<option value="<%=dto.getConstNum()%>"><%=dto.getConstName() %></option>
														<%} %>
													</select>
												</div>
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-pencil"></i> <input id="busiName"
																name="busiName" type="text" placeholder="업체명"
																class="form-control" tabindex="2" onKeypress="hitEnterKey(event)"/>
														</div>
													</div>
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-calendar"></i> <input id="bisiOpening" name="bisiOpening"
															type="text" placeholder="개찰일" class="form-control" tabindex="3" onKeypress="hitEnterKey(event)"/>
														</div>
													</div>
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-percent"></i> <input id="busiPercent" name="busiPercent"
															type="text" placeholder="업체사정률" class="form-control" tabindex="4" onKeypress="hitEnterKey(event)"/>
														</div>
													</div>
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-bar-chart"></i> <input id="busiPrice" name="busiPrice"
															type="text" placeholder="예가변동폭" class="form-control" tabindex="5" onKeypress="hitEnterKey(event)"/>
														</div>
													</div>
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-balance-scale"></i> <input id="busiWay" name="busiWay"
															type="text" placeholder="계약방법" class="form-control" tabindex="6" onKeypress="hitEnterKey(event)"/>
														</div>
													</div>
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-map-marker"></i> <input id="busiArea" name="busiArea"
															type="text" placeholder="지역제한" class="form-control" tabindex="7" onKeypress="hitEnterKey(event)"/>
														</div>
													</div>
												
											</div>
												<div class="form-actions text-right pal">
												<button type="button" onclick="checkForm();" class="btn btn-primary">등록</button>
												</div>
												</form>
									</div>
									
	                            </div>	
	                        </div>
							<!-- 여기까지 등록 폼 -->	
						</div>
					</div>
				</div>
				
				<!--END CONTENT-->
				<!--BEGIN FOOTER-->
				<%@ include file="/include/inc_footer.jsp"%>
				<!--END FOOTER-->
			</div>
			<!--END PAGE WRAPPER-->
		</div>
	</div>
</body>
</html>

