package com.controller;

import com.db.DBConnection;
import com.model.Teacher;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/TeacherListServlet")
public class TeacherListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Map<String, List<Teacher>> data = new LinkedHashMap<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM teachers ORDER BY department";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Teacher t = new Teacher();

                t.setId(rs.getInt("id"));
                t.setName(rs.getString("name"));
                t.setEmail(rs.getString("email"));
                t.setPhone(rs.getString("phone"));
                t.setDepartment(rs.getString("department"));

                data.putIfAbsent(t.getDepartment(), new ArrayList<>());
                data.get(t.getDepartment()).add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("teacherData", data);
        request.getRequestDispatcher("/admin/teacherList.jsp").forward(request, response);
    }
}