<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.GuestUser,model.RegisteredUser" %>
<%
    RegisteredUser user = (RegisteredUser) session.getAttribute("user");
    GuestUser guest = (GuestUser) session.getAttribute("guest");
    if (user != null) {
        response.sendRedirect("home.jsp"); return;
    }
    // Hapus auto routing ke guest, biarkan user pilih!
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>CINEMAGZ - Selamat Datang</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@700;600;400&display=swap" rel="stylesheet">
    <style>
        body {
            background: #181A20;
            min-height: 100vh;
            font-family: 'Poppins', Arial, sans-serif;
        }
        .cinemagz-title {
            font-family: 'Poppins', Arial, sans-serif;
            font-weight: 700;
            font-size: 3.2rem;
            color: #FFB800;
            letter-spacing: 2px;
            margin-bottom: 0.5rem;
            text-shadow: 0 4px 24px rgba(0,0,0,0.26);
        }
        .welcome-card {
            max-width: 400px;
            margin: 7vh auto 0 auto;
            border-radius: 1.5rem;
            background: #23262F;
            box-shadow: 0 8px 32px 0 rgba(0,0,0,0.18);
            padding: 2.8rem 2.2rem 2.2rem 2.2rem;
            color: #fff;
        }
        .btn-cinemagz {
            background: #FFB800;
            color: #23262F;
            font-weight: 600;
            border-radius: 1rem;
            letter-spacing: 1px;
            font-size: 1.13rem;
        }
        .btn-cinemagz:hover {
            background: #e6a900;
            color: #23262F;
        }
        .btn-guest {
            background: #2D303A;
            color: #FFB800;
            border: 2px solid #FFB800;
            font-weight: 600;
            border-radius: 1rem;
            letter-spacing: 1px;
            font-size: 1.08rem;
            transition: background 0.2s, color 0.2s;
        }
        .btn-guest:hover {
            background: #181A20;
            color: #FFB800;
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
        <div class="welcome-card shadow-lg text-center">
            <div class="cinemagz-title">CINEMAGZ</div>
            <div style="color:#bbb;font-size:1.08rem;margin-bottom:2.1rem;">
                Selamat Datang di Portal Film Favoritmu!
            </div>
            <div class="d-grid gap-3">
                <a href="login.jsp" class="btn btn-cinemagz py-2">Login</a>
                <a href="register.jsp" class="btn btn-outline-light py-2" style="border-radius:1rem;font-weight:600;">Register</a>
                <a href="guesthome.jsp" class="btn btn-guest py-2 mt-1">Lanjut sebagai Guest</a>
            </div>
        </div>
        <div class="cinemagz-footer">&copy; 2025 CINEMAGZ. All rights reserved.</div>
    </div>
</body>
</html>