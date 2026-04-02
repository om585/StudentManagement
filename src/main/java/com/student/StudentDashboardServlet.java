package com.student;

import com.db.DBConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/StudentDashboardServlet")
public class StudentDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer studentId = (Integer) session.getAttribute("studentId");

        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login/studentLogin.jsp");
            return;
        }

        int totalSubjects = 5; // static for now
        int present = 0;
        int total = 0;

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT status FROM attendance WHERE student_id=?"
            );
            ps.setInt(1, studentId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                total++;
                if ("Present".equalsIgnoreCase(rs.getString("status"))) {
                    present++;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        double percentage = total == 0 ? 0 : (present * 100.0 / total);

        request.setAttribute("subjects", totalSubjects);
        request.setAttribute("attendance", percentage);
        request.setAttribute("present", present);
        request.setAttribute("absent", total - present);

        request.getRequestDispatcher("/student/studentDashboard.jsp").forward(request, response);
    }
}