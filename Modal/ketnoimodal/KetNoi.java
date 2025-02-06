package ketnoimodal;

import java.sql.Connection;
import java.sql.DriverManager;

public class KetNoi {
	public Connection cn;
	public void ketNoi() throws Exception {
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		String url ="jdbc:sqlserver://ADMIN-PC\\MSSQLSERVER01:1433;databaseName=HighLightDB;user=sa; password=123456";
		cn = DriverManager.getConnection(url);
		System.out.println("Da ket noi");
	}
}
