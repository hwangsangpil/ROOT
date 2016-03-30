<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="vo.OtbMenuVO"%>
<%@ page import="dao.OtbMenuDao"%>
<%@ page import="util.StringUtil"%>
<%@ page import="util.HashUtil" %>
<%@ page import="util.Constant" %>
<%@page import="java.net.URLDecoder"%> 

<%@page import="java.io.*"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.awt.Image"%>
<%@page import="com.sun.jimi.core.Jimi"%>
<%@page import="com.sun.jimi.core.JimiUtils"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	String uploadFolder = Constant.PHOTO_UPLOAD_URL_OTB_MENU;
	int size = Constant.UPLOAD_PHOTO_SIZE;
	String uploadRealPath = request.getRealPath(Constant.PHOTO_UPLOAD_URL) + "/";
	String uploadPath = uploadRealPath + uploadFolder;
	String uploadThumbPath = uploadRealPath + Constant.PHOTO_UPLOAD_URL_THUMBNAIL + uploadFolder;
	// --------------------------------
	
	File f = new File(uploadPath); 
	
	if(!f.exists()){
		f.mkdirs();
	}
	
	f = new File(uploadThumbPath); 
	
	if(!f.exists()){
		f.mkdirs();
	}
	
	int result = 0;
	int optionResult =0;
	OtbMenuDao dao = new OtbMenuDao();
	try{
		
		MultipartRequest mul = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
		
		int otbCateBig = Integer.parseInt(StringUtil.nchk(mul.getParameter("otbCateBig"), "0"));
		String otbMenuName = StringUtil.nchk(mul.getParameter("otbMenuName"),"");
		String otbMenuEName = StringUtil.nchk(mul.getParameter("otbMenuEName"),"");
		String otbMenuBasicName = StringUtil.nchk(mul.getParameter("otbMenuBasicName"),"");
		String otbMenuBasicEName = StringUtil.nchk(mul.getParameter("otbMenuBasicEName"),"");
		String otbMenuCode = StringUtil.nchk(mul.getParameter("otbMenuCode"),"");
		int otbMenuPrice = Integer.parseInt(StringUtil.nchk(mul.getParameter("otbMenuPrice"), "0"));
		String otbMenuContent = StringUtil.nchk(mul.getParameter("otbMenuContent"),"");
		int otbMenuNew = Integer.parseInt(StringUtil.nchk(mul.getParameter("otbMenuNew"), "0"));
		String otbOptionMenuNamea[] = mul.getParameterValues("otbOptionMenuNamea");
		String otbOptionMenuPricea[] = mul.getParameterValues("otbOptionMenuPricea");
		String otbOptionMenuCode[] = mul.getParameterValues("otbOptionMenuCode");
		int otbOptionPrice =0;
		int rptMenuGubun = 0;
		int rptMenuReslut = 0;
		if(otbMenuName.equals("")){
			otbMenuName = otbMenuBasicName;
		}
		if(otbMenuEName.equals("")){
			otbMenuEName = otbMenuBasicEName;
		}
		String otbMenuListImg = "";
		String otbMenuContentImg = "";
		
		f = mul.getFile("otbMenuListImg"); 
		if (f !=null){
			otbMenuListImg = StringUtil.nchk(f.getName(), "");
		}
		
		f = mul.getFile("otbMenuContentImg"); 
		if (f !=null){
			otbMenuContentImg = StringUtil.nchk(f.getName(), "");
		}
		//RPT_MENU 기초 테이블에 mcode 값이 있는지 파악
		rptMenuGubun = dao.selectRptMenuSeq(otbMenuCode);
		if(rptMenuGubun >0){
			//mcode 값이 있을경우 업데이트
			rptMenuReslut = dao.updateRptMenu(otbMenuCode, otbMenuName, otbMenuEName, otbMenuPrice);
		}else{
			//mcode 값이 없을경우
			rptMenuReslut = dao.insertRptMenu(otbMenuCode, otbMenuName, otbMenuEName, otbMenuPrice);
		}
		result = dao.insertOtbMenu(otbMenuCode, otbCateBig, otbMenuName, otbMenuListImg, otbMenuContentImg, otbMenuContent, otbMenuNew, otbMenuEName);
		if(result>0){
			if(otbOptionMenuNamea!=null){
				for(int i=0; i<otbOptionMenuNamea.length;i++){
					otbOptionPrice = Integer.parseInt(otbOptionMenuPricea[i]);
					rptMenuGubun = dao.selectRptMenuSeq(otbOptionMenuCode[i]);
					if(rptMenuGubun >0){
						rptMenuReslut = dao.updateRptMenu(otbOptionMenuCode[i], otbOptionMenuNamea[i], "", otbOptionPrice);
					}else{
						rptMenuReslut = dao.insertRptMenu(otbOptionMenuCode[i], otbOptionMenuNamea[i], "", otbOptionPrice);
					}
					optionResult = dao.insertOtbMenuOption(result, otbOptionMenuNamea[i],otbOptionPrice,otbOptionMenuCode[i]);
				}
			}else{
				optionResult = dao.insertOtbMenuOption(result, otbMenuName,otbMenuPrice,otbMenuCode);
			}
				
			
			
		}
		if(otbMenuListImg.length() != 0)
		{
			if(result > 0){
				Image image = JimiUtils.getThumbnail(uploadPath + otbMenuListImg, 200 , 200 , Jimi.IN_MEMORY);
        		Jimi.putImage(image, uploadThumbPath + otbMenuListImg);
			}
			
		}
		
		if(otbMenuContentImg.length() != 0)
		{
			if(result > 0){
				Image image = JimiUtils.getThumbnail(uploadPath + otbMenuContentImg, 200 , 200 , Jimi.IN_MEMORY);
        		Jimi.putImage(image, uploadThumbPath + otbMenuContentImg);
			}
			
		}
		
	}catch(IOException e){
		e.printStackTrace();
	}catch(Exception ex){
		ex.printStackTrace();
	}finally{
		dao.closeConn();
	}
	
	if(result > 0){ 
%>
		<script language=javascript>
			alert("등록되었습니다.");
			location.href = "/menu/otb_menu_list.jsp";
		</script>
<%
	}else{
%>
		<script language=javascript>
			alert("등록 실패했습니다."); 
			location.href = "/menu/otb_menu_list.jsp"; 
		</script>
<%
	}
%>

