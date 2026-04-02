package com.controller;

import com.db.DBConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/AttendanceReportServlet")
public class AttendanceReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int studentId = Integer.parseInt(request.getParameter("studentId"));

        int total = 0;
        int present = 0;

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

        double percentage = (total == 0) ? 0 : (present * 100.0 / total);

        request.setAttribute("percentage", percentage);
        request.setAttribute("present", present);
        request.setAttribute("absent", total - present);

        request.getRequestDispatcher("/teacher/report.jsp").forward(request, response);
    }
}