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
<title>공고등록</title>
<%@ include file="/include/inc_header.jsp"%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#constName").focus();
});
var count = 1;
var addCount;
var addedFormDiv;
$(function() {
	// 요소 삭제
	 $(document).on("click", "#remove", function() {
	  $(this).parent().parent().parent().remove();
	 });
	});
function addInputBoxa(arg1, arg2, arg3){
	/* var content = document.frm.otbOptionMenuName.value;
	 var price = document.frm.otbOptionMenuPrice.value;
	 var code = document.frm.optionMenuCode.value; */
	  var addedFormDiv = document.getElementById("addedFormDiv");
     
     var str = "";
     /* str+="<div class='row'><div class='col-md-6'><div class='form-group'><div class='input-icon right'><i class='fa fa-tag'></i> <input id='otbOptionMenuNamea'name='otbOptionMenuNamea' type='text' value='"+arg1+"' placeholder='옵션명'class='form-control' /></div></div></div><div class='col-md-6'><div class='form-group'><div class='input-icon right'><i class='fa fa-tag'></i> <input id='otbOptionMenuPricea'name='otbOptionMenuPricea' value='"+arg3+"' type='text' placeholder='옵션가격(숫자만 입력)' class='form-control' /></div></div></div><div class='col-md-6'><div class='form-group'><input id='otbOptionMenuCode'name='otbOptionMenuCode' type='hidden' value='"+arg2+"' placeholder='코드'/></div></div></div>"; */
     str+="<div class='row' id='addRorw' name='addRow'><div class='col-md-4'><div class='form-group'><div class='input-icon right'><i class='fa fa-tag'></i> <input id='otbOptionMenuNamea'name='otbOptionMenuNamea' type='text' value='"+arg1+"' placeholder='옵션명'class='form-control' /></div></div></div><div class='col-md-4'><div class='form-group'><div class='input-icon right'><i class='fa fa-tag'></i> <input id='otbOptionMenuPricea'name='otbOptionMenuPricea' value='"+arg3+"' type='text' placeholder='옵션가격(숫자만 입력)' class='form-control' /></div></div></div><div class='col-md-4'><div class='form-group'><button href='#' id='remove' name='remove' class='btn btn-primary'>삭제</button></div></div><div class='col-md-6'><div class='form-group'><input id='otbOptionMenuCode'name='otbOptionMenuCode' type='hidden' value='"+arg2+"' placeholder='코드'/></div></div></div>";

     // 추가할 폼(에 들어갈 HTML)
    
     var addedDiv = document.createElement("div"); // 폼 생성
     addedDiv.id = "added"; // 폼 Div에 ID 부여 (삭제를 위해)
     addedDiv.innerHTML  = str; // 폼 Div안에 HTML삽입
     addedFormDiv.appendChild(addedDiv); // 삽입할 DIV에 생성한 폼 삽입
	
document.frm.otbOptionMenuName.value ="";
document.frm.otbOptionMenuPrice.value="";
document.frm.optionMenuCode.value="0";
}

