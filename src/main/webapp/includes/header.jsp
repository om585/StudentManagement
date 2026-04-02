<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/aboutContact.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
</head>
<body>

<header class="header">
    <div class="logo">🎓 StudentMS</div>

    <nav class="navbar">
        <ul>
            <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>

            <li class="dropdown">
                <a href="#">Login ▾</a>
                <ul class="dropdown-menu">
                    <li><a href="${pageContext.request.contextPath}/login/adminLogin.jsp">Admin Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/login/studentLogin.jsp">Student Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/login/teacherLogin.jsp">Teacher Login</a></li>
                </ul>
            </li>

            
                    <li><a href="${pageContext.request.contextPath}/register/studentRegister.jsp">Student Register</a></li>
                    
                
            

            <li><a href="${pageContext.request.contextPath}/includes/about.jsp">About Us</a></li>
            <li><a href="${pageContext.request.contextPath}/includes/contact.jsp">Contact</a></li>
        </ul>
    </nav>
</header>