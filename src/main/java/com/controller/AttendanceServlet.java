package com.controller;

import com.db.DBConnection;
import com.model.Student;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/AttendanceServlet")
public class AttendanceServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int teacherId = (int) request.getSession().getAttribute("teacherId");

        List<Student> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            // Get teacher dept + class
            PreparedStatement ps1 = con.prepareStatement(
                "SELECT department, student_class FROM teachers WHERE id=?"
            );
            ps1.setInt(1, teacherId);

            ResultSet rs1 = ps1.executeQuery();

            String dept = "", cls = "";

            if (rs1.next()) {
                dept = rs1.getString("department");
                cls = rs1.getString("student_class");
            }

            // Get students
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM students WHERE department=? AND student_class=?"
            );
            ps.setString(1, dept);
            ps.setString(2, cls);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Student s = new Student();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("students", list);
        request.getRequestDispatcher("/teacher/attendance.jsp").forward(request, response);
    }
}