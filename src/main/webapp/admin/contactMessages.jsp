<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<jsp:include page="../admin/adminHeader.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/contact-messages.css">

<%
    List<Map<String, String>> messages =
        (List<Map<String, String>>) request.getAttribute("messages");
%>

<div class="main-content">

    <h2>Contact Messages</h2>

    <div class="table-container">

        <table>

            <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Message</th>
                    <th>Date</th>
                </tr>
            </thead>

            <tbody>

            <% if (messages != null && !messages.isEmpty()) {
                for (Map<String, String> m : messages) { %>

                <tr>
                    <td><%= m.get("name") %></td>
                    <td><%= m.get("email") %></td>
                    <td class="msg"><%= m.get("message") %></td>
                    <td><%= m.get("date") %></td>
                </tr>

            <% } } else { %>

                <tr>
                    <td colspan="4" class="no-data">No messages found</td>
                </tr>

            <% } %>

            </tbody>

        </table>

    </div>

</div>