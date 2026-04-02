package com.controller;

import com.db.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/UpdateStudentStatusServlet")
public class UpdateStudentStatusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String action = request.getParameter("action");

        try {
            Connection con = DBConnection.getConnection();

            if ("approve".equals(action)) {

                // ✅ APPROVE → update status
                PreparedStatement ps = con.prepareStatement(
                    "UPDATE students SET status='approved' WHERE id=?"
                );
                ps.setInt(1, id);
                ps.executeUpdate();

            } else if ("deny".equals(action)) {

                // ❌ DENY → DELETE student
                PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM students WHERE id=?"
                );
                ps.setInt(1, id);
                ps.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("StudentListServlet");
    }
}