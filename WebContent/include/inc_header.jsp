<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="util.StringUtil"%>
<%@page import="util.DateUtil"%>
<%@ page import="util.CookieBox"%> 
<%
CookieBox cookieBox_header = new CookieBox(request);
String role = cookieBox_header.getValue("ROLE");
%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="/images/icons/favicon.ico">
<link rel="apple-touch-icon" href="/images/icons/favicon.png">
<link rel="apple-touch-icon" sizes="72x72" href="/images/icons/favicon-72x72.png">
<link rel="apple-touch-icon" sizes="114x114" href="/images/icons/favicon-114x114.png">
<!--Loading bootstrap css-->
<link type="text/css" rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,400,300,700">
<link type="text/css" rel="stylesheet" href="http://fonts.googleapis.com/css?family=Oswald:400,700,300">
<link type="text/css" rel="stylesheet" href="/styles/jquery-ui-1.10.4.custom.min.css">
<link type="text/css" rel="stylesheet" href="/styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="/styles/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="/styles/animate.css">
<link type="text/css" rel="stylesheet" href="/styles/all.css">
<link type="text/css" rel="stylesheet" href="/styles/main.css">
<link type="text/css" rel="stylesheet" href="/styles/style-responsive.css">
<link type="text/css" rel="stylesheet" href="/styles/zabuto_calendar.min.css">
<link type="text/css" rel="stylesheet" href="/styles/pace.css">
<link type="text/css" rel="stylesheet" href="/styles/jquery.news-ticker.css">
<script src="/script/jquery-1.10.2.min.js"></script>
<script src="/script/jquery-migrate-1.2.1.min.js"></script>
<script src="/script/jquery-ui.js"></script>
<script src="/script/bootstrap.min.js"></script>
<script src="/script/bootstrap-hover-dropdown.js"></script>
<script src="/script/html5shiv.js"></script>
<script src="/script/respond.min.js"></script>
<script src="/script/jquery.metisMenu.js"></script>
<script src="/script/jquery.slimscroll.js"></script>
<script src="/script/jquery.cookie.js"></script>
<script src="/script/icheck.min.js"></script>
<script src="/script/custom.min.js"></script>
<script src="/script/jquery.news-ticker.js"></script>
<script src="/script/jquery.menu.js"></script>
<script src="/script/jquery.formchecker.js"></script>
<script src="/script/pace.min.js"></script>
<script src="/script/holder.js"></script>
<script src="/script/responsive-tabs.js"></script>
<script src="/script/jquery.flot.js"></script>
<script src="/script/jquery.flot.categories.js"></script>
<script src="/script/jquery.flot.pie.js"></script>
<script src="/script/jquery.flot.tooltip.js"></script>
<script src="/script/jquery.flot.resize.js"></script>
<script src="/script/jquery.flot.fillbetween.js"></script>
<script src="/script/jquery.flot.stack.js"></script>
<script src="/script/jquery.flot.spline.js"></script>
<script src="/script/zabuto_calendar.min.js"></script>
<!-- <script src="script/index.js"></script>  -->
<!--LOADING SCRIPTS FOR CHARTS-->
<!-- 
<script src="/script/highcharts.js"></script>
<script src="/script/data.js"></script>
<script src="/script/drilldown.js"></script>
<script src="/script/exporting.js"></script>
<script src="/script/highcharts-more.js"></script>
<script src="/script/charts-highchart-pie.js"></script>
<script src="/script/charts-highchart-more.js"></script>
-->
<!--CORE JAVASCRIPT-->
<script src="/script/main.js"></script>
<!-- skhero.kang 2015-06-16 펼침 메뉴 처리 코드 최적화 -->
<script type="text/javascript">
function func_menu_ext(menuId, subMenuCnt){
	if(document.getElementById(menuId + "_sub1").style.display == "none"){
		for ( var cnt = 1; cnt <= subMenuCnt; cnt++) {
			document.getElementById(menuId + "_sub" + cnt).style.display = "block";
		}
	}else{
		for ( var cnt = 1; cnt <= subMenuCnt; cnt++) {
			document.getElementById(menuId + "_sub" + cnt).style.display = "none";
		}
	}
}
var G_TIMER;
// setTimeout(location.reload(), 10000);
function pagestartbt(){
	alert("자동 리플레쉬가 켜졌습니다.");
	$.cookie('refresh', 'on');
	pagestart();
}

function pagestart() {
	if ($.cookie('refresh') == 'off') {
		return;
	}
	G_TIMER = setTimeout("pagereload()", 10000);
}

function pagereload() {
	location.reload();
}
 
function stop(){
	alert("자동 리플레쉬가 꺼졌습니다.");
	//window.stop();
	clearTimeout(G_TIMER);
}
 
function stopbt(){
	alert("자동 리플레쉬가 꺼졌습니다.");
	$.cookie('refresh', 'off');
	//window.stop();
	clearTimeout(G_TIMER);
}
  
/**
 * ajax 를 호출하기 위한 함수
 * @param $.ajax()를 호출하기 위한 인자값
 * @returns
 */
function gfnc_Ajax( options ) {
	var defaults = {
    	type: 'POST',
    	url: '',
    	data: {},
    	async: true,
    	cache: true,
    	headers: {}
    };
	var settings = $.extend({}, defaults, options);
	return $.ajax(settings);
}

</script>
