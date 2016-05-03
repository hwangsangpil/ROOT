<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.util.ArrayList"%>
<%@page import="board.model.AdminDao"%>
<%@page import="board.model.AdminVO"%>
<%@page import="util.StringUtil"%>
<%@page import="util.DateUtil"%>
<%

int no = Integer.parseInt(StringUtil.nchk(request.getParameter("no"), "1"));
int pageno = Integer.parseInt(StringUtil.nchk(request.getParameter("pageno"), "1"));	

AdminDao dao = new AdminDao();
AdminVO vo = dao.selectAdminInfo(no);
dao.closeConn();	
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>OTB CMS-설정</title>
<%@ include file="../include/inc_header.jsp"%>
<script type="text/javascript">
function checkForm() {
	var adminName = document.getElementById("adminName").value;
	var adminId = document.getElementById("adminId").value;
	var adminPw = document.getElementById("adminPw").value;
	var adminConfirmPw = document.getElementById("adminConfirmPw").value;
	var adminEmail = document.getElementById("adminEmail").value;
	var adminPhone = document.getElementById("adminPhone").value;
	var adminRole = document.getElementById("adminRole");
	var selectedAdminRole = adminRole.options[adminRole.selectedIndex].value;
	
	if( adminName.length == 0 ) {
		alert("이름을 입력해주세요.");
		document.getElementById("adminName").focus();
		return;
	}
	
	if( adminId.length == 0 ) {
		alert("아이디를 입력해주세요.");
		document.getElementById("adminId").focus();
		return;
	}
	
	/* if( adminPw.length == 0 ) {
		alert("비밀번호를 입력해주세요.");
		document.getElementById("adminPw").focus();
		return;
	}
	
	if( adminConfirmPw.length == 0 ) {
		alert("비밀번호 확인을 입력해주세요.");
		document.getElementById("adminConfirmPw").focus();
		return;
	}
	 */
	if( adminEmail.length == 0 ) {
		alert("이메일을 입력해주세요.");
		document.getElementById("adminEmail").focus();
		return;
	}
	
	if( adminPhone.length == 0 ) {
		alert("폰번호를 입력해주세요.");
		document.getElementById("adminPhone").focus();
		return;
	}
	
	if( adminPw != adminConfirmPw) {
		alert("비밀번호 확인을 정확히 입력해주세요.");
		document.getElementById("adminConfirmPw").focus();
		return;
	}
	
	if( selectedAdminRole == -1){
		alert("메뉴 권한을 선택해주세요.");
		return;
	}
	
	registForm.action = "admin_modify_ok.jsp";
	registForm.submit();
}

function fnc_delete(){
	if (confirm("정말 삭제하시겠습니까??") == true){    //확인
		location.href = "/setting/admin_delete_ok.jsp?no=<%=no%>";
	}else{
		return;
	}
}

