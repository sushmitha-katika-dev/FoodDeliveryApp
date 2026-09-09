
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
	
	int count = 1;
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println("Hi from login servlet");

		String email = req.getParameter("email");
        String password = req.getParameter("password");
        
        HttpSession session = req.getSession();
        Integer attempts = (Integer) session.getAttribute("loginAttempts");
        
        if (attempts == null) attempts = 0;

        UserDAO udao = new UserDAOImpl();
        User user = udao.getUserByEmailId(email);
        
        if (user == null) {
            req.setAttribute("error", "Email not registered. Click on 'register here' to create an account</a>");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        } 
        else if (attempts >= 2) {
            req.setAttribute("error", "Account locked. Contact admin for support.");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        } 
        else if (!password.equals(user.getPassword())) {
            attempts++;
            session.setAttribute("loginAttempts", attempts);
            int remaining = 3 - attempts;
            String message = ( remaining > 0 ) ? ( String.format("Wrong password! %d attempt%s remaining.", remaining, remaining > 1 ? "s" : "") ) : ( "Last attempt!" );
            req.setAttribute("error", message);
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        } 
        else {
            // Successful login
            session.setAttribute("userId", user.getUserid());
            session.setAttribute("userAddress", user.getAddress());
            session.setAttribute("user", user);
            session.removeAttribute("loginAttempts");
            req.getRequestDispatcher("home").forward(req, resp);
        }
	}
}