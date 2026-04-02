<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.model.Teacher" %>

<jsp:include page="../teacher/teacherHeader.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/teacherProfile.css">

<%
    Teacher t = (Teacher) request.getAttribute("teacher");
%>

<div class="teacher-content">

    <div class="profile-card">

        <h2>My Profile</h2>

        <div class="profile-info">

            <div>
                <span>ID</span>
                <b><%= t.getId() %></b>
            </div>

            <div>
                <span>Name</span>
                <b><%= t.getName() %></b>
            </div>

            <div>
                <span>Email</span>
                <b><%= t.getEmail() %></b>
            </div>

            <div>
                <span>Phone</span>
                <b><%= t.getPhone() %></b>
            </div>

            <div>
                <span>Department</span>
                <b><%= t.getDepartment() %></b>
            </div>

            <div>
                <span>Gender</span>
                <b><%= t.getGender() %></b>
            </div>

        </div>

    </div>

</div>