# 🍴 FoodZone — Online Food Delivery Platform

[![Java](https://img.shields.io/badge/Java-17%20LTS-orange.svg?logo=openjdk&logoColor=white)](https://www.oracle.com/java/)
[![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-10.0-blue.svg?logo=jakartaee&logoColor=white)](https://jakarta.ee/)
[![Apache Tomcat](https://img.shields.io/badge/Apache%20Tomcat-10.1-yellow.svg?logo=apachetomcat&logoColor=white)](https://tomcat.apache.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-blue.svg?logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED.svg?logo=docker&logoColor=white)](https://www.docker.com/)
[![Maven](https://img.shields.io/badge/Build-Maven%203.9-red.svg?logo=apachemaven&logoColor=white)](https://maven.apache.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

> A modern, enterprise-grade Java web application inspired by **Swiggy & Zomato**, enabling users to explore restaurants across multiple cuisines, manage unified multi-restaurant carts, apply promo discount coupons, track live order status with digital invoice receipts, reorder past meals with 1 click, manage customer profiles, and monitor platform operations via an interactive Merchant & Admin Portal.

---

## 🌟 Key Features

### 🍽️ 1. Multi-Cuisine Restaurant Discovery & Instant Live Search
- **Instant Client-Side Search**: Zero-lag real-time filtering as you type restaurant names, dishes, or areas with live match counter badges.
- **Quick Category Chips**: 1-click filtering for 🍗 *Biryani*, 🍕 *Pizza*, 🍔 *Burgers*, 🥟 *Chinese*, ☕ *South Indian*, 🍛 *North Indian*, 🍰 *Desserts*, and 🥗 *Healthy Bowls*.

### 🛒 2. Unified Multi-Restaurant Shopping Cart
- Order food items from **multiple restaurants in a single cart session** without losing previously selected dishes.
- Real-time quantity adjustments (`+` / `−`), dynamic grand total calculation, and multi-outlet checkout support.
- Floating bottom cart bar on restaurant menu pages.

### 🧾 3. Swiggy / Zomato Style Digital Billing & Live Tracking
- **Live Fulfillment Stepper**: Real-time visual progress tracker (`Confirmed` ➔ `Cooking & In Prep` ➔ `Out for Delivery` ➔ `Delivered`).
- **Itemized Invoice Receipt**: Grouped by restaurant with veg/non-veg indicators, item quantity badges, and subtotal breakdown.
- **Detailed Bill Summary**: Item subtotal, delivery fee (discounted to **FREE**), platform fee, 5% restaurant GST, applied coupon savings, and payment status badges (`PAID ONLINE (UPI / Card)`).
- **Print Receipt**: One-click printable receipt formatted for clean invoicing.
- **⭐ 5-Star Interactive Rating Widget**: Instant customer review submission with animated feedback.

### 🏷️ 4. Promo Codes & Discount Engine
- Apply discount coupon codes at Cart / Checkout with live calculations:
  | Coupon Code | Discount Offer | Minimum Order |
  | :--- | :--- | :--- |
  | **`WELCOME50`** | **50% OFF** (up to ₹100) | No minimum |
  | **`FOODZONE20`** | **20% OFF** (up to ₹150) | ₹200 |
  | **`FEAST100`** | **Flat ₹100 OFF** | ₹400 |
  | **`FREEDEL`** | **Free Delivery** | No minimum |

### 👤 5. User Profile & Saved Address Management
- Dedicated `/profile` page for customers to view account info, update phone numbers, save default delivery addresses for 1-click checkout, and update security passwords.

### 🏪 6. Operations & Merchant Admin Dashboard
- Dedicated `/admin-dashboard` portal with:
  - **Platform KPIs**: Total Gross Revenue (₹), Total Orders Received, Active Kitchen Partners, Registered Customers.
  - **Live Customer Orders Table**: View real-time orders with customer names, amounts, payment modes, and update order status (*Confirmed*, *In Prep*, *Out for Delivery*, *Delivered*, *Cancelled*).
  - **Partner Kitchens Overview**: List of registered restaurants, menus, and ratings.

### 📜 7. "My Orders" History & 1-Click Reorder
- Dedicated order history dashboard displaying past orders with timestamps, restaurant details, dishes, and delivery status.
- **1-Click "Reorder All"**: Instantly re-adds all dishes from any past order into the active shopping cart.

### 🔐 8. Authentication & 1-Click Demo Logins
- User registration, login authentication, remaining attempt warnings, and 1-click quick-fill test credentials.

---

## 🛠️ Technology Stack

| Layer | Technologies |
| :--- | :--- |
| **Backend** | Java 17, Jakarta Servlet API 6.0, Jakarta JSP 3.1, JSTL 3.0, JDBC |
| **Frontend** | JSP, HTML5, Vanilla CSS3, JavaScript, FontAwesome 6 Icons |
| **Database** | MySQL 8.0 (Relational schema with foreign keys and cascading deletes) |
| **Server / Runtime** | Apache Tomcat 10.1 (Embedded Tomcat runner + Standalone WAR support) |
| **DevOps / Containers** | Docker, Docker Compose (Multi-stage build) |
| **Build & Tooling** | Apache Maven 3.9, Git |

---

## 📂 Project Architecture & Directory Structure

```text
FoodDeliveryApp/
├── .gitignore
├── pom.xml                               # Root Maven Aggregator POM
├── Dockerfile                            # Multi-stage Docker Build for Tomcat 10.1
├── docker-compose.yml                    # 1-Click App + MySQL Orchestration
├── README.md
└── FoodApp/
    ├── pom.xml                           # Submodule POM (Jakarta EE 10, Tomcat Embed, MySQL)
    ├── database/
    │   └── food_delivery.sql             # Database schema & rich sample dataset
    └── src/main/
        ├── java/com/foodapp/
        │   ├── Main.java                 # Standalone Embedded Tomcat 10.1 Launcher
        │   ├── DAO/                      # Data Access Object Interfaces
        │   │   ├── UserDAO.java
        │   │   ├── RestaurantDAO.java
        │   │   ├── MenuDAO.java
        │   │   ├── OrderDAO.java
        │   │   └── OrderItemDAO.java
        │   ├── DAOImpl/                  # JDBC Implementations
        │   │   ├── UserDAOImpl.java
        │   │   ├── RestaurantDAOImpl.java
        │   │   ├── MenuDAOImpl.java
        │   │   ├── OrderDAOImpl.java
        │   │   └── OrderItemDAOImpl.java
        │   ├── models/                   # Entity & Business Models
        │   │   ├── User.java
        │   │   ├── Restaurant.java
        │   │   ├── Menu.java
        │   │   ├── Cart.java
        │   │   ├── CartItem.java
        │   │   ├── Order.java
        │   │   └── OrderItem.java
        │   ├── Servlets/                 # Web Controllers
        │   │   ├── HomeServlet.java      # GET /home
        │   │   ├── SearchServlet.java    # POST /SearchServlet
        │   │   ├── MenuServlet.java      # GET /menu
        │   │   ├── CartServlet.java      # POST /cart
        │   │   ├── ApplyCouponServlet.java # POST /apply-coupon
        │   │   ├── CheckoutServlet.java  # POST /checkout
        │   │   ├── OrderHistoryServlet.java # GET /my-orders
        │   │   ├── ReorderServlet.java   # POST /reorder
        │   │   ├── ProfileServlet.java   # GET/POST /profile
        │   │   ├── AdminDashboardServlet.java # GET/POST /admin-dashboard
        │   │   ├── LoginServlet.java     # POST /login
        │   │   ├── LogoutServlet.java    # GET /logout
        │   │   └── UserRegisterServlet.java # POST /user-resgistration
        │   └── util/
        │       └── DBConnection.java     # JDBC Connection Pool Manager
        └── webapp/                       # Web Views & UI
            ├── WEB-INF/
            │   └── web.xml               # Servlet & Welcome File Configurations
            ├── index.jsp                 # Landing redirection
            ├── login.jsp                 # Authentication & 1-click test credentials
            ├── userregistration.jsp      # Customer Registration Page
            ├── home.jsp                  # Restaurant discovery, live search & chips
            ├── menu.jsp                  # Restaurant menu with multi-cart & modal
            ├── cart.jsp                  # Shopping cart, promo coupons & total
            ├── checkout.jsp              # Address selection & payment gateway simulation
            ├── order_conformation.jsp    # Swiggy/Zomato live bill invoice & tracker
            ├── my_orders.jsp             # Past order history & 1-click reorder
            ├── profile.jsp               # User account & delivery address manager
            └── admin_dashboard.jsp       # Live operations, KPIs & order fulfillment
```

---

## 🚀 Quick Start Guide

### Prerequisites
- **Java JDK 17** or higher
- **Apache Maven 3.8+**
- **MySQL Server 8.0+** (or Docker)

---

### Method 1: Local Development (Embedded Tomcat)

#### 1. Database Setup
Log into your MySQL CLI or Workbench and run the initial setup script:
```sql
CREATE DATABASE IF NOT EXISTS food;
USE food;
SOURCE FoodApp/database/food_delivery.sql;
```

> Ensure your MySQL user credentials in [`DBConnection.java`](file:///c:/Users/katik/FoodDeliveryApp-main/FoodApp/src/main/java/com/foodapp/util/DBConnection.java) match your local instance (default: `root` / `root`).

#### 2. Build & Run
Run the embedded Tomcat server directly via Maven:
```powershell
cd FoodApp
mvn clean compile
mvn exec:java
```

The application will be accessible at:
👉 **`http://localhost:8080`**

---

### Method 2: Docker & Docker Compose (1-Click)

Run both MySQL and FoodZone in isolated containers:
```bash
docker-compose up --build
```

---

## 🔑 Available Test Credentials

| Account | Email | Password | Role |
| :--- | :--- | :--- | :--- |
| **Sushmitha** | `katikasushmitha7228@gmail.com` | `Sushmitha@06` | Customer |
| **Kavya** | `katika@gmail.com` | `Kavya@06` | Customer |
| **John (Demo)** | `john@example.com` | `password123` | Customer |
| **Admin** | `admin@foodzone.com` | `admin123` | Admin / Partner |

---

## 🗺️ Application Endpoints & Routes

| Route | Servlet / Page | Description |
| :--- | :--- | :--- |
| `/home` | `HomeServlet` ➔ `home.jsp` | Top restaurants, live search, and cuisine chips |
| `/menu?restaurantId={id}` | `MenuServlet` ➔ `menu.jsp` | Restaurant dishes with sticky multi-cart bar |
| `/cart.jsp` | `CartServlet` ➔ `cart.jsp` | Unified cart items, promo codes, and pricing |
| `/checkout.jsp` | `CheckoutServlet` | Delivery address confirmation & payment mode |
| `/order_conformation.jsp` | `order_conformation.jsp` | Live fulfillment stepper, digital bill & rating |
| `/my-orders` | `OrderHistoryServlet` | Order history & 1-click reorder |
| `/profile` | `ProfileServlet` ➔ `profile.jsp` | Account details & delivery address editor |
| `/admin-dashboard` | `AdminDashboardServlet` | Partner KPIs, revenue, and live order status updater |
| `/login.jsp` | `LoginServlet` | Sign In with demo quick-fill buttons |
| `/logout` | `LogoutServlet` | Session invalidation and secure logout |

---

## 📜 License
This project is open-source under the [MIT License](LICENSE).
