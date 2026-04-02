package com.contact;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import com.db.DBConnection;

@WebServlet("/ViewContactServlet")
public class ViewContactServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, String>> list = new ArrayList<>();

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT * FROM contact_messages ORDER BY created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, String> row = new HashMap<>();

                row.put("name", rs.getString("name"));
                row.put("email", rs.getString("email"));
                row.put("message", rs.getString("message"));
                row.put("date", rs.getString("created_at"));

                list.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("messages", list);
        request.getRequestDispatcher("/admin/contactMessages.jsp").forward(request, response);
    }
}