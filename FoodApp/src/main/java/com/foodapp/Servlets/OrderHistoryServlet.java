package com.foodapp.Servlets;

import java.io.IOException;
import java.util.List;

import com.foodapp.DAO.OrderDAO;
import com.foodapp.DAOImpl.OrderDAOImpl;
import com.foodapp.models.Order;
import com.foodapp.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/my-orders")
public class OrderHistoryServlet extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect("login.jsp");
			return;
		}

		User user = (User) session.getAttribute("user");
		OrderDAO odao = new OrderDAOImpl();
		List<Order> userOrders = odao.getOrdersByUserId(user.getUserid());
		
		req.setAttribute("userOrders", userOrders);
		req.getRequestDispatcher("my_orders.jsp").forward(req, resp);
	}
}
