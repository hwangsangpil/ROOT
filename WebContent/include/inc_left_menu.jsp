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
				
			<!-- 1차메뉴 -->
			<li id="menu_notice_faq"><a href="#"
				onclick="javascript:func_menu_ext('menu_notice_faq',2);"><i
					class="fa fa-sitemap fa-fw">
				</i><span class="menu-title">공지사항/FAQ</span></a></li>		
			<!-- 2차메뉴 -->
			<li id="menu_notice_faq_sub1" <%if(!menuId.equals("notice")){ %>style="display: none;"<%} %>><a href="/notice/notice_list.jsp"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;공지사항</span></a></li>
			<li id="menu_notice_faq_sub2" <%if(!menuId.equals("notice")){ %>style="display: none;"<%} %>><a href="/faq/faq_list.jsp"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;FAQ</span></a></li>
				
			<!-- OTB 메뉴관리 -->
			<!-- 1차메뉴 -->
			<li id="menu_food_menu"><a href="/menu/otb_menu_list.jsp"><i
					class="fa fa-send-o fa-fw">
				</i><span class="menu-title">OTB 메뉴관리</span></a></li>
			<!-- 2차메뉴 -->
			<!-- 
			<li id="menu_food_menu_sub1" style="display: none;"><a
				href="Tables.html"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;신메뉴</span></a></li>
			<li id="menu_food_menu_sub2" style="display: none;"><a
				href="Tables.html"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;에피타이저</span></a></li>
			<li id="menu_food_menu_sub3" style="display: none;"><a
				href="Tables.html"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;셀러드&수프</span></a></li>
			<li id="menu_food_menu_sub4" style="display: none;"><a
				href="Tables.html"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;화이타그릴</span></a></li>
			<li id="menu_food_menu_sub5" style="display: none;"><a
				href="Tables.html"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;오프더그릴</span></a></li>
			<li id="menu_food_menu_sub6" style="display: none;"><a
				href="Tables.html"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;부리또
						& 타코</span></a></li>
			<li id="menu_food_menu_sub7" style="display: none;"><a
				href="Tables.html"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;엔칠라다&퀘사디아</span></a></li>
			<li id="menu_food_menu_sub8" style="display: none;"><a
				href="Tables.html"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;콤보</span></a></li>
			<li id="menu_food_menu_sub9" style="display: none;"><a
				href="Tables.html"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;디저트</span></a></li>
			<li id="menu_food_menu_sub10" style="display: none;"><a
				href="Tables.html"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;런치메뉴</span></a></li>
			<li id="menu_food_menu_sub11" style="display: none;"><a
				href="Tables.html"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;드링크</span></a></li>
			-->
			<!-- 1차메뉴 -->
			<li id="menu_food_takeout_menu"><a href="#"
				onclick="javascript:func_menu_ext('menu_food_takeout_menu',2);"><i
					class="fa fa-sitemap fa-fw">
				</i><span class="menu-title">포장메뉴</span></a></li>		
			<!-- 2차메뉴 -->
			<li id="menu_food_takeout_menu_sub1" <%if(!menuId.equals("takeout")){ %>style="display: none;"<%} %>><a href="/takeout/menuAdminister/otb_takeout_list.jsp"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;메뉴관리</span></a></li>
			<li id="menu_food_takeout_menu_sub2" <%if(!menuId.equals("takeout")){ %>style="display: none;"<%} %>><a href="/takeout/order/otb_order_list.jsp"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;주문현황</span></a></li>
			
			<!-- 1차메뉴 -->
			<!-- <li id="menu_food_takeout_menu"><a href="/takeout/otb_takeout_list.jsp"><i
					class="fa fa-edit fa-fw">
				</i><span class="menu-title">포장메뉴</span></a></li>
			 -->
			<!-- 1차메뉴 -->
			<li id="menu_store_info"><a href="/branch/branch_list.jsp"><i
					class="fa fa-th-list fa-fw">
				</i><span class="menu-title">매장안내</span></a></li>
			
			<!-- 1차메뉴 -->
			<li id="menu_promotion"><a href="#"
				onclick="javascript:func_menu_ext('menu_promotion',4);"><i
					class="fa fa-gift fa-fw">
				</i><span class="menu-title">프로모션</span></a></li>		
			<!-- 2차메뉴 -->
			<li id="menu_promotion_sub1" <%if(!menuId.equals("event")){ %>style="display: none;"<%} %>><a href="/event/main_event_list.jsp"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;온더보더 이벤트</span></a></li>
			<li id="menu_promotion_sub2" <%if(!menuId.equals("event")){ %>style="display: none;"<%} %>><a href="/event/beacon_event_list.jsp"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;이벤트(비콘팝업)</span></a></li>
			<li id="menu_promotion_sub3" <%if(!menuId.equals("event")){ %>style="display: none;"<%} %>><a href="/event/coupon_list.jsp"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;쿠폰관리</span></a></li>	
		<!-- 	<li id="menu_promotion_sub4" style="display: none;"><a href="/event/gift_card_list.jsp"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;상품권관리</span></a></li>	 -->
			<!-- 1차메뉴 -->
			<li id="menu_setting"><a href="#"
				onclick="javascript:func_menu_ext('menu_setting',3);"><i
					class="fa fa-slack fa-fw">
				</i><span class="menu-title">설정</span></a></li>		
			<!-- 2차메뉴 -->
			<li id="menu_setting_sub1" <%if(!menuId.equals("setting")){ %>style="display: none;"<%} %>><a href="/setting/admin_list.jsp"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;관리자 관리</span></a></li>
			<li id="menu_setting_sub2" <%if(!menuId.equals("setting")){ %>style="display: none;"<%} %>><a href="/setting/category_list.jsp"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;메뉴 카테고리 관리</span></a></li>		
			<li id="menu_setting_sub3" <%if(!menuId.equals("setting")){ %>style="display: none;"<%} %>><a href="/setting/beacon_list.jsp"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;비콘 관리</span></a></li>		
			
			<li id="menu_food_takeout_menu"><a href="/customer/voice_customer_list.jsp"><i
					class="fa fa-edit fa-fw">
				</i><span class="menu-title">고객의 소리</span></a></li>
				
			
			<li id="menu_statistics"><a href="#"
				onclick="javascript:func_menu_ext('menu_statistics',2);"><i
					class="fa fa-sitemap fa-fw">
				</i><span class="menu-title">통계</span></a></li>		
			<!-- 2차메뉴 -->
			<li id="menu_statistics_sub1" <%if(!menuId.equals("statis")){ %>style="display: none;"<%} %>><a href="/statistics/total/statistics_total_list.jsp"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;종합 통계</span></a></li>
			<li id="menu_statistics_sub2" <%if(!menuId.equals("statis")){ %>style="display: none;"<%} %>><a href="/statistics/menu/statistics_menu_list.jsp"><i>
				</i><span class="menu-title">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;메뉴별 통계</span></a></li>
			
				
			<li id="menu_promotion"><a href="/report/rptnormal/ddr/ddr.jsp">
			<i class="fa fa-gift fa-fw">
				</i><span class="menu-title">리포트</span></a></li>
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
