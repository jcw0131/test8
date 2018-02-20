<%@ page import="db.beans.*,java.sql.*,java.util.*,java.io.*" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:useBean id="QueryBean" scope="page" class="db.beans.QueryBean"/>
<jsp:setProperty name="QueryBean" property="*" />
<%
	System.out.println("start insert");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	
	request.setCharacterEncoding("UTF-8");
	
	String set_file_name =request.getParameter("set_file_name")==null ? "" : request.getParameter("set_file_name").trim();

	
	System.out.println("name: "+set_file_name);
	
	QueryBean.getConnection();
	//ArrayList resArr =new ArrayList();
	
	ArrayList resArr =new ArrayList();
	
	try
	{
		resArr=QueryBean.getfileInfo(set_file_name);
	}
	catch(Exception e){
		out.print(e.toString());
	}
	finally{
		QueryBean.closeConnection();
	}
	out.println("{");
	out.println("\"datas\":[");
	
	if(resArr.size()==0){
		out.println("]");
		out.println("}");
	}
	else
	{
		out.print("{");
		out.print("\"NAME\": \"" + (String)resArr.get(0)+"\", ");
		out.print("\"CODE\": \"" + (String)resArr.get(1)+"\", ");
		out.print("\"NUM\": \"" + (String)resArr.get(2)+"\", ");
		out.print("\"PDATE\": \"" + (String)resArr.get(3)+"\", ");
		out.print("\"CONTENTS\": \"" + (String)resArr.get(4)+"\", ");
		out.print("\"STATE\": \"" + (String)resArr.get(5)+"\" ");
		out.print("} ");
		
		for(int i=6; i<resArr.size();i+=6)
		{
			out.print(",");
			out.print("{");
			out.print("		\"NAME\": \"" + (String)resArr.get(i)+"\", ");
			out.print("		\"CODE\": \"" + (String)resArr.get(i+1)+"\", ");
			out.print("		\"NUM\": \"" + (String)resArr.get(i+2)+"\", ");
			out.print("		\"PDATE\": \"" + (String)resArr.get(i+3)+"\", ");
			out.print("		\"CONTENTS\": \"" + (String)resArr.get(i+4)+"\", ");	
			out.print("		\"STATE\": \"" + (String)resArr.get(i+5)+"\" ");
			out.print("} ");
		}
		out.println("]");
		out.println("}");
	}
%>