<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="util.StringUtil"%>
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
					class="fa fa-file-o fa-fw">
				</i><span class="menu-title">공고관리</span></a></li>
				
			<li id="menu_member"><a href="/construction/constructionAdd.jsp"><i
					class="fa fa-file-o fa-fw">
				</i><span class="menu-title">공고입력</span></a></li>
			
			<li id="menu_member"><a href="/business/businessList.jsp"><i
					class="fa fa-file-o fa-fw">
				</i><span class="menu-title">업체관리</span></a></li>	
				
			<li id="menu_member"><a href="/business/businessAdd.jsp"><i
					class="fa fa-file-o fa-fw">
				</i><span class="menu-title">업체등록</span></a></li>	
			
			
			
			
			<!-- 여기서 부터 UI 참조할수 있는 URL (추후 삭제예정) -->
			<!-- 실제 메뉴와 구분하기 위한 공란 -->
			<!-- <li><a href="#"><i>
				</i><span class="menu-title">&nbsp;</span></a></li>
			<li><a href="#"><i>
				</i><span class="menu-title">&nbsp;</span></a></li>
			<li><a href="#"><i>
				</i><span class="menu-title">&nbsp;</span></a></li>
			
			<li><a href="../Layout.html" target="_blank"><i class="fa fa-desktop fa-fw">
				</i><span class="menu-title">Layouts</span></a></li>
			<li><a href="../UIElements.html" target="_blank"><i class="fa fa-send-o fa-fw">
				</i><span class="menu-title">UI Elements</span></a></li>
			<li><a href="../Forms.html" target="_blank"><i class="fa fa-edit fa-fw">
				</i><span class="menu-title">Forms</span></a></li>
			<li><a href="../Tables.html" target="_blank"><i
					class="fa fa-th-list fa-fw">
				</i><span class="menu-title">Tables</span></a></li>
			<li><a href="../DataGrid.html" target="_blank"><i class="fa fa-database fa-fw">
				</i><span class="menu-title">Data Grids</span></a></li>
			<li><a href="../Pages.html" target="_blank"><i class="fa fa-file-o fa-fw">
				</i><span class="menu-title">Pages</span></a></li>
			<li><a href="../Extras.html" target="_blank"><i class="fa fa-gift fa-fw">
				</i><span class="menu-title">Extras</span></a></li>
			<li><a href="../Dropdown.html" target="_blank"><i class="fa fa-sitemap fa-fw">
				</i><span class="menu-title">Multi-Level Dropdown</span></a></li>
			<li><a href="../Email.html" target="_blank"><i class="fa fa-envelope-o">
				</i><span class="menu-title">Email</span></a></li> -->
		</ul>
	</div>
</nav>
