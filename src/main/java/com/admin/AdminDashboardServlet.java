package com.admin;

import com.db.DBConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int totalStudents = 0;
        int totalTeachers = 0;
        int totalClasses = 6; // FY SY TY
        int totalSubjects = 30; // static or change later
        double attendancePercent = 0;

        try {
            Connection con = DBConnection.getConnection();

            // Students
            PreparedStatement ps1 = con.prepareStatement("SELECT COUNT(*) FROM students");
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) totalStudents = rs1.getInt(1);

            // Teachers
            PreparedStatement ps2 = con.prepareStatement("SELECT COUNT(*) FROM teachers");
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) totalTeachers = rs2.getInt(1);

            // Attendance %
            PreparedStatement ps3 = con.prepareStatement(
                "SELECT COUNT(*) total, SUM(CASE WHEN status='Present' THEN 1 ELSE 0 END) present FROM attendance"
            );
            ResultSet rs3 = ps3.executeQuery();

            if (rs3.next()) {
                int total = rs3.getInt("total");
                int present = rs3.getInt("present");

                if (total != 0)
                    attendancePercent = (present * 100.0) / total;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("students", totalStudents);
        request.setAttribute("teachers", totalTeachers);
        request.setAttribute("classes", totalClasses);
        request.setAttribute("subjects", totalSubjects);
        request.setAttribute("attendance", attendancePercent);

        request.getRequestDispatcher("/admin/adminDashboard.jsp").forward(request, response);
    }
}