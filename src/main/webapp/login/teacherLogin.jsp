<%@ page contentType="text/html;charset=UTF-8" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
<jsp:include page="../includes/header.jsp"/>

<div class="login-container teacher-theme">
    <h2>Teacher Login</h2>

    <form action="${pageContext.request.contextPath}/TeacherLoginServlet" method="post">

    <input type="text" name="email" placeholder="Email Teacher Username" required>
    <input type="password" name="password" placeholder="Password" required>

    <button type="submit">Login</button>
</form>

    <p class="error">${error}</p>
</div>

<jsp:include page="../includes/footer.jsp"/>