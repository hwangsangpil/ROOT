<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="util.StringUtil"%>
<%@ page import="util.CookieBox"%>	
<%
	String menuId = StringUtil.nchk(request.getParameter("menuId"),"aa");
//System.out.println("menuId : " +menuId);
%>

<nav id="sidebar" role="navigation" data-step="2"
	data-intro="Template has &lt;b&gt;many navigation styles&lt;/b&gt;"
	data-position="right" class="navbar-default navbar-static-side">
	<div class="sidebar-collapse menu-scroll">
		<ul id="side-menu" class="nav">

			<div class="clearfix"></div>

			<!-- 메뉴카테고리 관리 -->
			<!-- 1차메뉴 -->
			<li id="menu_member"><a href="/construction/constructionList.jsp"><i
					class="fa fa-list-ul">
				</i><span class="menu-title">공고관리</span></a></li>
				
			<li id="menu_member"><a href="/construction/constructionAdd.jsp"><i
					class="fa fa-pencil-square-o">
				</i><span class="menu-title">공고등록</span></a></li>
			
			<li id="menu_member"><a href="/business/businessList.jsp"><i
					class="fa fa-list-ul">
				</i><span class="menu-title">업체관리</span></a></li>	
				
			<li id="menu_member"><a href="/business/businessAdd.jsp"><i
					class="fa fa-pencil-square-o">
				</i><span class="menu-title">업체등록</span></a></li>	
				
			<li id="menu_member"><a href="/admin/adminList.jsp"><i
					class="fa fa-list-ul">
				</i><span class="menu-title">관리자관리</span></a></li>
			
			<li id="menu_member"  ><a href="/totalInsert/totalInsert.jsp" ><i
					class="fa fa-list-ul">
				</i><span class="menu-title">전체등록</span></a></li>
				
			<!-- 1차메뉴 -->
			<li id="menu_trashcan"><a href="#"
				onclick="javascript:func_menu_ext('menu_trashcan',3);"><i
					class="fa fa-sitemap fa-fw">
				</i><span class="menu-title">휴지통</span></a></li>		
				<!-- 2차메뉴 -->
			<li id="menu_trashcan_sub1" style="display: none;"><a href="/trashcan/constructionDelList.jsp"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;공고관리</span></a></li>
			<li id="menu_trashcan_sub2" style="display: none;"><a href="/trashcan/businessDelList.jsp"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;업체관리</span></a></li>
			<li id="menu_trashcan_sub3" style="display: none;"><a href="/trashcan/adminDelList.jsp"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;관리자 관리</span></a></li>
					
		</ul>
	</div>
</nav>
