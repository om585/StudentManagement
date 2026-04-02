<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:include page="../includes/header.jsp"/>

<div class="page-container">

    <section class="page-hero">
        <h1>Contact Us</h1>
        <p>We’d love to hear from you</p>
    </section>

    <section class="contact-wrapper">

        <!-- LEFT INFO -->
        <div class="contact-info">
            <h2>Get In Touch</h2>
            <p>If you have any questions or suggestions, feel free to contact us.</p>

            <ul>
                <li><strong>Email:</strong> support@studentms.com</li>
                <li><strong>Phone:</strong> +91 98765 43210</li>
                <li><strong>Location:</strong> Pune, India</li>
            </ul>
        </div>

        <!-- RIGHT FORM -->
        <div class="contact-form">
            <form action="${pageContext.request.contextPath}/ContactServlet" method="post">
  <input type="text" name="name" placeholder="Your Name" required>

    <input type="email" name="email" placeholder="Your Email" required>

    <textarea name="message" rows="4" placeholder="Your Message" required></textarea>

    <button type="submit">Send Message</button>
            </form>
            <p style="color:green;">${success}</p>
			<p style="color:red;">${error}</p>
        </div>

    </section>

</div>

<jsp:include page="../includes/footer.jsp"/>