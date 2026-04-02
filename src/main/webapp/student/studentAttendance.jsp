<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>


<jsp:include page="../student/studentHeader.jsp"/>


<%
    List<String> dates = (List<String>) request.getAttribute("dates");
    List<Integer> values = (List<Integer>) request.getAttribute("values");

    Integer present = (Integer) request.getAttribute("present");
    Integer absent = (Integer) request.getAttribute("absent");
    Double percentage = (Double) request.getAttribute("percentage");

    if (dates == null) {
        dates = new ArrayList<>();
        values = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Attendance</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body>

<div class="main-content">

    <h2>My Attendance</h2>

    <!-- FILTER -->
    <form class="filter-form" method="get" action="${pageContext.request.contextPath}/StudentAttendanceServlet">
        <label>Select Month:</label>
        <input type="month" name="month">
        <button type="submit">Filter</button>
    </form>

    <h3>Attendance Percentage: <%= String.format("%.2f", percentage) %>%</h3>

    <!-- LINE CHART -->
    <div class="chart-container">
        <canvas id="lineChart"></canvas>
    </div>

    <!-- PIE CHART -->
    <div class="chart-container">
        <canvas id="pieChart"></canvas>
    </div>

</div>
<script>
    const labels = [
        <% for(int i=0;i<dates.size();i++){ %>
            "<%= dates.get(i) %>",
        <% } %>
    ];

    const dataValues = [
        <% for(int i=0;i<values.size();i++){ %>
            <%= values.get(i) %>,
        <% } %>
    ];

    new Chart(document.getElementById("lineChart"), {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: "Attendance",
                data: dataValues,
                tension: 0.3
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false   // 🔥 IMPORTANT
        }
    });
</script>



<script>
new Chart(document.getElementById("pieChart"), {
    type: 'pie',
    data: {
        labels: ["Present", "Absent"],
        datasets: [{
            data: [<%= present %>, <%= absent %>]
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false   // 🔥 IMPORTANT
    }
});
</script>

</body>
</html>