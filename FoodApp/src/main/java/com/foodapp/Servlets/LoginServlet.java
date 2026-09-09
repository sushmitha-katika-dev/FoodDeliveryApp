package com.foodapp.Servlets;

import java.io.IOException;

import com.foodapp.DAO.UserDAO;
import com.foodapp.DAOImpl.UserDAOImpl;
import com.foodapp.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    public static boolean isAdminRole(User user) {
        if (user == null || user.getRole() == null) return false;
        String r = user.getRole().trim().toLowerCase();
        return r.contains("admin") || r.contains("owner") || r.contains("partner");
    }
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("email");
        String password = req.getParameter("password");
        
        HttpSession session = req.getSession();
        Integer attempts = (Integer) session.getAttribute("loginAttempts");
        if (attempts == null) attempts = 0;

        UserDAO udao = new UserDAOImpl();
        User user = (email != null) ? udao.getUserByEmailId(email.trim()) : null;
        
        if (user == null) {
            req.setAttribute("error", "Email not registered. Please check your email or register a new account.");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        } 
        
        // If password is correct, log in immediately and route according to role
        if (password != null && password.equals(user.getPassword())) {
            session.setAttribute("userId", user.getUserid());
            session.setAttribute("userAddress", user.getAddress());
            session.setAttribute("user", user);
            session.removeAttribute("loginAttempts");

            // Role-Based Redirection
            if (isAdminRole(user)) {
                resp.sendRedirect("admin-dashboard");
            } else {
                resp.sendRedirect("home");
            }
            return;
        }

        // Handle wrong password
        attempts++;
        session.setAttribute("loginAttempts", attempts);
        int maxAttempts = 5;
        int remaining = maxAttempts - attempts;
        
        if (remaining > 0) {
            req.setAttribute("error", "Incorrect password. " + remaining + " attempt" + (remaining > 1 ? "s" : "") + " remaining.");
        } else {
            session.removeAttribute("loginAttempts"); // reset for next try
            req.setAttribute("error", "Too many failed attempts. Please check your password or use the test credentials below.");
        }
        
        req.getRequestDispatcher("login.jsp").forward(req, resp);
	}
}