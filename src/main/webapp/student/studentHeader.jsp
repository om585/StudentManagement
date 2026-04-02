<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student.css">
</head>
<body>

<div class="student-layout">

    <!-- SIDEBAR -->
    <aside class="student-sidebar">
        <h2>🎓 StudentMS</h2>

        <ul>
            <li><a href="${pageContext.request.contextPath}/StudentDashboardServlet">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/student/studentProfile.jsp">My Profile</a></li>
            <li><a href="${pageContext.request.contextPath}/StudentAttendanceServlet">Attendance</a></li>
            <li><a href="${pageContext.request.contextPath}/StudentResultServlet">Results</a></li>
            <li><a href="${pageContext.request.contextPath}/StudentTimeTableServlet">Time Table</a></li>
            <li><a href="${pageContext.request.contextPath}/ChatServlet">
    Group Chat
</a></li>

            <li class="logout">
                <a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a>
            </li>
        </ul>
    </aside>

    <!-- MAIN CONTENT START -->
    <main class="student-main">