<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
    <title>Teacher Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/teacher.css">
</head>
<body>

<div class="teacher-layout">

    <!-- SIDEBAR -->
    <aside class="teacher-sidebar">
        <h2>📘 Teacher Panel</h2>

        <ul>
            <li><a href="${pageContext.request.contextPath}/TeacherDashboardServlet">Dashboard</a></li>
            <li>
    <a href="${pageContext.request.contextPath}/TeacherProfileServlet">My Profile</a>
</li>
            <li>
    <a href="${pageContext.request.contextPath}/MyStudentsServlet">My Students</a>
</li>
            <li><a href="${pageContext.request.contextPath}/AttendanceServlet">Attendance</a></li>
            <li><a href="${pageContext.request.contextPath}/MarksEntryServlet">Marks Entry</a></li>
            <li><a href="${pageContext.request.contextPath}/TimeTableServlet">Time Table</a></li>
             <li><a href="${pageContext.request.contextPath}/ChatServlet">
    Group Chat
</a></li>

            <li class="logout">
                <a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a>
            </li>
        </ul>
    </aside>

    <!-- MAIN CONTENT START -->
    <main class="teacher-main">