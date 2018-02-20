<%@ page import="db.beans.*,java.sql.*,java.util.*,java.io.*" %>
<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="QueryBean" scope="page" class="db.beans.QueryBean"/>
<jsp:setProperty name="QueryBean" property="*"/>
<%	
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	
	request.setCharacterEncoding("UTF-8");
	
	//String user_id=request.getParameter("user_id");
	String goods_name =request.getParameter("goods_name")==null ? "" : request.getParameter("goods_name").trim();
	
	QueryBean.getConnection(); //1. DB연결
	
	
	ArrayList resArr =new ArrayList(); //data를 담는 배열리스트
	
	try
	{
		resArr = QueryBean.getSearchInfo(goods_name);//2.질의 (QueryBean에서 결과 리턴)
	}
	catch(SQLException e)
	{
		out.print(e.toString());
	}
	finally
	{
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