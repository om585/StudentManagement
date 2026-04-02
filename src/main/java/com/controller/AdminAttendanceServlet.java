package com.controller;

import com.db.DBConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/AdminAttendanceServlet")
public class AdminAttendanceServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String date = request.getParameter("date");

        if (date == null || date.isEmpty()) {
            date = java.time.LocalDate.now().toString(); // default today
        }

        Map<String, Map<String, int[]>> data = new LinkedHashMap<>();
        Map<String, Integer> deptPresent = new LinkedHashMap<>();

        int totalPresent = 0;
        int totalAbsent = 0;
        int totalStudents = 0;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT s.department, s.student_class, a.status " +
                         "FROM attendance a " +
                         "JOIN students s ON a.student_id = s.id " +
                         "WHERE a.date=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, date);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                String dept = rs.getString("department");
                String cls = rs.getString("student_class");
                String status = rs.getString("status");

                data.putIfAbsent(dept, new LinkedHashMap<>());
                Map<String, int[]> classMap = data.get(dept);

                classMap.putIfAbsent(cls, new int[]{0, 0});

                deptPresent.putIfAbsent(dept, 0);

                if ("Present".equalsIgnoreCase(status)) {
                    classMap.get(cls)[0]++;
                    totalPresent++;
                    deptPresent.put(dept, deptPresent.get(dept) + 1);
                } else {
                    classMap.get(cls)[1]++;
                    totalAbsent++;
                }

                totalStudents++;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        double presentPercent = totalStudents == 0 ? 0 : (totalPresent * 100.0 / totalStudents);

        request.setAttribute("attendanceData", data);
        request.setAttribute("totalPresent", totalPresent);
        request.setAttribute("totalAbsent", totalAbsent);
        request.setAttribute("totalStudents", totalStudents);
        request.setAttribute("presentPercent", presentPercent);
        request.setAttribute("deptPresent", deptPresent);
        request.setAttribute("selectedDate", date);

        request.getRequestDispatcher("/admin/adminAttendance.jsp").forward(request, response);
    }
}