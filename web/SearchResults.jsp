<%@page import="java.util.List"%>
<%@page import="model.Content"%>
<%@page import="database.ContentDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Results</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                background: #1A1D24;
                color: #fff;
                min-height: 100vh;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 2rem;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 2rem;
                padding: 1rem 0;
            }

            .back-btn {
                background: #FFB800;
                color: #23262F;
                border: none;
                padding: 0.5rem 1rem;
                border-radius: 0.5rem;
                font-weight: 600;
                cursor: pointer;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
            }

            .back-btn:hover {
                background: #e6a600;
            }

            .search-info {
                margin-bottom: 2rem;
            }

            .search-info h1 {
                font-size: 1.5rem;
                margin-bottom: 0.5rem;
                color: #fff;
                font-weight: 600;
            }

            .search-info p {
                color: #fff;
                opacity: 0.8;
            }

            .results-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                gap: 1.5rem;
            }

            .content-card {
                background: #23262F;
                border-radius: 0.8rem;
                overflow: hidden;
                transition: transform 0.2s;
            }

            .content-card:hover {
                transform: translateY(-5px);
            }

            .content-card img {
                width: 100%;
                height: 280px;
                object-fit: cover;
            }

            .content-info {
                padding: 1rem;
            }

            .content-title {
                font-weight: 600;
                margin-bottom: 0.5rem;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .content-meta {
                display: flex;
                justify-content: space-between;
                align-items: center;
                color: #888;
                font-size: 0.9rem;
            }

            .no-results {
                text-align: center;
                padding: 3rem;
                background: #23262F;
                border-radius: 0.8rem;
            }

            .no-results i {
                font-size: 3rem;
                color: #888;
                margin-bottom: 1rem;
            }

            .no-results h2 {
                font-size: 1.5rem;
                margin-bottom: 0.5rem;
            }

            .no-results p {
                color: #888;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <a href="Main.jsp" class="back-btn">
                    <i class="fas fa-arrow-left"></i>
                    Back to Home
                </a>
            </div>

            <div class="search-info">
                <h1>Search Results</h1>
                <p>Showing results for: "${param.query}"</p>
            </div>

            <%
                String query = request.getParameter("query");
                if (query != null && !query.trim().isEmpty()) {
                    ContentDAO contentDAO = new ContentDAO();
                    List<Content> results = contentDAO.searchContent(query);
                    
                    if (results != null && !results.isEmpty()) {
            %>
                <div class="results-grid">
                    <% for (Content content : results) { %>
                        <div class="content-card">
                            <a href="RegisteredUserController?action=viewContent&contentId=<%= content.getId() %>">
                                <img src="<%= content.getImageUrl() %>" 
                                     alt="<%= content.getTitle() %>"
                                     onerror="this.src='https://via.placeholder.com/200x280?text=No+Image'">
                                <div class="content-info">
                                    <div class="content-title"><%= content.getTitle() %></div>
                                    <div class="content-meta">
                                        <span><%= content.getType() %></span>
                                        <span><%= content.getReleaseDate() %></span>
                                    </div>
                                </div>
                            </a>
                        </div>
                    <% } %>
                </div>
            <%
                    } else {
            %>
                <div class="no-results">
                    <i class="fas fa-search"></i>
                    <h2>No Results Found</h2>
                    <p>We couldn't find any content matching your search.</p>
                </div>
            <%
                    }
                } else {
            %>
                <div class="no-results">
                    <i class="fas fa-search"></i>
                    <h2>No Search Query</h2>
                    <p>Please enter a search term to find content.</p>
                </div>
            <%
                }
            %>
        </div>
    </body>
</html> 