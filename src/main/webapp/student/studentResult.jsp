<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ page import="java.util.*" %>
<jsp:include page="../student/studentHeader.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/studentResult.css">



<%
    List<Map<String, Object>> results =
        (List<Map<String, Object>>) request.getAttribute("results");

    Double percentage = (Double) request.getAttribute("percentage");
    Integer totalMarks = (Integer) request.getAttribute("totalMarks");

    if (results == null) results = new ArrayList<>();
    if (percentage == null) percentage = 0.0;
    if (totalMarks == null) totalMarks = 0;
%>

<div class="main-content">

    <h2>My Result</h2>

    <% if(results.isEmpty()) { %>
        <p class="no-data">No result found!</p>
    <% } else { %>

    <div class="result-card">

        <!-- TABLE -->
        <div class="table-container">
            <table>
                <tr>
                    <th>Subject</th>
                    <th>Internal</th>
                    <th>External</th>
                    <th>Total</th>
                </tr>

                <% for (Map<String, Object> row : results) { %>
                <tr>
                    <td><%= row.get("subject") %></td>
                    <td><%= row.get("internal") %></td>
                    <td><%= row.get("semester") %></td>
                    <td><%= row.get("total") %></td>
                </tr>
                <% } %>

            </table>
        </div>

        <!-- SUMMARY -->
        <div class="result-summary">

            <div class="summary-box">
                <span>Total Marks</span>
                <b><%= totalMarks %></b>
            </div>

            <div class="summary-box">
                <span>Percentage</span>
                <b><%= String.format("%.2f", percentage) %>%</b>
            </div>
<% String grade; if (percentage >= 75) grade = "A"; else if (percentage >= 60) grade = "B"; else if (percentage >= 40) grade = "C"; else grade = "Fail"; %>
            <div class="summary-box">
                <span>Grade</span>
                <b class="grade <%= grade %>"><%= grade %></b>
            </div>

        </div>

    </div>

    <% } %>

</div>