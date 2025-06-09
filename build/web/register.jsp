<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.GuestUser,model.RegisteredUser" %>
<%
    RegisteredUser user = (RegisteredUser) session.getAttribute("user");
    GuestUser guest = (GuestUser) session.getAttribute("guest");
    if (user != null) { response.sendRedirect("home.jsp"); return; }
    if (guest == null) {
        guest = new GuestUser();
        session.setAttribute("guest", guest);
    }
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Register - CINEMAGZ</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@700;600;400&display=swap" rel="stylesheet">
    <style>
        body {
            background: #181A20;
            font-family: 'Poppins', Arial, sans-serif;
        }
        .cinemagz-logo {
            font-family: 'Poppins', Arial, sans-serif;
            font-weight: 700;
            font-size: 2.3rem;
            color: #FFB800;
            letter-spacing: 2px;
            margin-bottom: 0.6rem;
        }
        .register-card {
            max-width: 410px;
            margin: 7vh auto;
            border-radius: 1.4rem;
            box-shadow: 0 8px 32px 0 rgba(0,0,0,0.22);
            background: #23262F;
            padding: 2.2rem 2rem 2rem 2rem;
            color: #fff;
        }
        .form-label, .form-control {
            color: #fff !important;
            background: #2D303A !important;
        }
        .form-control:focus {
            border-color: #FFB800;
            box-shadow: 0 0 0 0.16rem rgba(255,184,0,0.18);
            background: #23262F;
            color: #fff;
        }
        .btn-cinemagz {
            background: #FFB800;
            color: #23262F;
            font-weight: 600;
            border-radius: 1rem;
            letter-spacing: 1px;
        }
        .btn-cinemagz:hover {
            background: #e6a900;
            color: #23262F;
        }
        .login-link {
            color: #FFB800;
            text-decoration: none;
            font-weight: 600;
        }
        .login-link:hover {
            text-decoration: underline;
        }
        .cinemagz-footer {
            font-size: 0.93rem;
            color: #888;
            margin-top: 2rem;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="register-card shadow-lg">
            <div class="text-center">
                <span class="cinemagz-logo">CINEMAGZ</span>
                <div style="font-size:1.1rem;color:#bbb;">Buat Akun Baru</div>
                <hr style="opacity:0.10;">
            </div>
            <form method="POST" action="AuthController" class="mt-3">
                <input type="hidden" name="action" value="register">
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" name="username" id="username" placeholder="Username" required>
                    <label for="username">Username</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="email" class="form-control" name="email" id="email" placeholder="Email" required>
                    <label for="email">Email</label>
                </div>
                <div class="form-floating mb-2">
                    <input type="password" class="form-control" name="password" id="password" placeholder="Password" required>
                    <label for="password">Password</label>
                </div>
                <% if (error != null) { %>
                <div class="alert alert-danger mt-2 text-center py-2" style="font-size:0.97em;">
                    <%= error %>
                </div>
                <% } %>
                <button type="submit" class="btn btn-cinemagz w-100 my-2 py-2">Register</button>
            </form>
            <div class="mt-4 text-center">
                <span style="color:#bbb;">Sudah punya akun?</span>
                <a href="login.jsp" class="login-link ms-1">Login sekarang</a>
            </div>
        </div>
        <div class="cinemagz-footer">&copy; 2025 CINEMAGZ. All rights reserved.</div>
    </div>
</body>
</html>