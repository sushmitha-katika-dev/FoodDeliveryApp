<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.foodapp.models.Cart, com.foodapp.models.CartItem, com.foodapp.models.User, com.foodapp.DAO.RestaurantDAO, com.foodapp.DAOImpl.RestaurantDAOImpl, com.foodapp.models.Restaurant" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Your Cart - FoodZone</title>
  <link type="image/png" rel="icon" href="images/food app header logo.png">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style type="text/css">
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
      gap: 10px;
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
      transition: all 0.2s ease;
    }

    .nav-btn:hover {
      background-color: #ff6f61;
      color: white;
    }

    .container {
      max-width: 680px;
      margin: 25px auto;
      padding: 0 15px;
    }

    .cart-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }

    .cart-header h1 {
      font-size: 24px;
      color: #222;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .add-more-link {
      color: #ff6f61;
      text-decoration: none;
      font-weight: bold;
      font-size: 14px;
      display: flex;
      align-items: center;
      gap: 6px;
    }

    .add-more-link:hover {
      text-decoration: underline;
    }

    .cart-card {
      background: #fff;
      padding: 24px;
      border-radius: 16px;
      box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
      border: 1px solid #eee;
    }

    .multi-restaurant-alert {
      background-color: #e3f2fd;
      border: 1px solid #bbdefb;
      color: #1565c0;
      padding: 10px 16px;
      border-radius: 10px;
      font-size: 13px;
      margin-bottom: 18px;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .cart-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-bottom: 1px solid #f0f0f0;
      padding: 16px 0;
    }

    .cart-row:last-child {
      border-bottom: none;
    }

    .cart-left p {
      margin: 3px 0;
      font-size: 14px;
      color: #555;
    }

    .cart-left .item-name {
      font-weight: 700;
      font-size: 16px;
      color: #222;
    }

    .restaurant-tag {
      display: inline-block;
      background: #fff3e0;
      color: #e65100;
      font-size: 11px;
      font-weight: bold;
      padding: 2px 8px;
      border-radius: 6px;
      margin-bottom: 4px;
    }

    .cart-right {
      display: flex;
      align-items: center;
      gap: 16px;
    }

    .qty-box {
      display: flex;
      align-items: center;
      gap: 6px;
      background: #f8f8f8;
      padding: 4px 8px;
      border-radius: 20px;
      border: 1px solid #e0e0e0;
    }

    .qty-btn {
      background-color: #ff6f61;
      color: #fff;
      border: none;
      width: 28px;
      height: 28px;
      font-size: 16px;
      border-radius: 50%;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: background-color 0.2s;
    }

    .qty-btn:hover:not(:disabled) {
      background-color: #e65b50;
    }

    .qty-btn:disabled {
      background-color: #ccc;
      cursor: not-allowed;
    }

    .qty-display {
      min-width: 24px;
      text-align: center;
      font-weight: bold;
      font-size: 14px;
    }

    .item-total-price {
      font-weight: bold;
      font-size: 15px;
      color: #ff4d4f;
      min-width: 70px;
      text-align: right;
    }

    .remove-btn {
      background-color: transparent;
      border: none;
      color: #999;
      cursor: pointer;
      font-size: 15px;
      padding: 6px;
      transition: color 0.2s ease;
    }

    .remove-btn:hover {
      color: #ff4d4f;
    }

    /* Coupon Box */
    .coupon-box {
      background: #fafafa;
      border: 1px dashed #ffd8cc;
      border-radius: 12px;
      padding: 16px;
      margin: 18px 0 10px;
    }

    .coupon-form {
      display: flex;
      gap: 8px;
    }

    .coupon-input {
      flex: 1;
      padding: 10px 14px;
      border: 1px solid #ddd;
      border-radius: 8px;
      font-size: 14px;
      text-transform: uppercase;
      font-weight: 600;
    }

    .coupon-btn {
      background-color: #333;
      color: white;
      border: none;
      padding: 10px 18px;
      border-radius: 8px;
      font-weight: bold;
      font-size: 13.5px;
      cursor: pointer;
      transition: 0.2s;
    }

    .coupon-btn:hover {
      background-color: #111;
    }

    .coupon-pills {
      display: flex;
      gap: 8px;
      margin-top: 10px;
      flex-wrap: wrap;
    }

    .coupon-pill {
      background: white;
      border: 1px solid #ffd1cb;
      color: #ff6f61;
      font-size: 11px;
      font-weight: bold;
      padding: 3px 8px;
      border-radius: 6px;
      cursor: pointer;
    }

    .coupon-success {
      background: #e8f5e9;
      border: 1px solid #c8e6c9;
      color: #2e7d32;
      padding: 10px 14px;
      border-radius: 8px;
      font-size: 13px;
      font-weight: 600;
      margin-top: 10px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .coupon-error {
      background: #ffebee;
      border: 1px solid #ffcdd2;
      color: #c62828;
      padding: 8px 12px;
      border-radius: 8px;
      font-size: 13px;
      margin-top: 10px;
    }

    .grand-total {
      display: flex;
      justify-content: space-between;
      padding: 14px 0 10px;
      font-size: 18px;
      font-weight: bold;
      color: #222;
      border-top: 2px dashed #eee;
      margin-top: 10px;
    }

    .cart-actions {
      display: flex;
      flex-direction: column;
      gap: 12px;
      margin-top: 15px;
    }

    .action-btn {
      background-color: #ff6f61;
      color: white;
      text-decoration: none;
      text-align: center;
      border: none;
      padding: 14px;
      font-size: 15px;
      font-weight: bold;
      border-radius: 12px;
      cursor: pointer;
      transition: background-color 0.2s ease;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
    }

    .action-btn:hover {
      background-color: #e65b50;
    }

    .action-btn.secondary {
      background-color: #f0f0f0;
      color: #333;
    }

    .action-btn.secondary:hover {
      background-color: #e4e4e4;
    }

    .empty-cart-container {
      text-align: center;
      padding: 40px 20px;
    }

    .empty-cart-container i {
      font-size: 50px;
      color: #ddd;
      margin-bottom: 15px;
    }
  </style>
  <script>
    function setCoupon(code) {
      document.getElementById('couponCodeInput').value = code;
    }
  </script>
</head>
<body>

  <%
    Cart cart = (Cart)session.getAttribute("cart");
    int cartCount = (cart != null) ? cart.getTotalCount() : 0;
    int subTotal = (cart != null) ? (int)cart.getGrandTotal() : 0;
    User loggedInUser = (User)session.getAttribute("user");
    RestaurantDAO rdao = new RestaurantDAOImpl();

    String appliedCoupon = (String)session.getAttribute("appliedCoupon");
    Integer couponDiscountObj = (Integer)session.getAttribute("couponDiscount");
    int couponDiscount = (couponDiscountObj != null) ? couponDiscountObj : 0;
    String couponMessage = (String)session.getAttribute("couponMessage");
    String couponError = (String)session.getAttribute("couponError");

    int finalPayable = Math.max(0, subTotal - couponDiscount);
  %>

  <nav class="navbar">
    <div class="logo"><a href="home">FoodZone 🍴</a></div>
    <div class="nav-buttons">
      <a class="nav-btn" href="home"><i class="fa-solid fa-utensils"></i> Browse Restaurants</a>
      <% if(loggedInUser != null) { %>
        <a class="nav-btn" href="my-orders"><i class="fa-solid fa-receipt"></i> My Orders</a>
        <span style="display: flex; align-items: center; color: white; font-weight: bold; margin-left: 4px;"><i class="fa-solid fa-circle-user" style="margin-right: 5px;"></i> <%= loggedInUser.getName().split(" ")[0] %></span>
      <% } else { %>
        <a class="nav-btn" href="login.jsp">Sign In <i class="fa-solid fa-right-to-bracket"></i></a>
      <% } %>
    </div>
  </nav>

  <div class="container">
    <div class="cart-header">
      <h1><i class="fa-solid fa-cart-shopping" style="color: #ff6f61;"></i> Your Food Cart</h1>
      <% if(cart != null && !cart.getItems().isEmpty()) { %>
        <a href="home" class="add-more-link"><i class="fa-solid fa-plus"></i> Add from other restaurants</a>
      <% } %>
    </div>

    <div class="cart-card">
      <%
		    if(cart != null && !cart.getItems().isEmpty())
		    {
      %>
        <div class="multi-restaurant-alert">
          <i class="fa-solid fa-store"></i>
          <span>Multi-cuisine enabled! You can mix food items from different restaurants in one single order.</span>
        </div>

			  <% for(CartItem item : cart.getItems().values())
			  { 
          String restName = "";
          if (item.getRestaurantId() > 0) {
            Restaurant r = rdao.getRestaurantById(item.getRestaurantId());
            if (r != null) {
              restName = r.getName();
            }
          }
        %>
			    <!-- Cart Item -->
			    <div class="cart-row">
			      <div class="cart-left">
              <% if (!restName.isEmpty()) { %>
                <span class="restaurant-tag"><i class="fa-solid fa-utensils"></i> <%= restName %></span>
              <% } %>
			        <p class="item-name"><%= item.getName() %></p>
			        <p>Price: ₹ <%= (int)item.getPrice() %></p>
			      </div>
			
			      <div class="cart-right">
			        <div class="qty-box">
		                <form action="cart" method="post" style="display:inline;">
		                    <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
		                    <input type="hidden" name="action" value="update">
		                    <input type="hidden" name="quantity" value="<%= item.getQuantity() - 1 %>">
		                    <button type="submit" class="qty-btn" <% if(item.getQuantity() <= 1) { %>disabled<% } %>>−</button>
		                </form>
						        <span class="qty-display"><%= item.getQuantity() %></span>
		                <form action="cart" method="post" style="display:inline;">
		                    <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
		                    <input type="hidden" name="action" value="update">
		                    <input type="hidden" name="quantity" value="<%= item.getQuantity() + 1 %>">
		                    <button type="submit" class="qty-btn">+</button>
		                </form>
			        </div>

              <div class="item-total-price">₹ <%= (int)item.getTotalprice() %></div>

			        <form action="cart" method="post" style="display:inline;">
			        	<input type="hidden" name="itemId" value="<%= item.getItemId() %>">
			        	<input type="hidden" name="action" value="remove">
			        	<button type="submit" class="remove-btn" title="Remove item"><i class="fa-solid fa-trash-can"></i></button>
			        </form>
			      </div>
			    </div>
			  <% } %>

        <!-- Coupon Section -->
        <div class="coupon-box">
          <form action="apply-coupon" method="post" class="coupon-form">
            <input type="text" id="couponCodeInput" name="couponCode" placeholder="Enter coupon code (e.g. WELCOME50)" class="coupon-input" value="<%= appliedCoupon != null ? appliedCoupon : "" %>">
            <button type="submit" class="coupon-btn">Apply</button>
          </form>

          <div class="coupon-pills">
            <span class="coupon-pill" onclick="setCoupon('WELCOME50')">🏷️ WELCOME50 (50% OFF)</span>
            <span class="coupon-pill" onclick="setCoupon('FOODZONE20')">🏷️ FOODZONE20 (20% OFF)</span>
            <span class="coupon-pill" onclick="setCoupon('FEAST100')">🏷️ FEAST100 (₹100 OFF)</span>
          </div>

          <% if (appliedCoupon != null) { %>
            <div class="coupon-success">
              <span><%= couponMessage %></span>
              <form action="apply-coupon" method="post" style="display:inline;">
                <input type="hidden" name="action" value="remove">
                <button type="submit" style="background:none; border:none; color:#c62828; font-weight:bold; cursor:pointer;">✕ Remove</button>
              </form>
            </div>
          <% } %>

          <% if (couponError != null) { %>
            <div class="coupon-error">
              <i class="fa-solid fa-triangle-exclamation"></i> <%= couponError %>
            </div>
          <% } %>
        </div>

        <!-- Bill Breakdown -->
        <div style="padding: 10px 0 5px; font-size: 14px;">
          <div style="display: flex; justify-content: space-between; margin: 4px 0; color: #666;">
            <span>Item Subtotal:</span>
            <span>₹ <%= subTotal %></span>
          </div>
          <% if (couponDiscount > 0) { %>
            <div style="display: flex; justify-content: space-between; margin: 4px 0; color: #2e7d32; font-weight: 600;">
              <span>Coupon Discount (<%= appliedCoupon %>):</span>
              <span>- ₹ <%= couponDiscount %></span>
            </div>
          <% } %>
        </div>

        <!-- Grand Total -->
        <div class="grand-total">
          <span>Amount Payable</span>
          <span style="color: #ff4d4f;">₹ <%= finalPayable %></span>
        </div>

        <!-- Action Buttons -->
        <div class="cart-actions">
          <form action="checkout.jsp" method="post">
            <button type="submit" class="action-btn" style="width: 100%;">
              <i class="fa-solid fa-bag-shopping"></i> Proceed to Checkout (₹<%= finalPayable %>)
            </button>
          </form>
          <a href="home" class="action-btn secondary"><i class="fa-solid fa-plus"></i> Add Items from Other Restaurants</a>
        </div>

		  <% } else { %>
        <div class="empty-cart-container">
          <i class="fa-solid fa-cart-arrow-down"></i>
          <h3 style="margin-bottom: 8px; color: #444;">Your cart is empty</h3>
          <p style="color: #777; margin-bottom: 20px;">Explore our delicious restaurants and add your favorite dishes!</p>
          <a href="home" class="action-btn" style="display:inline-flex; width: auto; padding: 12px 28px;">
            <i class="fa-solid fa-utensils"></i> Explore Restaurants
          </a>
        </div>
      <% } %>

    </div>
  </div>
</body>
</html>