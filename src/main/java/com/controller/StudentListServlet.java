package com.controller;

import com.db.*;

import com.model.Student;


import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;


@WebServlet("/StudentListServlet")
@MultipartConfig
public class StudentListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Map<Department, Map<Class, List<Student>>>
        Map<String, Map<String, List<Student>>> data = new LinkedHashMap<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM students ORDER BY department, student_class";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Student s = new Student();

                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setEmail(rs.getString("email"));
                s.setPhone(rs.getString("phone"));
                s.setStudentClass(rs.getString("student_class"));
                s.setDepartment(rs.getString("department"));
                s.setStatus(rs.getString("status"));

                // Grouping logic
                data.putIfAbsent(s.getDepartment(), new LinkedHashMap<>());
                Map<String, List<Student>> classMap = data.get(s.getDepartment());

                classMap.putIfAbsent(s.getStudentClass(), new ArrayList<>());
                classMap.get(s.getStudentClass()).add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("groupedData", data);
        request.getRequestDispatcher("/admin/studentList.jsp").forward(request, response);
    }
}