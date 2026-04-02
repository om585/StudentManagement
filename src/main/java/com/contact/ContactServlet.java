package com.contact;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.db.DBConnection;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔹 Get data from form
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "INSERT INTO contact_messages(name, email, message) VALUES (?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, message);

            int i = ps.executeUpdate();

            if (i > 0) {
                // Success message
                request.setAttribute("success", "Message sent successfully!");
            } else {
                request.setAttribute("error", "Failed to send message.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong!");
        }

        // Redirect back to contact page
        request.getRequestDispatcher("/includes/contact.jsp").forward(request, response);
    }
}