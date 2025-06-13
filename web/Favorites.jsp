<%--
    Document   : FavoritesList
    Created on : May 27, 2025, 9:50:04 PM
    Author     : user
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Content" %> <%-- Replace with your actual Content class package --%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Favorites - CineMagz</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@700;600;400&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
        <style>
            body {
                background: #181A20;
                font-family: 'Poppins', Arial, sans-serif;
                margin: 0;
            }
            .sidebar {
                position: fixed;
                left: 0;
                top: 0;
                bottom: 0;
                width: 230px;
                background: #23262F;
                color: #fff;
                padding: 2.5rem 1.3rem 1rem 1.3rem;
                z-index: 200;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }
            .brand {
                display: flex;
                align-items: center;
                gap: 0.8rem;
                margin-bottom: 2.5rem;
            }
            .brand img {
                width: 38px;
                height: 38px;
            }
            .brand-title {
                font-size: 1.36rem;
                font-weight: 700;
                letter-spacing: 1px;
                color: #FFB800;
                line-height: 1.1;
            }
            .nav-menu {
                flex: 1;
                display: flex;
                flex-direction: column;
                gap: 1.2rem;
            }
            .nav-menu a {
                color: #fff;
                text-decoration: none;
                padding: 0.65rem 1.2rem;
                border-radius: 0.9rem;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 0.7rem;
                transition: background 0.14s;
                font-size: 1.01rem;
            }
            .nav-menu a.active, .nav-menu a:hover {
                background: #181A20;
                color: #FFB800;
            }
            .nav-menu .icon {
                width: 20px;
                height: 20px;
            }
            .sidebar-bottom {
                border-top: 1px solid #363942;
                padding-top: 1.7rem;
                margin-top: 1.7rem;
                display: flex;
                flex-direction: column;
                gap: 1.2rem;
                font-size: 0.97rem;
            }
            .sidebar-bottom a {
                color: #fff;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 0.7rem;
                transition: color 0.14s;
            }
            .sidebar-bottom a:hover {
                color: #FFB800;
            }
            .main-content {
                margin-left: 230px;
                padding: 0 2.4rem 2rem 2.4rem;
            }
            .header-bar {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-top: 2.2rem;
                margin-bottom: 2.1rem;
            }
            .header-tabs {
                display: flex;
                gap: 2.2rem;
                font-size: 1.13rem;
            }
            .header-tabs a {
                color: #fff;
                text-decoration: none;
                font-weight: 500;
                opacity: 0.78;
                padding-bottom: 0.2rem;
                border-bottom: 2px solid transparent;
                transition: border 0.18s, color 0.18s;
            }
            .header-tabs a:hover {
                color: #FFB800;
                opacity: 1;
                border-bottom: 2px solid #FFB800;
            }
            .search-bar {
                background: #23262F;
                border-radius: 0.8rem;
                padding: 0.37rem 1.1rem;
                display: flex;
                align-items: center;
                min-width: 270px;
                max-width: 330px;
            }
            .search-bar input {
                background: transparent;
                border: none;
                color: #fff;
                width: 100%;
                outline: none;
                font-size: 1rem;
                margin-left: 0.5rem;
            }
            .search-bar .fa-search {
                color: #888;
            }
            .banner {
                width: 100%;
                background: #26292F;
                border-radius: 1.6rem;
                overflow: hidden;
                position: relative;
                min-height: 310px;
                display: flex;
                align-items: flex-end;
                margin-bottom: 2.7rem;
            }
            .banner-img {
                width: 100%;
                height: 310px;
                object-fit: cover;
                filter: brightness(0.65);
                position: absolute;
                left: 0;
                top: 0;
                z-index: 1;
            }
            .banner-content {
                position: relative;
                z-index: 2;
                color: #fff;
                padding: 2.9rem 2.5rem;
                max-width: 600px;
            }
            .banner-genre {
                font-size: 0.95rem;
                text-transform: uppercase;
                color: #FFB800;
                font-weight: 600;
                margin-bottom: 0.2rem;
                letter-spacing: 1px;
            }
            .banner-title {
                font-size: 2.2rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }
            .banner-meta {
                font-size: 1.01rem;
                color: #ccc;
                margin-bottom: 1.2rem;
            }
            .banner-rating {
                display: inline-block;
                background: #FFB800;
                color: #23262F;
                font-weight: 700;
                border-radius: 0.8rem;
                padding: 0.38rem 1.1rem;
                font-size: 1.18rem;
                margin-right: 0.9rem;
            }
            .banner-watchlist {
                background: #24272D;
                color: #fff;
                font-weight: 600;
                border: 1.5px solid #fff;
                border-radius: 1.2rem;
                padding: 0.43rem 1.6rem;
                font-size: 1.07rem;
                margin-right: 0.5rem;
                transition: background 0.18s, color 0.14s;
            }
            .banner-watchlist:hover {
                background: #FFB800;
                color: #23262F;
                border-color: #FFB800;
            }
            .banner-fav {
                background: none;
                border: none;
                color: #fff;
                font-size: 1.46rem;
                margin-left: 0.6rem;
                vertical-align: middle;
            }
            .section-title {
                color: #fff;
                font-size: 1.25rem;
                font-weight: 600;
                margin-bottom: 1.2rem;
                margin-top: 1.8rem;
            }
            .movie-grid {
                display: flex;
                gap: 1.5rem;
                flex-wrap: wrap;
            }
            .movie-card {
                background: #23262F;
                border-radius: 1.1rem;
                overflow: hidden;
                width: 210px;
                min-width: 210px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
                position: relative;
                margin-bottom: 1.3rem;
                transition: transform 0.16s;
            }
            .movie-card:hover {
                transform: translateY(-7px) scale(1.03);
                box-shadow: 0 6px 28px rgba(0,0,0,0.13);
            }
            .movie-img {
                width: 100%;
                height: 140px;
                object-fit: cover;
            }
            .movie-body {
                padding: 1.05rem 1rem 0.7rem 1rem;
            }
            .movie-title {
                color: #fff;
                font-size: 1.06rem;
                font-weight: 600;
                margin-bottom: 0.1rem;
            }
            .movie-meta {
                color: #bbb;
                font-size: 0.98rem;
            }
            .fav-btn {
                position: absolute;
                top: 10px;
                right: 13px;
                background: #fff;
                color: #FFB800;
                border: none;
                border-radius: 50%;
                padding: 0.45rem;
                font-size: 1.19rem;
                box-shadow: 0 2px 8px rgba(0,0,0,0.13);
                cursor: pointer;
                transition: background 0.17s;
            }
            .fav-btn.active, .fav-btn:hover {
                background: #FFB800;
                color: #fff;
            }
            @media (max-width: 900px) {
                .main-content {
                    margin-left: 0;
                    padding: 1rem;
                }
                .sidebar {
                    display: none;
                }
                .movie-card {
                    width: 46vw;
                    min-width: 140px;
                }
            }
            .page-title {
                margin-bottom: 2rem;
            }

            .page-title h2 {
                color: #fff;
                font-size: 1.8rem;
                font-weight: 600;
                margin: 0;
            }

            .card-container {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 1.5rem;
            }

            .card {
                background: #23262F;
                border-radius: 1rem;
                overflow: hidden;
                transition: transform 0.2s;
            }

            .card:hover {
                transform: translateY(-5px);
            }

            .card img {
                width: 100%;
                height: 200px;
                object-fit: cover;
            }

            .card-content {
                padding: 1.2rem;
            }

            .card-content h3 {
                color: #fff;
                font-size: 1.2rem;
                font-weight: 600;
                margin-bottom: 0.5rem;
            }

            .card-content p {
                color: #fff;
                opacity: 0.8;
                margin-bottom: 1rem;
            }

            .card-actions {
                display: flex;
                gap: 0.8rem;
            }

            .action-form {
                flex: 1;
            }

            .remove-btn, .action-btn {
                width: 100%;
                padding: 0.6rem;
                border: none;
                border-radius: 0.5rem;
                font-weight: 500;
                cursor: pointer;
                transition: background 0.2s;
            }

            .remove-btn {
                background: #ff4444;
                color: #fff;
            }

            .remove-btn:hover {
                background: #ff0000;
            }

            .action-btn {
                background: #FFB800;
                color: #23262F;
            }

            .action-btn:hover {
                background: #e6a600;
            }

            .empty-state {
                text-align: center;
                padding: 3rem;
                background: #23262F;
                border-radius: 1rem;
                color: #fff;
                opacity: 0.8;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <div class="brand">
                <img src="https://cdn-icons-png.flaticon.com/512/891/891462.png" alt="logo">
                <span class="brand-title">CINE<br>MAGZ</span>
            </div>
            <div class="nav-menu">
                <a href="Main.jsp"><i class="fa-solid fa-house"></i>For you</a>
                <a href="../movie.jsp"><i class="fa fa-star icon"></i>Movies</a>
                <a href="../series.jsp"><i class="fa fa-film icon"></i>Series</a>
                <a href="Favorites.jsp" class="active"><i class="fa fa-heart icon"></i>Favourites</a>
                <a href="WatchList.jsp"><i class="fa fa-bookmark icon"></i>Watchlist</a>
                <a href="History.jsp"><i class="fa fa-clock icon"></i>History</a>
            </div>
            <div class="sidebar-bottom">
                <a href="#"><i class="fa fa-user icon"></i>User</a>
                <a href="AuthController?action=logout"><i class="fa fa-sign-out-alt icon"></i>Logout</a>
            </div>
        </div>

        <div class="main-content">
            <div class="page-title">
                <h2>Your Favorites</h2>
            </div>

            <div class="card-container">
                <%
                    List<Content> contents = (List<Content>) request.getAttribute("contents");
                    if (contents != null && !contents.isEmpty()) {
                        for (Content content : contents) {
                %>
                <div class="card">
                    <img src="<%= content.getImageUrl()%>" alt="<%= content.getTitle()%>">
                    <div class="card-content">
                        <h3><%= content.getTitle()%></h3>
                        <p>
                            <%= content.getClass().getSimpleName()%> | <%= (content.getGenres() != null && !content.getGenres().isEmpty()) ? content.getGenres().get(0) : ""%>
                        </p>
                        <div class="card-actions">
                            <form action="<%= request.getContextPath()%>/RegisteredUserController" method="post" class="action-form">
                                <input type="hidden" name="action" value="removeFromFavourites">
                                <input type="hidden" name="contentId" value="<%= content.getId()%>">
                                <button type="submit" class="remove-btn">Remove from Favorites</button>
                            </form>
                            <form action="<%= request.getContextPath()%>/RegisteredUserController" method="post" class="action-form">
                                <input type="hidden" name="action" value="addToWatchlist">
                                <input type="hidden" name="contentId" value="<%= content.getId()%>">
                                <button type="submit" class="action-btn">Add to Watchlist</button>
                            </form>
                        </div>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <div class="empty-state">
                    <p>No favorites added yet.</p>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <script>
            function removeFromFavorites(contentId, element) {
                if (confirm('Are you sure you want to remove this from your favorites?')) {
                    fetch('<%= request.getContextPath()%>/RegisteredUserController', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: `action=removeFromFavourites&contentId=${contentId}`
                    })
                            .then(response => response.json())
                            .then(data => {
                                if (data.success) {
                                    // Remove the card from the UI
                                    element.closest('.card').remove();
                                    // Check if there are any cards left
                                    if (document.querySelectorAll('.card').length === 0) {
                                        document.querySelector('.card-container').innerHTML =
                                                '<div class="empty-state"><p>No favorites added yet.</p></div>';
                                    }
                                }
                            })
                            .catch(error => console.error('Error:', error));
                }
            }

            function addToWatchlist(contentId, button) {
                fetch('<%= request.getContextPath()%>/RegisteredUserController', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: `action=addToWatchlist&contentId=${contentId}`
                })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                // You might want to provide visual feedback here, like changing the button text or style
                                // button.classList.toggle('active'); // Example: if you have an 'active' state for watchlist
                                alert('Added to Watchlist!'); // Simple alert for demonstration
                            } else {
                                alert('Failed to add to Watchlist: ' + data.message); // Show error message if any
                            }
                        })
                        .catch(error => console.error('Error:', error));
            }

            // Event listener for the "Remove from Favorites" buttons
            document.querySelectorAll('.remove-btn').forEach(button => {
                button.addEventListener('click', function (event) {
                    event.preventDefault(); // Prevent default form submission
                    const contentId = this.previousElementSibling.value; // Get contentId from hidden input
                    removeFromFavorites(contentId, this);
                });
            });

            // Event listener for the "Add to Watchlist" buttons
            document.querySelectorAll('.action-btn').forEach(button => {
                button.addEventListener('click', function (event) {
                    event.preventDefault(); // Prevent default form submission
                    const contentId = this.previousElementSibling.value; // Get contentId from hidden input
                    addToWatchlist(contentId, this);
                });
            });
        </script>
    </body>
</html>