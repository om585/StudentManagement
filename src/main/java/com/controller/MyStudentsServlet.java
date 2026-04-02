package com.controller;

import com.db.DBConnection;
import com.model.Student;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/MyStudentsServlet")
public class MyStudentsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer teacherId = (Integer) session.getAttribute("teacherId");

        if (teacherId == null) {
            response.sendRedirect(request.getContextPath() + "/login/teacherLogin.jsp");
            return;
        }

        Map<String, List<Student>> data = new LinkedHashMap<>();

        try {
            Connection con = DBConnection.getConnection();

            // 🔍 Get teacher department
            PreparedStatement ps1 = con.prepareStatement(
                "SELECT department FROM teachers WHERE id=?"
            );
            ps1.setInt(1, teacherId);

            ResultSet rs1 = ps1.executeQuery();
            String dept = "";

            if (rs1.next()) {
                dept = rs1.getString("department");
            }

            // 🔍 Get students of same department
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM students WHERE department=? ORDER BY student_class"
            );

            ps.setString(1, dept);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Student s = new Student();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setStudentClass(rs.getString("student_class"));

                // 🔥 GROUP BY CLASS
                data.putIfAbsent(s.getStudentClass(), new ArrayList<>());
                data.get(s.getStudentClass()).add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("studentData", data);
        request.getRequestDispatcher("/teacher/myStudents.jsp").forward(request, response);
    }
}