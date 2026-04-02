<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/groupChat.css">

<%
String student = (String) session.getAttribute("studentName");
String teacher = (String) session.getAttribute("teacher");
String admin = (String) session.getAttribute("admin");

//👇 Current logged user name
String currentUser = null;

if (student != null) currentUser = student;
else if (teacher != null) currentUser = teacher;
else if (admin != null) currentUser = "Admin";
%>

<!-- ✅ Dynamic Header -->
<% if (student != null) { %>
    <jsp:include page="../student/studentHeader.jsp"/>
<% } else if (teacher != null) { %>
    <jsp:include page="../teacher/teacherHeader.jsp"/>
<% } else if (admin != null) { %>
    <jsp:include page="../admin/adminHeader.jsp"/>
<% } %>

<div class="main-content">


<h2 style="text-align:center;">💬 Group Chat</h2>
<div class="chat-wrapper">


<!-- CHAT BOX -->
<div id="chatBox" >

<%
List<Map<String, String>> msgs =
    (List<Map<String, String>>) request.getAttribute("messages");

if (msgs != null) {
    for (Map<String, String> m : msgs) {

        String sender = m.get("name");
        boolean isMe = sender != null && sender.equals(currentUser);
%>

  <div class="message <%= isMe ? "right" : "left" %>">
    <div class="bubble">
        <b><%= sender %></b>
        <p><%= m.get("text") %></p>
        <small><%= m.get("time") %></small>
    </div>
</div>

<%
    }
}
%>

</div>

<!-- SEND MESSAGE -->
<form action="${pageContext.request.contextPath}/SendMessageServlet"
      method="post"
      style="width:60%;margin:auto;margin-top:10px;display:flex;gap:10px;">

    <input type="text" name="message"
           placeholder="Type message..."
           style="flex:1;padding:10px;border-radius:5px;border:1px solid #ccc;"
           required>

    <button type="submit" style="padding:10px 20px;">Send</button>
</form>
</div>
</div>

<!-- AUTO SCROLL + AUTO REFRESH -->
<script>
function scrollToBottom() {
    const chatBox = document.getElementById("chatBox");
    if (chatBox) {
        chatBox.scrollTop = chatBox.scrollHeight;
    }
}

// Scroll on load
window.onload = scrollToBottom;

// Refresh + scroll
setInterval(() => {
    location.reload();
}, 15000);
</script>