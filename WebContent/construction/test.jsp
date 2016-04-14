<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="java.util.ArrayList"%>
<%@page import="util.StringUtil"%>
<%@page import="util.DateUtil"%>
<% 
request.setCharacterEncoding("UTF-8");

String[] checked=request.getParameterValues("check");

if(checked != null)
{
	for(int i=0; i<checked.length;i++)
	{
		System.out.println("checked[]:     "+checked[i]);
	}
}



/* int i=checked.length;
if(i>=0)
{
System.out.println("checked[]:     "+checked);
} */
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function fnc_search(){		
		document.frm.submit();
	}
</script>
</head>
<body>
<form name="frm" action="/construction/test.jsp" method="post">
						
													<table class="table table-hover">
														<thead>
															<tr>
																<th style="text-align:center; width: 5%">NO</th>
																<td style="text-align:center; width: 5%">공고명<input type="checkbox" id="check" name="check" value="1" checked/></td>
																<td style="text-align:center; width: 5%">계약방법<input type="checkbox" id="check" name="check" value="2"/></td>
																<td style="text-align:center; width: 5%">지역제한<input type="checkbox" id="check" name="check" value="3"/></td>
																<td style="text-align:center; width: 5%">예가변동폭<input type="checkbox" id="check" name="check" value="4"/></td>
																<td style="text-align:center; width: 5%">투찰하한율<input type="checkbox" id="check" name="check" value="5"/></td>
																<td style="text-align:center; width: 5%">개찰일<input type="checkbox" id="check" name="check" value="6"/></td>
																<td style="text-align:center; width: 5%">공고기관<input type="checkbox" id="check" name="check" value="7"/></td>
																<td style="text-align:center; width: 5%">사정률<input type="checkbox" id="check" name="check" value="8"/></td>
																<td style="text-align:center; width: 5%">입력날짜</td>
																<td style="text-align:center; width: 5%">수정날짜</td>
																<td style="text-align:center; width: 5%">수정</td>
																<td style="text-align:center; width: 5%">삭제</td>
																
															</tr>
															<tr>
																<td><button type="button" class="btn btn-default" onclick="javascript:fnc_search()">검색</button></td>
															</tr>
														</thead>
														
													</table>
												
					</form>
</body>
</html>