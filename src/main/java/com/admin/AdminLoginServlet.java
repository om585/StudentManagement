package com.admin;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String role = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 🔐 Admin Login Check (Static for now)
        if ("admin".equals(role)) {

            if ("admin".equals(username) && "1234".equals(password)) {

                // Create session
                HttpSession session = request.getSession();
                session.setAttribute("admin", username);

                // Redirect to Admin Dashboard
                response.sendRedirect("AdminDashboardServlet");

            } else {
                // Invalid login
                request.setAttribute("error", "Invalid Admin Credentials!");
                request.getRequestDispatcher("/login/adminLogin.jsp").forward(request, response);
            }
        }
    }
}