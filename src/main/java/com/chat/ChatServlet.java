package com.chat;

import com.db.DBConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/ChatServlet")
public class ChatServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, String>> messages = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM chat_messages ORDER BY created_at ASC"
            );

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, String> msg = new HashMap<>();
                msg.put("name", rs.getString("sender_name"));
                msg.put("text", rs.getString("message"));
                msg.put("time", rs.getString("created_at"));

                messages.add(msg);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("messages", messages);
        request.getRequestDispatcher("/chat/chat.jsp").forward(request, response);
    }
}