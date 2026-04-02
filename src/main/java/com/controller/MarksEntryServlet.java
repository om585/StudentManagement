package com.controller;

import com.db.DBConnection;
import com.model.Student;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/MarksEntryServlet")
public class MarksEntryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int teacherId = (int) request.getSession().getAttribute("teacherId");

        List<Student> students = new ArrayList<>();
        Set<String> subjects = new LinkedHashSet<>();

        try {
            Connection con = DBConnection.getConnection();

            // 🔍 Get teacher dept + class
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

            // 🔍 Get students
            PreparedStatement ps2 = con.prepareStatement(
                "SELECT * FROM students WHERE department=? AND student_class=?"
            );
            ps2.setString(1, dept);
            ps2.setString(2, cls);

            ResultSet rs2 = ps2.executeQuery();

            while (rs2.next()) {
                Student s = new Student();
                s.setId(rs2.getInt("id"));
                s.setName(rs2.getString("name"));
                students.add(s);
            }

            // ✅ STATIC SUBJECT LOGIC (REPLACED)
            if (dept.equalsIgnoreCase("BCA")) {
                if (cls.equalsIgnoreCase("FY")) {
                    subjects.add("Maths");
                    subjects.add("English");
                    subjects.add("Computer");
                    subjects.add("EVS");
                    subjects.add("Lab");
                } else if (cls.equalsIgnoreCase("SY")) {
                    subjects.add("Java");
                    subjects.add("DBMS");
                    subjects.add("OS");
                    subjects.add("CN");
                    subjects.add("Lab");
                } else if (cls.equalsIgnoreCase("TY")) {
                    subjects.add("AI");
                    subjects.add("ML");
                    subjects.add("Cloud");
                    subjects.add("Project");
                    subjects.add("Seminar");
                }
            } else if (dept.equalsIgnoreCase("BVOC_CSD")) {
                if (cls.equalsIgnoreCase("FY")) {
                    subjects.add("HTML");
                    subjects.add("CSS");
                    subjects.add("Design");
                    subjects.add("Web");
                    subjects.add("Lab");
                } else if (cls.equalsIgnoreCase("SY")) {
                    subjects.add("JS");
                    subjects.add("React");
                    subjects.add("Node");
                    subjects.add("MongoDB");
                    subjects.add("Lab");
                } else if (cls.equalsIgnoreCase("TY")) {
                    subjects.add("UI/UX");
                    subjects.add("App Dev");
                    subjects.add("Cloud");
                    subjects.add("Project");
                    subjects.add("Lab");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("students", students);
        request.setAttribute("subjects", subjects);

        request.getRequestDispatcher("/teacher/marksEntry.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int teacherId = (int) request.getSession().getAttribute("teacherId");
        String examType = request.getParameter("examType");

        try {
            Connection con = DBConnection.getConnection();

            Map<String, String[]> params = request.getParameterMap();

            for (String key : params.keySet()) {

                if (key.startsWith("marks_")) {

                    String[] parts = key.split("_");
                    int studentId = Integer.parseInt(parts[1]);
                    String subject = parts[2];

                    String markValue = request.getParameter(key);

                    if (markValue == null || markValue.isEmpty()) continue;

                    int marks = Integer.parseInt(markValue);

                    PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO marks(student_id, subject, marks, teacher_id, exam_type) VALUES (?,?,?,?,?) " +
                        "ON DUPLICATE KEY UPDATE marks=?"
                    );

                    ps.setInt(1, studentId);
                    ps.setString(2, subject);
                    ps.setInt(3, marks);
                    ps.setInt(4, teacherId);
                    ps.setString(5, examType);
                    ps.setInt(6, marks);

                    ps.executeUpdate();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("MarksEntryServlet");
    }
}