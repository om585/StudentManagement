<%@ page language="java" pageEncoding="UTF-8"%>

<%-- <%@ page import="com.sms.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("../login/adminLogin.jsp");
        return;
    }
%>  --%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>

<div class="admin-layout">

    <!-- SIDEBAR -->
    <aside class="admin-sidebar">
        <h2>📊 Admin Panel</h2>

        <ul>
            <li><a href="${pageContext.request.contextPath}/AdminDashboardServlet">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/StudentListServlet">Students</a></li>
            <li><a href="${pageContext.request.contextPath}/TeacherListServlet">Teachers</a></li>
         
            <li><a href="${pageContext.request.contextPath}/AdminAttendanceServlet">ViewAttendance</a></li>
            <li><a href="${pageContext.request.contextPath}/AdminResultServlet">ViewResults</a></li>
             <li><a href="${pageContext.request.contextPath}/ChatServlet">
    Group Chat
</a></li>
<li><a href="${pageContext.request.contextPath}/ViewContactServlet">
    View Contact Messages
</a></li>
            <li class="logout">
                <a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a>
            </li>
        </ul>
    </aside>

    <!-- MAIN CONTENT START -->
    <main class="admin-main">