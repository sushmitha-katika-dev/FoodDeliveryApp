package com.foodapp.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	
	private static final String URL = System.getProperty("db.url", System.getenv().getOrDefault("DB_URL", "jdbc:mysql://localhost:3306/food?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"));
	private static final String USERNAME = System.getProperty("db.username", System.getenv().getOrDefault("DB_USERNAME", "root"));
	private static final String PASSWORD = System.getProperty("db.password", System.getenv().getOrDefault("DB_PASSWORD", "root"));
	
	public static final Connection getConnection(){
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			return DriverManager.getConnection(URL, USERNAME, PASSWORD);
		}
		catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}