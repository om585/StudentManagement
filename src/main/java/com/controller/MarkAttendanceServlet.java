package com.controller;

import com.db.DBConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.Map;

@WebServlet("/MarkAttendanceServlet")
public class MarkAttendanceServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String date = request.getParameter("date");
        String today = LocalDate.now().toString();

        // ❌ Check if not today
        if (!date.equals(today)) {
            request.setAttribute("error", "❌ You can mark attendance only for today!");
            request.getRequestDispatcher("/AttendanceServlet").forward(request, response);
            return;
        }

        int teacherId = (int) request.getSession().getAttribute("teacherId");

        try {
            Connection con = DBConnection.getConnection();

            Map<String, String[]> params = request.getParameterMap();

            for (String key : params.keySet()) {

                if (key.startsWith("status_")) {

                    int studentId = Integer.parseInt(key.split("_")[1]);
                    String status = request.getParameter(key);

                    // 🔍 Check if already exists
                    PreparedStatement check = con.prepareStatement(
                        "SELECT * FROM attendance WHERE student_id=? AND date=?"
                    );

                    check.setInt(1, studentId);
                    check.setString(2, date);

                    ResultSet rs = check.executeQuery();

                    if (rs.next()) {
                        // 🔄 Update
                        PreparedStatement update = con.prepareStatement(
                            "UPDATE attendance SET status=? WHERE student_id=? AND date=?"
                        );

                        update.setString(1, status);
                        update.setInt(2, studentId);
                        update.setString(3, date);
                        update.executeUpdate();

                    } else {
                        // ➕ Insert
                        PreparedStatement insert = con.prepareStatement(
                            "INSERT INTO attendance(student_id, teacher_id, date, status) VALUES (?,?,?,?)"
                        );

                        insert.setInt(1, studentId);
                        insert.setInt(2, teacherId);
                        insert.setString(3, date);
                        insert.setString(4, status);
                        insert.executeUpdate();
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("AttendanceServlet");
    }
}