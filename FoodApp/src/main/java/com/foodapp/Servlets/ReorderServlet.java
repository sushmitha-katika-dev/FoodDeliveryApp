package com.foodapp.Servlets;

import java.io.IOException;
import java.util.List;

import com.foodapp.DAO.MenuDAO;
import com.foodapp.DAO.OrderItemDAO;
import com.foodapp.DAOImpl.MenuDAOImpl;
import com.foodapp.DAOImpl.OrderItemDAOImpl;
import com.foodapp.models.Cart;
import com.foodapp.models.CartItem;
import com.foodapp.models.Menu;
import com.foodapp.models.OrderItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/reorder")
public class ReorderServlet extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect("login.jsp");
			return;
		}

		String orderIdStr = req.getParameter("orderId");
		if (orderIdStr != null && !orderIdStr.trim().isEmpty()) {
			try {
				int orderId = Integer.parseInt(orderIdStr.trim());
				OrderItemDAO oitemDao = new OrderItemDAOImpl();
				MenuDAO menuDao = new MenuDAOImpl();
				
				List<OrderItem> items = oitemDao.getOrderItemsByOrderId(orderId);
				
				Cart cart = (Cart) session.getAttribute("cart");
				if (cart == null) {
					cart = new Cart();
					session.setAttribute("cart", cart);
				}
				
				for (OrderItem oi : items) {
					Menu menu = menuDao.getMenuById(oi.getMenuid());
					if (menu != null) {
						CartItem ci = new CartItem(
							menu.getMenuid(),
							menu.getRestaurantid(),
							menu.getItemname(),
							oi.getQuantity(),
							menu.getPrice(),
							oi.getQuantity() * menu.getPrice()
						);
						cart.addItemToCart(ci);
					}
				}
				session.setAttribute("cart", cart);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		resp.sendRedirect("cart.jsp");
	}
}
