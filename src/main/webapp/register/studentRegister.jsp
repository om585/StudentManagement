<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/studentRegister.css?v=2">

<jsp:include page="../includes/header.jsp"/>

<div class="register-container">



 <form action="${pageContext.request.contextPath}/StudentRegisterServlet" method="post" enctype="multipart/form-data">
<h2>🎓 Student Registration</h2>
        <div class="form-group">
            <input type="text" name="name" placeholder="Full Name" required>
            <input type="email" name="email" placeholder="Email" required>
        </div>

        <div class="form-group">
            <input type="tel" name="phone" placeholder="Phone" required>
            <input type="date" name="dob" required>
        </div>

        <textarea name="address" placeholder="Address" required></textarea>

        <div class="form-group">
            <select name="studentClass" required>
                <option value="">Select Class</option>
                <option value="FY">FY</option>
                <option value="SY">SY</option>
                <option value="TY">TY</option>
            </select>

            <select name="department" required>
                <option value="">Select Department</option>
                <option value="BCA">BCA</option>
                <option value="BVOC_CSD">B.Voc (CSD)</option>
            </select>
        </div>

        <div class="form-group">
            <select name="gender" required>
                <option value="">Gender</option>
                <option>Male</option>
                <option>Female</option>
            </select>

            <input type="text" name="guardian" placeholder="Guardian Name" required>
        </div>

        <input type="file" name="profileImage" required>

        <div class="form-group">
            <input type="password" name="password" placeholder="Password" required>
            <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
        </div>

        <button type="submit">Register</button>

        <p>${error}</p>

    </form>
</div>
<jsp:include page="../includes/footer.jsp"/>