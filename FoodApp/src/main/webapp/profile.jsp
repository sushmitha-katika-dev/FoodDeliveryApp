<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.foodapp.models.User, com.foodapp.models.Cart" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Profile - FoodZone</title>
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
      background: linear-gradient(135deg, #f8f9fa 0%, #f1f4f6 100%);
      color: #333;
      padding-bottom: 70px;
      min-height: 100vh;
    }

    .navbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: #ff6f61;
      padding: 12px 24px;
      color: white;
      border-radius: 0 0 12px 12px;
      position: sticky;
      top: 0;
      z-index: 100;
      box-shadow: 0 2px 8px rgba(0,0,0,0.15);
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
      gap: 6px;
      background-color: white;
      color: #ff6f61;
      text-decoration: none;
      border: 2px solid #ff6f61;
      padding: 7px 14px;
      border-radius: 20px;
      font-weight: bold;
      font-size: 13.5px;
      cursor: pointer;
      transition: all 0.2s ease;
    }

    .nav-btn:hover {
      background-color: #ff6f61;
      color: white;
    }

    .container {
      max-width: 900px;
      margin: 30px auto;
      padding: 0 20px;
    }

    .profile-grid {
      display: grid;
      grid-template-columns: 280px 1fr;
      gap: 25px;
    }

    @media (max-width: 768px) {
      .profile-grid {
        grid-template-columns: 1fr;
      }
    }

    .sidebar-card {
      background: white;
      border-radius: 16px;
      padding: 25px 20px;
      box-shadow: 0 4px 16px rgba(0,0,0,0.06);
      text-align: center;
      height: fit-content;
    }

    .avatar-circle {
      width: 90px;
      height: 90px;
      border-radius: 50%;
      background: linear-gradient(135deg, #ff6f61, #ff9a8b);
      color: white;
      font-size: 36px;
      font-weight: bold;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 15px;
      box-shadow: 0 4px 12px rgba(255, 111, 97, 0.35);
    }

    .user-name {
      font-size: 20px;
      font-weight: 700;
      color: #222;
      margin-bottom: 4px;
    }

    .user-email {
      font-size: 13.5px;
      color: #777;
      margin-bottom: 12px;
      word-break: break-all;
    }

    .role-badge {
      display: inline-block;
      background: #eef8f2;
      color: #2e7d32;
      padding: 4px 12px;
      border-radius: 12px;
      font-size: 12px;
      font-weight: 700;
      text-transform: uppercase;
      margin-bottom: 20px;
    }

    .sidebar-nav {
      list-style: none;
      text-align: left;
      border-top: 1px solid #f0f0f0;
      padding-top: 15px;
    }

    .sidebar-nav li {
      margin-bottom: 8px;
    }

    .sidebar-nav a {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 10px 14px;
      color: #555;
      text-decoration: none;
      border-radius: 10px;
      font-size: 14px;
      font-weight: 600;
      transition: all 0.2s;
    }

    .sidebar-nav a.active, .sidebar-nav a:hover {
      background: #fff0ed;
      color: #ff6f61;
    }

    .main-card {
      background: white;
      border-radius: 16px;
      padding: 30px;
      box-shadow: 0 4px 16px rgba(0,0,0,0.06);
    }

    .section-title {
      font-size: 20px;
      font-weight: 700;
      color: #222;
      margin-bottom: 20px;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      font-size: 13.5px;
      font-weight: 600;
      color: #444;
      margin-bottom: 6px;
    }

    .form-control {
      width: 100%;
      padding: 12px 14px;
      border: 1px solid #ddd;
      border-radius: 10px;
      font-size: 14px;
      transition: border-color 0.2s;
    }

    .form-control:focus {
      border-color: #ff6f61;
      outline: none;
      box-shadow: 0 0 0 3px rgba(255, 111, 97, 0.15);
    }

    .form-control:disabled, .form-control[readonly] {
      background-color: #f8f9fa;
      cursor: not-allowed;
      color: #777;
    }

    .save-btn {
      background: #ff6f61;
      color: white;
      border: none;
      padding: 12px 28px;
      border-radius: 12px;
      font-size: 15px;
      font-weight: bold;
      cursor: pointer;
      display: inline-flex;
      align-items: center;
      gap: 8px;
      transition: background 0.2s ease;
    }

    .save-btn:hover {
      background: #e65b50;
    }

    .alert-success {
      background: #e8f5e9;
      color: #2e7d32;
      border: 1px solid #c8e6c9;
      padding: 12px 16px;
      border-radius: 10px;
      font-size: 14px;
      font-weight: 600;
      margin-bottom: 20px;
      display: flex;
      align-items: center;
      gap: 8px;
    }
  </style>
</head>
<body>

  <%
    User user = (User) request.getAttribute("userProfile");
    if (user == null) {
        user = (User) session.getAttribute("user");
    }
    String successMsg = (String) request.getAttribute("successMessage");
    String initials = "U";
    if (user != null && user.getName() != null && !user.getName().trim().isEmpty()) {
        initials = user.getName().trim().substring(0, 1).toUpperCase();
    }
  %>

  <nav class="navbar">
    <div class="logo"><a href="home">FoodZone 🍴</a></div>
    <div class="nav-buttons">
      <a class="nav-btn" href="home"><i class="fa-solid fa-house"></i> Home</a>
      <a class="nav-btn" href="my-orders"><i class="fa-solid fa-receipt"></i> My Orders</a>
      <a class="nav-btn" href="cart.jsp"><i class="fa-solid fa-cart-shopping"></i> Cart</a>
      <a class="nav-btn" href="logout" style="background:#fee2e2; border-color:#ef4444; color:#dc2626;"><i class="fa-solid fa-arrow-right-from-bracket"></i> Logout</a>
    </div>
  </nav>

  <div class="container">
    <% if (successMsg != null) { %>
      <div class="alert-success">
        <i class="fa-solid fa-circle-check"></i> <%= successMsg %>
      </div>
    <% } %>

    <div class="profile-grid">
      <!-- Sidebar -->
      <div class="sidebar-card">
        <div class="avatar-circle"><%= initials %></div>
        <div class="user-name"><%= user != null ? user.getName() : "Guest" %></div>
        <div class="user-email"><%= user != null ? user.getEmail() : "" %></div>
        <div class="role-badge"><%= user != null && user.getRole() != null ? user.getRole() : "Customer" %></div>

        <ul class="sidebar-nav">
          <li><a href="profile" class="active"><i class="fa-solid fa-user-pen"></i> Edit Profile</a></li>
          <li><a href="my-orders"><i class="fa-solid fa-clock-rotate-left"></i> Order History</a></li>
          <% if (user != null && "Admin".equalsIgnoreCase(user.getRole())) { %>
            <li><a href="admin-dashboard" style="color: #6366f1;"><i class="fa-solid fa-chart-line"></i> Admin Portal</a></li>
          <% } %>
          <li><a href="home"><i class="fa-solid fa-utensils"></i> Explore Food</a></li>
          <li><a href="logout" style="color:#dc2626;"><i class="fa-solid fa-power-off"></i> Sign Out</a></li>
        </ul>
      </div>

      <!-- Main Form -->
      <div class="main-card">
        <h2 class="section-title"><i class="fa-solid fa-user-gear" style="color: #ff6f61;"></i> Account & Delivery Details</h2>
        
        <form action="update-profile" method="POST">
          <div class="form-group">
            <label><i class="fa-solid fa-user"></i> Full Name</label>
            <input type="text" name="name" class="form-control" value="<%= user != null && user.getName() != null ? user.getName() : "" %>" required>
          </div>

          <div class="form-group">
            <label><i class="fa-solid fa-envelope"></i> Email Address (Account ID)</label>
            <input type="email" class="form-control" value="<%= user != null && user.getEmail() != null ? user.getEmail() : "" %>" readonly>
            <small style="color: #888; font-size: 12px; margin-top: 4px; display: block;">Email ID cannot be changed as it is tied to your order history.</small>
          </div>

          <div class="form-group">
            <label><i class="fa-solid fa-phone"></i> Mobile Phone Number</label>
            <input type="text" name="phonenumber" class="form-control" value="<%= user != null && user.getPhonenumber() != null ? user.getPhonenumber() : "" %>" placeholder="+91 9876543210" required>
          </div>

          <div class="form-group">
            <label><i class="fa-solid fa-location-dot"></i> Default Delivery Address</label>
            <textarea name="address" class="form-control" rows="3" placeholder="e.g. Flat 402, Sunshine Heights, MG Road, Bangalore" required><%= user != null && user.getAddress() != null ? user.getAddress() : "" %></textarea>
            <small style="color: #888; font-size: 12px; margin-top: 4px; display: block;">This address will be auto-selected during 1-click checkout.</small>
          </div>

          <div class="form-group" style="margin-top: 25px; padding-top: 20px; border-top: 1px solid #eee;">
            <label><i class="fa-solid fa-lock"></i> Change Password (optional)</label>
            <input type="password" name="newPassword" class="form-control" placeholder="Enter new password to change">
          </div>

          <button type="submit" class="save-btn">
            <i class="fa-solid fa-floppy-disk"></i> Save Changes
          </button>
        </form>
      </div>
    </div>
  </div>

</body>
</html>
