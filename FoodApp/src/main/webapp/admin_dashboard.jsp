<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map, com.foodapp.models.Order, com.foodapp.models.Restaurant, com.foodapp.models.Menu, com.foodapp.models.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin & Partner Portal - FoodZone</title>
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
      background-color: #f4f6f9;
      color: #333;
      padding-bottom: 60px;
    }

    .navbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: #1e293b;
      padding: 14px 28px;
      color: white;
      box-shadow: 0 2px 10px rgba(0,0,0,0.15);
    }

    .logo a {
      font-size: 22px;
      font-weight: 800;
      color: #ff6f61;
      text-decoration: none;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .admin-badge {
      background: #475569;
      color: #f8fafc;
      font-size: 11px;
      padding: 3px 8px;
      border-radius: 6px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
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
      background-color: #334155;
      color: white;
      text-decoration: none;
      padding: 7px 14px;
      border-radius: 8px;
      font-weight: 600;
      font-size: 13.5px;
      transition: all 0.2s ease;
    }

    .nav-btn:hover {
      background-color: #475569;
    }

    .container {
      max-width: 1300px;
      margin: 25px auto;
      padding: 0 20px;
    }

    .page-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 25px;
      flex-wrap: wrap;
      gap: 15px;
    }

    .page-title h1 {
      font-size: 26px;
      color: #0f172a;
      font-weight: 800;
    }

    .page-title p {
      font-size: 14px;
      color: #64748b;
      margin-top: 4px;
    }

    /* Stats Grid */
    .stats-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
      gap: 20px;
      margin-bottom: 30px;
    }

    .stat-card {
      background: white;
      border-radius: 14px;
      padding: 22px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.04);
      display: flex;
      align-items: center;
      gap: 18px;
      border: 1px solid #e2e8f0;
    }

    .stat-icon {
      width: 54px;
      height: 54px;
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 24px;
    }

    .icon-revenue { background: #dcfce7; color: #16a34a; }
    .icon-orders { background: #e0f2fe; color: #0284c7; }
    .icon-restaurants { background: #ffedd5; color: #ea580c; }
    .icon-users { background: #ede9fe; color: #7c3aed; }

    .stat-info h3 {
      font-size: 24px;
      font-weight: 800;
      color: #0f172a;
    }

    .stat-info span {
      font-size: 13px;
      color: #64748b;
      font-weight: 600;
    }

    /* Main Section Card */
    .section-card {
      background: white;
      border-radius: 14px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.04);
      border: 1px solid #e2e8f0;
      overflow: hidden;
      margin-bottom: 30px;
    }

    .card-header {
      padding: 18px 24px;
      border-bottom: 1px solid #e2e8f0;
      display: flex;
      justify-content: space-between;
      align-items: center;
      background: #fafafa;
    }

    .card-header h2 {
      font-size: 17px;
      font-weight: 700;
      color: #1e293b;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .table-responsive {
      overflow-x: auto;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      text-align: left;
      font-size: 13.5px;
    }

    th {
      background: #f8fafc;
      padding: 12px 18px;
      font-weight: 700;
      color: #475569;
      border-bottom: 1px solid #e2e8f0;
      text-transform: uppercase;
      font-size: 11.5px;
      letter-spacing: 0.5px;
    }

    td {
      padding: 14px 18px;
      border-bottom: 1px solid #f1f5f9;
      color: #334155;
      vertical-align: middle;
    }

    tr:hover td {
      background-color: #f8fafc;
    }

    .status-badge {
      display: inline-block;
      padding: 4px 10px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: 700;
    }

    .status-delivered { background: #dcfce7; color: #15803d; }
    .status-confirmed { background: #e0e7ff; color: #4338ca; }
    .status-prep { background: #fef3c7; color: #b45309; }
    .status-out { background: #ffedd5; color: #c2410c; }
    .status-cancelled { background: #fee2e2; color: #b91c1c; }

    .status-select {
      padding: 6px 10px;
      border-radius: 6px;
      border: 1px solid #cbd5e1;
      font-size: 13px;
      background: white;
    }

    .update-btn {
      padding: 6px 12px;
      background: #1e293b;
      color: white;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-size: 12px;
      font-weight: 600;
      transition: background 0.2s;
    }

    .update-btn:hover {
      background: #ff6f61;
    }
  </style>
</head>
<body>

  <%
    List<Order> allOrders = (List<Order>) request.getAttribute("allOrders");
    List<Restaurant> allRestaurants = (List<Restaurant>) request.getAttribute("allRestaurants");
    List<Menu> allMenuItems = (List<Menu>) request.getAttribute("allMenuItems");
    List<User> allUsers = (List<User>) request.getAttribute("allUsers");
    Map<Integer, String> restaurantNames = (Map<Integer, String>) request.getAttribute("restaurantNames");
    Map<Integer, String> userNames = (Map<Integer, String>) request.getAttribute("userNames");

    Double totalRevenue = (Double) request.getAttribute("totalRevenue");
    Integer activeOrders = (Integer) request.getAttribute("activeOrders");
    Integer completedOrders = (Integer) request.getAttribute("completedOrders");
  %>

  <nav class="navbar">
    <div class="logo">
      <a href="home">FoodZone <span class="admin-badge">Admin & Partner</span></a>
    </div>
    <div class="nav-buttons">
      <a class="nav-btn" href="home"><i class="fa-solid fa-store"></i> Customer View</a>
      <a class="nav-btn" href="profile"><i class="fa-solid fa-user"></i> My Account</a>
      <a class="nav-btn" href="logout" style="background:#dc2626;"><i class="fa-solid fa-power-off"></i> Logout</a>
    </div>
  </nav>

  <div class="container">
    <div class="page-header">
      <div class="page-title">
        <h1>Live Operations & Analytics</h1>
        <p>Monitor platform sales, fulfill live kitchen orders, and manage partner restaurants</p>
      </div>
      <a href="home" class="update-btn" style="padding:10px 18px; font-size:14px; text-decoration:none; background:#ff6f61;">
        <i class="fa-solid fa-plus"></i> Browse Restaurants
      </a>
    </div>

    <!-- Metric Cards -->
    <div class="stats-grid">
      <div class="stat-card">
        <div class="stat-icon icon-revenue"><i class="fa-solid fa-indian-rupee-sign"></i></div>
        <div class="stat-info">
          <h3>₹<%= totalRevenue != null ? totalRevenue.intValue() : 0 %></h3>
          <span>Total Gross Revenue</span>
        </div>
      </div>

      <div class="stat-card">
        <div class="stat-icon icon-orders"><i class="fa-solid fa-boxes-packing"></i></div>
        <div class="stat-info">
          <h3><%= allOrders != null ? allOrders.size() : 0 %></h3>
          <span>Total Orders Received</span>
        </div>
      </div>

      <div class="stat-card">
        <div class="stat-icon icon-restaurants"><i class="fa-solid fa-utensils"></i></div>
        <div class="stat-info">
          <h3><%= allRestaurants != null ? allRestaurants.size() : 0 %></h3>
          <span>Active Kitchen Partners</span>
        </div>
      </div>

      <div class="stat-card">
        <div class="stat-icon icon-users"><i class="fa-solid fa-users"></i></div>
        <div class="stat-info">
          <h3><%= allUsers != null ? allUsers.size() : 0 %></h3>
          <span>Registered Customers</span>
        </div>
      </div>
    </div>

    <!-- Live Orders Section -->
    <div class="section-card">
      <div class="card-header">
        <h2><i class="fa-solid fa-bell" style="color: #ff6f61;"></i> Live Customer Orders</h2>
        <span style="font-size: 13px; color: #64748b; font-weight: 600;"><%= allOrders != null ? allOrders.size() : 0 %> Total Records</span>
      </div>

      <div class="table-responsive">
        <table>
          <thead>
            <tr>
              <th>Order ID</th>
              <th>Customer</th>
              <th>Restaurant</th>
              <th>Total (₹)</th>
              <th>Payment</th>
              <th>Order Date</th>
              <th>Current Status</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <% 
              if (allOrders != null && !allOrders.isEmpty()) {
                for (Order o : allOrders) {
                  String status = o.getStatus() != null ? o.getStatus() : "Confirmed";
                  String badgeClass = "status-confirmed";
                  if (status.equalsIgnoreCase("Delivered")) badgeClass = "status-delivered";
                  else if (status.equalsIgnoreCase("Cooking") || status.contains("Preparation")) badgeClass = "status-prep";
                  else if (status.equalsIgnoreCase("Out for Delivery")) badgeClass = "status-out";
                  else if (status.equalsIgnoreCase("Cancelled")) badgeClass = "status-cancelled";

                  String rName = restaurantNames != null && restaurantNames.containsKey(o.getRestaurantid()) ? restaurantNames.get(o.getRestaurantid()) : "Restaurant #" + o.getRestaurantid();
                  String uName = userNames != null && userNames.containsKey(o.getUserid()) ? userNames.get(o.getUserid()) : "Customer #" + o.getUserid();
            %>
              <tr>
                <td><strong>#<%= o.getOrderid() %></strong></td>
                <td><strong><%= uName %></strong></td>
                <td><%= rName %></td>
                <td><strong style="color: #0f172a;">₹<%= (int)o.getTotalamount() %></strong></td>
                <td><span style="background: #f1f5f9; padding: 3px 8px; border-radius: 4px; font-weight: 600; font-size: 12px;"><%= o.getPaymentmode() %></span></td>
                <td style="color: #64748b; font-size: 12.5px;"><%= o.getOrderdate() %></td>
                <td><span class="status-badge <%= badgeClass %>"><%= status %></span></td>
                <td>
                  <form action="admin-dashboard" method="POST" style="display: flex; gap: 6px; align-items: center;">
                    <input type="hidden" name="action" value="updateOrderStatus">
                    <input type="hidden" name="orderId" value="<%= o.getOrderid() %>">
                    <select name="newStatus" class="status-select">
                      <option value="Confirmed" <%= "Confirmed".equalsIgnoreCase(status) ? "selected" : "" %>>Confirmed</option>
                      <option value="Cooking & In Prep" <%= status.contains("Prep") ? "selected" : "" %>>In Prep</option>
                      <option value="Out for Delivery" <%= "Out for Delivery".equalsIgnoreCase(status) ? "selected" : "" %>>Out for Delivery</option>
                      <option value="Delivered" <%= "Delivered".equalsIgnoreCase(status) ? "selected" : "" %>>Delivered</option>
                      <option value="Cancelled" <%= "Cancelled".equalsIgnoreCase(status) ? "selected" : "" %>>Cancelled</option>
                    </select>
                    <button type="submit" class="update-btn">Update</button>
                  </form>
                </td>
              </tr>
            <% 
                }
              } else { 
            %>
              <tr>
                <td colspan="8" style="text-align: center; padding: 40px; color: #64748b;">No orders placed yet.</td>
              </tr>
            <% } %>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Active Restaurants Grid -->
    <div class="section-card">
      <div class="card-header">
        <h2><i class="fa-solid fa-shop" style="color: #3b82f6;"></i> Registered Kitchen Partners</h2>
        <span style="font-size: 13px; color: #64748b; font-weight: 600;"><%= allRestaurants != null ? allRestaurants.size() : 0 %> Partner Outlets</span>
      </div>
      <div class="table-responsive">
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Restaurant Name</th>
              <th>Cuisine</th>
              <th>Location</th>
              <th>Delivery ETA</th>
              <th>Rating</th>
              <th>Live Menu</th>
            </tr>
          </thead>
          <tbody>
            <% if (allRestaurants != null) {
                for (Restaurant r : allRestaurants) { %>
              <tr>
                <td>#<%= r.getRestaurantid() %></td>
                <td><strong><%= r.getName() %></strong></td>
                <td><span style="background: #fff0ed; color: #ff6f61; padding: 2px 8px; border-radius: 4px; font-weight: bold; font-size: 12px;"><%= r.getCusinetype() %></span></td>
                <td><%= r.getAddress() %></td>
                <td><%= r.getDeliverytime() %></td>
                <td>⭐ <%= r.getRating() %></td>
                <td><a href="menu?restaurantId=<%= r.getRestaurantid() %>" target="_blank" style="color: #ff6f61; font-weight: bold; text-decoration: none;">View Items →</a></td>
              </tr>
            <%  } 
              } %>
          </tbody>
        </table>
      </div>
    </div>

  </div>

</body>
</html>
