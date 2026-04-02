package com.controller;

import com.db.DBConnection;
import com.model.Teacher;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/TeacherProfileServlet")
public class TeacherProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer teacherId = (Integer) session.getAttribute("teacherId");

        // 🔐 SECURITY CHECK
        if (teacherId == null) {
            response.sendRedirect(request.getContextPath() + "/teacher/teacherLogin.jsp");
            return;
        }

        Teacher t = new Teacher();

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM teachers WHERE id=?"
            );

            ps.setInt(1, teacherId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                t.setId(rs.getInt("id"));
                t.setName(rs.getString("name"));
                t.setEmail(rs.getString("email"));
                t.setPhone(rs.getString("phone"));
                t.setDepartment(rs.getString("department"));
                t.setGender(rs.getString("gender"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("teacher", t);
        request.getRequestDispatcher("/teacher/myProfile.jsp").forward(request, response);
    }
}