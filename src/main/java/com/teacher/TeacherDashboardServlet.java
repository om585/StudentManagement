package com.teacher;

import com.db.DBConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/TeacherDashboardServlet")
public class TeacherDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer teacherId = (Integer) session.getAttribute("teacherId");

        if (teacherId == null) {
            response.sendRedirect(request.getContextPath() + "/login/teacherLogin.jsp");
            return;
        }

        int totalStudents = 0;
        int totalClasses = 3; // FY SY TY
        int subjects = 5; // static or dynamic
        int present = 0;
        int total = 0;

        try {
            Connection con = DBConnection.getConnection();

            // Get teacher department
            PreparedStatement ps1 = con.prepareStatement(
                "SELECT department FROM teachers WHERE id=?"
            );
            ps1.setInt(1, teacherId);
            ResultSet rs1 = ps1.executeQuery();

            String dept = "";
            if (rs1.next()) {
                dept = rs1.getString("department");
            }

            // Total students in dept
            PreparedStatement ps2 = con.prepareStatement(
                "SELECT COUNT(*) FROM students WHERE department=?"
            );
            ps2.setString(1, dept);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) totalStudents = rs2.getInt(1);

            // Attendance today
            PreparedStatement ps3 = con.prepareStatement(
                "SELECT status FROM attendance WHERE teacher_id=? AND date=CURDATE()"
            );
            ps3.setInt(1, teacherId);
            ResultSet rs3 = ps3.executeQuery();

            while (rs3.next()) {
                total++;
                if ("Present".equalsIgnoreCase(rs3.getString("status"))) {
                    present++;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        double attendance = total == 0 ? 0 : (present * 100.0 / total);

        request.setAttribute("students", totalStudents);
        request.setAttribute("classes", totalClasses);
        request.setAttribute("subjects", subjects);
        request.setAttribute("attendance", attendance);
        request.setAttribute("present", present);
        request.setAttribute("absent", total - present);

        request.getRequestDispatcher("/teacher/teacherDashboard.jsp").forward(request, response);
    }
}