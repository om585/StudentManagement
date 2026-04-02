
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../admin/adminHeader.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/addTeacher.css">

<div class="main-content">

    <div class="form-container">

<h2>Add Teacher</h2>

<form action="${pageContext.request.contextPath}/AddTeacherServlet" method="post">

    <input type="text" name="name" placeholder="Name" required><br>

    <input type="email" name="email" placeholder="Email" required><br>

    <input type="text" name="phone" placeholder="Phone"><br>

    <!-- ✅ Department Dropdown -->
    <label>Department:</label><br>
    <select name="department" required>
        <option value="">Select Department</option>
        <option value="BCA">BCA</option>
        <option value="BVOC_CSD">BVOC_CSD</option>
    </select><br><br>

    <!-- ✅ Class Dropdown -->
    <label>Class:</label><br>
    <select name="student_class" required>
        <option value="">Select Class</option>
        <option value="FY">FY</option>
        <option value="SY">SY</option>
        <option value="TY">TY</option>
    </select><br><br>

    <!-- Gender -->
    <label>Gender:</label><br>
    <select name="gender">
        <option>Male</option>
        <option>Female</option>
    </select><br><br>

    <input type="password" name="password" placeholder="Password" required><br>

    <button type="submit">Add Teacher</button>
</form>
</div>
</div>