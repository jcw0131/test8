<%@ page import="db.beans.*,java.util.*,java.sql.*,java.io.*" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:useBean id="QueryBean" scope="page" class="db.beans.QueryBean"/>
<jsp:setProperty property="*" name="QueryBean"/>
<%
	//캐쉬제거?
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	
	request.setCharacterEncoding("UTF-8");
	
	String goods_name = request.getParameter("goods_name") ==null? "gd" : request.getParameter("goods_name").trim();
	
	System.out.println("삭제할 ID: "+goods_name);
	
	QueryBean.getConnection();
	
// 	ArrayList resArr = new ArrayList();
	int res=0;
	
	try{
		res= QueryBean.deleteGoodsInfo(goods_name);
	}catch(Exception e){
		out.print(e.toString());
	}
	finally{
		QueryBean.closeConnection();
	}
	
	out.print("[");
	out.print("{");
	out.print("\"RESULT_OK\":\""+res+"\"");
	out.print("}");
	out.print("]");
	
	System.out.println("res: "+res);
%>