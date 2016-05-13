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
	$("#sql").focus();
});

function checkForm() {
var sql = document.getElementById("sql").value;
	
	if($( "#sql" ).val() == -1){
		alert("내용을 입력해 주세요.");
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
						<li><i class="fa fa-home"></i>&nbsp;<a href="/home/home.jsp">Home</a>&nbsp;&nbsp;<i
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
	                                    <form action="/totalInsert/totalInsertOk.jsp" id="registForm" name="frm" method="post" enctype="multipart/form-data">
	                                    	<div class="form-body pal">
	                                    	
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-pencil"></i> <textarea style="height:400px" id="sql"
																name="sql" placeholder="INSERT INTO 테이블명(칼럼명, 칼럼명, 칼럼명, 칼럼명, 칼럼명)
&#10;VALUES('값','값', '값', '값', '값'
&#10;,('값','값', '값', '값', '값')
&#10;,('값','값', '값', '값', '값')
&#10;,('값','값', '값', '값', '값')
&#10;,('값','값', '값', '값', '값')
&#10;,('값','값', '값', '값', '값')
&#10;,('값','값', '값', '값', '값')
&#10;,('값','값', '값', '값', '값')
&#10;,('값','값', '값', '값', '값');"
																class="form-control" tabindex="1" ></textarea>
														</div>
													</div>
													
												
											</div>
												<div class="form-actions text-right pal">
												<button type="button" onclick="checkForm();" class="btn btn-primary" tabindex="2">등록</button>
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

