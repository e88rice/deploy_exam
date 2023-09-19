package com.example.mvc.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	
	public static Connection getConnection() throws ClassNotFoundException, SQLException {
		Connection connection = null;
		
		String url 				= "jdbc:mariadb://localhost:3306/servlet_sample_market";
		String user 			= "root";
		String password			= "2115";
		
		Class.forName("org.mariadb.jdbc.Driver");
		connection = DriverManager.getConnection(url, user, password); 
		
		return connection;
	}
}
