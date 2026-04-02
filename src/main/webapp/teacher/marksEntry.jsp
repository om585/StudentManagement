<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.model.Student" %>

<jsp:include page="../teacher/teacherHeader.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/marksEntry.css">
<div class="teacher-content">

<h2>Marks Entry</h2>

<div class="form-card">

<form method="post" action="MarksEntryServlet">

            <div class="form-group">
                <label>Exam Type:</label>
                <select name="examType">
                    <option value="Internal">Internal</option>
                    <option value="Semester">Semester</option>
                </select>
            </div>


<div class="table-container">


<table border="1" width="100%">
<tr>
    <th>Student</th>

<%
Set<String> subjects = (Set<String>) request.getAttribute("subjects");

for (String sub : subjects) {
%>
    <th><%= sub %></th>
<% } %>

</tr>

<%
List<Student> students = (List<Student>) request.getAttribute("students");

for (Student s : students) {
%>

<tr>
    <td><%= s.getName() %></td>

<%
    for (String sub : subjects) {
%>
    <td>
        <input type="number" name="marks_<%=s.getId()%>_<%=sub%>" min="0" max="100">
    </td>
<% } %>

</tr>

<% } %>

</table>

</div>
<br>
<button type="submit">Save Marks</button>
</form>
</div>
</div>


