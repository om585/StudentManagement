package com.student;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/StudentTimeTableServlet")
public class StudentTimeTableServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String dept = (String) session.getAttribute("department");
        String cls = (String) session.getAttribute("studentClass");

        if (dept == null || cls == null) {
            response.sendRedirect(request.getContextPath() + "/login/studentLogin.jsp");
            return;
        }

        request.setAttribute("dept", dept);
        request.setAttribute("cls", cls);

        request.getRequestDispatcher("/student/studentTimeTable.jsp").forward(request, response);
    }
}