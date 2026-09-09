<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.foodapp.models.Menu, com.foodapp.models.Cart, com.foodapp.models.CartItem, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <link type="image/png" rel="icon" href="images/food app header logo.png">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <title>Restaurant Menu - FoodZone</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
      background-color: #fafafa;
      color: #333;
      padding-bottom: 100px;
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
	  justify-content: center;
	  gap: 8px;
	  background-color: white;
	  color: #ff6f61;
	  text-decoration: none;
	  border: 2px solid #ff6f61;
	  padding: 8px 16px;
	  border-radius: 20px;
	  font-size: 15px;
	  font-weight: bold;
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

    .top-bar-action {
      max-width: 1200px;
      margin: 18px auto 0;
      padding: 0 2rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-wrap: wrap;
      gap: 12px;
    }

    .back-link {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      color: #ff6f61;
      text-decoration: none;
      font-weight: bold;
      font-size: 15px;
    }

    .back-link:hover {
      text-decoration: underline;
    }

    /* Veg/Non-Veg Filter Controls */
    .filter-controls {
      display: flex;
      gap: 8px;
      background: white;
      padding: 4px;
      border-radius: 24px;
      border: 1px solid #e0e0e0;
      box-shadow: 0 2px 6px rgba(0,0,0,0.04);
    }

    .filter-pill {
      padding: 6px 14px;
      border-radius: 20px;
      border: none;
      font-size: 13px;
      font-weight: 700;
      cursor: pointer;
      background: transparent;
      color: #666;
      transition: all 0.2s ease;
      display: inline-flex;
      align-items: center;
      gap: 6px;
    }

    .filter-pill.active {
      background: #ff6f61;
      color: white;
    }

    .filter-pill.active.veg {
      background: #2e7d32;
      color: white;
    }

    .filter-pill.active.nonveg {
      background: #c62828;
      color: white;
    }

    .veg-dot {
      display: inline-block;
      width: 14px;
      height: 14px;
      border: 2px solid #2e7d32;
      padding: 2px;
      border-radius: 3px;
      position: relative;
      margin-right: 6px;
      vertical-align: middle;
    }

    .veg-dot::after {
      content: '';
      display: block;
      width: 6px;
      height: 6px;
      background: #2e7d32;
      border-radius: 50%;
    }

    .nonveg-dot {
      display: inline-block;
      width: 14px;
      height: 14px;
      border: 2px solid #c62828;
      padding: 2px;
      border-radius: 3px;
      position: relative;
      margin-right: 6px;
      vertical-align: middle;
    }

    .nonveg-dot::after {
      content: '';
      display: block;
      width: 6px;
      height: 6px;
      background: #c62828;
      border-radius: 50%;
    }

    .toast-container {
      max-width: 1200px;
      margin: 12px auto 0;
      padding: 0 2rem;
    }

    .toast-alert {
      background-color: #e8f5e9;
      border: 1px solid #c8e6c9;
      color: #2e7d32;
      padding: 12px 18px;
      border-radius: 12px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-wrap: wrap;
      gap: 10px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }

    .toast-actions {
      display: flex;
      gap: 10px;
    }

    .toast-btn {
      background-color: #2e7d32;
      color: white;
      padding: 6px 14px;
      border-radius: 16px;
      text-decoration: none;
      font-weight: bold;
      font-size: 13px;
    }

    .menu-container {
      padding: 1.5rem 2rem;
      max-width: 1250px;
      margin: 0 auto;
    }

    .menu-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
      gap: 1.8rem;
    }

    .menu-card {
      background-color: white;
      border-radius: 14px;
      overflow: hidden;
      box-shadow: 0 4px 14px rgba(0, 0, 0, 0.06);
      transition: transform 0.2s ease, box-shadow 0.2s ease;
      display: flex;
      flex-direction: column;
      position: relative;
    }

    .menu-card:hover {
      transform: translateY(-4px);
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
    }

    .menu-card img {
      width: 100%;
      height: 180px;
      object-fit: cover;
    }

    .menu-card-content {
      padding: 1.2rem;
      display: flex;
      flex-direction: column;
      flex-grow: 1;
    }

    .menu-card h3 {
      font-size: 1.15rem;
      margin-bottom: 0.4rem;
      color: #222;
      display: flex;
      align-items: center;
    }

    .menu-card p.description {
      font-size: 0.88rem;
      color: #666;
      margin-bottom: 0.8rem;
      line-height: 1.4;
      flex-grow: 1;
    }

    .price-rating {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1rem;
    }

    .price {
      font-weight: bold;
      color: #ff4d4f;
      font-size: 1.15rem;
    }

    .rating {
      font-size: 0.85rem;
      background-color: #f5f5f5;
      padding: 0.2rem 0.5rem;
      border-radius: 10px;
      color: #333;
      font-weight: 500;
    }
    
	.button-container {
	    display: flex;
	    justify-content: center;
	    margin-top: auto;
	}
	
	.add-btn {
	    width: 100%;
	    background-color: #ff6f61;
	    color: white;
	    border: none;
	    padding: 10px 16px;
	    border-radius: 20px;
	    font-size: 14px;
	    font-weight: bold;
	    cursor: pointer;
	    transition: background-color 0.2s ease;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    gap: 6px;
	}
	
	.add-btn:hover {
	    background-color: #e65b50;
	}

    .in-cart-pill {
      position: absolute;
      top: 10px;
      right: 10px;
      background: rgba(46, 125, 50, 0.9);
      color: white;
      font-size: 12px;
      font-weight: bold;
      padding: 4px 10px;
      border-radius: 12px;
      backdrop-filter: blur(4px);
    }

    /* Floating Cart Sticky Bar */
    .floating-cart-bar {
      position: fixed;
      bottom: 0;
      left: 0;
      right: 0;
      background-color: #222;
      color: white;
      padding: 14px 24px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      z-index: 1000;
      box-shadow: 0 -4px 15px rgba(0,0,0,0.2);
    }

    .floating-cart-info {
      display: flex;
      align-items: center;
      gap: 12px;
      font-size: 15px;
    }

    .floating-cart-actions {
      display: flex;
      gap: 12px;
    }

    .btn-secondary {
      background: #444;
      color: white;
      text-decoration: none;
      padding: 8px 16px;
      border-radius: 20px;
      font-size: 14px;
      font-weight: bold;
      transition: 0.2s;
    }

    .btn-secondary:hover {
      background: #555;
    }

    .btn-primary {
      background: #ff6f61;
      color: white;
      text-decoration: none;
      padding: 8px 18px;
      border-radius: 20px;
      font-size: 14px;
      font-weight: bold;
      transition: 0.2s;
    }

    .btn-primary:hover {
      background: #e65b50;
    }
  </style>
