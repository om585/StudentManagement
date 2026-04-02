package com.controller;

import com.db.DBConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/AdminResultServlet")
public class AdminResultServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Map<String, Map<String, List<Map<String, Object>>>> data = new LinkedHashMap<>();
        Set<String> subjects = new LinkedHashSet<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT s.id, s.name, s.department, s.student_class, " +
                         "m.subject, m.marks, m.exam_type " +
                         "FROM students s " +
                         "LEFT JOIN marks m ON s.id = m.student_id " +
                         "ORDER BY s.department, s.student_class";

            ResultSet rs = con.prepareStatement(sql).executeQuery();

            while (rs.next()) {

                int studentId = rs.getInt("id");
                String name = rs.getString("name");
                String dept = rs.getString("department");
                String cls = rs.getString("student_class");
                String subject = rs.getString("subject");
                String examType = rs.getString("exam_type");
                int marks = rs.getInt("marks");

                if (subject != null) subjects.add(subject);

                data.putIfAbsent(dept, new LinkedHashMap<>());
                Map<String, List<Map<String, Object>>> classMap = data.get(dept);

                classMap.putIfAbsent(cls, new ArrayList<>());
                List<Map<String, Object>> students = classMap.get(cls);

                Map<String, Object> studentMap = null;

                for (Map<String, Object> s : students) {
                    if ((int) s.get("id") == studentId) {
                        studentMap = s;
                        break;
                    }
                }

                if (studentMap == null) {
                    studentMap = new HashMap<>();
                    studentMap.put("id", studentId);
                    studentMap.put("name", name);
                    studentMap.put("marks", new HashMap<String, Integer>());
                    students.add(studentMap);
                }

                Map<String, Integer> marksMap =
                        (Map<String, Integer>) studentMap.get("marks");

                if (subject != null) {
                    if ("Internal".equalsIgnoreCase(examType)) {
                        marksMap.put(subject + "_I", marks);
                    } else {
                        marksMap.put(subject + "_E", marks);
                    }
                }
            }

            // ✅ CALCULATE TOTAL, %, GRADE
            for (String dept : data.keySet()) {
                for (String cls : data.get(dept).keySet()) {

                    List<Map<String, Object>> students = data.get(dept).get(cls);

                    for (Map<String, Object> s : students) {

                        Map<String, Integer> marksMap =
                                (Map<String, Integer>) s.get("marks");

                        int total = 0;

                        for (int m : marksMap.values()) {
                            total += m;
                        }

                        double percent = subjects.size() == 0 ? 0 :
                                (total * 100.0 / (subjects.size() * 100));

                        // 🎓 Grade
                        String grade;
                        if (percent >= 75) grade = "A";
                        else if (percent >= 60) grade = "B";
                        else if (percent >= 40) grade = "C";
                        else grade = "Fail";

                        s.put("total", total);
                        s.put("percent", percent);
                        s.put("grade", grade);
                    }

                    // 🏆 Rank (descending %)
                    students.sort((a, b) -> Double.compare(
                            (double) b.get("percent"),
                            (double) a.get("percent")
                    ));

                    int rank = 1;
                    for (Map<String, Object> s : students) {
                        s.put("rank", rank++);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("resultData", data);
        request.setAttribute("subjects", subjects);

        request.getRequestDispatcher("/admin/adminResult.jsp").forward(request, response);
    }
}