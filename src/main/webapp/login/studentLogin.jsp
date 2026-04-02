<%@ page contentType="text/html;charset=UTF-8" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
<jsp:include page="../includes/header.jsp"/>

<div class="login-container teacher-theme">

<h2>Student Login</h2>

<form action="${pageContext.request.contextPath}/StudentLoginServlet" method="post">
    <input type="text" name="email" placeholder="Email"><br>
    <input type="password" name="password" placeholder="Password"><br>

    <button type="submit">Login</button>

    <p style="color:red;">${error}</p>
</form>
    <p class="error">${error}</p>
</div>
<%
    String success = (String) session.getAttribute("success");
    if (success != null) {
%>
<p style="color:green;"><%= success %></p>
<%
    session.removeAttribute("success");
}
%>

<jsp:include page="../includes/footer.jsp"/>