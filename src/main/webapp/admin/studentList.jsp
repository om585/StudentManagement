<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*,com.model.Student" %>

<jsp:include page="../admin/adminHeader.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminStudent.css">
<div class="main-content">
<h2>Student Management (Department → Class Wise)</h2>

<!-- 🔍 SEARCH BAR -->
<input type="text" id="searchInput"
       placeholder="Search by ID or Name..."
       style="width:300px;padding:10px;margin:10px;border:1px solid #ccc;border-radius:5px;">

<%
Map<String, Map<String, List<Student>>> data =
    (Map<String, Map<String, List<Student>>>) request.getAttribute("groupedData");

if (data != null) {
    for (String dept : data.keySet()) {
%>

    <h2 class="deptTitle" style="background:#2c3e50;color:white;padding:10px;">
        Department: <%= dept %>
    </h2>

<%
    Map<String, List<Student>> classMap = data.get(dept);

    for (String cls : classMap.keySet()) {
%>

    <h3 class="classTitle" style="background:#34495e;color:white;padding:8px;">
        Class: <%= cls %>
    </h3>

    <table border="1" width="100%" cellpadding="8" class="studentTable">
        <tr style="background:#eee;">
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Status</th>
            <th>Action</th>
        </tr>

<%
        List<Student> students = classMap.get(cls);

        for (Student s : students) {
%>

        <tr class="studentRow">
            <td class="sid"><%=s.getId()%></td>
            <td class="sname"><%=s.getName()%></td>
            <td><%=s.getEmail()%></td>
            <td><%=s.getPhone()%></td>
            <td><b><%=s.getStatus()%></b></td>

            <td>
    <% if ("pending".equalsIgnoreCase(s.getStatus())) { %>

        <form action="UpdateStudentStatusServlet" method="post" style="display:inline;">
            <input type="hidden" name="id" value="<%=s.getId()%>">
            <input type="hidden" name="action" value="approve">
            <button type="submit">Approve</button>
        </form>

        <form action="UpdateStudentStatusServlet" method="post" style="display:inline;">
            <input type="hidden" name="id" value="<%=s.getId()%>">
            <input type="hidden" name="action" value="deny">
            <button type="submit">Deny</button>
        </form>

    <% } else { %>

        <!-- ✅ No Action after approval -->
        <span style="color:green;font-weight:bold;">Approved</span>

    <% } %>
</td>
        </tr>

<%
        }
%>
    </table>
    <br>

<%
    } // class loop
} // dept loop
}
%>
</div>

<!-- 🔥 LIVE SEARCH SCRIPT -->
<script>
document.getElementById("searchInput").addEventListener("keyup", function () {

    let value = this.value.toLowerCase();

    let tables = document.querySelectorAll(".studentTable");
    let classTitles = document.querySelectorAll(".classTitle");
    let deptTitles = document.querySelectorAll(".deptTitle");

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

        // Hide class if empty
        if (visibleCount === 0) {
            table.style.display = "none";
            classTitles[index].style.display = "none";
        } else {
            table.style.display = "";
            classTitles[index].style.display = "";
        }
    });

    // 🔥 Hide department if all classes hidden
    deptTitles.forEach(dept => {

        let next = dept.nextElementSibling;
        let hasVisible = false;

        while (next && next.classList && next.classList.contains("classTitle")) {
            if (next.style.display !== "none") {
                hasVisible = true;
                break;
            }
            next = next.nextElementSibling;
        }

        dept.style.display = hasVisible ? "" : "none";
    });

});
</script>