<%--
    Document   : WatchList
    Created on : May 27, 2025, 9:50:23 PM
    Author     : user
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Content" %> <%-- Replace with your actual Content class package --%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Watchlist - CineMagz</title>
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
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 24px;
            margin-top: 20px;
        }

        .card {
            background: #ffffff10;
            border-radius: 12px;
            overflow: hidden;
            position: relative;
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: scale(1.02);
        }

        .card img {
            width: 100%;
            height: 380px;
            object-fit: cover;
        }

        .card-content {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 20px;
            background: linear-gradient(to top, rgba(0,0,0,0.9) 0%, rgba(0,0,0,0.5) 100%);
        }

        .card-content h3 {
            margin: 0;
            font-size: 18px;
            color: #fff;
            font-weight: 600;
        }

        .card-content p {
            margin: 8px 0;
            font-size: 14px;
            color: #ffffff90;
        }

        .card-actions {
            position: absolute;
            top: 12px;
            right: 12px;
            display: flex;
            gap: 8px;
        }

        .action-button {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: rgba(0, 0, 0, 0.6);
            border: none;
            color: white;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            transition: all 0.3s ease;
        }

        .action-button:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        .action-button.active {
            background: #4CAF50;
        }

        .remove-link {
            color: #ff4081;
            text-decoration: none;
            font-size: 14px;
            margin-top: 8px;
            display: inline-block;
        }

        .remove-link:hover {
            text-decoration: underline;
        }

        .page-title {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 40px;
        }

        .page-title h2 {
            margin: 0;
            font-size: 48px;
            font-weight: 700;
        }

        .plus-icon {
            font-size: 40px;
            color: white;
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
        <% request.setAttribute("currentPage", "watchlist"); %>
        <jsp:include page="sidebar.jsp"/>

        <div class="main-content">
            <div class="page-title">
                <h2>Your Watchlist</h2>
            </div>
            
            <div class="card-container">
                <%
                    List<Content> contents = (List<Content>) request.getAttribute("contents");
                    if (contents != null && !contents.isEmpty()) {
                        for (Content content : contents) {
                %>
                            <div class="card">
                                <img src="<%= content.getImageUrl() %>" alt="<%= content.getTitle() %>">
                                <div class="card-content">
                                    <h3><%= content.getTitle() %></h3>
                                    <p>
                                        <%= content.getClass().getSimpleName() %> | <%= (content.getGenres() != null && !content.getGenres().isEmpty()) ? content.getGenres().get(0) : "" %>
                                    </p>
                                    <div class="card-actions">
                                        <form action="<%= request.getContextPath() %>/RegisteredUserController" method="post" class="action-form">
                                            <input type="hidden" name="action" value="removeFromWatchlist">
                                            <input type="hidden" name="contentId" value="<%= content.getId() %>">
                                            <button type="submit" class="remove-btn">Remove from Watchlist</button>
                                        </form>
                                        <form action="<%= request.getContextPath() %>/RegisteredUserController" method="post" class="action-form">
                                            <input type="hidden" name="action" value="addToFavourites">
                                            <input type="hidden" name="contentId" value="<%= content.getId() %>">
                                            <button type="submit" class="action-btn">Add to Favorites</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                <%
                        }
                    } else {
                %>
                        <div class="empty-state">
                            <p>Your watchlist is empty.</p>
                        </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>

    <script>
        function removeFromWatchlist(contentId, element) {
            if (confirm('Are you sure you want to remove this from your watchlist?')) {
                fetch('<%= request.getContextPath() %>/RegisteredUserController', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: `action=removeFromWatchlist&contentId=${contentId}`
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Remove the card from the UI
                        element.closest('.card').remove();
                        // Check if there are any cards left
                        if (document.querySelectorAll('.card').length === 0) {
                            document.querySelector('.card-container').innerHTML = 
                                '<div class="empty-state"><p>Your watchlist is empty.</p></div>';
                        }
                    }
                })
                .catch(error => console.error('Error:', error));
            }
        }

        function addToFavorites(contentId, button) {
            fetch('<%= request.getContextPath() %>/RegisteredUserController', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `action=addToFavourites&contentId=${contentId}`
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    button.classList.toggle('active');
                }
            })
            .catch(error => console.error('Error:', error));
        }

        // Event listener for the "Remove from Watchlist" buttons
        document.querySelectorAll('.remove-btn').forEach(button => {
            button.addEventListener('click', function(event) {
                event.preventDefault(); // Prevent default form submission
                const contentId = this.previousElementSibling.value; // Get contentId from hidden input
                removeFromWatchlist(contentId, this);
            });
        });

        // Event listener for the "Add to Favorites" buttons
        document.querySelectorAll('.action-btn').forEach(button => {
            button.addEventListener('click', function(event) {
                event.preventDefault(); // Prevent default form submission
                const contentId = this.previousElementSibling.value; // Get contentId from hidden input
                addToFavorites(contentId, this);
            });
        });
    </script>
</body>
</html>