<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.foodapp.models.Restaurant, com.foodapp.models.Cart, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link type="image/png" rel="icon" href="images/food app header logo.png">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <title>FoodZone - Online Food Delivery</title>
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
      padding-bottom: 70px;
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

    .search-container {
      position: relative;
      flex-grow: 1;
      margin: 0 20px;
      max-width: 450px;
    }
    
    .search-bar {
      width: 100%;
      padding: 10px 42px 10px 16px;
      border-radius: 20px;
      border: none;
      outline: none;
      font-size: 14px;
      background-color: white;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    
    .search-button {
      position: absolute;
      right: 12px;
      top: 50%;
      transform: translateY(-50%);
      background: none;
      border: none;
      cursor: pointer;
      padding: 5px;
      font-size: 16px;
    }

    .nav-buttons {
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .nav-btn {
      display: flex;
      align-items: center;
      justify-content: center;
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

    .cart-badge {
      background-color: #333;
      color: white;
      font-size: 11px;
      padding: 2px 7px;
      border-radius: 10px;
      font-weight: bold;
    }

    .banner-strip {
      background: linear-gradient(135deg, #ffefe8 0%, #fff7f2 100%);
      border: 1px solid #ffd8cc;
      border-radius: 12px;
      padding: 12px 20px;
      margin: 18px auto 0;
      max-width: 1250px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .banner-strip span {
      font-size: 14.5px;
      color: #444;
      font-weight: 500;
    }

    .banner-btn {
      background-color: #ff6f61;
      color: white;
      padding: 6px 14px;
      border-radius: 16px;
      text-decoration: none;
      font-weight: bold;
      font-size: 13px;
      transition: 0.2s;
    }

    .banner-btn:hover {
      background-color: #e65b50;
    }

    .container {
      padding: 1.5rem 2rem;
      max-width: 1300px;
      margin: 0 auto;
    }

    /* Category Filter Chips */
    .categories-section {
      margin-bottom: 25px;
    }

    .section-subtitle {
      font-size: 14px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      font-weight: 700;
      color: #888;
      margin-bottom: 12px;
    }

    .category-chips {
      display: flex;
      gap: 10px;
      overflow-x: auto;
      padding-bottom: 8px;
      scrollbar-width: thin;
    }

    .category-chip {
      background: white;
      border: 1px solid #e0e0e0;
      padding: 8px 16px;
      border-radius: 20px;
      font-size: 13.5px;
      font-weight: 600;
      color: #444;
      text-decoration: none;
      white-space: nowrap;
      display: inline-flex;
      align-items: center;
      gap: 6px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.04);
      transition: all 0.2s ease;
    }

    .category-chip:hover {
      border-color: #ff6f61;
      color: #ff6f61;
      background: #fff8f6;
      transform: translateY(-2px);
    }

    .filter-bar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
      flex-wrap: wrap;
      gap: 10px;
    }

    .section-title {
      font-size: 22px;
      color: #222;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .card-grid {
      display: flex;
      flex-wrap: wrap;
      gap: 2rem;
      justify-content: flex-start;
    }
    
    .card-grid a {
      text-decoration: none;
      color: inherit;
      display: inline-block;
    }
    
    .card {
      background-color: white;
      width: 285px;
      border-radius: 14px;
      overflow: hidden;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      transition: transform 0.2s ease, box-shadow 0.2s ease;
      cursor: pointer;
    }

    .card:hover {
      transform: translateY(-6px);
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
    }

    .card img {
      width: 100%;
      height: 180px;
      object-fit: cover;
    }

    .card-content {
      padding: 1rem;
    }

    .card h3 {
      font-size: 1.2rem;
      margin-bottom: 0.4rem;
      color: #222;
    }

    .card p {
      font-size: 0.9rem;
      margin-bottom: 0.4rem;
      color: #666;
    }

    .card .meta {
      font-size: 0.85rem;
      color: #444;
      margin-top: 4px;
    }

    .cuisine-tag {
      display: inline-block;
      background-color: #fff0ed;
      color: #ff6f61;
      padding: 3px 8px;
      border-radius: 6px;
      font-size: 12px;
      font-weight: bold;
      margin-bottom: 6px;
    }
  </style>
</head>
<body>
  <%
    Cart cart = (Cart)session.getAttribute("cart");
    int cartCount = (cart != null) ? cart.getTotalCount() : 0;
    com.foodapp.models.User loggedInUser = (com.foodapp.models.User)session.getAttribute("user");
  %>

  <nav class="navbar">
    <div class="logo"><a href="home">FoodZone 🍴</a></div>
    <div class="search-container">
      <form action="SearchServlet" method="POST">
        <input type="text" name="searchQuery" placeholder="Search biryani, pizza, burger, noodles..." class="search-bar">
        <button type="submit" class="search-button">
          <i class="fa-solid fa-magnifying-glass" style="color: #ff6f61;"></i>
        </button>
      </form>
    </div>  
    <div class="nav-buttons">
      <% if(loggedInUser != null) { %>
        <a class="nav-btn" href="my-orders"><i class="fa-solid fa-receipt"></i> My Orders</a>
        <span style="display: flex; align-items: center; color: white; font-weight: bold; margin: 0 4px;"><i class="fa-solid fa-circle-user" style="margin-right: 5px;"></i> <%= loggedInUser.getName().split(" ")[0] %></span>
      <% } else { %>
        <a class="nav-btn" href="login.jsp">Sign In <i class="fa-solid fa-right-to-bracket"></i></a>
      <% } %>
      <a class="nav-btn" href="cart.jsp">
        <i class="fa-solid fa-cart-shopping"></i> Cart
        <% if (cartCount > 0) { %>
          <span class="cart-badge"><%= cartCount %></span>
        <% } %>
      </a>
    </div>
  </nav>

  <% if (cartCount > 0) { %>
    <div class="banner-strip">
      <span>🛒 You have <strong><%= cartCount %> item<%= cartCount > 1 ? "s" : "" %></strong> in your cart (Total: <strong>₹<%= (int)cart.getGrandTotal() %></strong>). Multi-restaurant checkout enabled!</span>
      <a href="cart.jsp" class="banner-btn">View Cart & Checkout →</a>
    </div>
  <% } %>

  <div class="container">
    
    <!-- Quick Cuisine Chips -->
    <div class="categories-section">
      <div class="section-subtitle">What are you craving?</div>
      <div class="category-chips">
        <a href="SearchServlet?searchQuery=Biryani" class="category-chip">🍗 Biryani</a>
        <a href="SearchServlet?searchQuery=Pizza" class="category-chip">🍕 Pizza</a>
        <a href="SearchServlet?searchQuery=Burger" class="category-chip">🍔 Burgers</a>
        <a href="SearchServlet?searchQuery=Chinese" class="category-chip">🥟 Chinese</a>
        <a href="SearchServlet?searchQuery=South Indian" class="category-chip">☕ South Indian</a>
        <a href="SearchServlet?searchQuery=North Indian" class="category-chip">🍛 North Indian</a>
        <a href="SearchServlet?searchQuery=Dessert" class="category-chip">🍰 Cakes & Desserts</a>
        <a href="SearchServlet?searchQuery=Healthy" class="category-chip">🥗 Healthy Bowls</a>
      </div>
    </div>

    <div class="filter-bar">
      <h2 class="section-title"><i class="fa-solid fa-utensils" style="color: #ff6f61;"></i> Top Restaurants for You</h2>
    </div>

    <div class="card-grid">
		<% 
		List<Restaurant> allRestaurants = (List<Restaurant>)request.getAttribute("allRestaurants");
		
	    if(allRestaurants == null || allRestaurants.isEmpty())
	    { %>
	            <div style="width:100%; text-align:center; padding:60px 20px; color:#666;">
	                <h3>No restaurants found</h3>
	                <p style="margin-top: 8px;">Try searching for another cuisine or restaurant name</p>
	                <a href="home" style="display:inline-block; margin-top:15px; color:#ff6f61; font-weight:bold;">View All Restaurants</a>
	            </div>
	  <% }
	    else 
	    { 
			for(Restaurant restaurant: allRestaurants)
			{ %>
				<a href="menu?restaurantId=<%= restaurant.getRestaurantid() %>">
					<div class="card">
						<img src="<%= restaurant.getImagepath() %>" alt="restaurant image" onerror="this.src='https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=600&auto=format&fit=crop&q=80'">
						<div class="card-content">
							<span class="cuisine-tag"><%= restaurant.getCusinetype() %></span>
							<h3><%= restaurant.getName() %></h3>
							<p><i class="fa-solid fa-location-dot" style="color: #888;"></i> <%= restaurant.getAddress() %></p>
							<p class="meta"><b>ETA</b>: <%= restaurant.getDeliverytime() %> &bull; <b>Rating</b>: ⭐ <%= restaurant.getRating() %></p>
						</div>
					</div>
				</a>
			<% } 
		} %>     
    </div>
  </div>
</body>
</html>