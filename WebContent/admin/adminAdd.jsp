<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
    <%
    String searchKeyword = URLDecoder.decode(StringUtil.nchk(request.getParameter("searchKeyword"),""),"UTF-8");
    String[] checked=request.getParameterValues("check");
    int selectGubun = 0;
    int pageno = Integer.parseInt(StringUtil.nchk(request.getParameter("pageno"), "1"));
    %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>관리자 등록</title>
<%@ include file="../include/inc_header.jsp"%>
<%if("일반관리자".equals(role)){ %>
<script type="text/javascript">
		alert("<%=role%>는 권한이없습니다.");
		history.back();
<%}%>
</script>
<script type="text/javascript">
$(document).ready(function() {
	$("#adminId").focus();
});
function checkForm() {
	var adminId = document.getElementById("adminId").value;
	var adminPw = document.getElementById("adminPw").value;
	var adminConfirmPw = document.getElementById("adminConfirmPw").value;
	var adminName = document.getElementById("adminName").value;
	var adminPhone = document.getElementById("adminPhone").value;
	var adminEmail = document.getElementById("adminEmail").value;
	var adminRole = document.getElementById("adminRole");
	var selectedAdminRole = adminRole.options[adminRole.selectedIndex].value;
	
	if( adminId.length == 0 ) {
		alert("아이디를 입력해주세요.");
		document.getElementById("adminId").focus();
		return;
	}
	if( adminPw.length == 0 ) {
		alert("비밀번호를 입력해주세요.");
		document.getElementById("adminPw").focus();
		return;
	}
	if( adminConfirmPw.length == 0 ) {
		alert("비밀번호 확인을 입력해주세요.");
		document.getElementById("adminConfirmPw").focus();
		return;
	}
	if( adminPw != adminConfirmPw) {
		alert("비밀번호 확인을 정확히 입력해주세요.");
		document.getElementById("adminConfirmPw").focus();
		return;
	}
	if( adminName.length == 0 ) {
		alert("이름을 입력해주세요.");
		document.getElementById("adminName").focus();
		return;
	}
	if( adminPhone.length == 0 ) {
		alert("폰번호를 입력해주세요.");
		document.getElementById("adminPhone").focus();
		return;
	}
	if( adminEmail.length == 0 ) {
		alert("이메일을 입력해주세요.");
		document.getElementById("adminEmail").focus();
		return;
	}
	if( selectedAdminRole == -1){
		alert("메뉴 권한을 선택해주세요.");
		return;
	}
	registForm.action="adminAddOk.jsp?pageno="+<%=pageno%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("1")){%>+"&check="+<%=checked[i]%><%}}}%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("2")){%>+"&check="+<%=checked[i]%><%}}}%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("3")){%>+"&check="+<%=checked[i]%><%}}}%>
	<%if(checked!=null){for(int i=0;i<checked.length;i++){if(checked[i].equals("4")){%>+"&check="+<%=checked[i]%><%}}}%>
		+"&searchKeyword="+encodeURI(encodeURIComponent("<%=searchKeyword%>"));
	registForm.submit();
}
function changeView(a){
	if(a==4){
		document.all.branchGubun.style.display="block";
	}else{
		document.all.branchGubun.style.display="none";
	}
}
function hitEnterKey(e){
	  if(e.keyCode == 13){
		  checkForm();
	  }else{
		  e.keyCode == 0;
	 	  return;
	  }
	} 
$(document).ready(function() {
	gfnc_Ajax({
	    type: "post",
	    url: "/branch/branch_list_selectbox_ajax.jsp",
	    data: {
	    	
	    },
	    dataType: "html",
	    success: function(data){
	    	//alert(data);
	        $('#branchCode').append(data);
	    },
	    error: function(err) {
	    	//alert(err.responseText);
	    }
	});
});
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
						<div class="page-title">관리자 등록</div>
					</div>
					<ol class="breadcrumb page-breadcrumb pull-right">
						<li><i class="fa fa-home"></i>&nbsp;<a href="/home/home.jsp">Home</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active"><a href="#">설정</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">관리자 등록</li>
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
								<div class="panel panel-orange">
		                            <div class="panel-heading">관리자 등록</div>
		                            <div class="panel-body pan">
		                                <form id="registForm" method="post">
		                                <input type="hidden" name="pageno" value="<%=pageno %>";/>
		                                <div class="form-body pal">
		                                    <div class="form-group">
		                                        <div class="input-icon right">
		                                            <i class="fa fa-user"></i>
		                                            <input id="adminId" name="adminId" type="text" placeholder="아이디" class="form-control" onKeypress="hitEnterKey(event)" tabindex="1"/></div>
		                                    </div>
		                                    <div class="form-group">
		                                        <div class="input-icon right">
		                                            <i class="fa fa-lock"></i>
		                                            <input id="adminPw" name="adminPw" type="password" placeholder="비밀번호" class="form-control" onKeypress="hitEnterKey(event)" tabindex="2"/></div>
		                                    </div>
		                                    <div class="form-group">
		                                        <div class="input-icon right">
		                                            <i class="fa fa-lock"></i>
		                                            <input id="adminConfirmPw" name="adminConfirmPw" type="password" placeholder="비밀번호 확인" class="form-control" onKeypress="hitEnterKey(event)" tabindex="3"/></div>
		                                    </div>
		                                    <div class="form-group">
		                                        <div class="input-icon right">
		                                            <i class="fa fa-list-alt"></i>
		                                            <input id="adminName" name="adminName" type="text" placeholder="이름" class="form-control" onKeypress="hitEnterKey(event)" tabindex="4"/></div>
		                                    </div>
		                                    <div class="form-group">
		                                        <div class="input-icon right">
		                                            <i class="fa fa-phone"></i>
		                                            <input id="adminPhone" name="adminPhone" type="text" placeholder="핸드폰 번호" class="form-control" onKeypress="hitEnterKey(event)" tabindex="5"/></div>
		                                    </div>
		                                    <div class="form-group">
		                                        <div class="input-icon right">
		                                            <i class="fa fa-envelope-o"></i>
		                                            <input id="adminEmail" name="adminEmail" type="text" placeholder="이메일" class="form-control" onKeypress="hitEnterKey(event)" tabindex="6"/></div>
		                                    </div>
		                                    <div class="form-group">
		                                        <select id="adminRole" name="adminRole" class="form-control" onChange="javascript:changeView(this.value)" onKeypress="hitEnterKey(event)" tabindex="7">
		                                            <option value="-1">메뉴 권한</option>
		                                            <option value="전체관리자">전체관리자</option>
		                                            <option value="일반관리자">일반관리자</option>
		                                        </select>
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
				<%@ include file="../include/inc_footer.jsp"%>
				<!--END FOOTER-->
			</div>
			<!--END PAGE WRAPPER-->
		</div>
	</div>
</body>
</html>
