package com.teacher;

import com.db.DBConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/TeacherLoginServlet")
public class TeacherLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM teachers WHERE email=? AND password=?"
            );

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // ✅ Login Success

                HttpSession session = request.getSession();
                session.setAttribute("teacher", rs.getString("name"));
                session.setAttribute("teacherId", rs.getInt("id"));
                session.setAttribute("department", rs.getString("department"));

                response.sendRedirect(request.getContextPath() + "/TeacherDashboardServlet");

            } else {
                // ❌ Login Failed
                request.setAttribute("error", "Invalid Email or Password!");
                request.getRequestDispatcher("/login/teacherLogin.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}