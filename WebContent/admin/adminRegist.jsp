<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Login</title>
    <%@ include file="/include/inc_header.jsp"%>
	<script language="JavaScript">
	
		$(document).ready(function() {
			$("#id").focus();
		});
	 
		function checkForm() {
			var adminRole = document.getElementById("role");
			var selectedAdminRole = adminRole.options[adminRole.selectedIndex].value;
			
			if (Validator.isEmpty("#id", "아이디를 입력해주세요.")) { return; }
			if (Validator.isEmpty("#password", "패스워드를 입력해주세요.")) { return; }
			if (Validator.isEmpty("#name", "이름을 입력해주세요.")) { return; }
			if (Validator.isEmpty("#phone", "전화번호를 입력해주세요.")) { return; }
			if (Validator.isEmpty("#email", "이메일을 입력해주세요.")) { return; }
			if( selectedAdminRole == -1){
				alert("메뉴 권한을 선택해주세요.");
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
	
		function changeView(a){
			if(a==4){
				document.all.branchGubun.style.display="block";
			}else{
				document.all.branchGubun.style.display="none";
			}
		}
		
	</script>
</head>
<body style="background: url('/images/bg/bg.png') 100% 100% fixed;">
    <div class="page-form">
        <div class="panel panel-blue">
            <div class="panel-body pan">
                <form action="adminRegistOk.jsp" id="registForm" method="post" class="form-horizontal">
				<input type="hidden" name="returnUrl" value="L2FkbWluL21haW4vbWFpbi5kbw"/>
				<br/><br/>
                <div class="form-body pal" style="margin-top: -135px;">
                    <div class="col-md-12 text-center">
                        <h1 style="font-size: 30px;">
                          <a href="/index.jsp">INFO SYSTEM</a></h1>
                        <br/>
                    </div>
                    <div class="form-group">
                        <div class="col-md-3">
                            <img src="/images/avatar/profile-pic.png" class="img-responsive" style="margin-top: -30px;" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputName" class="col-md-3 control-label">
                            UserId:</label>
                        <div class="col-md-9">
                            <div class="input-icon right">
                                <i class="fa fa-user"></i>
                                <input type="text" id="id" name="id" placeholder="" class="form-control" tabindex="1" onKeypress="hitEnterKey(event)"/></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword" class="col-md-3 control-label">
                            Password:</label>
                        <div class="col-md-9">
                            <div class="input-icon right">
                                <i class="fa fa-lock"></i>
                                <input type="password" id="password" name="password" placeholder="" class="form-control" tabindex="2" onKeypress="hitEnterKey(event)"/></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputName" class="col-md-3 control-label">
                            Username:</label>
                        <div class="col-md-9">
                            <div class="input-icon right">
                                <i class="fa fa-list-alt"></i>
                                <input type="text" id="name" name="name" placeholder="" class="form-control" tabindex="3" onKeypress="hitEnterKey(event)"/></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputName" class="col-md-3 control-label">
                            UserPhone :</label>
                        <div class="col-md-9">
                            <div class="input-icon right">
                                <i class="fa fa-phone"></i>
                                <input type="text" id="phone" name="phone" placeholder="" class="form-control" tabindex="4" onKeypress="hitEnterKey(event)"/></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputName" class="col-md-3 control-label">
                            UserEmail:</label>
                        <div class="col-md-9">
                            <div class="input-icon right">
                                <i class="fa fa-envelope-o"></i>
                                <input type="text" id="email" name="email" placeholder="" class="form-control" tabindex="5" onKeypress="hitEnterKey(event)"/></div>
                        </div>
                    </div>
                    <div class="form-group">
                    	<label for="inputName" class="col-md-3 control-label">
                            UserRole:</label>
                        <div class="col-md-9">
		                                        <select id="role" name="role" class="form-control" onChange="javascript:changeView(this.value)" tabindex="6" onKeypress="hitEnterKey(event)">
		                                            <option value="-1">메뉴 권한</option>
		                                            <option value="전체관리자">전체관리자</option>
		                                            <option value="일반관리자">일반관리자</option>
		                                        </select>
		                                    </div>
		                                 </div>
		            <div class="form-group" id="branchGubun" name = "branchGubun" style="display:none">
		                                        <select name="branchCode" id="branchCode" class="form-control">
													</select>
											</div>
                    <div class="form-group mbn">
                        <div class="col-lg-12" align="right">
                            <div class="form-group mbn">
                                <div class="col-lg-3">
                                    &nbsp;
                                </div>
                                <div class="col-lg-9">
                                    <button type="button" class="btn btn-default" onclick="checkForm();" tabindex="7">
                                        Regist</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
