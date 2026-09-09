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

@WebServlet({"/profile", "/update-profile"})
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User sessionUser = (User) session.getAttribute("user");

        if (sessionUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        UserDAO udao = new UserDAOImpl();
        User currentUser = udao.getUserById(sessionUser.getUserid());
        if (currentUser == null) {
            currentUser = sessionUser;
        }

        req.setAttribute("userProfile", currentUser);
        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User sessionUser = (User) session.getAttribute("user");

        if (sessionUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String name = req.getParameter("name");
        String phonenumber = req.getParameter("phonenumber");
        String address = req.getParameter("address");
        String newPassword = req.getParameter("newPassword");

        UserDAO udao = new UserDAOImpl();
        User user = udao.getUserById(sessionUser.getUserid());

        if (user != null) {
            if (name != null && !name.trim().isEmpty()) {
                user.setName(name.trim());
            }
            if (phonenumber != null && !phonenumber.trim().isEmpty()) {
                user.setPhonenumber(phonenumber.trim());
            }
            if (address != null && !address.trim().isEmpty()) {
                user.setAddress(address.trim());
            }
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                user.setPassword(newPassword.trim());
            }

            udao.updateUser(user);

            // Refresh session attributes
            session.setAttribute("user", user);
            session.setAttribute("userAddress", user.getAddress());
            req.setAttribute("successMessage", "Profile updated successfully!");
        }

        req.setAttribute("userProfile", user);
        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }
}
