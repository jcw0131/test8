package db.beans;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.eclipse.jdt.internal.compiler.parser.ParserBasicInformation;

public class QueryBean {
	Connection conn;
	Statement stmt;
	ResultSet rs;
	
	public QueryBean() {
		conn = null;//���� ��ü
		stmt = null;//���� ��ü
		rs = null;//��� ��ü
	}
	
	public void getConnection() {
		try {//1.db����
			conn =DBConnection.getConnection();
		}
		catch (Exception e1) {
			e1.printStackTrace();
		}
		
		try {//2.����
			stmt =conn.createStatement();			
		}
		
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void closeConnection() {
		if (stmt != null) {
			try {
				stmt.close();
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public ArrayList getSearchInfo() throws Exception{
		StringBuffer sb = new StringBuffer();
		String csvName = "C:\\Users\\USER\\Desktop\\classfile\\MONGODB"; 
		
		System.out.println("getSearchInfo Start");
		sb.append(" SELECT ");
		sb.append("    NAME, CODE, NUM, PDATE, CONTENTS, STATE ");
		sb.append(" FROM ");
		sb.append("    GOODS ");//where user_id like"%user_id%"
		sb.append(" ORDER BY  ");
		sb.append("    NAME  ASC");
		
		rs = stmt.executeQuery(sb.toString());//2.���ǹ� ����
		
		File file = new File("test.csv"); 
        FileWriter fw = new FileWriter(file, true); 
        String a = null;
        
		ArrayList res =new ArrayList();
		while (rs.next()) {
			res.add(rs.getString(1));
			res.add(rs.getString(2));
			res.add(rs.getString(3));
			res.add(rs.getString(4));
			res.add(rs.getString(5));
			res.add(rs.getString(6));
			
			a = rs.getString(1) +","+ rs.getString(2) + rs.getString(3) +","+rs.getString(4) +","+rs.getString(5) +","+rs.getString(6) +"\n";
			
		}
		
		fw.write(a);
		
		if(fw != null) 
	         try { 
	            fw.close(); 
	            } catch (IOException e) { 
	            e.printStackTrace(); 
	         } 
		System.out.println(sb.toString());
		return res;
	}
	public ArrayList getSearchInfo(String name) throws Exception{
		StringBuffer sb = new StringBuffer();
//		String csvName = "C:\\Users\\USER\\Desktop\\classfile\\MONGODB\\test.csv";
		
//		File file = new File(csvName); 
//        FileWriter fw = new FileWriter(file, true); 
//        String a = null;
        
		sb.append(" SELECT ");
		sb.append("    NAME, CODE, NUM, PDATE, CONTENTS, STATE ");
		sb.append(" FROM ");
		sb.append("    GOODS ");
		sb.append(" WHERE NAME LIKE '%"+name+"%'");
		sb.append(" ORDER BY  ");
		sb.append("    NAME ");
		sb.append("  ASC ");
		
		rs = stmt.executeQuery(sb.toString());//2.���ǹ� ����
		
		ArrayList res =new ArrayList();
		while (rs.next()) {
			res.add(rs.getString(1));
			res.add(rs.getString(2));
			res.add(rs.getString(3));
			res.add(rs.getString(4));
			res.add(rs.getString(5));
			res.add(rs.getString(6));
			
//			a = rs.getString(1) +","+ rs.getString(2) +","+ rs.getString(3) +","+rs.getString(4) +","+rs.getString(5) +","+rs.getString(6) +"\n";
//			fw.write(a);
		}

//		System.out.println(a);
//		if(fw != null) 
//	         try {
//	            fw.close();
//	            System.out.println("close");
//	            } catch (IOException e) { 
//	            e.printStackTrace(); 
//	         }
		
		System.out.println(sb.toString());
		return res;
	}
	
	public int setGoodsInfo(String name,String code, String num,String contents,String state) 
	{
		int result =0;
		
		StringBuffer sb=new StringBuffer();
		PreparedStatement pstmt= null;
		//int getnum = Integer.parseInt(num);
		
		sb.append(" INSERT INTO");
		sb.append("   GOODS (NAME, CODE, NUM, PDATE, CONTENTS, STATE) ");
		sb.append(" VALUES ");
//		sb.append("    (?,?,?,?, sysdate)");���2
		sb.append("    ('"+ name +"', '"+ code +"', "+ num +", sysdate ,'"+contents+"', '"+state+"')");
		
		
		System.out.println(sb.toString());
		
		try {
			pstmt = conn.prepareStatement(sb.toString());			
//			pstmt.clearParameters();���2
//			pstmt.setString(1, name);
//			pstmt.setString(2, code);
//			pstmt.setString(3, num);
//			pstmt.setString(4, sysdate);
//			pstmt.setString(5, contents);
//			pstmt.setString(6, state);
			
			result = pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(pstmt != null) {
					pstmt.close();
				}
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public int deleteGoodsInfo(String name) throws Exception
	{
		int result =0;
		
		PreparedStatement pstmt = null;
		
		StringBuffer sb = new StringBuffer();
		
		sb.append(" DELETE ");
		sb.append("  FROM ");
		sb.append("  GOODS ");
		sb.append("  WHERE ");
		sb.append("   NAME='"+name+"'");
		System.out.println(sb);
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
//			pstmt.clearParameters();
//			pstmt.setString(1, name);
			
			result =pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
			
		}
		
		finally 
		{
			try {
				if(pstmt != null) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		return result;
		
	}
	public ArrayList getfileInfo(String name) throws Exception{
		StringBuffer sb = new StringBuffer();
		String csvName = "C:\\file\\"+name+".csv"; 
		
		System.out.println("getfileInfo Start");
		sb.append(" SELECT ");
		sb.append("    NAME, CODE, NUM, PDATE, CONTENTS, STATE ");
		sb.append(" FROM ");
		sb.append("    GOODS ");//where user_id like"%user_id%"
		sb.append(" ORDER BY  ");
		sb.append("    NAME  ASC");
		
		rs = stmt.executeQuery(sb.toString());//2.���ǹ� ����
		
		File file = new File(csvName); 
        FileWriter fw = new FileWriter(file, true); 
        String a = null;
        
		ArrayList res =new ArrayList();
		while (rs.next()) {
			res.add(rs.getString(1));
			res.add(rs.getString(2));
			res.add(rs.getString(3));
			res.add(rs.getString(4));
			res.add(rs.getString(5));
			res.add(rs.getString(6));
			
			a = rs.getString(1) +","+ rs.getString(2) + rs.getString(3) +","+rs.getString(4) +","+rs.getString(5) +","+rs.getString(6) +"\n";
			
		}
		
		fw.write(a);
		
		if(fw != null) 
	         try { 
	            fw.close(); 
	            } catch (IOException e) { 
	            e.printStackTrace(); 
	         } 
		System.out.println(sb.toString());
		return res;
	}
}
