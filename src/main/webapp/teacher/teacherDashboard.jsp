<%@ page contentType="text/html;charset=UTF-8" %>

<%
String teacher = (String) session.getAttribute("teacher");

if (teacher == null) {
    response.sendRedirect(request.getContextPath() + "/login/teacherLogin.jsp");
    return;
}
%>

<jsp:include page="../teacher/teacherHeader.jsp"/>

<h1 style="text-align:center;">👨‍🏫 Teacher Dashboard</h1>

<p style="text-align:center;">Welcome, <b><%= teacher %></b></p>

<!-- CARDS -->
<div class="card-container">

    <div class="card">Classes<br><b>${classes}</b></div>
    <div class="card">Students<br><b>${students}</b></div>
    <div class="card">Attendance Today<br><b>${attendance}%</b></div>
    <div class="card">Subjects<br><b>${subjects}</b></div>

</div>

<!-- CHART -->
<div class="chart-container">
    <div class="chart-box">
        <h3 style="text-align:center;">Today's Attendance</h3>
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
    background: #16a085;
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
    type: 'doughnut',
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