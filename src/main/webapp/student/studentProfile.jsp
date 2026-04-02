<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,com.db.DBConnection" %>
<jsp:include page="../student/studentHeader.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/studentProfile.css">

<%
    Integer studentId = (Integer) session.getAttribute("studentId");

    if (studentId == null) {
        response.sendRedirect(request.getContextPath() + "/login/studentLogin.jsp");
        return;
    }

    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement("SELECT * FROM students WHERE id=?");
    ps.setInt(1, studentId);

    ResultSet rs = ps.executeQuery();
%>

<div class="main-content">

    <div class="profile-card">

        <h2>My Profile</h2>

<%
    if (rs.next()) {
%>



        <!-- Profile Image -->
        <div class="profile-img">
            <img src="<%= request.getContextPath() %>/uploads/<%= rs.getString("profile_image") %>">
        </div>

        <!-- Info -->
        <div class="profile-info">

            <div>
                <span>Name</span>
                <b><%= rs.getString("name") %></b>
            </div>

            <div>
                <span>Email</span>
                <b><%= rs.getString("email") %></b>
            </div>

            <div>
                <span>Phone</span>
                <b><%= rs.getString("phone") %></b>
            </div>

            <div>
                <span>DOB</span>
                <b><%= rs.getString("dob") %></b>
            </div>

            <div>
                <span>Class</span>
                <b><%= rs.getString("student_class") %></b>
            </div>

            <div>
                <span>Department</span>
                <b><%= rs.getString("department") %></b>
            </div>

            <div>
                <span>Gender</span>
                <b><%= rs.getString("gender") %></b>
            </div>

            <div>
                <span>Guardian</span>
                <b><%= rs.getString("guardian") %></b>
            </div>

            <div class="full">
                <span>Address</span>
                <b><%= rs.getString("address") %></b>
            </div>

        </div>

    </div>

</div>
<%
    }
%>