function fnc_list(){
	location.href = "/setting/admin_list.jsp?pageno="+<%=pageno%>;
}
function changeView(a){
	if(a==4){
		document.all.branchGubun.style.display="block";
	}else{
		document.all.branchGubun.style.display="none";
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
	        $("#branchCode").val("<%=vo.getAdminBranch()%>").attr("selected", "selected");
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
						<div class="page-title">권한 관리</div>
					</div>
					<ol class="breadcrumb page-breadcrumb pull-right">
						<li><i class="fa fa-home"></i>&nbsp;<a href="index.html">Home</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active"><a href="#">설정</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">권한 관리</li>
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
		                            <div class="panel-heading">관리자 수정/삭제</div>
		                            <div class="panel-body pan">
		                                <form id="registForm" method="post">
		                                <input type="hidden" name="no" value="<%=no%>">
		                                <div class="form-body pal">
		                                    <div class="form-group">
		                                        <div class="input-icon right">
		                                            <i class="fa fa-user"></i>
		                                            <input id="adminName" name="adminName" type="text" placeholder="이름" class="form-control" value="<%=StringUtil.NVL(vo.getAdminName()) %>"
		                                            onMouseOver="javascript: this.value='이름';" onmouseout="javascript: this.value='<%=vo.getAdminName()%>';" onclick="javascript: this.value='<%=vo.getAdminName()%>';"/></div>
		                                    </div>
		                                    <div class="form-group">
		                                        <div class="input-icon right">
		                                            <i class="fa fa-envelope"></i>
		                                            <input id="adminId" name="adminId" type="text" placeholder="아이디" class="form-control" value="<%=StringUtil.NVL(vo.getAdminId()) %>"
		                                            onMouseOver="javascript: this.value='아이디';" onmouseout="javascript: this.value='<%=vo.getAdminId()%>';" onclick="javascript: this.value='<%=vo.getAdminId()%>';"/></div>
		                                    </div>
		                                    <div class="form-group">
		                                        <div class="input-icon right">
		                                            <i class="fa fa-lock"></i>
		                                            <input id="adminPw" name="adminPw" type="password" placeholder="비밀번호" class="form-control" /></div>
		                                    </div>
		                                    <div class="form-group">
		                                        <div class="input-icon right">
		                                            <i class="fa fa-lock"></i>
		                                            <input id="adminConfirmPw" name="adminConfirmPw" type="password" placeholder="비밀번호 확인" class="form-control" /></div>
		                                    </div>
		                                    <div class="form-group">
		                                        <div class="input-icon right">
		                                            <i class="fa fa-envelope"></i>
		                                            <input id="adminEmail" name="adminEmail" type="text" placeholder="이메일" class="form-control" value="<%=StringUtil.NVL(vo.getAdminEmail()) %>" 
		                                            onMouseOver="javascript: this.value='이메일';" onmouseout="javascript: this.value='<%=vo.getAdminEmail()%>';" onclick="javascript: this.value='<%=vo.getAdminEmail()%>';"/></div>
		                                    </div>
		                                    <div class="form-group">
		                                        <div class="input-icon right">
		                                            <i class="fa fa-envelope"></i>
		                                            <input id="adminPhone" name="adminPhone" type="text" placeholder="핸드폰 번호" class="form-control" value="<%=StringUtil.NVL(vo.getAdminPhone()) %>" 
		                                            onMouseOver="javascript: this.value='핸드폰 번호';" onmouseout="javascript: this.value='<%=vo.getAdminPhone()%>';" onclick="javascript: this.value='<%=vo.getAdminPhone()%>';"/></div>
		                                    </div>
		                                    <div class="form-group">
		                                        <select id="adminRole" name="adminRole" class="form-control" onChange="javascript:changeView(this.value)">
		                                            <option value="-1" <%if(vo.getAdminRole() == -1){%>selected<%}%>>메뉴 권한</option>
		                                            <option value="0" <%if(vo.getAdminRole() == 0){%>selected<%}%>>전체 관리자</option>
		                                            <option value="1" <%if(vo.getAdminRole() == 1){%>selected<%}%>>OTB메뉴 관리자</option>
		                                            <option value="2" <%if(vo.getAdminRole() == 2){%>selected<%}%>>일반 컨텐츠 관리자</option>
		                                            <option value="3" <%if(vo.getAdminRole() == 3){%>selected<%}%>>이벤트 관리자</option>
		                                            <option value="4" <%if(vo.getAdminRole() == 4){%>selected<%}%>>매장용 CMS 관리자</option>
		                                        </select>
		                                    </div>
		                                   <%if(vo.getAdminRole() == 4){ %>
		                                    <div class="form-group" id="branchGubun" name = "branchGubun">
		                                        <select name="branchCode" id="branchCode" class="form-control">
													</select>
											</div>
											<%} %>
		                                </div>
		                                <div class="form-actions text-right pal">
		                                    <button type="button" onclick="checkForm();" class="btn btn-primary">수정</button>&nbsp;
		                                    <button type="button" onclick="fnc_delete();" class="btn btn-primary">삭제</button>&nbsp;
		                                    <button type="button" onclick="fnc_list();" class="btn btn-primary">목록</button>
		                                </div>
		                                 <div>
                                                        <h5>&nbsp;&nbsp;&nbsp;전체 관리자 : 모든 메뉴 관리자 및 관>리자 관리</h5>
                                                        <h5>&nbsp;&nbsp;&nbsp;OTB메뉴 관리자 : OTB메뉴, 포장메뉴, >설정(메뉴 카테고리), 리포트 관리</h5>
                                                        <h5>&nbsp;&nbsp;&nbsp;일반 컨텐츠 관리자 : 공지사항/FAQ, 매
장안내, 고객의 소리, 리포트 관리</h5>
                                                        <h5>&nbsp;&nbsp;&nbsp;이벤트 관리자 : 프로모션, 리포트 관리
</h5>
                                                        <h5>&nbsp;&nbsp;&nbsp;매장용 CMS 관리자 : 해당 매장 CMS 관>리</h5>
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
