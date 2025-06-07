<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Error - CINEMAGZ</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@700;600;400&display=swap" rel="stylesheet">
    <style>
        body {
            background: #181A20;
            font-family: 'Poppins', Arial, sans-serif;
        }
        .error-card {
            max-width: 420px;
            margin: 12vh auto;
            border-radius: 1.2rem;
            box-shadow: 0 8px 32px 0 rgba(0,0,0,0.15);
            background: #23262F;
            padding: 2.2rem 2rem 2rem 2rem;
            color: #fff;
        }
        .cinemagz-logo {
            font-family: 'Poppins', Arial, sans-serif;
            font-weight: 700;
            font-size: 2.1rem;
            color: #FFB800;
            letter-spacing: 2px;
        }
        .cinemagz-footer {
            font-size: 0.93rem;
            color: #888;
            margin-top: 2rem;
            text-align: center;
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
    </style>
</head>
<body>
    <div class="container">
        <div class="error-card shadow-lg text-center">
            <div class="cinemagz-logo mb-3">CINEMAGZ</div>
            <div class="alert alert-danger" style="font-size:1.08rem;">
                Error: <%= request.getAttribute("error") %>
            </div>
            <a href="index.jsp" class="btn btn-cinemagz mt-3 px-4 py-2">Kembali ke Home</a>
        </div>
        <div class="cinemagz-footer">&copy; 2025 CINEMAGZ. All rights reserved.</div>
    </div>
</body>
</html>