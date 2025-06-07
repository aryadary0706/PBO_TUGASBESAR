<%-- 
    Document   : Main
    Created on : May 24, 2025, 8:59:57 AM
    Author     : user
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Content" %>
<%@ page import="model.movie" %>
<%@ page import="model.Series" %>
<%@ page import="java.util.List" %>
<%
    // Get data from request attributes
    Content recommendedContent = (Content) request.getAttribute("recommendedContent");
    List<Content> topRatedContent = (List<Content>) request.getAttribute("topRatedContent");
    List<Content> mostViewedContent = (List<Content>) request.getAttribute("mostViewedContent");
    
    // Set current page for sidebar
    request.setAttribute("currentPage", "forYou");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>CineMagz - For You</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap">
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

            /* Header styles */
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }

            .nav-tabs a {
                color: #ffffff80;
                text-decoration: none;
                margin-right: 20px;
                font-weight: 600;
                transition: color 0.3s;
            }

            .nav-tabs a:hover,
            .nav-tabs a.active {
                color: #fff;
            }

            .search-bar {
                display: flex;
                align-items: center;
                background: #ffffff10;
                border-radius: 20px;
                padding: 5px 15px;
            }

            .search-bar input {
                background: none;
                border: none;
                color: #fff;
                padding: 5px;
                outline: none;
            }

            .search-bar button {
                background: none;
                border: none;
                color: #ffffff80;
                cursor: pointer;
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

            .btn-heart {
                position: absolute;
                top: 10px;
                right: 10px;
                background: #ffffff20;
                border: none;
                color: #fff;
                width: 30px;
                height: 30px;
                border-radius: 50%;
                cursor: pointer;
                transition: all 0.3s;
            }

            .btn-heart:hover,
            .btn-heart.active {
                background: #ff4081;
                transform: scale(1.1);
            }

            /* Recommendation section */
            .recommendation {
                position: relative;
                border-radius: 20px;
                overflow: hidden;
                margin-bottom: 40px;
                height: 400px;
            }

            .recommendation .banner-img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .recommendation .info {
                position: absolute;
                bottom: 0;
                left: 0;
                right: 0;
                padding: 40px;
                background: linear-gradient(transparent, #000000cc);
            }

            .recommendation h2 {
                font-size: 36px;
                margin: 10px 0;
            }

            .recommendation .actions {
                display: flex;
                gap: 10px;
                margin-top: 20px;
            }

            .btn {
                background: #ffffff20;
                border: none;
                color: #fff;
                padding: 8px 20px;
                border-radius: 20px;
                cursor: pointer;
                transition: background 0.3s;
            }

            .btn:hover {
                background: #ffffff40;
            }

            .rating {
                background: #ffcc00;
                color: #000;
                padding: 8px 20px;
                border-radius: 20px;
                font-weight: 600;
            }

            /* Empty state */
            .empty-state {
                text-align: center;
                padding: 40px;
                color: #ffffff80;
            }

            /* Top Rated section styles */
            .Top.Rated {
                margin-bottom: 40px;
            }

            .Top.Rated h2 {
                font-size: 24px;
                margin-bottom: 20px;
                color: #fff;
            }

            .scroll-container {
                display: flex;
                overflow-x: auto;
                gap: 20px;
                padding: 10px 0;
                scrollbar-width: thin;
                scrollbar-color: #ffffff40 transparent;
            }

            .scroll-container::-webkit-scrollbar {
                height: 8px;
            }

            .scroll-container::-webkit-scrollbar-track {
                background: transparent;
            }

            .scroll-container::-webkit-scrollbar-thumb {
                background-color: #ffffff40;
                border-radius: 4px;
            }

            .content-card {
                flex: 0 0 200px;
                background: #ffffff10;
                border-radius: 8px;
                overflow: hidden;
                transition: transform 0.3s;
            }

            .content-card:hover {
                transform: translateY(-5px);
            }

            .content-card a {
                text-decoration: none;
                color: white;
            }

            .content-card img {
                width: 100%;
                height: 300px;
                object-fit: cover;
            }

            .content-info {
                padding: 12px;
            }

            .content-info h3 {
                margin: 8px 0;
                font-size: 16px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .content-info p {
                margin: 0;
                color: #ffffff80;
                font-size: 14px;
            }

            .rating {
                display: inline-flex;
                align-items: center;
                background: #ffffff15;
                padding: 4px 8px;
                border-radius: 4px;
                font-size: 14px;
            }

            .star {
                color: #ffd700;
                margin-right: 4px;
            }

            .rating-value {
                font-weight: 600;
            }

            /* Additional styles for new layout */
            .hero-section {
                position: relative;
                height: 80vh;
                width: 100%;
                margin-bottom: 40px;
            }

            .hero-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
                position: absolute;
                top: 0;
                left: 0;
            }

            .hero-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(to top, rgba(0,0,0,0.9) 0%, rgba(0,0,0,0.3) 60%, rgba(0,0,0,0.3) 100%);
                display: flex;
                flex-direction: column;
                justify-content: flex-end;
                padding: 60px;
            }

            .hero-content {
                max-width: 600px;
            }

            .hero-title {
                font-size: 48px;
                font-weight: 700;
                margin-bottom: 16px;
            }

            .hero-metadata {
                font-size: 16px;
                color: #ffffff90;
                margin-bottom: 24px;
            }

            .hero-buttons {
                display: flex;
                gap: 16px;
                margin-bottom: 32px;
            }

            .hero-button {
                padding: 12px 24px;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 8px;
                border: none;
            }

            .watchlist-button {
                background: rgba(255, 255, 255, 0.1);
                color: white;
            }

            .favorite-button {
                background: rgba(255, 255, 255, 0.1);
                color: white;
            }

            .imdb-rating {
                display: inline-flex;
                align-items: center;
                background: #f5c518;
                color: black;
                padding: 6px 12px;
                border-radius: 6px;
                font-weight: 600;
                margin-right: 16px;
            }

            .section-title {
                font-size: 24px;
                font-weight: 600;
                margin-bottom: 24px;
                color: white;
            }

            /* Update content grid to horizontal scroll */
            .content-grid {
                display: flex;
                gap: 24px;
                margin-bottom: 48px;
                overflow-x: auto;
                scroll-behavior: smooth;
                padding: 20px 0;
                scrollbar-width: none; /* Firefox */
                position: relative;
            }

            .content-grid::-webkit-scrollbar {
                display: none; /* Chrome, Safari, Opera */
            }

            .content-card {
                flex: 0 0 280px;
                position: relative;
                border-radius: 12px;
                overflow: hidden;
                transition: transform 0.3s ease;
            }

            /* Slide controls */
            .slide-controls {
                position: absolute;
                top: 50%;
                width: 100%;
                transform: translateY(-50%);
                display: flex;
                justify-content: space-between;
                pointer-events: none;
                z-index: 10;
            }

            .slide-button {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: rgba(0, 0, 0, 0.7);
                border: none;
                color: white;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                pointer-events: auto;
                transition: background 0.3s ease;
            }

            .slide-button:hover {
                background: rgba(255, 255, 255, 0.2);
            }

            .section-container {
                position: relative;
                padding: 0 40px;
            }

            /* Active states for buttons */
            .action-button.active {
                background: #ff4081;
            }

            .watchlist-button.active {
                background: #4CAF50;
            }

            /* Toast notification */
            .toast {
                position: fixed;
                bottom: 20px;
                right: 20px;
                background: rgba(0, 0, 0, 0.9);
                color: white;
                padding: 12px 24px;
                border-radius: 8px;
                z-index: 1000;
                display: none;
                animation: slideIn 0.3s ease;
            }

            @keyframes slideIn {
                from {
                    transform: translateY(100%);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <!-- Include Sidebar -->
            <jsp:include page="sidebar.jsp"/>

            <!-- Main Content -->
            <main class="main-content">
                <!-- Hero Section -->
                <% if (recommendedContent != null) { %>
                <section class="hero-section">
                    <img src="<%= recommendedContent.getImageUrl() %>" alt="<%= recommendedContent.getTitle() %>" class="hero-image">
                    <div class="hero-overlay">
                        <div class="hero-content">
                            <h1 class="hero-title"><%= recommendedContent.getTitle() %></h1>
                            <div class="hero-metadata">
                                <%= recommendedContent.getType() %> | <%= recommendedContent.getYear() %> | <%= recommendedContent.getDuration() %>
                            </div>
                            <div class="hero-buttons">
                                <div class="imdb-rating">
                                    <span>IMDb</span>
                                    <span><%= recommendedContent.getRating() %>/10</span>
                                </div>
                                <button class="hero-button watchlist-button">
                                    <span>+</span> Watchlist
                                </button>
                                <button class="hero-button favorite-button">
                                    <span>♥</span> Favorite
                                </button>
                            </div>
                        </div>
                    </div>
                </section>
                <% } %>

                <!-- Top Rated Section -->
                <section class="section-container">
                    <h2 class="section-title">Top Rated</h2>
                    <div class="slide-controls">
                        <button class="slide-button prev-button" data-section="top-rated">❮</button>
                        <button class="slide-button next-button" data-section="top-rated">❯</button>
                    </div>
                    <div class="content-grid" id="top-rated-grid">
                        <% 
                        if (topRatedContent != null && !topRatedContent.isEmpty()) {
                            for (Content content : topRatedContent) { 
                        %>
                            <div class="content-card">
                                <img src="<%= content.getImageUrl() %>" alt="<%= content.getTitle() %>" class="content-image">
                                <div class="content-overlay">
                                    <h3 class="content-title"><%= content.getTitle() %></h3>
                                    <div class="content-metadata">
                                        <%= content.getYear() %> | <%= content.getGenre() %>
                                    </div>
                                </div>
                                <div class="action-buttons">
                                    <button class="action-button favorite-btn <%= content.isFavorite() ? "active" : "" %>" 
                                            data-content-id="<%= content.getId() %>" 
                                            data-action="favorite" 
                                            title="Add to favorites">♥</button>
                                    <button class="action-button watchlist-btn <%= content.isInWatchlist() ? "active" : "" %>" 
                                            data-content-id="<%= content.getId() %>" 
                                            data-action="watchlist" 
                                            title="Add to watchlist">+</button>
                                </div>
                            </div>
                        <% 
                            }
                        } else { 
                        %>
                            <div class="empty-state">
                                <p>No top rated content available</p>
                            </div>
                        <% } %>
                    </div>
                </section>

                <!-- Most Viewed Section -->
                <section class="section-container">
                    <h2 class="section-title">Most Viewed</h2>
                    <div class="slide-controls">
                        <button class="slide-button prev-button" data-section="most-viewed">❮</button>
                        <button class="slide-button next-button" data-section="most-viewed">❯</button>
                    </div>
                    <div class="content-grid" id="most-viewed-grid">
                        <% 
                        if (mostViewedContent != null && !mostViewedContent.isEmpty()) {
                            for (Content content : mostViewedContent) { 
                        %>
                            <div class="content-card">
                                <img src="<%= content.getImageUrl() %>" alt="<%= content.getTitle() %>" class="content-image">
                                <div class="content-overlay">
                                    <h3 class="content-title"><%= content.getTitle() %></h3>
                                    <div class="content-metadata">
                                        <%= content.getYear() %> | <%= content.getGenre() %>
                                    </div>
                                </div>
                                <div class="action-buttons">
                                    <button class="action-button favorite-btn <%= content.isFavorite() ? "active" : "" %>" 
                                            data-content-id="<%= content.getId() %>" 
                                            data-action="favorite" 
                                            title="Add to favorites">♥</button>
                                    <button class="action-button watchlist-btn <%= content.isInWatchlist() ? "active" : "" %>" 
                                            data-content-id="<%= content.getId() %>" 
                                            data-action="watchlist" 
                                            title="Add to watchlist">+</button>
                                </div>
                            </div>
                        <% 
                            }
                        } else { 
                        %>
                            <div class="empty-state">
                                <p>No most viewed content available</p>
                            </div>
                        <% } %>
                    </div>
                </section>
            </main>
        </div>

        <!-- Toast notification -->
        <div id="toast" class="toast"></div>

        <!-- JavaScript for sliding and interactions -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Sliding functionality
                function initializeSlider(gridId, prevBtn, nextBtn) {
                    const grid = document.getElementById(gridId);
                    const scrollAmount = 280 + 24; // card width + gap

                    prevBtn.addEventListener('click', () => {
                        grid.scrollBy({
                            left: -scrollAmount,
                            behavior: 'smooth'
                        });
                    });

                    nextBtn.addEventListener('click', () => {
                        grid.scrollBy({
                            left: scrollAmount,
                            behavior: 'smooth'
                        });
                    });

                    // Show/hide buttons based on scroll position
                    grid.addEventListener('scroll', () => {
                        prevBtn.style.display = grid.scrollLeft > 0 ? 'flex' : 'none';
                        nextBtn.style.display = 
                            grid.scrollLeft < (grid.scrollWidth - grid.clientWidth) ? 'flex' : 'none';
                    });

                    // Initial button visibility
                    prevBtn.style.display = 'none';
                }

                // Initialize sliders
                document.querySelectorAll('.section-container').forEach(section => {
                    const prevBtn = section.querySelector('.prev-button');
                    const nextBtn = section.querySelector('.next-button');
                    const gridId = section.querySelector('.content-grid').id;
                    initializeSlider(gridId, prevBtn, nextBtn);
                });

                // Toast notification function
                function showToast(message, duration = 3000) {
                    const toast = document.getElementById('toast');
                    toast.textContent = message;
                    toast.style.display = 'block';
                    setTimeout(() => {
                        toast.style.display = 'none';
                    }, duration);
                }

                // Handle Favorites and Watchlist buttons
                document.querySelectorAll('.action-button').forEach(button => {
                    button.addEventListener('click', function(e) {
                        e.preventDefault();
                        const contentId = this.dataset.contentId;
                        const action = this.dataset.action;
                        const isActive = this.classList.contains('active');

                        // AJAX call to update backend
                        fetch(`/CineMagz/api/${action}`, {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            body: JSON.stringify({
                                contentId: contentId,
                                action: isActive ? 'remove' : 'add'
                            })
                        })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                this.classList.toggle('active');
                                const actionText = action === 'favorite' ? 'favorites' : 'watchlist';
                                const actionVerb = isActive ? 'Removed from' : 'Added to';
                                showToast(`${actionVerb} ${actionText}`);
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            showToast('An error occurred. Please try again.');
                        });
                    });
                });

                // Handle hero buttons similarly
                document.querySelectorAll('.hero-button').forEach(button => {
                    button.addEventListener('click', function(e) {
                        e.preventDefault();
                        // Similar AJAX logic as above
                        // Add specific handling for hero content
                    });
                });
            });
        </script>
    </body>
</html>