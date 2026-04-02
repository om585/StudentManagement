package com.student;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

import com.db.DBConnection;

@WebServlet("/StudentLoginServlet")
public class StudentLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT * FROM students WHERE email=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String status = rs.getString("status");

                if ("approved".equalsIgnoreCase(status)) {

                    HttpSession session = request.getSession();

                    int studentId = rs.getInt("id");

                    // ✅ IMPORTANT SESSION VALUES
                    session.setAttribute("studentId", studentId);
                    session.setAttribute("studentName", rs.getString("name"));
                    session.setAttribute("studentEmail", rs.getString("email"));
                    session.setAttribute("department", rs.getString("department"));
                    session.setAttribute("studentClass", rs.getString("student_class"));

                   // System.out.println("LOGIN SUCCESS - Student ID: " + studentId);

                    response.sendRedirect(request.getContextPath() + "/StudentDashboardServlet");

                } else {
                    request.setAttribute("error", "Account pending approval!");
                    request.getRequestDispatcher("/login/studentLogin.jsp").forward(request, response);
                }

            } else {
                request.setAttribute("error", "Invalid credentials!");
                request.getRequestDispatcher("/login/studentLogin.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}