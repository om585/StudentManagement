<%@ page language="java" contentType="text/html;charset=UTF-8" %>

<jsp:include page="../teacher/teacherHeader.jsp"/>

<h2 style="text-align:center;">📊 Attendance Report</h2>

<p style="text-align:center;">
    <b>Attendance Percentage:</b> ${percentage}%
</p>

<!-- CHART CONTAINER -->
<div class="chart-container">
    <div class="chart-box">
        <canvas id="attendanceChart"></canvas>
    </div>
</div>

<!-- STYLE -->
<style>

body {
    background: #f4f6f9;
    font-family: Arial;
}

.chart-container {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
}

.chart-box {
    width: 100%;
    max-width: 400px;
    height: 300px;
    background: #fff;
    padding: 15px;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
}

canvas {
    width: 100% !important;
    height: 100% !important;
}

/* Responsive */
@media (max-width: 600px) {
    .chart-box {
        max-width: 100%;
        height: 250px;
    }
}

</style>

<!-- CHART JS -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>

const present = ${present};
const absent = ${absent};

new Chart(document.getElementById("attendanceChart"), {
    type: 'pie',
    data: {
        labels: ['Present', 'Absent'],
        datasets: [{
            data: [present, absent]
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false
    }
});

</script>