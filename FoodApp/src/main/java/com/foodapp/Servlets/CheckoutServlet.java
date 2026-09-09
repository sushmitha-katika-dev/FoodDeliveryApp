package com.foodapp.Servlets;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.foodapp.models.*;
import com.foodapp.DAO.*;
import com.foodapp.DAOImpl.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
	
	private OrderDAO odao;
	private OrderItemDAO orderItemDao;
	
	@Override
	public void init() throws ServletException {
		odao = new OrderDAOImpl();
		orderItemDao = new OrderItemDAOImpl();
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		Cart cart = (Cart) session.getAttribute("cart");
		User user = (User) session.getAttribute("user");
		
		if (cart != null && user != null && !cart.getItems().isEmpty()) {
			String paymentmode = req.getParameter("payment");
			String address = req.getParameter("address");
			if (address != null && !address.trim().isEmpty()) {
				session.setAttribute("userAddress", address.trim());
			}
			
			// Save copy of cart items for the Swiggy/Zomato style detailed receipt
			List<CartItem> receiptItems = new ArrayList<>(cart.getItems().values());
			int subTotal = (int) cart.getGrandTotal();
			
			Integer discountObj = (Integer) session.getAttribute("couponDiscount");
			int discount = (discountObj != null) ? discountObj : 0;
			String appliedCoupon = (String) session.getAttribute("appliedCoupon");
			int grandTotal = Math.max(0, subTotal - discount);
			
			// Group items by restaurant ID
			Map<Integer, List<CartItem>> itemsByRestaurant = new HashMap<>();
			for (CartItem item : cart.getItems().values()) {
				int rId = item.getRestaurantId();
				if (rId <= 0) {
					Integer sessionRestId = (Integer) session.getAttribute("restaurantId");
					rId = sessionRestId != null ? sessionRestId : 1;
				}
				itemsByRestaurant.computeIfAbsent(rId, k -> new ArrayList<>()).add(item);
			}
			
			List<Order> placedOrders = new ArrayList<>();
			
			for (Map.Entry<Integer, List<CartItem>> entry : itemsByRestaurant.entrySet()) {
				int restId = entry.getKey();
				List<CartItem> restItems = entry.getValue();
				int restTotal = 0;
				for (CartItem itm : restItems) {
					restTotal += (int) itm.getTotalprice();
				}
				
				// Deduct proportional discount if any
				if (subTotal > 0 && discount > 0) {
					double ratio = (double) restTotal / subTotal;
					restTotal = (int) Math.max(0, restTotal - (discount * ratio));
				}
				
				Order order = new Order();
				order.setUserid(user.getUserid());
				order.setRestaurantid(restId);
				order.setOrderdate(new Timestamp(System.currentTimeMillis()));
				order.setPaymentmode(paymentmode != null ? paymentmode : "Card");
				order.setStatus("Confirmed");
				order.setTotalamount(restTotal);
				
				int orderid = odao.addOrder(order);
				order.setOrderid(orderid);
				placedOrders.add(order);
				
				for (CartItem item : restItems) {
					OrderItem orderitem = new OrderItem(orderid, item.getItemId(), item.getQuantity(), (int) item.getTotalprice());
					orderItemDao.addOrderItem(orderitem);
				}
			}
			
			// Set receipt details in session
			session.setAttribute("receiptItems", receiptItems);
			session.setAttribute("receiptSubTotal", subTotal);
			session.setAttribute("receiptDiscount", discount);
			session.setAttribute("receiptCoupon", appliedCoupon);
			session.setAttribute("receiptGrandTotal", grandTotal);
			session.setAttribute("receiptPaymentMode", paymentmode != null ? paymentmode : "Card");
			session.setAttribute("receiptTime", new SimpleDateFormat("dd MMM yyyy, hh:mm a").format(new Date()));
			
			// Clear cart and coupons
			session.removeAttribute("cart");
			session.removeAttribute("appliedCoupon");
			session.removeAttribute("couponDiscount");
			session.removeAttribute("couponMessage");
			session.removeAttribute("couponError");
			
			if (!placedOrders.isEmpty()) {
				session.setAttribute("order", placedOrders.get(0));
				session.setAttribute("placedOrders", placedOrders);
			}
			
			resp.sendRedirect("order_conformation.jsp");
		} else {
			resp.sendRedirect("cart.jsp");
		}
	}
}