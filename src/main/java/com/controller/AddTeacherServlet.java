package com.controller;

import com.db.DBConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/AddTeacherServlet")
public class AddTeacherServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	String email = request.getParameter("email");

        try {
            Connection con = DBConnection.getConnection();
            
            // 🔍 CHECK DUPLICATE EMAIL
            PreparedStatement check = con.prepareStatement(
                "SELECT * FROM teachers WHERE email=?"
            );
            check.setString(1, email);

            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                // ❌ Email already exists
                request.setAttribute("error", "Email already registered!");
                request.getRequestDispatcher("/admin/addTeacher.jsp").forward(request, response);
                return;
            }

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO teachers(name,email,phone,department,student_class,gender,password) VALUES (?,?,?,?,?,?,?)"
            );

            ps.setString(1, request.getParameter("name"));
            ps.setString(2, request.getParameter("email"));
            ps.setString(3, request.getParameter("phone"));
            ps.setString(4, request.getParameter("department"));
            ps.setString(5, request.getParameter("student_class")); // ✅ NEW
            ps.setString(6, request.getParameter("gender"));
            ps.setString(7, request.getParameter("password"));

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("TeacherListServlet");
    }
}