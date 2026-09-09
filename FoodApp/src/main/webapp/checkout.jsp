<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.foodapp.models.Cart, com.foodapp.models.CartItem, com.foodapp.models.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - FoodZone</title>
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
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 30px 15px;
        }

        .navbar-brand {
            margin-bottom: 20px;
        }

        .navbar-brand a {
            font-size: 26px;
            font-weight: bold;
            color: #ff6f61;
            text-decoration: none;
        }

        .checkout-container {
            background-color: #ffffff;
            padding: 30px;
            width: 100%;
            max-width: 480px;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            border: 1px solid #eee;
        }

        .checkout-container h2 {
            font-size: 22px;
            color: #222;
            margin-bottom: 18px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .order-summary-box {
            background: #fff8f6;
            border: 1px solid #ffd8cc;
            padding: 14px 16px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .order-summary-box .row {
            display: flex;
            justify-content: space-between;
            margin: 4px 0;
            font-size: 14px;
            color: #555;
        }

        .order-summary-box .total-row {
            font-weight: bold;
            font-size: 16px;
            color: #ff4d4f;
            border-top: 1px solid #ffd8cc;
            padding-top: 8px;
            margin-top: 8px;
        }

        .checkout-container label {
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 6px;
            display: block;
            color: #333;
        }

        .checkout-container input[type="text"],
        .checkout-container select {
            width: 100%;
            padding: 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 10px;
            margin-bottom: 18px;
            transition: border-color 0.2s;
        }

        .checkout-container input[type="text"]:focus,
        .checkout-container select:focus {
            border-color: #ff6f61;
            outline: none;
        }

        .place-order-btn {
            width: 100%;
            padding: 14px;
            background-color: #ff6f61;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            transition: background-color 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .place-order-btn:hover {
            background-color: #e65b50;
        }

        .back-cart-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #666;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
        }

        .back-cart-link:hover {
            color: #ff6f61;
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="navbar-brand">
        <a href="home">FoodZone 🍴</a>
    </div>

    <%
        Cart cart = (Cart)session.getAttribute("cart");
        int cartCount = (cart != null) ? cart.getTotalCount() : 0;
        int subTotal = (cart != null) ? (int)cart.getGrandTotal() : 0;
        Integer discountObj = (Integer)session.getAttribute("couponDiscount");
        int discount = (discountObj != null) ? discountObj : 0;
        String couponCode = (String)session.getAttribute("appliedCoupon");
        int grandTotal = Math.max(0, subTotal - discount);

        String userAddress = (String)session.getAttribute("userAddress");
        if (userAddress == null || userAddress.trim().isEmpty()) {
            userAddress = "Flat 402, Sunshine Heights, MG Road, Bangalore";
        }
    %>
	
	<div class="checkout-container">
        <h2><i class="fa-solid fa-credit-card" style="color: #ff6f61;"></i> Complete Your Order</h2>

        <div class="order-summary-box">
            <div class="row">
                <span>Total Items:</span>
                <span><strong><%= cartCount %></strong></span>
            </div>
            <div class="row">
                <span>Item Subtotal:</span>
                <span>₹ <%= subTotal %></span>
            </div>
            <% if (discount > 0) { %>
                <div class="row" style="color: #2e7d32; font-weight: 600;">
                    <span>Coupon Discount (<%= couponCode %>):</span>
                    <span>- ₹ <%= discount %></span>
                </div>
            <% } %>
            <div class="row total-row">
                <span>Amount Payable:</span>
                <span>₹ <%= grandTotal %></span>
            </div>
        </div>

	    <form action="checkout" method="POST">
		    <label for="address"><i class="fa-solid fa-location-dot" style="color: #ff6f61;"></i> Delivery Address</label>
		    <input type="text" id="address" name="address" value="<%= userAddress %>" required>
		
		    <label for="payment"><i class="fa-solid fa-wallet" style="color: #ff6f61;"></i> Payment Method</label>
		    <select id="payment" name="payment">
		        <option value="UPI / GPay / PhonePe">UPI / Google Pay / PhonePe</option>
		        <option value="Credit / Debit Card">Credit / Debit Card</option>
		        <option value="Cash on Delivery">Cash on Delivery (COD)</option>
		    </select>

			<button type="submit" class="place-order-btn">
                <i class="fa-solid fa-check"></i> Place Order (₹<%= grandTotal %>)
            </button>
		</form>

        <a href="cart.jsp" class="back-cart-link"><i class="fa-solid fa-arrow-left"></i> Modify Cart / Coupons</a>
	</div>
	
</body>
</html>