</head>
<body>

  <%
    Cart cart = (Cart)session.getAttribute("cart");
    int cartCount = (cart != null) ? cart.getTotalCount() : 0;
    com.foodapp.models.User loggedInUser = (com.foodapp.models.User)session.getAttribute("user");
    String addedItemName = request.getParameter("added");
  %>

  <nav class="navbar">
    <div class="logo"><a href="home">FoodZone 🍴</a></div>
    <div class="nav-buttons">
      <a class="nav-btn" href="home"><i class="fa-solid fa-house"></i> All Restaurants</a>
      <% if(loggedInUser != null) { %>
        <a class="nav-btn" href="profile"><i class="fa-solid fa-circle-user"></i> <%= loggedInUser.getName().split(" ")[0] %></a>
        <a class="nav-btn" href="logout" style="background:#fee2e2; border-color:#fca5a5; color:#dc2626;" title="Sign Out"><i class="fa-solid fa-power-off"></i></a>
      <% } else { %>
        <a class="nav-btn" href="login.jsp">Sign In <i class="fa-solid fa-right-to-bracket"></i></a>
      <% } %>
      <a class="nav-btn" href="cart.jsp">
        <i class="fa-solid fa-cart-shopping"></i> Cart
        <% if(cartCount > 0) { %>
          <span class="cart-badge"><%= cartCount %></span>
        <% } %>
      </a>
    </div>
  </nav>

  <div class="top-bar-action">
    <a href="home" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to All Restaurants</a>
    
    <!-- Pure Veg / Non-Veg Toggle Filter -->
    <div class="filter-controls">
      <button type="button" class="filter-pill active" onclick="filterVeg('all', this)">🍽️ All Items</button>
      <button type="button" class="filter-pill veg" onclick="filterVeg('veg', this)"><span class="veg-dot"></span> Pure Veg</button>
      <button type="button" class="filter-pill nonveg" onclick="filterVeg('nonveg', this)"><span class="nonveg-dot"></span> Non-Veg</button>
    </div>
  </div>

  <!-- Acknowledgement Toast when an item is added -->
  <% if(addedItemName != null && !addedItemName.trim().isEmpty()) { %>
    <div class="toast-container">
      <div class="toast-alert">
        <div>
          <i class="fa-solid fa-circle-check" style="font-size: 18px; margin-right: 8px;"></i>
          <strong><%= addedItemName %></strong> has been added to your cart!
        </div>
        <div class="toast-actions">
          <a href="home" class="toast-btn" style="background-color: #555;">+ Add from other restaurants</a>
          <a href="cart.jsp" class="toast-btn">View Cart (<%= cartCount %>) & Checkout →</a>
        </div>
      </div>
    </div>
  <% } %>

  <div class="menu-container">
    <div class="menu-grid" id="menuGrid">
      
      <!-- Menu Cards -->
      <%
      List<Menu> menuByRestaurantId = (List<Menu>)request.getAttribute("menuByRestaurantId");
      
      if(menuByRestaurantId != null && !menuByRestaurantId.isEmpty())
      {
        for(Menu menu : menuByRestaurantId)
        { 
          int inCartQty = 0;
          if (cart != null && cart.getItems().containsKey(menu.getMenuid())) {
            inCartQty = cart.getItems().get(menu.getMenuid()).getQuantity();
          }
          
          String lowerName = (menu.getItemname() + " " + menu.getDescription()).toLowerCase();
          boolean isNonVeg = lowerName.contains("chicken") || lowerName.contains("mutton") || lowerName.contains("egg") || lowerName.contains("fish") || lowerName.contains("pepperoni") || lowerName.contains("prawn") || lowerName.contains("meat") || lowerName.contains("pork") || lowerName.contains("beef") || lowerName.contains("bbq");
        %>
        
        <div class="menu-card" data-is-veg="<%= !isNonVeg %>">
          <% if(inCartQty > 0) { %>
            <div class="in-cart-pill"><i class="fa-solid fa-check"></i> <%= inCartQty %> in cart</div>
          <% } %>
          <img src="<%= menu.getImagepath() %>" alt="menu item" onerror="this.src='https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&auto=format&fit=crop&q=80'">
          <div class="menu-card-content">
            <h3>
              <span class="<%= isNonVeg ? "nonveg-dot" : "veg-dot" %>" title="<%= isNonVeg ? "Non-Vegetarian" : "Pure Vegetarian" %>"></span>
              <%= menu.getItemname() %>
            </h3>
            <div class="price-rating">
              <span class="price">₹ <%= menu.getPrice() %></span>
              <span class="rating">⭐ <%= menu.getRatings() %></span>
            </div>
            <p class="description"><%= menu.getDescription() %></p>
            
            <form action="cart" method="POST">
              <input type="hidden" name="menuId" value="<%= menu.getMenuid() %>">
              <input type="hidden" name="quantity" value="1">
              <input type="hidden" name="restaurantId" value="<%= menu.getRestaurantid() %>">
              <input type="hidden" name="action" value="add">
              <input type="hidden" name="redirect" value="menu">
              <div class="button-container">
                <button type="submit" class="add-btn">
                  <i class="fa-solid fa-plus"></i> <%= inCartQty > 0 ? "Add Another" : "Add Item" %>
                </button>
              </div>
            </form>
          </div>
        </div>
          
        <% } 
      } else { %>
        <div style="width:100%; text-align:center; padding:50px; color:#666;">
          <h3>No menu items found for this restaurant.</h3>
          <a href="home" style="display:inline-block; margin-top:15px; color:#ff6f61; font-weight:bold;">← Back to Restaurants</a>
        </div>
      <% } %>

    </div>
  </div>

  <!-- Sticky Bottom Cart Bar -->
  <% if(cart != null && cartCount > 0) { %>
    <div class="floating-cart-bar">
      <div class="floating-cart-info">
        <i class="fa-solid fa-basket-shopping" style="color: #ff6f61; font-size: 20px;"></i>
        <span><strong><%= cartCount %> item<%= cartCount > 1 ? "s" : "" %></strong> in cart &bull; Total: <strong>₹<%= (int)cart.getGrandTotal() %></strong></span>
      </div>
      <div class="floating-cart-actions">
        <a href="home" class="btn-secondary"><i class="fa-solid fa-utensils"></i> Add More Cuisines</a>
        <a href="cart.jsp" class="btn-primary">View Cart & Checkout →</a>
      </div>
    </div>
  <% } %>

  <script>
    function filterVeg(type, btn) {
      document.querySelectorAll('.filter-pill').forEach(p => p.classList.remove('active'));
      btn.classList.add('active');

      const cards = document.querySelectorAll('.menu-card');
      cards.forEach(card => {
        const isVeg = card.getAttribute('data-is-veg') === 'true';
        if (type === 'all') {
          card.style.display = 'flex';
        } else if (type === 'veg') {
          card.style.display = isVeg ? 'flex' : 'none';
        } else if (type === 'nonveg') {
          card.style.display = !isVeg ? 'flex' : 'none';
        }
      });
    }
  </script>
</body>
</html>