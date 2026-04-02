package com.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/TimeTableServlet")
public class TimeTableServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer teacherId = (Integer) session.getAttribute("teacherId");

        if (teacherId == null) {
            response.sendRedirect(request.getContextPath() + "/login/teacherLogin.jsp");
            return;
        }

        // Get department from session (store during login)
        String department = (String) session.getAttribute("department");

        request.setAttribute("dept", department);

        request.getRequestDispatcher("/teacher/timetable.jsp").forward(request, response);
    }
}