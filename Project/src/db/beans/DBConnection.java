package db.beans;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	public static Connection getConnection() throws Exception//DB����
	{
		System.out.println("DB����õ�");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		return DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","madang","madang");
	}
	
	public static Connection getConnection(String ip,int port,String db,String user,String pw) throws Exception{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		return DriverManager.getConnection("jdbc:oracle:thin:@"+ip+":"+db,user,pw);
	}
}
