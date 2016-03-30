<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="util.StringUtil"%>
<%@page import="util.DateUtil"%>
<%@page import="util.Constant"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>OTB CMS-OTB 메뉴 관리</title>
<%@ include file="/include/inc_header.jsp"%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<script type="text/javascript">
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
	var couponImg = document.getElementById("otbMenuListImg").value;
	var couponImgDetail = document.getElementById("otbMenuContentImg").value;
	
	var idx = couponImg.lastIndexOf(".")+1;
	var idx2 = couponImg.lastIndexOf("\\")+1;
	var couponImgCheck = couponImg.substring(idx2, couponImg.length).toLowerCase();
	
	var detail = couponImgDetail.lastIndexOf(".")+1;
	var detail2 = couponImgDetail.lastIndexOf("\\")+1;
	var detailCheck = couponImgDetail.substring(detail2, couponImgDetail.length).toLowerCase();
	
	if (couponImg.length != 0) {
		for(i=0; i<couponImgCheck.length; i++){
			var chk = couponImgCheck.charCodeAt(i);
			if(chk>128){
				alert("리스트 노출 이미지 파일명이 한글입니다.")
				return;
			}
		}
	}
	
	if (couponImgDetail.length != 0) {
		for(i=0; i<detailCheck.length; i++){
			var chk = detailCheck.charCodeAt(i);
			if(chk>128){
				alert("상세 노출 이미지파일명이 한글입니다.")
				return;
			}
		}
	}
	
	if($( "#otbCateBig" ).val() == -1){
		alert("대메뉴 카테고리를 선택해 주세요.");
		return;
	}
		
	 if (Validator.isEmpty("#otbMenuBasicName", "찾기를 클릭하셔서 메뉴를 선택해 주세요.")) { return; }
	
	registForm.submit();
}

