<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../teacher/teacherHeader.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/teacherTimeTable.css">
<div class="teacher-content">

<h2>Time Table</h2>

<%
String dept = (String) request.getAttribute("dept");
%>
    <div class="timetable-card">

<% if ("BCA".equalsIgnoreCase(dept)) { %>

    <!-- ================= BCA FY ================= -->
    <h3>BCA - FY</h3>
    <div class="table-container">
    
    <table border="1" width="100%">
        <tr>
            <th>Day</th><th>9-10</th><th>10-11</th><th>11-12</th><th>12-1</th><th>2-3</th>
        </tr>
        <tr><td>Monday</td><td>Maths</td><td>English</td><td>Computer</td><td>Lab</td><td>EVS</td></tr>
        <tr><td>Tuesday</td><td>Java</td><td>DBMS</td><td>Maths</td><td>Lab</td><td>English</td></tr>
        <tr><td>Wednesday</td><td>Computer</td><td>Maths</td><td>English</td><td>Lab</td><td>EVS</td></tr>
        <tr><td>Thursday</td><td>DBMS</td><td>Java</td><td>Maths</td><td>Lab</td><td>English</td></tr>
        <tr><td>Friday</td><td>Maths</td><td>Computer</td><td>English</td><td>Lab</td><td>EVS</td></tr>
        <tr><td>Saturday</td><td>Revision</td><td>Maths</td><td>English</td><td>Lab</td><td>Sports</td></tr>
    </table>

    <!-- ================= BCA SY ================= -->
    <h3>BCA - SY</h3>
    <table border="1" width="100%">
        <tr>
            <th>Day</th><th>9-10</th><th>10-11</th><th>11-12</th><th>12-1</th><th>2-3</th>
        </tr>
        <tr><td>Monday</td><td>OS</td><td>Java</td><td>DBMS</td><td>Lab</td><td>CN</td></tr>
        <tr><td>Tuesday</td><td>DBMS</td><td>CN</td><td>Java</td><td>Lab</td><td>OS</td></tr>
        <tr><td>Wednesday</td><td>Java</td><td>OS</td><td>CN</td><td>Lab</td><td>DBMS</td></tr>
        <tr><td>Thursday</td><td>CN</td><td>Java</td><td>OS</td><td>Lab</td><td>DBMS</td></tr>
        <tr><td>Friday</td><td>OS</td><td>DBMS</td><td>Java</td><td>Lab</td><td>CN</td></tr>
        <tr><td>Saturday</td><td>Revision</td><td>Java</td><td>OS</td><td>Lab</td><td>Seminar</td></tr>
    </table>

    <!-- ================= BCA TY ================= -->
    <h3>BCA - TY</h3>
    <table border="1" width="100%">
        <tr>
            <th>Day</th><th>9-10</th><th>10-11</th><th>11-12</th><th>12-1</th><th>2-3</th>
        </tr>
        <tr><td>Monday</td><td>AI</td><td>ML</td><td>Cloud</td><td>Project</td><td>Seminar</td></tr>
        <tr><td>Tuesday</td><td>Cloud</td><td>AI</td><td>ML</td><td>Project</td><td>Lab</td></tr>
        <tr><td>Wednesday</td><td>ML</td><td>Cloud</td><td>AI</td><td>Project</td><td>Seminar</td></tr>
        <tr><td>Thursday</td><td>AI</td><td>ML</td><td>Cloud</td><td>Project</td><td>Lab</td></tr>
        <tr><td>Friday</td><td>Cloud</td><td>AI</td><td>ML</td><td>Project</td><td>Seminar</td></tr>
        <tr><td>Saturday</td><td>Revision</td><td>AI</td><td>ML</td><td>Project</td><td>Presentation</td></tr>
    </table>

<% } else if ("BVOC_CSD".equalsIgnoreCase(dept)) { %>

    <!-- ================= BVOC FY ================= -->
    <h3>BVOC_CSD - FY</h3>
    <table border="1" width="100%">
        <tr>
            <th>Day</th><th>9-10</th><th>10-11</th><th>11-12</th><th>12-1</th><th>2-3</th>
        </tr>
        <tr><td>Monday</td><td>HTML</td><td>CSS</td><td>Design</td><td>Lab</td><td>Communication</td></tr>
        <tr><td>Tuesday</td><td>Web</td><td>HTML</td><td>CSS</td><td>Lab</td><td>Design</td></tr>
        <tr><td>Wednesday</td><td>CSS</td><td>Web</td><td>HTML</td><td>Lab</td><td>Communication</td></tr>
        <tr><td>Thursday</td><td>Design</td><td>CSS</td><td>Web</td><td>Lab</td><td>HTML</td></tr>
        <tr><td>Friday</td><td>HTML</td><td>Design</td><td>CSS</td><td>Lab</td><td>Web</td></tr>
        <tr><td>Saturday</td><td>Revision</td><td>HTML</td><td>CSS</td><td>Lab</td><td>Sports</td></tr>
    </table>

    <!-- ================= BVOC SY ================= -->
    <h3>BVOC_CSD - SY</h3>
    <table border="1" width="100%">
        <tr>
            <th>Day</th><th>9-10</th><th>10-11</th><th>11-12</th><th>12-1</th><th>2-3</th>
        </tr>
        <tr><td>Monday</td><td>JS</td><td>React</td><td>Node</td><td>Lab</td><td>MongoDB</td></tr>
        <tr><td>Tuesday</td><td>Node</td><td>JS</td><td>React</td><td>Lab</td><td>MongoDB</td></tr>
        <tr><td>Wednesday</td><td>React</td><td>JS</td><td>Node</td><td>Lab</td><td>MongoDB</td></tr>
        <tr><td>Thursday</td><td>MongoDB</td><td>Node</td><td>JS</td><td>Lab</td><td>React</td></tr>
        <tr><td>Friday</td><td>JS</td><td>MongoDB</td><td>React</td><td>Lab</td><td>Node</td></tr>
        <tr><td>Saturday</td><td>Revision</td><td>JS</td><td>React</td><td>Lab</td><td>Seminar</td></tr>
    </table>

    <!-- ================= BVOC TY ================= -->
    <h3>BVOC_CSD - TY</h3>
    <table border="1" width="100%">
        <tr>
            <th>Day</th><th>9-10</th><th>10-11</th><th>11-12</th><th>12-1</th><th>2-3</th>
        </tr>
        <tr><td>Monday</td><td>Project</td><td>UI/UX</td><td>App Dev</td><td>Lab</td><td>Cloud</td></tr>
        <tr><td>Tuesday</td><td>App Dev</td><td>Project</td><td>UI/UX</td><td>Lab</td><td>Cloud</td></tr>
        <tr><td>Wednesday</td><td>UI/UX</td><td>Cloud</td><td>Project</td><td>Lab</td><td>App Dev</td></tr>
        <tr><td>Thursday</td><td>Cloud</td><td>UI/UX</td><td>Project</td><td>Lab</td><td>App Dev</td></tr>
        <tr><td>Friday</td><td>Project</td><td>Cloud</td><td>UI/UX</td><td>Lab</td><td>App Dev</td></tr>
        <tr><td>Saturday</td><td>Revision</td><td>Project</td><td>UI/UX</td><td>Lab</td><td>Presentation</td></tr>
    </table>

<% } else { %>

    <p>No timetable available</p>

<% } %>
</div>
</div>
</div>