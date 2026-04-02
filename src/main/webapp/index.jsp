<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

<jsp:include page="includes/header.jsp" />

<section class="hero">
    <div class="hero-content">
        <h1>Student Management System</h1>
        <p>
            Manage students, teachers, attendance, results and academic
            data in one secure platform.
        </p>

        <div class="hero-buttons">
            <%-- <a href="login/studentLogin.jsp" class="btn primary">Student Login</a>
            <a href="login/teacherLogin.jsp" class="btn secondary">Teacher Login</a> --%>
            <a href="admin/adminDashboard.jsp" class="btn secondary"> Admin</a>
            <a href="student/studentDashboard.jsp" class="btn secondary">Student</a>
            <a href="teacher/teacherDashboard.jsp" class="btn secondary">Teacher</a>
        </div>
    </div>
</section>

<section class="features">
    <h2>Key Features</h2>

    <div class="feature-box">
        <div class="card">📚 Student Records</div>
        <div class="card">👩‍🏫 Teacher Management</div>
        <div class="card">📝 Attendance Tracking</div>
        <div class="card">📊 Results and Reports</div>
        <div class="card">🔐 Secure Login</div>
        <div class="card">⚡ Fast and Responsive</div>
    </div>
</section>

<jsp:include page="includes/footer.jsp" />