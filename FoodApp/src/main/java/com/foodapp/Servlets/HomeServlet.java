package com.foodapp.Servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.foodapp.DAO.RestaurantDAO;
import com.foodapp.DAOImpl.RestaurantDAOImpl;
import com.foodapp.models.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RestaurantDAO rdao = new RestaurantDAOImpl();
        List<Restaurant> allRestaurants = null;
        try {
            allRestaurants = rdao.getAllRestaurants();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        if (allRestaurants == null) {
            allRestaurants = new ArrayList<>();
        }
        
        req.setAttribute("allRestaurants", allRestaurants);
        req.getRequestDispatcher("home.jsp").forward(req, resp);
	}
}