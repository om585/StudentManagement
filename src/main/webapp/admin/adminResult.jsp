<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<jsp:include page="../admin/adminHeader.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminStudentResult.css">
<div class="main-content">

<h2>Student Results</h2>



<%
Map<String, Map<String, List<Map<String, Object>>>> data =
    (Map<String, Map<String, List<Map<String, Object>>>>) request.getAttribute("resultData");

Set<String> subjects =
    (Set<String>) request.getAttribute("subjects");

for (String dept : data.keySet()) {
%>

<h3>Department: <%= dept %></h3>

<%
    for (String cls : data.get(dept).keySet()) {
%>

<h4>Class: <%= cls %></h4>

<div class="table-container">

<table border="1" width="100%" cellpadding="8">
<tr>
    <th>Rank</th>
    <th>Name</th>

<%
    for (String sub : subjects) {
%>
    <th><%= sub %> (I)</th>
    <th><%= sub %> (E)</th>
<% } %>

    <th>Total</th>
    <th>%</th>
    <th>Grade</th>
</tr>

<%
    for (Map<String, Object> s : data.get(dept).get(cls)) {

        Map<String, Integer> marksMap =
            (Map<String, Integer>) s.get("marks");
%>

<tr>
    <td><%= s.get("rank") %></td>
    <td><%= s.get("name") %></td>

<%
    for (String sub : subjects) {
%>
    <td><%= marksMap.getOrDefault(sub + "_I", 0) %></td>
    <td><%= marksMap.getOrDefault(sub + "_E", 0) %></td>
<% } %>

    <td><%= s.get("total") %></td>
    <td><%= String.format("%.2f", s.get("percent")) %>%</td>
    <td><b><%= s.get("grade") %></b></td>
</tr>

<% } %>

</table>
</div>

<br>

<%
    }
}
%>
</div>

