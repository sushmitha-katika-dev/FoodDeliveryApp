package com.foodapp.Servlets;

import java.io.IOException;
import com.foodapp.models.Cart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/apply-coupon")
public class ApplyCouponServlet extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String action = req.getParameter("action");
		
		if ("remove".equalsIgnoreCase(action)) {
			session.removeAttribute("appliedCoupon");
			session.removeAttribute("couponDiscount");
			session.removeAttribute("couponMessage");
			session.removeAttribute("couponError");
			resp.sendRedirect("cart.jsp");
			return;
		}

		String code = req.getParameter("couponCode");
		Cart cart = (Cart) session.getAttribute("cart");
		
		if (cart == null || cart.getItems().isEmpty()) {
			session.setAttribute("couponError", "Your cart is empty!");
			resp.sendRedirect("cart.jsp");
			return;
		}

		double grandTotal = cart.getGrandTotal();
		session.removeAttribute("couponError");
		session.removeAttribute("couponMessage");

		if (code != null) {
			code = code.trim().toUpperCase();
			int discount = 0;
			
			if ("WELCOME50".equals(code)) {
				discount = (int) Math.min(100, grandTotal * 0.50);
				session.setAttribute("appliedCoupon", "WELCOME50");
				session.setAttribute("couponDiscount", discount);
				session.setAttribute("couponMessage", "🎉 WELCOME50 applied! ₹" + discount + " saved.");
			} else if ("FOODZONE20".equals(code)) {
				if (grandTotal >= 200) {
					discount = (int) Math.min(150, grandTotal * 0.20);
					session.setAttribute("appliedCoupon", "FOODZONE20");
					session.setAttribute("couponDiscount", discount);
					session.setAttribute("couponMessage", "🎉 FOODZONE20 applied! ₹" + discount + " saved.");
				} else {
					session.setAttribute("couponError", "FOODZONE20 requires minimum order of ₹200.");
				}
			} else if ("FEAST100".equals(code)) {
				if (grandTotal >= 400) {
					discount = 100;
					session.setAttribute("appliedCoupon", "FEAST100");
					session.setAttribute("couponDiscount", discount);
					session.setAttribute("couponMessage", "🎉 FEAST100 applied! Flat ₹100 discount.");
				} else {
					session.setAttribute("couponError", "FEAST100 requires minimum order of ₹400.");
				}
			} else if ("FREEDEL".equals(code)) {
				session.setAttribute("appliedCoupon", "FREEDEL");
				session.setAttribute("couponDiscount", 35);
				session.setAttribute("couponMessage", "🎉 Free Delivery applied!");
			} else {
				session.setAttribute("couponError", "Invalid coupon code. Try WELCOME50 or FOODZONE20.");
			}
		}

		resp.sendRedirect("cart.jsp");
	}
}
