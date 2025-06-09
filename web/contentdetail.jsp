<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Content" %>
<%@ page import="model.RegisteredUser" %>
<%@ page import="model.GuestUser" %>
<%@ page import="java.util.List" %>

<%
    // Get content from request attribute
    Content content = (Content) request.getAttribute("content");
    if (content == null) {
        response.sendRedirect("home.jsp");
        return;
    }
    
    // Get user from session
    Object user = session.getAttribute("user");
    boolean isGuest = user instanceof GuestUser;
    boolean isRegistered = user instanceof RegisteredUser;
%>
<!DOCTYPE html>
<html>
    <head>
        <title><%= content.getTitle() %> - CineMagz</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
        <style>
            body {
                background: #181A20;
                font-family: 'Poppins', Arial, sans-serif;
                margin: 0;
                color: #fff;
            }
            .content-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 2rem;
            }
            .content-header {
                display: flex;
                gap: 2rem;
                margin-bottom: 2rem;
            }
            .content-poster {
                width: 300px;
                height: 450px;
                object-fit: cover;
                border-radius: 1rem;
                box-shadow: 0 4px 20px rgba(0,0,0,0.2);
            }
            .content-info {
                flex: 1;
            }
            .content-title {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 1rem;
                color: #FFB800;
            }
            .content-meta {
                display: flex;
                gap: 1rem;
                margin-bottom: 1rem;
                color: #ccc;
            }
            .content-rating {
                background: #FFB800;
                color: #23262F;
                padding: 0.5rem 1rem;
                border-radius: 0.5rem;
                font-weight: 600;
            }
            .content-actions {
                display: flex;
                gap: 1rem;
                margin: 1.5rem 0;
            }
            .action-btn {
                padding: 0.8rem 1.5rem;
                border-radius: 0.8rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.2s;
                border: none;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }
            .watchlist-btn {
                background: #23262F;
                color: #fff;
                border: 2px solid #FFB800;
            }
            .watchlist-btn:hover {
                background: #FFB800;
                color: #23262F;
            }
            .favorite-btn {
                background: #23262F;
                color: #fff;
                border: 2px solid #FFB800;
            }
            .favorite-btn:hover, .favorite-btn.active {
                background: #FFB800;
                color: #23262F;
            }
            .content-description {
                margin-top: 2rem;
                line-height: 1.6;
            }
            .content-genres {
                display: flex;
                gap: 0.5rem;
                flex-wrap: wrap;
                margin: 1rem 0;
            }
            .genre-tag {
                background: #23262F;
                padding: 0.4rem 1rem;
                border-radius: 2rem;
                font-size: 0.9rem;
            }
            .content-details {
                margin-top: 2rem;
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1rem;
            }
            .detail-item {
                background: #23262F;
                padding: 1rem;
                border-radius: 0.8rem;
            }
            .detail-label {
                color: #888;
                font-size: 0.9rem;
                margin-bottom: 0.3rem;
            }
            .detail-value {
                font-weight: 600;
            }
            .reviews-section {
                margin-top: 3rem;
            }
            .review-card {
                background: #23262F;
                padding: 1.5rem;
                border-radius: 1rem;
                margin-bottom: 1rem;
            }
            .review-header {
                display: flex;
                justify-content: space-between;
                margin-bottom: 1rem;
            }
            .review-user {
                font-weight: 600;
            }
            .review-rating {
                color: #FFB800;
            }
            .review-content {
                line-height: 1.6;
            }
            .review-date {
                color: #888;
                font-size: 0.9rem;
                margin-top: 0.5rem;
            }
            .back-btn {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                color: #fff;
                text-decoration: none;
                margin-bottom: 2rem;
                padding: 0.5rem 1rem;
                border-radius: 0.5rem;
                background: #23262F;
                transition: background 0.2s;
            }
            .back-btn:hover {
                background: #2C2F3A;
                color: #FFB800;
            }
        </style>
    </head>
    <body>
        <div class="content-container">
            <a href="home.jsp" class="back-btn">
                <i class="fas fa-arrow-left"></i> Back to Home
            </a>
            
            <div class="content-header">
                <img src="<%= content.getImageUrl() != null ? content.getImageUrl() : "https://via.placeholder.com/300x450?text=No+Image"%>" 
                     alt="<%= content.getTitle()%>"
                     class="content-poster"
                     onerror="this.src='https://via.placeholder.com/300x450?text=Image+Not+Found'">
                
                <div class="content-info">
                    <h1 class="content-title"><%= content.getTitle()%></h1>
                    
                    <div class="content-meta">
                        <span><%= content.getReleaseDate() != null ? content.getReleaseDate() : "Unknown"%></span>
                        <span>|</span>
                        <span><%= content.getClass().getSimpleName()%></span>
                    </div>
                    
                    <div class="content-rating">
                        IMDb <%= String.format("%.1f", content.getAverageRating())%>/10
                    </div>
                    
                    <div class="content-genres">
                        <% if (content.getGenres() != null) {
                            for (String genre : content.getGenres()) { %>
                                <span class="genre-tag"><%= genre%></span>
                            <% }
                        } %>
                    </div>
                    
                    <div class="content-actions">
                        <% if (isRegistered) { %>
                            <button class="action-btn watchlist-btn" onclick="addToWatchlist()">
                                <i class="fas fa-bookmark"></i> Add to Watchlist
                            </button>
                            <button class="action-btn favorite-btn" onclick="toggleFavorite()">
                                <i class="fas fa-heart"></i> Add to Favorites
                            </button>
                        <% } else { %>
                            <button class="action-btn watchlist-btn" disabled>
                                <i class="fas fa-bookmark"></i> Login to Add to Watchlist
                            </button>
                            <button class="action-btn favorite-btn" disabled>
                                <i class="fas fa-heart"></i> Login to Add to Favorites
                            </button>
                        <% } %>
                    </div>
                    
                    <div class="content-description">
                        <h3>Overview</h3>
                        <p><%= content.getDescription() != null ? content.getDescription() : "No description available."%></p>
                    </div>
                </div>
            </div>
            
            <div class="content-details">
                <div class="detail-item">
                    <div class="detail-label">Type</div>
                    <div class="detail-value"><%= content.getClass().getSimpleName()%></div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Release Date</div>
                    <div class="detail-value"><%= content.getReleaseDate() != null ? content.getReleaseDate() : "Unknown"%></div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Rating</div>
                    <div class="detail-value"><%= String.format("%.1f", content.getAverageRating())%>/10</div>
                </div>
                <% if (content instanceof model.Series) { %>
                    <div class="detail-item">
                        <div class="detail-label">Seasons</div>
                        <div class="detail-value"><%= ((model.Series)content).getSeasons()%></div>
                    </div>
                <% } %>
            </div>
            
            <div class="reviews-section">
                <h2>Reviews</h2>
                <% List<model.Review> reviews = content.getReviews();
                if (reviews != null && !reviews.isEmpty()) {
                    for (model.Review review : reviews) { %>
                        <div class="review-card">
                            <div class="review-header">
                                <div class="review-user"><%= review.getUser().getUsername()%></div>
                                <div class="review-rating"><%= review.getRating()%>/10</div>
                            </div>
                            <div class="review-content"><%= review.getComment()%></div>
                            <div class="review-date"><%= review.getReviewDate()%></div>
                        </div>
                    <% }
                } else { %>
                    <div class="review-card">
                        <p>No reviews yet. Be the first to review!</p>
                    </div>
                <% } %>
                
                <% if (isRegistered) { %>
                    <div class="review-card">
                        <h3>Write a Review</h3>
                        <form action="ReviewController" method="POST">
                            <input type="hidden" name="action" value="addReview">
                            <input type="hidden" name="contentId" value="<%= content.getId()%>">
                            <div class="mb-3">
                                <label for="rating" class="form-label">Rating (1-10)</label>
                                <input type="number" class="form-control" id="rating" name="rating" min="1" max="10" required>
                            </div>
                            <div class="mb-3">
                                <label for="comment" class="form-label">Your Review</label>
                                <textarea class="form-control" id="comment" name="comment" rows="4" required></textarea>
                            </div>
                            <button type="submit" class="action-btn watchlist-btn">Submit Review</button>
                        </form>
                    </div>
                <% } else { %>
                    <div class="review-card">
                        <p>Please <a href="login.jsp">login</a> to write a review.</p>
                    </div>
                <% } %>
            </div>
        </div>

        <script>
            function addToWatchlist() {
                fetch(`RegisteredUserController?action=addToWatchlist&contentId=<%= content.getId()%>`, {
                    method: 'POST'
                })
                .then(response => response.json())
                .then(data => {
                    showToast(data.message);
                })
                .catch(error => {
                    console.error('Error:', error);
                    showToast('An error occurred. Please try again.');
                });
            }

            function toggleFavorite() {
                fetch(`RegisteredUserController?action=favorite&contentId=<%= content.getId()%>`, {
                    method: 'POST'
                })
                .then(response => response.json())
                .then(data => {
                    const btn = document.querySelector('.favorite-btn');
                    if (data.success) {
                        btn.classList.toggle('active');
                    }
                    showToast(data.message);
                })
                .catch(error => {
                    console.error('Error:', error);
                    showToast('An error occurred. Please try again.');
                });
            }

            function showToast(message) {
                const toast = document.createElement('div');
                toast.className = 'toast';
                toast.textContent = message;
                document.body.appendChild(toast);

                setTimeout(() => {
                    toast.remove();
                }, 3000);
            }

            // Add CSS for toast
            const style = document.createElement('style');
            style.textContent = `
                .toast {
                    position: fixed;
                    bottom: 20px;
                    right: 20px;
                    background: rgba(0, 0, 0, 0.9);
                    color: white;
                    padding: 12px 24px;
                    border-radius: 8px;
                    z-index: 1000;
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
            `;
            document.head.appendChild(style);
        </script>
    </body>
</html> 