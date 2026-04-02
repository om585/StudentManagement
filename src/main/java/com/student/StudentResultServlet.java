package com.student;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import com.db.DBConnection;

@WebServlet("/StudentResultServlet")
public class StudentResultServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer studentId = (Integer) session.getAttribute("studentId");

        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login/studentLogin.jsp");
            return;
        }

        Map<String, Map<String, Integer>> subjectMap = new LinkedHashMap<>();

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT subject, marks, exam_type FROM marks WHERE student_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                String subject = rs.getString("subject");
                int marks = rs.getInt("marks");
                String type = rs.getString("exam_type"); // internal / external

                subjectMap.putIfAbsent(subject, new HashMap<>());

                subjectMap.get(subject).put(type.toLowerCase(), marks);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        List<Map<String, Object>> resultList = new ArrayList<>();
        int totalMarks = 0;
        int subjectCount = 0;

        for (String subject : subjectMap.keySet()) {

            int internal = subjectMap.get(subject).getOrDefault("internal", 0);
            int external = subjectMap.get(subject).getOrDefault("semester", 0);
            int total = internal + external;

            Map<String, Object> row = new HashMap<>();
            row.put("subject", subject);
            row.put("internal", internal);
            row.put("semester", external);
            row.put("total", total);

            resultList.add(row);

            totalMarks += total;
            subjectCount++;
        }

        double percentage = 0;
        if (subjectCount > 0) {
            percentage = (totalMarks * 100.0) / (subjectCount * 100);
        }

        request.setAttribute("results", resultList);
        request.setAttribute("totalMarks", totalMarks);
        request.setAttribute("percentage", percentage);

        request.getRequestDispatcher("/student/studentResult.jsp").forward(request, response);
    }
}