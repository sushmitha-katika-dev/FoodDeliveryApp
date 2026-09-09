package com.foodapp.Servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.foodapp.DAO.MenuDAO;
import com.foodapp.DAO.OrderDAO;
import com.foodapp.DAO.RestaurantDAO;
import com.foodapp.DAO.UserDAO;
import com.foodapp.DAOImpl.MenuDAOImpl;
import com.foodapp.DAOImpl.OrderDAOImpl;
import com.foodapp.DAOImpl.RestaurantDAOImpl;
import com.foodapp.DAOImpl.UserDAOImpl;
import com.foodapp.models.Menu;
import com.foodapp.models.Order;
import com.foodapp.models.Restaurant;
import com.foodapp.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({"/admin", "/admin-dashboard"})
public class AdminDashboardServlet extends HttpServlet {

    private boolean checkAdminAuthorization(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            resp.sendRedirect("login.jsp?error=Please+login+with+Admin+credentials");
            return false;
        }

        if (!LoginServlet.isAdminRole(user)) {
            // Customer attempted to access admin portal -> protect admin access
            resp.sendRedirect("home?error=Access+Denied:+Admin+authorization+required");
            return false;
        }

        return true;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkAdminAuthorization(req, resp)) {
            return;
        }

        OrderDAO orderDAO = new OrderDAOImpl();
        RestaurantDAO restaurantDAO = new RestaurantDAOImpl();
        MenuDAO menuDAO = new MenuDAOImpl();
        UserDAO userDAO = new UserDAOImpl();

        List<Order> allOrders = orderDAO.getAllOrders();
        List<Restaurant> allRestaurants = restaurantDAO.getAllRestaurants();
        List<Menu> allMenuItems = menuDAO.getAllMenu();
        List<User> allUsers = userDAO.getAllUsers();

        // Calculate business KPIs
        double totalRevenue = 0;
        int activeOrders = 0;
        int completedOrders = 0;

        if (allOrders != null) {
            for (Order o : allOrders) {
                totalRevenue += o.getTotalamount();
                if ("Delivered".equalsIgnoreCase(o.getStatus())) {
                    completedOrders++;
                } else if (!"Cancelled".equalsIgnoreCase(o.getStatus())) {
                    activeOrders++;
                }
            }
        }

        // Restaurant Name lookup (safe)
        Map<Integer, String> restaurantNames = new HashMap<>();
        if (allRestaurants != null) {
            for (Restaurant r : allRestaurants) {
                restaurantNames.put(r.getRestaurantid(), r.getName());
            }
        }

        // Safe User Name lookup ONLY (never expose passwords or sensitive private info)
        Map<Integer, String> userNames = new HashMap<>();
        int customerCount = 0;
        if (allUsers != null) {
            for (User u : allUsers) {
                userNames.put(u.getUserid(), u.getName());
                if (!LoginServlet.isAdminRole(u)) {
                    customerCount++;
                }
            }
        }

        req.setAttribute("allOrders", allOrders);
        req.setAttribute("allRestaurants", allRestaurants);
        req.setAttribute("allMenuItems", allMenuItems);
        req.setAttribute("customerCount", customerCount);
        req.setAttribute("restaurantNames", restaurantNames);
        req.setAttribute("userNames", userNames);
        req.setAttribute("totalRevenue", totalRevenue);
        req.setAttribute("activeOrders", activeOrders);
        req.setAttribute("completedOrders", completedOrders);

        req.getRequestDispatcher("admin_dashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkAdminAuthorization(req, resp)) {
            return;
        }

        String action = req.getParameter("action");
        OrderDAO orderDAO = new OrderDAOImpl();

        if ("updateOrderStatus".equals(action)) {
            String orderIdStr = req.getParameter("orderId");
            String newStatus = req.getParameter("newStatus");

            if (orderIdStr != null && newStatus != null) {
                try {
                    int orderId = Integer.parseInt(orderIdStr);
                    Order order = orderDAO.getOrderById(orderId);
                    if (order != null) {
                        order.setStatus(newStatus);
                        orderDAO.updateOrder(order);
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
        }

        resp.sendRedirect("admin-dashboard");
    }
}
