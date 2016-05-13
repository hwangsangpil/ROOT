<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="board.model.BusinessDTO"%>
<%@ page import="board.model.BusinessDAO"%>
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
	//OtbMenuDao dao = new OtbMenuDao();
	BusinessDAO dao = new BusinessDAO();
	try{
		
		MultipartRequest mul = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
		
		int constNum = Integer.parseInt(StringUtil.nchk(mul.getParameter("constNum"),"0"));
		String busiName = StringUtil.nchk(mul.getParameter("busiName"),"");
		String busiOpening = StringUtil.nchk(mul.getParameter("bisiOpening"),"");
		String busiPrice = StringUtil.nchk(mul.getParameter("busiPrice"),"");
		String busiPercent = StringUtil.nchk(mul.getParameter("busiPercent"),"");
		String busiWay = StringUtil.nchk(mul.getParameter("busiWay"),"");
		String busiArea = StringUtil.nchk(mul.getParameter("busiArea"),"");
		
		String otbMenuListImg = "";
		String otbMenuContentImg = "";
		
		String constName = dao.selectConstructionName(constNum);
		System.out.println("out constName=    "+constName);	
		result = dao.insertBusinessAdd(constNum, constName, busiName, busiOpening, busiPrice, busiPercent, busiWay, busiArea);
		if(result>0){
			 /* if(otbOptionMenuNamea!=null){
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
			} */
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
			location.href = "/business/businessList.jsp";
		</script>
<%
	}else{
%>
		<script language=javascript>
			alert("등록에 실패하였습니다.\n이미 해당 공사에 참여한 업체명 입니다"); 
			location.href = "/business/businessList.jsp"; 
		</script>
<%
	}
%>

