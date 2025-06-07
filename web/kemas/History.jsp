<%--
    Document   : History
    Created on : May 27, 2025, 9:50:39 PM
    Author     : user
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Content" %> <%-- Replace with your actual Content class package --%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>History - CineMagz</title>
    <style>
        /* Common styles for all pages */
        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background: linear-gradient(to right, #1e0a35, #431c69);
            color: white;
        }

        .container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar styles */
        .sidebar {
            width: 220px;
            background-color: #141414;
            padding: 20px;
            display: flex;
            flex-direction: column;
            position: fixed;
            height: 100vh;
        }

        .sidebar .logo {
            margin-bottom: 40px;
            text-align: center;
        }

        .sidebar .logo h1 {
            font-size: 24px;
            margin: 0;
            line-height: 1.2;
        }

        .sidebar nav {
            flex-grow: 1;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            color: #ffffff80;
            text-decoration: none;
            padding: 10px 0;
            transition: color 0.3s;
        }

        .sidebar a:hover,
        .sidebar a.active {
            color: #fff;
        }

        .user-controls {
            margin-top: auto;
            border-top: 1px solid #ffffff20;
            padding-top: 20px;
        }

        .logout-btn {
            background: none;
            border: none;
            color: #ffffff80;
            cursor: pointer;
            font-size: 16px;
            padding: 10px 0;
            width: 100%;
            text-align: left;
            transition: color 0.3s;
        }

        .logout-btn:hover {
            color: #fff;
        }

        /* Main content styles */
        .main-content {
            flex: 1;
            margin-left: 220px;
            padding: 30px;
        }

        .main-content h2 {
            font-size: 36px;
            margin-bottom: 30px;
        }

        /* Card styles */
        .card-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .card {
            background: #ffffff10;
            border-radius: 12px;
            overflow: hidden;
            position: relative;
        }

        .card img {
            width: 100%;
            height: 280px;
            object-fit: cover;
        }

        .card-content {
            padding: 15px;
        }

        .card-content h3 {
            margin: 0;
            font-size: 16px;
            color: #fff;
        }

        .card-content p {
            margin: 5px 0 0;
            font-size: 14px;
            color: #ffffff80;
        }

        .watched-date {
            display: block;
            margin-top: 8px;
            font-size: 12px;
            color: #ffffff60;
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 40px;
            color: #ffffff80;
        }
    </style>
</head>
<body>
    <div class="container">
        <% request.setAttribute("currentPage", "history"); %>
        <jsp:include page="sidebar.jsp"/>

        <div class="main-content">
            <h2>🗓️ History</h2>
            <div class="card-container">
                <%
                    List<Content> contents = (List<Content>) request.getAttribute("contents");
                    if (contents != null && !contents.isEmpty()) {
                        for (Content content : contents) {
                %>
                            <div class="card">
                                <a href="<%= request.getContextPath() %>/RegisteredUserController?action=viewContent&contentId=<%= content.getId() %>">
                                    <img src="<%= content.getImageUrl() %>" alt="<%= content.getTitle() %>">
                                </a>
                                <div class="card-content">
                                    <h3><%= content.getTitle() %></h3>
                                    <p>
                                        <strong><%= content.getClass().getSimpleName() %></strong> | 
                                        <%= (content.getGenres() != null && !content.getGenres().isEmpty()) ? content.getGenres().get(0) : "" %>
                                    </p>
                                    <small class="watched-date">
                                        Watched on <%= content.getLastWatchedDate() %>
                                    </small>
                                </div>
                            </div>
                <%
                        }
                    } else {
                %>
                        <div class="empty-state">
                            <p>No watch history yet.</p>
                        </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</body>
</html>