function fnc_search_basic_menu(){
	$('#ifrMenu').attr("src","/menu/otb_basic_menu_list.jsp");
	$( "#dialog" ).dialog({
		dialogClass: "no-close",
		autoOpen: true,
		resizable: false,
		height:800,
		width:800,
		modal: true,
		buttons: {
			"닫기": function() {
				$( this ).dialog( "close" );
			}
		}
	});
}
function fnc_search_basic_optionmenu(){
	$('#ifrMenuOption').attr("src","/menu/otb_basic_option_menu_list.jsp");
	$( "#optiondialog" ).dialog({
		dialogClass: "no-close",
		autoOpen: true,
		resizable: false,
		height:800,
		width:800,
		modal: true,
		buttons: {
			"닫기": function() {
				$( this ).dialog( "close" );
			}
		}
	});
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
						<li><i class="fa fa-home"></i>&nbsp;<a href="/first/first.jsp">Home</a>&nbsp;&nbsp;<i
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
	                                    <form action="constructionAdd_ok.jsp" id="registForm" name="frm" method="post" enctype="multipart/form-data">
	                                    	<div class="form-body pal">
												<div class="form-group">
													<select name="otbCateBig" id="otbCateBig" class="form-control">
													</select>
												</div>
												<div class="row">
													<div class="col-md-6">
														<div class="form-group">
															<div class="input-icon right">
																<i class="fa fa-tag"></i> <input id="otbMenuName"
																	name="otbMenuName" type="text" placeholder="메뉴명(한글명)"
																	class="form-control" />
															</div>
														</div>
													</div>
													<div class="col-md-6">
														<button type="button" onclick="fnc_search_basic_menu();" class="btn btn-primary">찾기</button>
													</div>
												</div>
												<div class="form-group">
													<div class="input-icon right">
														<i class="fa fa-tag"></i> <input id="otbMenuEName" name="otbMenuEName"
															type="text" placeholder="메뉴명(영문명)" class="form-control"/>
													</div>
												</div>
												<div class="form-group">
													<div class="input-icon right">
														<i class="fa fa-tag"></i> <input id="otbMenuBasicName" name="otbMenuBasicName"
															type="text" placeholder="한글메뉴명(기초테이블)" class="form-control" readonly />
													</div>
												</div>
													<div class="form-group">
													<div class="input-icon right">
														<i class="fa fa-tag"></i> <input id="otbMenuBasicEName" name="otbMenuBasicEName"
															type="text" placeholder="영문메뉴명(기초테이블)" class="form-control" readonly/>
													</div>
												</div>
												<div class="form-group">
													<div class="input-icon right">
														<i class="fa fa-tag"></i> <input id="otbMenuCode" name="otbMenuCode"
															type="text" placeholder="메뉴코드" class="form-control" readonly />
													</div>
												</div>
												<div class="form-group">
													<div class="input-icon right">
														<i class="fa fa-tag"></i> <input id="otbMenuPrice" name="otbMenuPrice"
															type="text" placeholder="판매가" class="form-control" readonly/>
													</div>
												</div>
												<div class="form-group">
													<div class="input-icon right">
														<i class="fa fa-tag"></i> <input id="otbOptionMenuName" name="otbOptionMenuName"
															type="text" placeholder="옵션명" class="form-control"/>
													</div>
												</div>
												<div class="row">
													<div class="col-md-6">
														<div class="form-group">
															<div class="input-icon right">
																<i class="fa fa-tag"></i> <input id="otbOptionMenuPrice"
																	name="otbOptionMenuPrice" type="text" placeholder="옵션가격"
																	class="form-control" />
															</div>
														</div>
													</div>
													
													<div class="col-md-6">
														<button type="button" onclick="javascript:addInputBox();" class="btn btn-primary">등록</button>
														<button type="button" onclick="fnc_search_basic_optionmenu();" class="btn btn-primary">찾기</button>
													</div>
													
												</div>
												<!-- <div class="row">
													<div class="col-md-4">
														<div class="form-group">
															<div class="input-icon right">
																<i class="fa fa-tag"></i> <input id="otbOptionMenuName"
																	name="otbOptionMenuName" type="text" placeholder="옵션명"
																	class="form-control" />
															</div>
														</div>
													</div>
													
													<div class="col-md-4">
														<div class="form-group">
															<div class="input-icon right">
																<input id="otbOptionMenuPrice"
																	name="otbOptionMenuPrice" type="text" placeholder="옵션가격(숫자만 입력)"
																	class="form-control" />
															</div>
														</div>
													</div>
													
													<div class="col-md-4">
														<button type="button" onclick="javascript:addInputBox();" class="btn btn-primary">등록</button>
														<button type="button" onclick="fnc_search_basic_optionmenu();" class="btn btn-primary">찾기</button>
													</div>
													
												</div> -->
												<br/>
												<div id="addedFormDiv">
												<label style="color:red">등록된 옵션</label>
												</div>
												<br/>
												<div class="form-group">
													<label for="inputAttachImg" class="control-label">
														파일첨부(리스트노출)</label>
													<input id="otbMenuListImg" name="otbMenuListImg" type="file" />
												</div>
												<div class="form-group">
													<label for="inputAttachImg" class="control-label">
														파일첨부(상세노출)</label>
													<input id="otbMenuContentImg" name="otbMenuContentImg" type="file" />
												</div>
												<div class="form-group">
													<label for="inputMessage" class="control-label">
														내용</label>
													<textarea id="otbMenuContent" name="otbMenuContent" rows="5" class="form-control"></textarea>
												</div>
												<div class="form-group mbn">
													<div class="checkbox">
														<label> <input id="otbMenuNew" name="otbMenuNew" type="checkbox" value="1"/>&nbsp;
															신메뉴 등록
														</label>
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
	<div id="dialog" title="메뉴선택">
		<div id="ifrTable">
			<iframe name="ifrMenu" id="ifrMenu" width="100%" height="650px" style="border-width: 0px;" scrolling="no"></iframe>
		</div>
	</div>
	<div id="optiondialog" title="옵션메뉴선택">
		<div id="ifrTable">
			<iframe name="ifrMenuOption" id="ifrMenuOption" width="100%" height="650px" style="border-width: 0px;" scrolling="no"></iframe>
		</div>
	</div>
</body>
</html>
