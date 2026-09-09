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
    }

    .back-link {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      color: #ff6f61;
      text-decoration: none;
      font-weight: bold;
      font-size: 15px;
      background: white;
      padding: 8px 16px;
      border-radius: 20px;
      border: 1px solid #ffd1cb;
      box-shadow: 0 2px 5px rgba(0,0,0,0.05);
      transition: 0.2s;
    }

    .back-link:hover {
      background-color: #ffefe8;
      transform: translateX(-3px);
    }

    /* Toast Acknowledgement Notification */
    .toast-container {
      max-width: 1200px;
      margin: 15px auto 0;
      padding: 0 2rem;
    }

    .toast-alert {
      background-color: #e8f5e9;
      border: 1px solid #a5d6a7;
      color: #1b5e20;
      padding: 14px 20px;
      border-radius: 12px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0 4px 12px rgba(0,0,0,0.08);
      animation: slideDown 0.3s ease-out;
    }

    @keyframes slideDown {
      from { transform: translateY(-10px); opacity: 0; }
      to { transform: translateY(0); opacity: 1; }
    }

    .toast-alert .toast-actions {
      display: flex;
      gap: 10px;
      align-items: center;
    }

    .toast-btn {
      background-color: #2e7d32;
      color: white;
      text-decoration: none;
      padding: 6px 14px;
      border-radius: 16px;
      font-weight: bold;
      font-size: 13px;
      transition: 0.2s;
    }

    .toast-btn:hover {
      background-color: #1b5e20;
    }
	
    .menu-container {
      padding: 1.5rem 2rem;
      max-width: 1200px;
      margin: auto;
    }

    .menu-grid {
      display: flex;
      flex-wrap: wrap;
      gap: 2rem;
      justify-content: flex-start;
    }

    .menu-card {
      background-color: white;
      width: 270px;
      border-radius: 14px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      overflow: hidden;
      display: flex;
      flex-direction: column;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
      position: relative;
    }

    .menu-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
    }

    .menu-card img {
      width: 100%;
      height: 170px;
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
        <span style="display: flex; align-items: center; color: white; font-weight: bold; margin-right: 4px;"><i class="fa-solid fa-circle-user" style="margin-right: 6px;"></i> <%= loggedInUser.getName().split(" ")[0] %></span>
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
    <% if(cartCount > 0) { %>
      <span style="font-size: 14px; color: #666;"><i class="fa-solid fa-circle-info" style="color:#ff6f61;"></i> Items from multiple restaurants will stay saved in your cart!</span>
    <% } %>
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
    <div class="menu-grid">
      
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
        %>
        
        <div class="menu-card">
          <% if(inCartQty > 0) { %>
            <div class="in-cart-pill"><i class="fa-solid fa-check"></i> <%= inCartQty %> in cart</div>
          <% } %>
          <img src="<%= menu.getImagepath() %>" alt="menu item" onerror="this.src='https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&auto=format&fit=crop&q=80'">
          <div class="menu-card-content">
            <h3><%= menu.getItemname() %></h3>
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

</body>
</html>