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
      z-index: 100;
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
      max-width: 620px;
      margin: 25px auto;
      padding: 0 15px;
    }

    /* Status Card */
    .status-card {
      background: white;
      border-radius: 16px;
      padding: 24px;
      text-align: center;
      box-shadow: 0 4px 16px rgba(0,0,0,0.06);
      margin-bottom: 20px;
      border: 1px solid #eef0f2;
    }

    .success-icon-badge {
      width: 60px;
      height: 60px;
      background: #e8f5e9;
      color: #2e7d32;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 28px;
      margin: 0 auto 12px;
      box-shadow: 0 4px 10px rgba(46,125,50,0.15);
    }

    .status-card h1 {
      font-size: 22px;
      color: #1a1a1a;
      margin-bottom: 4px;
    }

    .status-card .eta-text {
      font-size: 16px;
      font-weight: 700;
      color: #ff6f61;
      margin-bottom: 16px;
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
      width: 40%;
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

    .tracker-step.completed {
      color: #2e7d32;
    }

    .tracker-step.active {
      color: #ff6f61;
    }

    @keyframes pulse {
      0% { box-shadow: 0 0 0 0px rgba(255,111,97,0.4); }
      70% { box-shadow: 0 0 0 8px rgba(255,111,97,0); }
      100% { box-shadow: 0 0 0 0px rgba(255,111,97,0); }
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

    /* Bill Receipt Card (Swiggy/Zomato style) */
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
      font-size: 14px;
      text-transform: uppercase;
      letter-spacing: 0.8px;
      font-weight: 700;
      color: #777;
    }

    .receipt-order-id {
      font-size: 16px;
      font-weight: 700;
      color: #222;
      margin-top: 2px;
    }

    .receipt-date {
      font-size: 13px;
      color: #888;
      text-align: right;
    }

    .restaurant-bill-group {
      margin-bottom: 18px;
      padding-bottom: 12px;
      border-bottom: 1px dashed #e8e8e8;
    }

    .rest-title-pill {
      font-size: 14px;
      font-weight: 700;
      color: #ff6f61;
      margin-bottom: 10px;
      display: flex;
      align-items: center;
      gap: 6px;
    }

    .item-bill-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 6px 0;
      font-size: 14px;
    }

    .item-bill-left {
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .veg-indicator {
      width: 14px;
      height: 14px;
      border: 1.5px solid #2e7d32;
      border-radius: 3px;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .veg-dot {
      width: 6px;
      height: 6px;
      background: #2e7d32;
      border-radius: 50%;
    }

    .item-qty-badge {
      font-size: 12px;
      background: #f0f0f0;
      padding: 2px 6px;
      border-radius: 4px;
      font-weight: 700;
      color: #444;
    }

    .item-bill-price {
      font-weight: 600;
      color: #333;
    }

    .bill-summary-section {
      padding-top: 10px;
    }

    .summary-row {
      display: flex;
      justify-content: space-between;
      font-size: 14px;
      padding: 5px 0;
      color: #555;
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
      border-top: 2px solid #222;
      padding-top: 12px;
      margin-top: 10px;
      font-size: 18px;
      font-weight: 800;
      color: #1a1a1a;
    }

    .payment-status-badge {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      background: #e8f5e9;
      color: #2e7d32;
      padding: 4px 10px;
      border-radius: 6px;
      font-size: 12px;
      font-weight: 700;
      margin-top: 6px;
    }

    .delivery-details-card {
      background: white;
      border-radius: 16px;
      padding: 20px;
      box-shadow: 0 4px 16px rgba(0,0,0,0.06);
      border: 1px solid #eef0f2;
      margin-bottom: 25px;
    }

    .delivery-details-card h3 {
      font-size: 15px;
      color: #222;
      margin-bottom: 12px;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .delivery-info-text {
      font-size: 14px;
      color: #555;
      line-height: 1.5;
    }

    .actions-container {
      display: flex;
      gap: 10px;
    }

    .btn-action {
      flex: 1;
      padding: 14px;
      border-radius: 12px;
      font-weight: bold;
      font-size: 14.5px;
      text-align: center;
      text-decoration: none;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 6px;
      transition: 0.2s;
      border: none;
    }

    .btn-action.home {
      background-color: #ff6f61;
      color: white;
    }

    .btn-action.home:hover {
      background-color: #e65b50;
    }

    .btn-action.orders {
      background-color: #333;
      color: white;
    }

    .btn-action.orders:hover {
      background-color: #111;
    }

    .btn-action.print {
      background-color: white;
      color: #333;
      border: 1px solid #ccc;
    }

    .btn-action.print:hover {
      background-color: #f5f5f5;
    }

    @media print {
      body { background: white; padding: 0; }
      .navbar, .tracker-steps, .actions-container, .driver-card, .nav-link { display: none !important; }
      .main-container { max-width: 100%; margin: 0; padding: 0; }
      .bill-receipt-card, .status-card, .delivery-details-card { box-shadow: none; border: 1px solid #ddd; }
    }
  </style>
</head>
<body>

  <nav class="navbar">
    <div class="logo"><a href="home">FoodZone 🍴</a></div>
    <div>
      <a href="my-orders" class="nav-link"><i class="fa-solid fa-receipt"></i> My Orders</a>
      <a href="home" class="nav-link"><i class="fa-solid fa-house"></i> Home</a>
    </div>
  </nav>

  <%
    List<CartItem> receiptItems = (List<CartItem>)session.getAttribute("receiptItems");
    Integer subTotalObj = (Integer)session.getAttribute("receiptSubTotal");
    int subTotal = (subTotalObj != null) ? subTotalObj : 0;
    Integer discountObj = (Integer)session.getAttribute("receiptDiscount");
    int discount = (discountObj != null) ? discountObj : 0;
    String couponCode = (String)session.getAttribute("receiptCoupon");
    Integer grandTotalObj = (Integer)session.getAttribute("receiptGrandTotal");
    int grandTotal = (grandTotalObj != null) ? grandTotalObj : subTotal;

    String paymentMode = (String)session.getAttribute("receiptPaymentMode");
    if (paymentMode == null) paymentMode = "Online / Card";
    String receiptTime = (String)session.getAttribute("receiptTime");
    if (receiptTime == null) {
      receiptTime = new java.text.SimpleDateFormat("dd MMM yyyy, hh:mm a").format(new java.util.Date());
    }
    String address = (String)session.getAttribute("userAddress");
    if (address == null) address = "Flat 402, Sunshine Heights, MG Road, Bangalore";
    
    User loggedInUser = (User)session.getAttribute("user");
    String userName = (loggedInUser != null) ? loggedInUser.getName() : "Customer";
    String userPhone = (loggedInUser != null) ? loggedInUser.getPhonenumber() : "9876543210";

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

    <!-- 2. Delivery Executive Card -->
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

    <!-- 3. Detailed Swiggy/Zomato Style Bill Receipt -->
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
                <div class="veg-indicator"><div class="veg-dot"></div></div>
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
      <h3><i class="fa-solid fa-location-dot" style="color: #ff6f61;"></i> Delivery Details</h3>
      <div class="delivery-info-text">
        <div><strong><%= userName %></strong> &bull; <%= userPhone %></div>
        <div style="color: #666; margin-top: 4px;"><%= address %></div>
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

</body>
</html>