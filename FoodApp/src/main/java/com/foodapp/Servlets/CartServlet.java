package com.foodapp.Servlets;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import com.foodapp.models.*;
import com.foodapp.DAO.*;
import com.foodapp.DAOImpl.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
		HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        
        String restaurantIdStr = req.getParameter("restaurantId");
        int restaurantId = 0;
        if (restaurantIdStr != null && !restaurantIdStr.trim().isEmpty()) {
            try {
                restaurantId = Integer.parseInt(restaurantIdStr.trim());
                session.setAttribute("restaurantId", restaurantId);
            } catch (NumberFormatException ignored) {}
        }
        
        String action = req.getParameter("action");
        String redirect = req.getParameter("redirect");
        String addedItemName = null;
        
        try {
            if ("add".equals(action)) {
                addedItemName = addItemToCart(req, cart, restaurantId);
            } else if ("update".equals(action)) {
                updateCartItem(req, cart);
            } else if ("remove".equals(action)) {
                removeCartItem(req, cart);
            }
            
            session.setAttribute("cart", cart);
            
            if ("menu".equalsIgnoreCase(redirect) && restaurantId > 0) {
                String ackMsg = addedItemName != null ? URLEncoder.encode(addedItemName, StandardCharsets.UTF_8) : "Item";
                resp.sendRedirect("menu?restaurantId=" + restaurantId + "&added=" + ackMsg);
            } else {
                resp.sendRedirect("cart.jsp");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("cart.jsp");
        }
    }

    private String addItemToCart(HttpServletRequest req, Cart cart, int restaurantId) throws Exception {
        int menuId = Integer.parseInt(req.getParameter("menuId"));
        int quantity = 1;
        String qtyParam = req.getParameter("quantity");
        if (qtyParam != null && !qtyParam.trim().isEmpty()) {
            quantity = Integer.parseInt(qtyParam.trim());
        }
        
        MenuDAO menuDAO = new MenuDAOImpl();
        Menu menuItem = menuDAO.getMenuById(menuId);
        
        if (menuItem != null) {
            int actualRestaurantId = menuItem.getRestaurantid() > 0 ? menuItem.getRestaurantid() : restaurantId;
            CartItem item = new CartItem(menuId, actualRestaurantId, menuItem.getItemname(), quantity, menuItem.getPrice(), quantity * menuItem.getPrice());
            cart.addItemToCart(item);
            return menuItem.getItemname();
        }
        return null;
    }

    private void updateCartItem(HttpServletRequest req, Cart cart) {
        int itemId = Integer.parseInt(req.getParameter("itemId"));
        int newQuantity = Integer.parseInt(req.getParameter("quantity"));
        cart.updateItem(itemId, newQuantity);
    }

    private void removeCartItem(HttpServletRequest req, Cart cart) {
        int itemId = Integer.parseInt(req.getParameter("itemId"));
        cart.removeItem(itemId);
    }		
}