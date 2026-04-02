<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*,com.model.Student" %>

<jsp:include page="../teacher/teacherHeader.jsp"/>

<h2>My Students (Department Wise)</h2>

<!-- 🔍 SEARCH BAR -->
<input type="text" id="searchInput"
       placeholder="Search by ID or Name..."
       style="width:300px;padding:10px;margin:10px;border:1px solid #ccc;border-radius:5px;">

<%
Map<String, List<Student>> data =
    (Map<String, List<Student>>) request.getAttribute("studentData");

if (data != null) {
    for (String cls : data.keySet()) {
%>

<h3 class="classTitle" style="background:#2c3e50;color:white;padding:8px;">
    Class: <%= cls %>
</h3>

<table border="1" width="100%" cellpadding="8" class="studentTable">
    <tr style="background:#eee;">
        <th>ID</th>
        <th>Name</th>
    </tr>

<%
    for (Student s : data.get(cls)) {
%>

<tr class="studentRow">
    <td class="sid"><%= s.getId() %></td>
    <td class="sname"><%= s.getName() %></td>
</tr>

<% } %>

</table>
<br>

<%
    }
}
%>

<!-- 🔥 LIVE SEARCH SCRIPT -->
<script>
document.getElementById("searchInput").addEventListener("keyup", function () {

    let value = this.value.toLowerCase();

    let tables = document.querySelectorAll(".studentTable");
    let titles = document.querySelectorAll(".classTitle");

    tables.forEach((table, index) => {

        let rows = table.querySelectorAll(".studentRow");
        let visibleCount = 0;

        rows.forEach(row => {

            let id = row.querySelector(".sid").innerText.toLowerCase();
            let name = row.querySelector(".sname").innerText.toLowerCase();

            if (id.includes(value) || name.includes(value)) {
                row.style.display = "";
                visibleCount++;
            } else {
                row.style.display = "none";
            }

        });

        // 🔥 Hide class if no student found
        if (visibleCount === 0) {
            table.style.display = "none";
            titles[index].style.display = "none";
        } else {
            table.style.display = "";
            titles[index].style.display = "";
        }

    });

});
</script>