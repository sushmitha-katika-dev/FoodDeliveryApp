package com.foodapp;

import org.apache.catalina.Context;
import org.apache.catalina.WebResourceRoot;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.webresources.DirResourceSet;
import org.apache.catalina.webresources.StandardRoot;

import java.io.File;

public class Main {
    public static void main(String[] args) throws Exception {
        int port = 8080;
        String portEnv = System.getenv("PORT");
        if (portEnv != null && !portEnv.trim().isEmpty()) {
            try {
                port = Integer.parseInt(portEnv.trim());
            } catch (NumberFormatException ignored) {}
        }
        String portProp = System.getProperty("server.port");
        if (portProp != null && !portProp.trim().isEmpty()) {
            try {
                port = Integer.parseInt(portProp.trim());
            } catch (NumberFormatException ignored) {}
        }

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(port);
        
        File baseDir = new File("temp_tomcat");
        if (!baseDir.exists()) {
            baseDir.mkdirs();
        }
        tomcat.setBaseDir(baseDir.getAbsolutePath());
        tomcat.getConnector(); // Initialize default HTTP connector

        File webappDir = new File("src/main/webapp");
        if (!webappDir.exists()) {
            webappDir = new File("FoodApp/src/main/webapp");
        }

        Context ctx = tomcat.addWebapp("", webappDir.getAbsolutePath());
        ctx.setParentClassLoader(Main.class.getClassLoader());

        File classesDir = new File("target/classes");
        if (!classesDir.exists()) {
            classesDir = new File("FoodApp/target/classes");
        }
        if (!classesDir.exists()) {
            classesDir = new File("build/classes");
        }
        if (!classesDir.exists()) {
            classesDir = new File("FoodApp/build/classes");
        }

        WebResourceRoot resources = new StandardRoot(ctx);
        if (classesDir.exists()) {
            resources.addPreResources(new DirResourceSet(resources, "/WEB-INF/classes",
                    classesDir.getAbsolutePath(), "/"));
        }
        ctx.setResources(resources);

        System.out.println("==================================================");
        System.out.println(" FoodDeliveryApp (FoodZone) is running!");
        System.out.println(" Access URL: http://localhost:" + port);
        System.out.println("==================================================");

        tomcat.start();
        tomcat.getServer().await();
    }
}
