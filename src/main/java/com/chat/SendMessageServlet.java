package com.chat;

import com.db.DBConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/SendMessageServlet")
public class SendMessageServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String sender = null;

        // ✅ Student
        if (session.getAttribute("studentName") != null) {
            sender = (String) session.getAttribute("studentName");
        }

        // ✅ Teacher
        else if (session.getAttribute("teacher") != null) {
            sender = (String) session.getAttribute("teacher");
        }

        // ✅ Admin (STATIC)
        else if (session.getAttribute("admin") != null) {
            sender = "Admin";
        }

        // ❌ Safety
        if (sender == null) {
            sender = "Unknown";
        }

        String message = request.getParameter("message");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO chat_messages(sender_name, message) VALUES (?, ?)"
            );

            ps.setString(1, sender);
            ps.setString(2, message);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("ChatServlet");
    }
}