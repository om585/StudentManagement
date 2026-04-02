<%@ page contentType="text/html;charset=UTF-8" %>

<%
String student = (String) session.getAttribute("studentName");

if (student == null) {
    response.sendRedirect(request.getContextPath() + "/login/studentLogin.jsp");
    return;
}
%>

<jsp:include page="../student/studentHeader.jsp"/>

<h1 style="text-align:center;">🎓 Student Dashboard</h1>

<p style="text-align:center;">Welcome, <b><%= student %></b></p>

<!-- CARDS -->
<div class="card-container">

    <div class="card">Subjects<br><b>${subjects}</b></div>
    <div class="card">Attendance<br><b>${attendance}%</b></div>
    <div class="card">Present Days<br><b>${present}</b></div>
    <div class="card">Absent Days<br><b>${absent}</b></div>

</div>

<!-- CHART -->
<div class="chart-container">
    <div class="chart-box">
        <h3 style="text-align:center;">Attendance Overview</h3>
        <canvas id="attendanceChart"></canvas>
    </div>
</div>

<!-- STYLE -->
<style>

body {
    font-family: Arial;
    background: #f4f6f9;
}

.card-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 20px;
    padding: 20px;
}

.card {
    background: #3498db;
    color: white;
    padding: 20px;
    text-align: center;
    border-radius: 10px;
    font-size: 18px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
}

.card b {
    font-size: 28px;
}

.chart-container {
    display: flex;
    justify-content: center;
    padding: 20px;
}

.chart-box {
    width: 100%;
    max-width: 500px;
    height: 300px;
    background: white;
    padding: 15px;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
}

canvas {
    width: 100% !important;
    height: 100% !important;
}

</style>

<!-- CHART JS -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
new Chart(document.getElementById("attendanceChart"), {
    type: 'pie',
    data: {
        labels: ['Present', 'Absent'],
        datasets: [{
            data: [${present}, ${absent}]
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false
    }
});
</script>