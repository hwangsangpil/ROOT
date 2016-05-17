<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="util.StringUtil"%>
<%@page import="util.DateUtil"%>
<%@page import="util.Constant"%>
<%@page import="board.model.ConstructionDTO"%>
<%@page import="board.model.ConstructionDAO"%>
<%@page import="board.model.BusinessDTO"%>
<%@page import="board.model.BusinessDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%

int BusiNum = Integer.parseInt(StringUtil.nchk(request.getParameter("BusiNum"), "1"));
int pageno = Integer.parseInt(StringUtil.nchk(request.getParameter("pageno"), "1"));
String[] checked=request.getParameterValues("check");
String searchKeyword = URLDecoder.decode(StringUtil.nchk(request.getParameter("searchKeyword"),""),"UTF-8");


request.setCharacterEncoding("UTF-8");
BusinessDAO dao = new BusinessDAO();
BusinessDTO dto=dao.selectBusinessInfo(BusiNum);
/* 
ConstructionDAO conDao = new ConstructionDAO();
ArrayList<ConstructionDTO> list = new ArrayList<ConstructionDTO>();
list = conDao.selectConstructionList();
 */
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>업체수정</title>
<%@ include file="/include/inc_header.jsp"%>
<%if("일반관리자".equals(role)){ %>
<script type="text/javascript">
		alert("<%=role%>는 권한이없습니다.");
		history.back();
<%}%>
</script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#busiOpening").focus();
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

function fnc_list(){
	location.href = "/business/businessList.jsp?pageno="+<%=pageno%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){%>+"&check="+<%=checked[i]%><%}}}%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){%>+"&check="+<%=checked[i]%><%}}}%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){%>+"&check="+<%=checked[i]%><%}}}%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){%>+"&check="+<%=checked[i]%><%}}}%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("5")){%>+"&check="+<%=checked[i]%><%}}}%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("6")){%>+"&check="+<%=checked[i]%><%}}}%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("7")){%>+"&check="+<%=checked[i]%><%}}}%>
			+"&searchKeyword="+encodeURI(encodeURIComponent("<%=searchKeyword%>"));
}

function checkForm() {
	/* var constName = document.getElementById("constName").value;
	var constWay = document.getElementById("constWay").value;
	var constArea = document.getElementById("constArea").value;
	var constPrice = document.getElementById("constPrice").value;
	var constLower = document.getElementById("constLower").value;
	var constOpening = document.getElementById("constOpening").value;
	var constInstitution = document.getElementById("constInstitution").value;
	var constPercent = document.getElementById("constPercent").value; */
	
	//var selectedAdminRole = adminRole.options[adminRole.selectedIndex].value;
	
	/* if( constName.length == 0 ) {
		alert("공고명을 입력해주세요.");
		document.getElementById("constName").focus();
		return;
	} */
	/* 
	if( selectedAdminRole == -1){
		alert("메뉴 권한을 선택해주세요.");
		return;
	}
	 */
	registForm.action="businessModOk.jsp?BusiNum="+<%=BusiNum%>+"&pageno="+<%=pageno%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){%>+"&check="+<%=checked[i]%><%}}}%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){%>+"&check="+<%=checked[i]%><%}}}%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){%>+"&check="+<%=checked[i]%><%}}}%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){%>+"&check="+<%=checked[i]%><%}}}%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("5")){%>+"&check="+<%=checked[i]%><%}}}%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("6")){%>+"&check="+<%=checked[i]%><%}}}%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("7")){%>+"&check="+<%=checked[i]%><%}}}%>
			+"&searchKeyword="+encodeURI(encodeURIComponent("<%=searchKeyword%>"));
	registForm.submit();
}

