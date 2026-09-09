<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.foodapp.models.Order, com.foodapp.models.CartItem, com.foodapp.models.User, com.foodapp.DAO.RestaurantDAO, com.foodapp.DAOImpl.RestaurantDAOImpl, com.foodapp.models.Restaurant, java.util.List, java.util.Map, java.util.HashMap, java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Order Confirmed & Live Tracking - FoodZone</title>
  <link type="image/png" rel="icon" href="images/food app header logo.png">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
  <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
      background-color: #f4f6f8;
      color: #333;
      padding-bottom: 50px;
    }

    .navbar {
      background-color: #ff6f61;
      padding: 14px 24px;
      color: white;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0 2px 8px rgba(0,0,0,0.12);
      position: sticky;
      top: 0;
      z-index: 1000;
    }

    .logo a {
      font-size: 22px;
      font-weight: bold;
      color: white;
      text-decoration: none;
    }

    .nav-link {
      color: white;
      text-decoration: none;
      font-weight: 600;
      font-size: 13.5px;
      background: rgba(255,255,255,0.2);
      padding: 6px 14px;
      border-radius: 16px;
      transition: 0.2s;
      margin-left: 8px;
    }

    .nav-link:hover {
      background: rgba(255,255,255,0.3);
    }

    .main-container {
      max-width: 680px;
      margin: 24px auto;
      padding: 0 16px;
    }

    /* Live Status Tracker Card */
    .status-card {
      background: white;
      border-radius: 16px;
      padding: 24px 20px;
      box-shadow: 0 4px 16px rgba(0,0,0,0.06);
      text-align: center;
      margin-bottom: 20px;
      border: 1px solid #eef0f2;
    }

    .success-icon-badge {
      width: 55px;
      height: 55px;
      background: #e8f5e9;
      color: #2e7d32;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 26px;
      margin: 0 auto 12px;
    }

    .status-card h1 {
      font-size: 22px;
      color: #1a1a1a;
      margin-bottom: 4px;
    }

    .eta-text {
      font-size: 15px;
      font-weight: 700;
      color: #ff6f61;
      margin-bottom: 16px;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 6px;
    }

    /* Order Tracker Progress Bar */
    .tracker-steps {
      display: flex;
      justify-content: space-between;
      position: relative;
      margin: 20px 10px 10px;
    }

    .tracker-steps::before {
      content: '';
      position: absolute;
      top: 14px;
      left: 20px;
      right: 20px;
      height: 3px;
      background: #e0e0e0;
      z-index: 1;
    }

    .tracker-progress-line {
      position: absolute;
      top: 14px;
      left: 20px;
      width: 45%;
      height: 3px;
      background: #2e7d32;
      z-index: 2;
    }

    .tracker-step {
      position: relative;
      z-index: 3;
      display: flex;
      flex-direction: column;
      align-items: center;
      font-size: 12px;
      font-weight: 600;
      color: #888;
    }

    .tracker-step .circle {
      width: 30px;
      height: 30px;
      border-radius: 50%;
      background: white;
      border: 2px solid #e0e0e0;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 6px;
      font-size: 13px;
    }

    .tracker-step.completed .circle {
      background: #2e7d32;
      border-color: #2e7d32;
      color: white;
    }

    .tracker-step.active .circle {
      background: #fff;
      border-color: #ff6f61;
      color: #ff6f61;
      box-shadow: 0 0 0 4px #ffeae6;
      animation: pulse 1.5s infinite;
    }

    .tracker-step.completed { color: #2e7d32; }
    .tracker-step.active { color: #ff6f61; }

    @keyframes pulse {
      0% { box-shadow: 0 0 0 0px rgba(255,111,97,0.4); }
      70% { box-shadow: 0 0 0 8px rgba(255,111,97,0); }
      100% { box-shadow: 0 0 0 0px rgba(255,111,97,0); }
    }

    /* Live GPS Map Card */
    .map-card {
      background: white;
      border-radius: 16px;
      padding: 16px;
      box-shadow: 0 4px 16px rgba(0,0,0,0.06);
      border: 1px solid #eef0f2;
      margin-bottom: 20px;
    }

    .map-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 12px;
    }

    .map-title {
      font-size: 14.5px;
      font-weight: 700;
      color: #222;
      display: flex;
      align-items: center;
      gap: 6px;
    }

    .live-pulse-badge {
      background: #e8f5e9;
      color: #2e7d32;
      padding: 3px 8px;
      border-radius: 10px;
      font-size: 11.5px;
      font-weight: 700;
      display: inline-flex;
      align-items: center;
      gap: 4px;
    }

    #liveMap {
      height: 220px;
      width: 100%;
      border-radius: 12px;
      z-index: 10;
    }

    /* Cancellation Banner */
    .cancel-box {
      background: #fff5f5;
      border: 1px solid #fed7d7;
      border-radius: 12px;
      padding: 12px 16px;
      margin-bottom: 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-wrap: wrap;
      gap: 10px;
    }

    .cancel-box span {
      font-size: 13px;
      color: #9b2c2c;
    }

    .cancel-btn {
      background: #e53e3e;
      color: white;
      border: none;
      padding: 6px 14px;
      border-radius: 8px;
      font-size: 12.5px;
      font-weight: 700;
      cursor: pointer;
      transition: background 0.2s;
    }

    .cancel-btn:hover {
      background: #c53030;
    }

    /* Driver Partner Card */
    .driver-card {
      background: white;
      border-radius: 14px;
      padding: 16px 20px;
      box-shadow: 0 4px 14px rgba(0,0,0,0.05);
      border: 1px solid #eef0f2;
      margin-bottom: 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .driver-left {
      display: flex;
      align-items: center;
      gap: 14px;
    }

    .driver-avatar {
      width: 48px;
      height: 48px;
      border-radius: 50%;
      background: #ffeae6;
      color: #ff6f61;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 22px;
    }

    .driver-name {
      font-size: 15px;
      font-weight: 700;
      color: #222;
    }

    .driver-meta {
      font-size: 12.5px;
      color: #666;
    }

    .call-driver-btn {
      background: #f0f0f0;
      color: #333;
      text-decoration: none;
      padding: 8px 14px;
      border-radius: 16px;
      font-size: 13px;
      font-weight: 600;
      display: inline-flex;
      align-items: center;
      gap: 6px;
    }

    /* Bill Receipt Card */
    .bill-receipt-card {
      background: white;
      border-radius: 16px;
      padding: 24px;
      box-shadow: 0 4px 16px rgba(0,0,0,0.06);
      border: 1px solid #eef0f2;
      margin-bottom: 20px;
    }

    .receipt-header {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      border-bottom: 1px solid #f0f0f0;
      padding-bottom: 15px;
      margin-bottom: 18px;
    }

    .receipt-title {
      font-size: 18px;
      font-weight: 800;
      color: #222;
    }

    .receipt-order-id {
      font-size: 13px;
      color: #ff6f61;
      font-weight: 700;
      margin-top: 2px;
    }

    .receipt-date {
      font-size: 12.5px;
      color: #888;
      text-align: right;
    }

    .restaurant-bill-group {
      margin-bottom: 16px;
      padding-bottom: 12px;
      border-bottom: 1px dashed #e8e8e8;
    }

    .rest-title-pill {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      background: #fff0ed;
      color: #ff6f61;
      padding: 3px 10px;
      border-radius: 6px;
      font-size: 12px;
      font-weight: 700;
      margin-bottom: 10px;
    }

    .item-bill-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 14px;
      margin-bottom: 8px;
    }

    .item-bill-left {
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .item-qty-badge {
      background: #f0f2f5;
      color: #444;
      font-size: 12px;
      font-weight: bold;
      padding: 2px 6px;
      border-radius: 4px;
    }

    .item-bill-price {
      font-weight: 600;
      color: #333;
    }

    .bill-summary-section {
      margin-top: 18px;
      padding-top: 14px;
      border-top: 2px solid #f4f6f8;
    }

    .summary-row {
      display: flex;
      justify-content: space-between;
      font-size: 13.5px;
      color: #666;
      margin-bottom: 7px;
    }

    .summary-row.free-tag span:last-child {
      color: #2e7d32;
      font-weight: bold;
    }

    .summary-row.discount-row {
      color: #2e7d32;
      font-weight: 600;
    }

    .summary-row.grand-total-row {
      font-size: 17px;
      font-weight: 800;
      color: #111;
      border-top: 1px solid #eef0f2;
      padding-top: 10px;
      margin-top: 10px;
    }

    .payment-status-badge {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      background: #e8f5e9;
      color: #2e7d32;
      font-size: 12.5px;
      font-weight: 700;
      padding: 5px 12px;
      border-radius: 20px;
      margin-top: 8px;
    }

    .delivery-details-card {
      background: white;
      border-radius: 14px;
      padding: 18px 20px;
      box-shadow: 0 4px 14px rgba(0,0,0,0.05);
      border: 1px solid #eef0f2;
      margin-bottom: 20px;
    }

    .delivery-details-card h3 {
      font-size: 15px;
      color: #222;
      margin-bottom: 8px;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .actions-container {
      display: grid;
      grid-template-columns: 1fr 1fr 1fr;
      gap: 10px;
    }

    .btn-action {
      padding: 12px;
      border-radius: 12px;
      font-size: 14px;
      font-weight: bold;
      text-align: center;
      text-decoration: none;
      border: none;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 6px;
      transition: all 0.2s;
    }

    .btn-action.print { background: #e2e8f0; color: #334155; }
    .btn-action.orders { background: #fee2e2; color: #dc2626; }
    .btn-action.home { background: #ff6f61; color: white; }
  </style>
</head>
<body>

  <nav class="navbar">
    <div class="logo"><a href="home">FoodZone 🍴</a></div>
    <div>
      <a href="my-orders" class="nav-link"><i class="fa-solid fa-receipt"></i> Orders</a>
      <a href="home" class="nav-link"><i class="fa-solid fa-house"></i> Home</a>
    </div>
  </nav>

  <%
    List<CartItem> receiptItems = (List<CartItem>)session.getAttribute("receiptItems");
    Integer grandTotal = (Integer)session.getAttribute("receiptTotal");
    if (grandTotal == null) grandTotal = (Integer)request.getAttribute("totalAmount");
    if (grandTotal == null) grandTotal = 0;

    Integer subTotal = (Integer)session.getAttribute("receiptSubtotal");
    if (subTotal == null) subTotal = grandTotal;

    Integer discount = (Integer)session.getAttribute("receiptDiscount");
    if (discount == null) discount = 0;

    String couponCode = (String)session.getAttribute("receiptCoupon");
    String paymentMode = (String)session.getAttribute("receiptPayment");
    if (paymentMode == null) paymentMode = "Online Payment";

    String address = (String)session.getAttribute("receiptAddress");
    if (address == null) address = "Flat 402, Sunshine Heights, MG Road, Bangalore";

    String receiptTime = (String)session.getAttribute("receiptTime");
    if (receiptTime == null) receiptTime = "Just now";

    User loggedInUser = (User)session.getAttribute("user");
    String userName = (loggedInUser != null) ? loggedInUser.getName() : "Customer";
    String userPhone = (loggedInUser != null && loggedInUser.getPhonenumber() != null) ? loggedInUser.getPhonenumber() : "+91 9876543210";

    List<Order> placedOrders = (List<Order>)session.getAttribute("placedOrders");
    RestaurantDAO rdao = new RestaurantDAOImpl();

    Map<Integer, List<CartItem>> itemsByRest = new HashMap<>();
    if (receiptItems != null) {
      for (CartItem itm : receiptItems) {
        itemsByRest.computeIfAbsent(itm.getRestaurantId(), k -> new ArrayList<>()).add(itm);
      }
    }
  %>

  <div class="main-container">

    <!-- 1. Status & Live Tracking Card -->
    <div class="status-card">
      <div class="success-icon-badge">
        <i class="fa-solid fa-check"></i>
      </div>
      <h1>Order Placed Successfully!</h1>
      <div class="eta-text"><i class="fa-solid fa-bolt"></i> Estimated Delivery: 25 - 35 mins</div>

      <!-- Tracker -->
      <div class="tracker-steps">
        <div class="tracker-progress-line"></div>
        <div class="tracker-step completed">
          <div class="circle"><i class="fa-solid fa-check"></i></div>
          <span>Confirmed</span>
        </div>
        <div class="tracker-step active">
          <div class="circle"><i class="fa-solid fa-fire-burner"></i></div>
          <span>Cooking</span>
        </div>
        <div class="tracker-step">
          <div class="circle"><i class="fa-solid fa-motorcycle"></i></div>
          <span>On the Way</span>
        </div>
        <div class="tracker-step">
          <div class="circle"><i class="fa-solid fa-house-chimney"></i></div>
          <span>Delivered</span>
        </div>
      </div>
    </div>

    <!-- 1.5 Interactive GPS Live Map Tracking -->
    <div class="map-card">
      <div class="map-header">
        <div class="map-title"><i class="fa-solid fa-map-location-dot" style="color:#ff6f61;"></i> Live Delivery Route</div>
        <span class="live-pulse-badge"><i class="fa-solid fa-circle" style="font-size:8px; animation: pulse 1s infinite;"></i> GPS Live</span>
      </div>
      <div id="liveMap"></div>
    </div>

    <!-- 1.8 60-Second Grace Cancellation Box -->
    <% if (placedOrders != null && !placedOrders.isEmpty()) { 
         Order firstOrder = placedOrders.get(0);
    %>
      <div class="cancel-box" id="cancelGraceBox">
        <span>⏱️ Made a mistake? Cancel within <strong id="graceTimer">58s</strong> for an instant refund.</span>
        <form action="cancel-order" method="POST" style="margin:0;">
          <input type="hidden" name="orderId" value="<%= firstOrder.getOrderid() %>">
          <button type="submit" class="cancel-btn" onclick="return confirm('Are you sure you want to cancel this order? Your refund will be processed immediately.')">
            <i class="fa-solid fa-xmark"></i> Cancel Order
          </button>
        </form>
      </div>
    <% } %>

    <!-- 2. Delivery Partner Card -->
    <div class="driver-card">
      <div class="driver-left">
        <div class="driver-avatar"><i class="fa-solid fa-motorcycle"></i></div>
        <div>
          <div class="driver-name">Ramesh Kumar <span style="font-size:12px; color:#2e7d32; font-weight:normal;">⭐ 4.9</span></div>
          <div class="driver-meta">Delivery Partner Assigned &bull; KA-01-EF-2490</div>
        </div>
      </div>
      <a href="tel:9876543210" class="call-driver-btn"><i class="fa-solid fa-phone"></i> Call</a>
    </div>

    <!-- 3. Detailed Swiggy/Zomato Bill Receipt -->
    <div class="bill-receipt-card">
      <div class="receipt-header">
        <div>
          <div class="receipt-title">Digital Invoice & Receipt</div>
          <div class="receipt-order-id">
            <% if (placedOrders != null && !placedOrders.isEmpty()) { 
                 StringBuilder ids = new StringBuilder();
                 for(int i=0; i<placedOrders.size(); i++) {
                   if(i>0) ids.append(", #");
                   else ids.append("#FZ-");
                   ids.append(placedOrders.get(i).getOrderid());
                 }
            %>
              <%= ids.toString() %>
            <% } else { %>
              #FZ-89210
            <% } %>
          </div>
        </div>
        <div class="receipt-date">
          <i class="fa-regular fa-clock"></i> <%= receiptTime %>
        </div>
      </div>

      <!-- Itemized List by Restaurant -->
      <% if (!itemsByRest.isEmpty()) { 
           for (Map.Entry<Integer, List<CartItem>> entry : itemsByRest.entrySet()) {
             int rId = entry.getKey();
             List<CartItem> rItems = entry.getValue();
             Restaurant r = rdao.getRestaurantById(rId);
             String restName = (r != null) ? r.getName() : "Restaurant #" + rId;
      %>
        <div class="restaurant-bill-group">
          <div class="rest-title-pill">
            <i class="fa-solid fa-store"></i> <%= restName %>
          </div>

          <% for (CartItem itm : rItems) { %>
            <div class="item-bill-row">
              <div class="item-bill-left">
                <span class="item-qty-badge"><%= itm.getQuantity() %>x</span>
                <span><%= itm.getName() %></span>
              </div>
              <div class="item-bill-price">₹ <%= (int)itm.getTotalprice() %></div>
            </div>
          <% } %>
        </div>
      <%   } 
         } %>

      <!-- Bill Calculation Breakdown -->
      <div class="bill-summary-section">
        <div class="summary-row">
          <span>Item Subtotal</span>
          <span>₹ <%= subTotal > 0 ? subTotal : grandTotal %></span>
        </div>
        <% if (discount > 0) { %>
          <div class="summary-row discount-row">
            <span>Coupon Discount (<%= couponCode %>)</span>
            <span>- ₹ <%= discount %></span>
          </div>
        <% } %>
        <div class="summary-row free-tag">
          <span>Delivery Partner Fee (Discounted)</span>
          <span><span style="text-decoration: line-through; color: #999; font-weight: normal; margin-right: 4px;">₹35</span> FREE</span>
        </div>
        <div class="summary-row">
          <span>Platform Fee</span>
          <span>₹ 5</span>
        </div>
        <div class="summary-row">
          <span>Restaurant GST & Taxes (5%)</span>
          <span>₹ <%= Math.max(12, (int)(grandTotal * 0.05)) %></span>
        </div>

        <div class="summary-row grand-total-row">
          <span>Total Amount</span>
          <span>₹ <%= grandTotal %></span>
        </div>

        <div style="margin-top: 10px;">
          <span class="payment-status-badge">
            <i class="fa-solid fa-circle-check"></i> <%= paymentMode.equalsIgnoreCase("Cash on Delivery") ? "Cash to Pay on Delivery" : "PAID ONLINE (" + paymentMode + ")" %>
          </span>
        </div>
      </div>
    </div>

    <!-- 4. Delivery Details Card -->
    <div class="delivery-details-card">
      <h3><i class="fa-solid fa-location-dot" style="color: #ff6f61;"></i> Delivery Destination</h3>
      <div class="delivery-info-text">
        <div><strong><%= userName %></strong> &bull; <%= userPhone %></div>
        <div style="color: #666; margin-top: 4px;"><%= address %></div>
      </div>
    </div>

    <!-- 4.5. Interactive Experience Rating Card -->
    <div class="delivery-details-card" id="ratingCard" style="text-align: center; padding: 22px;">
      <h3 style="justify-content: center; margin-bottom: 8px;"><i class="fa-solid fa-star" style="color: #f59e0b;"></i> Rate Your Food & Delivery</h3>
      <p style="font-size: 13.5px; color: #666; margin-bottom: 12px;">How was your experience with FoodZone today?</p>
      
      <div id="starContainer" style="font-size: 28px; color: #e2e8f0; cursor: pointer; display: flex; justify-content: center; gap: 8px; margin-bottom: 14px;">
        <i class="fa-solid fa-star rating-star" data-val="1" onclick="submitRating(1)"></i>
        <i class="fa-solid fa-star rating-star" data-val="2" onclick="submitRating(2)"></i>
        <i class="fa-solid fa-star rating-star" data-val="3" onclick="submitRating(3)"></i>
        <i class="fa-solid fa-star rating-star" data-val="4" onclick="submitRating(4)"></i>
        <i class="fa-solid fa-star rating-star" data-val="5" onclick="submitRating(5)"></i>
      </div>

      <div id="ratingFeedback" style="display: none; background: #ecfdf5; border: 1px solid #a7f3d0; color: #065f46; padding: 10px 16px; border-radius: 10px; font-size: 14px; font-weight: 600;">
        🎉 Thank you! Your 5★ rating has been submitted to the kitchen partner.
      </div>
    </div>

    <!-- 5. Action Buttons -->
    <div class="actions-container">
      <button class="btn-action print" onclick="window.print()">
        <i class="fa-solid fa-print"></i> Print
      </button>
      <a href="my-orders" class="btn-action orders">
        <i class="fa-solid fa-receipt"></i> My Orders
      </a>
      <a href="home" class="btn-action home">
        <i class="fa-solid fa-utensils"></i> Order More
      </a>
    </div>

  </div>

  <script>
    // 1. Leaflet GPS Route Simulation
    document.addEventListener("DOMContentLoaded", function() {
      if (document.getElementById('liveMap')) {
        const kitchenPos = [12.9716, 77.5946]; // Bangalore center
        const customerPos = [12.9850, 77.6400]; // Delivery address

        const map = L.map('liveMap', { zoomControl: false }).setView([12.978, 77.617], 13);
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
          maxZoom: 18,
          attribution: '&copy; OpenStreetMap'
        }).addTo(map);

        // Markers
        const restMarker = L.marker(kitchenPos).addTo(map).bindPopup('<b>Kitchen Partner</b><br>Order is cooking').openPopup();
        const homeMarker = L.marker(customerPos).addTo(map).bindPopup('<b>Delivery Address</b><br>Your location');

        // Route Polyline
        const routePoints = [
          kitchenPos,
          [12.9750, 77.6050],
          [12.9800, 77.6200],
          [12.9820, 77.6320],
          customerPos
        ];
        L.polyline(routePoints, { color: '#ff6f61', weight: 4, opacity: 0.8, dashArray: '8, 8' }).addTo(map);

        // Moving Bike Marker
        let step = 0;
        const bikeIcon = L.divIcon({
          html: '<div style="background:#ff6f61; color:white; width:32px; height:32px; border-radius:50%; display:flex; align-items:center; justify-content:center; box-shadow:0 0 10px rgba(255,111,97,0.8);"><i class="fa-solid fa-motorcycle"></i></div>',
          className: 'bike-icon',
          iconSize: [32, 32],
          iconAnchor: [16, 16]
        });
        const bikeMarker = L.marker(routePoints[0], { icon: bikeIcon }).addTo(map);

        setInterval(() => {
          step = (step + 1) % routePoints.length;
          bikeMarker.setLatLng(routePoints[step]);
        }, 3000);
      }
    });

    // 2. Star Rating Handler
    function submitRating(stars) {
      const allStars = document.querySelectorAll('.rating-star');
      allStars.forEach((star, idx) => {
        if (idx < stars) {
          star.style.color = '#f59e0b';
        } else {
          star.style.color = '#e2e8f0';
        }
      });
      const feedback = document.getElementById('ratingFeedback');
      feedback.style.display = 'block';
      feedback.innerHTML = '🎉 Thank you! Your ' + stars + '★ review has been shared with the restaurant.';
    }

    // 3. Grace Cancellation Timer
    let graceSeconds = 60;
    const graceTimerElem = document.getElementById('graceTimer');
    const graceBox = document.getElementById('cancelGraceBox');
    if (graceTimerElem && graceBox) {
      const countdown = setInterval(() => {
        graceSeconds--;
        if (graceSeconds > 0) {
          graceTimerElem.textContent = graceSeconds + 's';
        } else {
          clearInterval(countdown);
          graceBox.style.display = 'none';
        }
      }, 1000);
    }
  </script>
</body>
</html>