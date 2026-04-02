<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*,com.model.Teacher" %>

<jsp:include page="../admin/adminHeader.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminTeacher.css">
<div class="main-content">

<h2>Teacher Management</h2>

<!-- 🔍 SEARCH BAR -->
<input type="text" id="searchInput"
       placeholder="Search by ID or Name..."
       style="width:300px;padding:10px;margin:10px;border:1px solid #ccc;border-radius:5px;">

<a href="${pageContext.request.contextPath}/admin/AddTeacher.jsp">
    <button>Add Teacher</button>
</a>

<%
Map<String, List<Teacher>> data =
    (Map<String, List<Teacher>>) request.getAttribute("teacherData");

if (data != null) {
    for (String dept : data.keySet()) {
%>

<h2 class="deptTitle" style="background:#2c3e50;color:white;padding:10px;">
    Department: <%= dept %>
</h2>

<table border="1" width="100%" cellpadding="8" class="teacherTable">
    <tr style="background:#eee;">
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Phone</th>
    </tr>

<%
    for (Teacher t : data.get(dept)) {
%>

<tr class="teacherRow">
    <td class="tid"><%=t.getId()%></td>
    <td class="tname"><%=t.getName()%></td>
    <td><%=t.getEmail()%></td>
    <td><%=t.getPhone()%></td>
</tr>

<% } %>
</table>
<br>

<%
    }
}
%>
</div>

<!-- 🔥 LIVE SEARCH SCRIPT -->
<script>
document.getElementById("searchInput").addEventListener("keyup", function () {

    let value = this.value.toLowerCase();

    let tables = document.querySelectorAll(".teacherTable");
    let deptTitles = document.querySelectorAll(".deptTitle");

    tables.forEach((table, index) => {

        let rows = table.querySelectorAll(".teacherRow");
        let visibleCount = 0;

        rows.forEach(row => {

            let id = row.querySelector(".tid").innerText.toLowerCase();
            let name = row.querySelector(".tname").innerText.toLowerCase();

            if (id.includes(value) || name.includes(value)) {
                row.style.display = "";
                visibleCount++;
            } else {
                row.style.display = "none";
            }

        });

        // 🔥 Hide department if no teachers visible
        if (visibleCount === 0) {
            table.style.display = "none";
            deptTitles[index].style.display = "none";
        } else {
            table.style.display = "";
            deptTitles[index].style.display = "";
        }

    });

});
</script>