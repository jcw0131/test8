<%@ page import="db.beans.*,java.sql.*,java.util.*,java.io.*" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:useBean id="QueryBean" scope="page" class="db.beans.QueryBean"/>
<jsp:setProperty name="QueryBean" property="*" />
<%
	System.out.println("start update");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	
	request.setCharacterEncoding("UTF-8");
	
	String set_goods_name =request.getParameter("set_goods_name")==null ? "" : request.getParameter("set_goods_name").trim();
	String set_goods_code =request.getParameter("set_goods_code")==null ? "" : request.getParameter("set_goods_code").trim();
	String set_goods_num = request.getParameter("set_goods_num")==null ? "" : request.getParameter("set_goods_num").trim();
	String set_goods_contents =request.getParameter("set_goods_contents")==null ? "" : request.getParameter("set_goods_contents").trim();
	String set_goods_state =request.getParameter("set_goods_state")==null ? "" : request.getParameter("set_goods_state").trim();
	
	System.out.println("name: "+set_goods_name);
	System.out.println("code: "+set_goods_code);
	System.out.println("num: "+set_goods_num);
	System.out.println("contents: "+set_goods_contents);
	System.out.println("state: "+set_goods_state);
	
	QueryBean.getConnection();
	//ArrayList resArr =new ArrayList();
	
	int res =0;
	
	try
	{
		res=QueryBean.setGoodsInfo(set_goods_name,set_goods_code,set_goods_num,set_goods_contents,set_goods_state);
	}
	catch(Exception e){
		out.print(e.toString());
	}
	finally{
		QueryBean.closeConnection();
	}
	out.print("[");
	out.print("{");
	out.print("\"RESULT_OK\": \""+res+"\"");
	out.print(")");
	out.print("]");
	
	System.out.println("res: "+res);
%>