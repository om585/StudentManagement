<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    


<%
String admin = (String) session.getAttribute("admin");
if (admin == null) {
    response.sendRedirect(request.getContextPath() + "/login/adminLogin.jsp");
    return;
}
%>

<jsp:include page="../admin/adminHeader.jsp"/>

<h1 style="text-align:center;">📊 Admin Dashboard</h1>

<!-- DASHBOARD CARDS -->
<div class="card-container">

    <div class="card">Students<br><b>${students}</b></div>
    <div class="card">Teachers<br><b>${teachers}</b></div>
    <div class="card">Classes<br><b>${classes}</b></div>
    <div class="card">Subjects<br><b>${subjects}</b></div>
    <div class="card">Attendance<br><b>${attendance}%</b></div>

</div>

<!-- CHART SECTION -->
<div class="chart-container">

    <div class="chart-box">
        <h3 style="text-align:center;">Overview</h3>
        <canvas id="barChart"></canvas>
    </div>

    <div class="chart-box">
        <h3 style="text-align:center;">Attendance</h3>
        <canvas id="pieChart"></canvas>
    </div>

</div>

<!-- STYLES -->
<style>

body {
    font-family: Arial;
    background: #f4f6f9;
}

/* Cards */
.card-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 20px;
    padding: 20px;
}

.card {
    background: #2c3e50;
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

/* Charts */
.chart-container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: center;
    padding: 20px;
}

.chart-box {
    width: 100%;
    max-width: 500px;
    height: 320px;
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

// BAR CHART
new Chart(document.getElementById("barChart"), {
    type: 'bar',
    data: {
        labels: ['Students', 'Teachers', 'Classes', 'Subjects'],
        datasets: [{
            label: 'Overview',
            data: [
                ${students},
                ${teachers},
                ${classes},
                ${subjects}
            ]
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false
    }
});

// PIE CHART
new Chart(document.getElementById("pieChart"), {
    type: 'pie',
    data: {
        labels: ['Present', 'Absent'],
        datasets: [{
            data: [
                ${attendance},
                100 - ${attendance}
            ]
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false
    }
});

</script>