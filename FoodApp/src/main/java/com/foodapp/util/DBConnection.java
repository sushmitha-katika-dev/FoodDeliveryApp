package com.foodapp.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static String getEnv(String name, String def) {
        String val = System.getenv(name);
        if (val == null || val.trim().isEmpty()) {
            val = System.getProperty(name, def);
        }
        return val != null ? val.trim() : def;
    }

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String directUrl = getEnv("DB_URL", null);
            String host = getEnv("DB_HOST", "localhost");
            String port = getEnv("DB_PORT", "3306");
            String dbName = getEnv("DB_NAME", "food");
            String username = getEnv("DB_USERNAME", getEnv("DB_USER", "root"));
            String password = getEnv("DB_PASSWORD", "root");

            String url;
            if (directUrl != null && !directUrl.isEmpty()) {
                url = directUrl;
            } else {
                boolean isRemote = !host.equalsIgnoreCase("localhost") && !host.equals("127.0.0.1") && !host.equals("mysql");
                if (isRemote) {
                    url = "jdbc:mysql://" + host + ":" + port + "/" + dbName + "?useSSL=true&requireSSL=true&verifyServerCertificate=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                } else {
                    url = "jdbc:mysql://" + host + ":" + port + "/" + dbName + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                }
            }

            return DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}