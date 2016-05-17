<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="util.CookieBox"%> 
<%
CookieBox cookieBox = new CookieBox(request);
boolean login = cookieBox.exists("LOGIN")&& cookieBox.getValue("LOGIN").equals("SUCCESS");




if(!login){
%>
<script language="javascript">
	alert("세션정보가 끊겼습니다. 다시 로그인 해주세요.");
	location = "/index.jsp";
</script>
<%}%>

<!-- <div id="header-topbar-option-demo" class="page-header-topbar">
    <nav id="topbar" role="navigation" style="margin-bottom: 0;" data-step="3" class="navbar navbar-default navbar-static-top">
     <div class="navbar-header"><a id="logo" href="/index.html" class="navbar-brand"><span class="logo-text">OTB CMS</span></a></div>
     <div class="topbar-main"><a id="menu-toggle" href="#" class="hidden-xs"><i class="fa fa-bars"></i></a></div>
  	<ul class="nav navbar navbar-top-links navbar-right mbn">
  	 <li id="topbar-chat" class="hidden-xs"><a href="javascript:void(0)" data-step="4" data-intro="&lt;b&gt;Form chat&lt;/b&gt; keep you connecting with other coworker" data-position="left" class="btn-chat"><i class="fa fa-comments"></i><span class="badge badge-info">3</span></a></li>
  	</ul>
  	</nav>
</div>
 -->
 <div id="header-topbar-option-demo" class="page-header-topbar">
            <nav id="topbar" role="navigation" style="margin-bottom: 0;" data-step="3" class="navbar navbar-default navbar-static-top">
            <div class="navbar-header">
                <button type="button" data-toggle="collapse" data-target=".sidebar-collapse" class="navbar-toggle"><span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
                <a id="logo" href="/home/home.jsp" class="navbar-brand"><span class="fa fa-rocket"></span><span class="logo-text">INFO SYSTEM</span><span style="display: none" class="logo-text-icon"></span></a></div>
            <div class="topbar-main">
            	<a id="menu-toggle" href="#" class="hidden-xs"><i class="fa fa-bars"></i></a>
            	
                <ul class="nav navbar navbar-top-links navbar-right mbn">
                    <li id="topbar-chat" class="hidden-xs"><a href="/login/logout.jsp" data-step="4" data-intro="&lt;b&gt;Form chat&lt;/b&gt; keep you connecting with other coworker" data-position="left" class="btn-chat"><i class="fa fa-key"></i>Log Out</a></li>
                    
                </ul>
            </div>
        </nav>
 
