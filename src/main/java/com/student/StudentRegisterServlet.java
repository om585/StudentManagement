package com.student;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.db.DBConnection;

@WebServlet("/StudentRegisterServlet")
@MultipartConfig
public class StudentRegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String studentClass = request.getParameter("studentClass");
        String department = request.getParameter("department");
        String gender = request.getParameter("gender");
        String guardian = request.getParameter("guardian");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("studentRegister.jsp").forward(request, response);
            return;
        }

        Part filePart = request.getPart("profileImage");
        String fileName = filePart.getSubmittedFileName();

        String uploadPath = getServletContext().getRealPath("") + "uploads";
        File dir = new File(uploadPath);
        if (!dir.exists()) dir.mkdir();

        filePart.write(uploadPath + File.separator + fileName);

        try {
            Connection conn = DBConnection.getConnection();
            
         // 🔍 CHECK IF EMAIL ALREADY EXISTS
            PreparedStatement check = conn.prepareStatement(
                "SELECT * FROM students WHERE email=?"
            );
            check.setString(1, email);

            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                request.setAttribute("error", "Email already registered!");
                request.getRequestDispatcher("/register/studentRegister.jsp").forward(request, response);
                return;
            }

            String sql = "INSERT INTO students(name,email,phone,dob,address,student_class,department,gender,guardian,profile_image,password,status) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, dob);
            ps.setString(5, address);
            ps.setString(6, studentClass);
            ps.setString(7, department);
            ps.setString(8, gender);
            ps.setString(9, guardian);
            ps.setString(10, fileName);
            ps.setString(11, password);
            ps.setString(12, "pending");

            int i = ps.executeUpdate();

            if (i > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("success",
                        "Registration successful! Wait for admin approval.");

                response.sendRedirect(request.getContextPath() + "/login/studentLogin.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}