function notModConName(){
	alert("공고명은 수정할 수 없습니다");
	$("#busiOpening").focus();
}
function notModBusiName(){
	alert("업체명은 수정할 수 없습니다");
	$("#busiOpening").focus();
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
						<div class="page-title">업체수정</div>
					</div>
					<ol class="breadcrumb page-breadcrumb pull-right">
						<li><i class="fa fa-home"></i>&nbsp;<a href="/home/home.jsp">Home</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active"><a href="#">업체</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">업체수정</li>
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
	                                <div class="panel-heading">업체수정</div>
	                                <div class="panel-body pan">
	                                    <form id="registForm" name="frm" method="post">
	                                    	<div class="form-body pal">
												<div class="form-group">
													<div class="input-icon right">
															<i class="fa fa-pencil"></i> <input id="constNum"
																name="constNum" type="text" placeholder="공고명"
																class="form-control" tabindex="1" onKeypress="hitEnterKey(event)"
																value="<%=dto.getConstName()%>" onMouseOver="javascript: this.value='공고명';" onmouseout="javascript: this.value='<%=dto.getConstName()%>';" onclick="notModConName();"  readonly/>
													</div>
												</div>
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-pencil"></i> <input id="busiName"
																name="busiName" type="text" placeholder="업체명"
																class="form-control" tabindex="2" onKeypress="hitEnterKey(event)"
																onclick="notModBusiName();" value="<%=dto.getBusiName()%>" onMouseOver="javascript: this.value='업체명';" onmouseout="javascript: this.value='<%=dto.getBusiName()%>';" readonly/>
														</div>
													</div>
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-calendar"></i> <input id="bisiOpening" name="bisiOpening"
															type="text" placeholder="개찰일" class="form-control" tabindex="3" onKeypress="hitEnterKey(event)"
															value="<%=dto.getBusiOpening()%>" onMouseOver="javascript: this.value='개찰일';" onmouseout="javascript: this.value='<%=dto.getBusiOpening()%>';" onclick="javascript: this.value='<%=dto.getBusiOpening()%>';"/>
														</div>
													</div>
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-percent"></i> <input id="busiPercent" name="busiPercent"
															type="text" placeholder="업체사정률" class="form-control" tabindex="4" onKeypress="hitEnterKey(event)"
															value="<%=dto.getBusiPercent()%>" onMouseOver="javascript: this.value='업체사정률';" onmouseout="javascript: this.value='<%=dto.getBusiPercent()%>';" onclick="javascript: this.value='<%=dto.getBusiPercent()%>';"/>
														</div>
													</div>
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-bar-chart"></i> <input id="busiPrice" name="busiPrice"
															type="text" placeholder="예가변동폭" class="form-control" tabindex="5" onKeypress="hitEnterKey(event)"
															value="<%=dto.getBusiPrice()%>" onMouseOver="javascript: this.value='예가변동폭';" onmouseout="javascript: this.value='<%=dto.getBusiPrice()%>';" onclick="javascript: this.value='<%=dto.getBusiPrice()%>';"/>
														</div>
													</div>
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-balance-scale"></i> <input id="busiWay" name="busiWay"
															type="text" placeholder="계약방법" class="form-control" tabindex="6" onKeypress="hitEnterKey(event)"
															value="<%=dto.getBusiWay()%>" onMouseOver="javascript: this.value='계약방법';" onmouseout="javascript: this.value='<%=dto.getBusiWay()%>';" onclick="javascript: this.value='<%=dto.getBusiWay()%>';"/>
														</div>
													</div>
													<div class="form-group">
														<div class="input-icon right">
															<i class="fa fa-map-marker"></i> <input id="busiArea" name="busiArea"
															type="text" placeholder="지역제한" class="form-control" tabindex="7" onKeypress="hitEnterKey(event)"
															value="<%=dto.getBusiArea()%>" onMouseOver="javascript: this.value='지역제한';" onmouseout="javascript: this.value='<%=dto.getBusiArea()%>';" onclick="javascript: this.value='<%=dto.getBusiArea()%>';"/>
														</div>
													</div>
												
											</div>
												<div class="form-actions text-right pal">
												<button type="button" onclick="checkForm();" class="btn btn-primary">수정</button>
												<button type="button" onclick="fnc_list();" class="btn btn-primary">목록</button>
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

