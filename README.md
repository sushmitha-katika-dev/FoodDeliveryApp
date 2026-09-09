🍴 Online Food Delivery Application

A Java-based web application that enables users to browse restaurants, view menus, place food orders online,
and track delivery status. This project is designed with a focus on Java, JDBC/ORM, and MySQL (or any RDBMS), with additional support for frontend integration.

🚀 Features

🔑 User Authentication – Sign up / Login / Logout 
🍕 Browse Restaurants & Menus – View restaurants, categories, and food items 
🛒 Cart Management – Add, update, or remove items from cart 
💳 Order Placement & Payment – Place order with COD / online payment integration 
🚚 Order Tracking – Track order status (Pending → Accepted → Preparing → Out for Delivery → Delivered) 
👨‍🍳 Admin Dashboard – Manage restaurants, menu items, users, and order 
📊 Database Integration – Stores all user, order, and food data

🛠 Tech Stack

Backend: Java, JDBC / Hibernate (ORM),Servlets / Spring Boot 
Frontend: JSP / HTML / CSS / JavaScript / Bootstrap 
Database: MySQL 
Tools & Build: Maven / Gradle, Tomcat Server 
Version Control: Git & GitHub# FoodDeliveryApp

🎯 Future Enhancements

✅ Implement JWT-based authentication 
✅ Mobile app integration (Android/iOS) 
✅ Add live order tracking with Google Maps API 
✅ AI-based food recommendations

📂 Project Structure

OnlineFoodDelivery/
│-- src/
│   ├── controller/       # Servlets / Controllers
│   ├── dao/              # Database Access Layer
│   ├── model/            # Entity Classes
│   ├── service/          # Business Logic
│   └── util/             # DB Connection / Helpers
│
│-- WebContent/           # JSP pages, CSS, JS, Images
│-- database/food_delivery.sql   # SQL Schema & Sample Data
│-- pom.xml               # Maven Dependencies
│-- README.md
