<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<jsp:include page="../admin/adminHeader.jsp"/>

<style>
.chart-container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: center;
}

.chart-box {
    flex: 1 1 400px;
    max-width: 500px;
    background: #fff;
    padding: 15px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.chart-box.full-width {
    flex: 1 1 100%;
    max-width: 100%;
}

canvas {
    width: 100% !important;
    height: 300px !important;
}
</style>

<h2>Admin Attendance Dashboard</h2>

<!-- 📅 DATE FILTER -->
<form method="get" action="AdminAttendanceServlet">
    Select Date:
    <input type="date" name="date" value="${selectedDate}">
    <button type="submit">Filter</button>
</form>

<br>

<!-- 📊 DASHBOARD CARDS -->
<div style="display:flex; gap:20px;">
    <div style="padding:20px; background:#3498db; color:white;">
        Total Students<br><b>${totalStudents}</b>
    </div>

    <div style="padding:20px; background:#2ecc71; color:white;">
        Present<br><b>${totalPresent}</b>
    </div>

    <div style="padding:20px; background:#e74c3c; color:white;">
        Absent<br><b>${totalAbsent}</b>
    </div>

    <div style="padding:20px; background:#9b59b6; color:white;">
        Attendance %<br><b>${presentPercent}%</b>
    </div>
</div>

<br>

<!-- 📊 TABLE -->
<%
Map<String, Map<String, int[]>> data =
    (Map<String, Map<String, int[]>>) request.getAttribute("attendanceData");

if (data != null) {
    for (String dept : data.keySet()) {
%>

<h3>Department: <%= dept %></h3>

<table border="1" width="100%" cellpadding="10">
<tr>
    <th>Class</th>
    <th>Present</th>
    <th>Absent</th>
</tr>

<%
    Map<String, int[]> classMap = data.get(dept);

    for (String cls : classMap.keySet()) {
%>

<tr>
    <td><%= cls %></td>
    <td style="color:green;"><%= classMap.get(cls)[0] %></td>
    <td style="color:red;"><%= classMap.get(cls)[1] %></td>
</tr>

<% } %>
</table>
<br>

<%
    }
}
%>

<!-- 📊 CHARTS -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<h3>Analytics</h3>

<!-- ✅ ADD THIS INSTEAD -->
<div class="chart-container">
    <div class="chart-box">
        <canvas id="barChart"></canvas>
    </div>

    <div class="chart-box">
        <canvas id="pieChart"></canvas>
    </div>
</div>

<br>
<h3>Department Wise Chart</h3>
<br>

<div class="chart-container">
    <div class="chart-box full-width">
        <canvas id="deptChart"></canvas>
    </div>
</div>

<br>



<script>
const present = ${totalPresent};
const absent = ${totalAbsent};

// BAR
new Chart(document.getElementById("barChart"), {
    type: 'bar',
    data: {
        labels: ['Present', 'Absent'],
        datasets: [{
            label: 'Count',
            data: [present, absent]
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false
    }
});

// PIE
new Chart(document.getElementById("pieChart"), {
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

// DEPARTMENT CHART
const deptData = {
<%
Map<String, Integer> deptPresent =
    (Map<String, Integer>) request.getAttribute("deptPresent");

if (deptPresent != null) {
    for (String d : deptPresent.keySet()) {
%>
    "<%=d%>": <%=deptPresent.get(d)%>,
<%
    }
}
%>
};

new Chart(document.getElementById("deptChart"), {
    type: 'bar',
    data: {
        labels: Object.keys(deptData),
        datasets: [{
            label: 'Present Students',
            data: Object.values(deptData)
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false
    }
});
</script>