//행추가
function addInputBox() {
	var content = document.frm.otbOptionMenuName.value;
	 var price = document.frm.otbOptionMenuPrice.value;
	 var code = "0";
	  var addedFormDiv = document.getElementById("addedFormDiv");
      
      var str = "";
     /*  str+="<a href='#' class='remove'>삭제</a><div class='row'><div class='col-md-6'><div class='form-group'><div class='input-icon right'><i class='fa fa-tag'></i> <input id='otbOptionMenuNamea'name='otbOptionMenuNamea' type='text' value='"+content+"' placeholder='옵션명'class='form-control' /></div></div></div><div class='col-md-6'><div class='form-group'><div class='input-icon right'><i class='fa fa-tag'></i> <input id='otbOptionMenuPricea'name='otbOptionMenuPricea' value='"+price+"' type='text' placeholder='옵션가격(숫자만 입력)' class='form-control' /></div></div></div><div class='col-md-6'><div class='form-group'><input id='otbOptionMenuCode'name='otbOptionMenuCode' type='hidden' value='"+code+"' placeholder='코드'/></div></div></div>"; */
	str+="<div class='row' id='addRorw' name='addRow'><div class='col-md-4'><div class='form-group'><div class='input-icon right'><i class='fa fa-tag'></i> <input id='otbOptionMenuNamea'name='otbOptionMenuNamea' type='text' value='"+content+"' placeholder='옵션명'class='form-control' /></div></div></div><div class='col-md-4'><div class='form-group'><div class='input-icon right'><i class='fa fa-tag'></i> <input id='otbOptionMenuPricea'name='otbOptionMenuPricea' value='"+price+"' type='text' placeholder='옵션가격(숫자만 입력)' class='form-control' /></div></div></div><div class='col-md-4'><div class='form-group'><button href='#' id='remove' name='remove' class='btn btn-primary'>삭제</button></div></div><div class='col-md-6'><div class='form-group'><input id='otbOptionMenuCode'name='otbOptionMenuCode' type='hidden' value='"+code+"' placeholder='코드'/></div></div></div>";
      // 추가할 폼(에 들어갈 HTML)
     
      var addedDiv = document.createElement("div"); // 폼 생성
      addedDiv.id = "added"; // 폼 Div에 ID 부여 (삭제를 위해)
      addedDiv.innerHTML  = str; // 폼 Div안에 HTML삽입
      addedFormDiv.appendChild(addedDiv); // 삽입할 DIV에 생성한 폼 삽입
	
document.frm.otbOptionMenuName.value ="";
document.frm.otbOptionMenuPrice.value="";
}

$(document).ready(function() {
	gfnc_Ajax({
	    type: "post",
	    url: "/setting/category_list_selectbox_ajax.jsp",
	    data: {
	    	
	    },
	    dataType: "html",
	    success: function(data){
	    	//alert(data);
	        $('#otbCateBig').append(data);
	    },
	    error: function(err) {
	    	//alert(err.responseText);
	    }
	});
});

function checkForm() {
	
	if (Validator.isEmpty("#constName", "공고명을 입력해주세요.")) { return; }
	
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
						<div class="page-title">공고등록</div>
					</div>
					<ol class="breadcrumb page-breadcrumb pull-right">
						<li><i class="fa fa-home"></i>&nbsp;<a href="/home/home.jsp">Home</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active"><a href="#">공고</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">공고등록</li>
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
	                                <div class="panel-heading">공고등록</div>
	                                <div class="panel-body pan">
	                                    <form action="/construction/constructionAddOk.jsp" id="registForm" name="frm" method="post" enctype="multipart/form-data">
	                                    	<div class="form-body pal">
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-pencil"></i> <input id="constName"
																name="constName" type="text" placeholder="공고명"
																class="form-control" tabindex="1" onKeypress="hitEnterKey(event)"/>
														</div>
													</div>
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-balance-scale"></i> <input id="constWay"
																name="constWay" type="text" placeholder="계약방법"
																class="form-control" tabindex="2" onKeypress="hitEnterKey(event)"/>
														</div>
													</div>
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-map-marker"></i> <input id="constArea" name="constArea"
															type="text" placeholder="지역제한" class="form-control" tabindex="3" onKeypress="hitEnterKey(event)"/>
														</div>
													</div>
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-bar-chart"></i> <input id="constPrice" name="constPrice"
															type="text" placeholder="예가변동폭" class="form-control" tabindex="4" onKeypress="hitEnterKey(event)"/>
														</div>
													</div>
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-line-chart"></i> <input id="constLower" name="constLower"
															type="text" placeholder="투찰하한율" class="form-control" tabindex="5" onKeypress="hitEnterKey(event)"/>
														</div>
													</div>
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-calendar"></i> <input id="constOpening" name="constOpening"
															type="text" placeholder="개찰일" class="form-control" tabindex="6" onKeypress="hitEnterKey(event)"/>
														</div>
													</div>
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-university"></i> <input id="constInstitution" name="constInstitution"
															type="text" placeholder="공고기관" class="form-control" tabindex="7" onKeypress="hitEnterKey(event)"/>
														</div>
													</div>
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-percent"></i> <input id="constPercent" name="constPercent"
															type="text" placeholder="사정률" class="form-control" tabindex="8" onKeypress="hitEnterKey(event)"/>
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

