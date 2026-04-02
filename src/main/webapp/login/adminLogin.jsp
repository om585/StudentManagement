<%@ page contentType="text/html;charset=UTF-8" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">

<jsp:include page="../includes/header.jsp"/>

<div class="login-container admin-theme">
    <h2>Admin Login</h2>

    <form action="${pageContext.request.contextPath}/AdminLoginServlet" method="post">
        <input type="hidden" name="role" value="admin">

        <input type="text" name="username" placeholder="Admin Username" required>
        <input type="password" name="password" placeholder="Password" required>

        <button type="submit">Login</button>
    </form>

    <p class="error" style="color:red;">
        ${error}
    </p>
</div>

<jsp:include page="../includes/footer.jsp"/>