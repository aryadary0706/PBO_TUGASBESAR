<%-- 
    Document   : History
    Created on : May 27, 2025, 9:50:39 PM
    Author     : user
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>History - CineMagz</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #1e0a35, #431c69);
            color: white;
        }

        .sidebar {
            width: 200px;
            height: 100vh;
            background-color: #1c1c1c;
            position: fixed;
            display: flex;
            flex-direction: column;
            padding: 20px;
        }

        .sidebar h1 {
            color: white;
            font-size: 20px;
            margin-bottom: 40px;
        }

        .sidebar a {
            text-decoration: none;
            color: white;
            margin: 10px 0;
            display: flex;
            align-items: center;
            font-size: 16px;
        }

        .sidebar a:hover {
            color: #ffcc00;
        }

        .main-content {
            margin-left: 220px;
            padding: 40px;
        }

        .main-content h2 {
            font-size: 36px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card-container {
            display: flex;
            gap: 20px;
            margin-top: 30px;
        }

        .card {
            background-color: #ffffff10;
            border-radius: 12px;
            overflow: hidden;
            width: 200px;
            color: black;
        }

        .card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .card-content {
            padding: 10px;
            background-color: white;
        }

        .card-content h3 {
            margin: 0;
            font-size: 16px;
            font-weight: bold;
        }

        .card-content p {
            margin: 5px 0 0;
            font-size: 14px;
            color: #444;
        }

        .user-controls {
            margin-top: auto;
            padding-top: 20px;
        }

        .user-controls a {
            color: white;
            display: flex;
            align-items: center;
            margin-top: 10px;
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <h1>🍿 CINE<br>MAGZ</h1>
    <a href="home.jsp">🏠 For You</a>
    <a href="favourites.jsp">🤍 Favourites</a>
    <a href="watchlist.jsp">🎬 Watchlist</a>
    <a href="history.jsp">🗓️ History</a>
    <div class="user-controls">
        <a href="profile.jsp">👤 User</a>
        <a href="logout.jsp">↩ Logout</a>
    </div>
</div>

<div class="main-content">
    <h2>🗓️ History</h2>
    <div class="card-container">
        <div class="card">
            <img src="images/tokyo_train.jpg" alt="Tokyo Train">
            <div class="card-content">
                <h3>Tokyo Train</h3>
                <p><strong>Movie</strong> | Action comedy</p>
            </div>
        </div>
        <div class="card">
            <img src="images/moonfall.jpg" alt="Moonfall">
            <div class="card-content">
                <h3>Moonfall</h3>
                <p><strong>Movie</strong> | Sci-fi</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>

