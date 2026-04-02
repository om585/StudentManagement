<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.*, com.model.Student" %>

<jsp:include page="../teacher/teacherHeader.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/markAttendence.css">

<%
    String today = LocalDate.now().toString();
    List<Student> list = (List<Student>) request.getAttribute("students");
%>

<div class="teacher-content">

    <h2>Mark Attendance (Only Today Allowed)</h2>

    <div class="form-card">

        <!-- FORM START -->
        <form action="${pageContext.request.contextPath}/MarkAttendanceServlet" method="post">

            <!-- DATE FIELD -->
            <div class="form-group">
                <label>Date:</label>
                <input type="date" name="date"
                       value="<%= today %>"
                       min="<%= today %>"
                       max="<%= today %>"
                       required>
            </div>

            <!-- ERROR MESSAGE -->
            <p class="error">${error}</p>

            <!-- TABLE -->
            <div class="table-container">
                <table>

                    <thead>
                        <tr>
                            <th>Student Name</th>
                            <th>Attendance</th>
                            <th>Report</th>
                        </tr>
                    </thead>

                    <tbody>

                    <% if (list != null && !list.isEmpty()) { 
                        for (Student s : list) { %>

                        <tr>
                            <td><%= s.getName() %></td>

                            <td class="attendance-options">
                                <label>
                                    <input type="radio" name="status_<%= s.getId() %>" value="Present" required>
                                    Present
                                </label>

                                <label>
                                    <input type="radio" name="status_<%= s.getId() %>" value="Absent">
                                    Absent
                                </label>
                            </td>

                            <td>
                                <a class="report-link"
                                   href="${pageContext.request.contextPath}/AttendanceReportServlet?studentId=<%= s.getId() %>">
                                    View Report
                                </a>
                            </td>
                        </tr>

                    <%  } 
                       } else { %>

                        <tr>
                            <td colspan="3" class="no-data">
                                No students found
                            </td>
                        </tr>

                    <% } %>

                    </tbody>

                </table>
            </div>

            <!-- SUBMIT BUTTON -->
            <button type="submit" class="submit-btn">
                Submit Attendance
            </button>

        </form>
        <!-- FORM END -->

    </div>

</div>