package com.student;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import com.db.DBConnection;

@WebServlet("/StudentAttendanceServlet")
public class StudentAttendanceServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer studentId = (Integer) request.getSession().getAttribute("studentId");

        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login/studentLogin.jsp");
            return;
        }

        String month = request.getParameter("month"); // yyyy-MM

        List<String> dates = new ArrayList<>();
        List<Integer> values = new ArrayList<>();

        int present = 0;
        int total = 0;

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT date, status FROM attendance WHERE student_id=?";

            if (month != null && !month.isEmpty()) {
                sql += " AND DATE_FORMAT(date, '%Y-%m') = ?";
            }

            sql += " ORDER BY date";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);

            if (month != null && !month.isEmpty()) {
                ps.setString(2, month);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                dates.add(rs.getString("date"));

                if ("Present".equals(rs.getString("status"))) {
                    values.add(1);
                    present++;
                } else {
                    values.add(0);
                }
                total++;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        double percentage = 0;
        if (total > 0) {
            percentage = (present * 100.0) / total;
        }

        request.setAttribute("dates", dates);
        request.setAttribute("values", values);
        request.setAttribute("present", present);
        request.setAttribute("absent", total - present);
        request.setAttribute("percentage", percentage);
        request.setAttribute("selectedMonth", month);

        request.getRequestDispatcher("/student/studentAttendance.jsp").forward(request, response);
    }
}