<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.foodapp.models.Order, com.foodapp.models.OrderItem, com.foodapp.models.Menu, com.foodapp.models.User, com.foodapp.models.Restaurant, com.foodapp.DAO.RestaurantDAO, com.foodapp.DAOImpl.RestaurantDAOImpl, com.foodapp.DAO.OrderItemDAO, com.foodapp.DAOImpl.OrderItemDAOImpl, com.foodapp.DAO.MenuDAO, com.foodapp.DAOImpl.MenuDAOImpl, java.util.List, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Orders - FoodZone</title>
  <link type="image/png" rel="icon" href="images/food app header logo.png">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
      background-color: #f8f9fa;
      color: #333;
      padding-bottom: 60px;
    }

    .navbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: #ff6f61;
      padding: 12px 24px;
      color: white;
      border-radius: 0 0 12px 12px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.15);
      position: sticky;
      top: 0;
      z-index: 100;
    }
    
    .logo a {
      font-size: 24px;
      font-weight: bold;
      color: white;
      text-decoration: none;
    }

    .nav-buttons {
      display: flex;
      align-items: center;
      gap: 12px;
    }
    
    .nav-btn {
      display: flex;
      align-items: center;
      gap: 8px;
      background-color: white;
      color: #ff6f61;
      text-decoration: none;
      border: 2px solid #ff6f61;
      padding: 8px 16px;
      border-radius: 20px;
      font-weight: bold;
      font-size: 14px;
      transition: all 0.2s ease;
    }

    .nav-btn:hover {
      background-color: #ff6f61;
      color: white;
    }

    .container {
      max-width: 800px;
      margin: 25px auto;
      padding: 0 15px;
    }

    .page-title {
      font-size: 24px;
      color: #222;
      margin-bottom: 20px;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .order-card {
      background: white;
      border-radius: 16px;
      padding: 22px;
      margin-bottom: 20px;
      box-shadow: 0 4px 14px rgba(0, 0, 0, 0.06);
      border: 1px solid #eef0f2;
      transition: transform 0.2s;
    }

    .order-card-header {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      border-bottom: 1px solid #f0f0f0;
      padding-bottom: 14px;
      margin-bottom: 14px;
    }

    .rest-name {
      font-size: 18px;
      font-weight: 700;
      color: #222;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .order-meta-info {
      font-size: 13px;
      color: #777;
      margin-top: 3px;
    }

    .status-badge {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      background: #e8f5e9;
      color: #2e7d32;
      padding: 4px 12px;
      border-radius: 14px;
      font-size: 12px;
      font-weight: 700;
    }

    .items-list {
      margin-bottom: 16px;
    }

    .item-row {
      display: flex;
      justify-content: space-between;
      padding: 5px 0;
      font-size: 14px;
      color: #444;
    }

    .order-card-footer {
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-top: 1px solid #f0f0f0;
      padding-top: 14px;
      margin-top: 10px;
    }

    .order-total-amount {
      font-size: 16px;
      font-weight: 800;
      color: #1a1a1a;
    }

    .reorder-btn {
      background-color: #ff6f61;
      color: white;
      text-decoration: none;
      padding: 8px 18px;
      border-radius: 20px;
      font-size: 14px;
      font-weight: 700;
      display: inline-flex;
      align-items: center;
      gap: 6px;
      transition: background-color 0.2s;
    }

    .reorder-btn:hover {
      background-color: #e65b50;
    }

    .empty-orders {
      text-align: center;
      padding: 60px 20px;
      background: white;
      border-radius: 16px;
      border: 1px solid #eee;
    }

    .empty-orders i {
      font-size: 55px;
      color: #ddd;
      margin-bottom: 15px;
    }
  </style>
</head>
<body>

  <%
    User loggedInUser = (User) session.getAttribute("user");
    List<Order> userOrders = (List<Order>) request.getAttribute("userOrders");
    RestaurantDAO rdao = new RestaurantDAOImpl();
    OrderItemDAO oitemDao = new OrderItemDAOImpl();
    MenuDAO menuDao = new MenuDAOImpl();
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
  %>

  <nav class="navbar">
    <div class="logo"><a href="home">FoodZone 🍴</a></div>
    <div class="nav-buttons">
      <a class="nav-btn" href="home"><i class="fa-solid fa-utensils"></i> Browse Food</a>
      <a class="nav-btn" href="cart.jsp"><i class="fa-solid fa-cart-shopping"></i> Cart</a>
      <% if (loggedInUser != null) { %>
        <a class="nav-btn" href="profile"><i class="fa-solid fa-circle-user"></i> <%= loggedInUser.getName().split(" ")[0] %></a>
        <a class="nav-btn" href="logout" style="background:#fee2e2; border-color:#fca5a5; color:#dc2626;" title="Sign Out"><i class="fa-solid fa-power-off"></i></a>
      <% } else { %>
        <a class="nav-btn" href="login.jsp">Sign In</a>
      <% } %>
    </div>
  </nav>

  <div class="container">
    <h1 class="page-title"><i class="fa-solid fa-clock-rotate-left" style="color: #ff6f61;"></i> Past Orders & Reorder</h1>

    <% if (userOrders != null && !userOrders.isEmpty()) { 
         for (Order ord : userOrders) {
           Restaurant r = rdao.getRestaurantById(ord.getRestaurantid());
           String restName = (r != null) ? r.getName() : "Restaurant #" + ord.getRestaurantid();
           String formattedDate = (ord.getOrderdate() != null) ? sdf.format(ord.getOrderdate()) : "Recent";
           List<OrderItem> items = oitemDao.getOrderItemsByOrderId(ord.getOrderid());
    %>
      <div class="order-card">
        <div class="order-card-header">
          <div>
            <div class="rest-name">
              <i class="fa-solid fa-store" style="color: #ff6f61;"></i> <%= restName %>
            </div>
            <div class="order-meta-info">
              Order #FZ-<%= ord.getOrderid() %> &bull; <%= formattedDate %>
            </div>
          </div>
          <span class="status-badge">
            <i class="fa-solid fa-circle-check"></i> <%= ord.getStatus() %>
          </span>
        </div>

        <div class="items-list">
          <% if (items != null && !items.isEmpty()) { 
               for (OrderItem oi : items) {
                 Menu m = menuDao.getMenuById(oi.getMenuid());
                 String itemName = (m != null) ? m.getItemname() : "Dish #" + oi.getMenuid();
          %>
            <div class="item-row">
              <span><strong><%= oi.getQuantity() %>x</strong> <%= itemName %></span>
              <span>₹ <%= oi.getTotalamount() %></span>
            </div>
          <%   } 
             } else { %>
            <div class="item-row">
              <span>Order Summary</span>
              <span>₹ <%= ord.getTotalamount() %></span>
            </div>
          <% } %>
        </div>

        <div class="order-card-footer">
          <div>
            <span style="font-size: 13px; color: #777;">Paid via <%= ord.getPaymentmode() %></span>
            <div class="order-total-amount">Total: ₹ <%= ord.getTotalamount() %></div>
          </div>
          <a href="reorder?orderId=<%= ord.getOrderid() %>" class="reorder-btn">
            <i class="fa-solid fa-rotate-right"></i> Reorder All
          </a>
        </div>
      </div>
    <%   }
       } else { %>
      <div class="empty-orders">
        <i class="fa-solid fa-receipt"></i>
        <h3 style="margin-bottom: 8px; color: #444;">No past orders yet</h3>
        <p style="color: #777; margin-bottom: 20px;">Explore top restaurants and order your favorite meal!</p>
        <a href="home" class="reorder-btn" style="padding: 10px 24px;">Explore Restaurants</a>
      </div>
    <% } %>
  </div>

</body>
</html>
