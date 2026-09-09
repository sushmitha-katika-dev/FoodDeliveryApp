package com.foodapp.Servlets;

import java.io.IOException;

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

@WebServlet("/cancel-order")
public class CancelOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        String orderIdStr = req.getParameter("orderId");

        if (orderIdStr != null) {
            try {
                int orderId = Integer.parseInt(orderIdStr);
                OrderDAO orderDAO = new OrderDAOImpl();
                Order order = orderDAO.getOrderById(orderId);

                // Ensure customer owns order or is Admin
                if (order != null) {
                    if (user != null && (user.getUserid() == order.getUserid() || LoginServlet.isAdminRole(user))) {
                        order.setStatus("Cancelled");
                        orderDAO.updateOrder(order);
                        session.setAttribute("cancelSuccess", "Order #" + orderId + " has been cancelled. Your refund of ₹" + order.getTotalamount() + " will be credited within 5 minutes.");
                    }
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        resp.sendRedirect("my-orders");
    }
}
