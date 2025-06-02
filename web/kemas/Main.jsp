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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        </style>
    </head>
    <body>
        <div class="container">
            <!-- Include Sidebar -->
            <c:set var="currentPage" value="forYou" scope="request"/>
            <jsp:include page="sidebar.jsp"/>

            <!-- Main Content -->
            <main class="main-content">
                <!-- Header -->
                <header class="header">
                    <nav class="nav-tabs">
                        <a href="${pageContext.request.contextPath}/RegisteredUserController?action=movies" 
                           class="${param.contentType eq 'movies' ? 'active' : ''}">Movies</a>
                        <a href="${pageContext.request.contextPath}/RegisteredUserController?action=series"
                           class="${param.contentType eq 'series' ? 'active' : ''}">Series</a>
                    </nav>
                    <form action="${pageContext.request.contextPath}/RegisteredUserController" method="get" class="search-form">
                        <input type="hidden" name="action" value="search">
                        <div class="search-bar">
                            <input type="text" name="query" placeholder="Search" value="${param.query}">
                            <button type="submit">🔍</button>
                        </div>
                    </form>
                </header>

                <!-- Recommendation -->
                <c:if test="${not empty recommended}">
                    <section class="recommendation">
                        <img src="${recommended.imageUrl}" alt="${recommended.title}" class="banner-img">
                        <div class="info">
                            <p>RECOMMEND FOR YOU</p>
                            <h2>${recommended.title}</h2>
                            <p>
                                ${recommended['class'].simpleName} | 
                                ${recommended.releaseDate} | 
                                <c:choose>
                                    <c:when test="${recommended['class'].simpleName eq 'movie'}">
                                        ${recommended.duration}m
                                    </c:when>
                                    <c:otherwise>
                                        ${recommended.totalEpisode} Episodes
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <div class="actions">
                                <div class="rating">
                                    Rating ${recommended.reviews.stream()
                                        .mapToDouble(r -> r.rating.averageRate)
                                        .average()
                                        .orElse(0.0)}/10
                                </div>
                                <form action="${pageContext.request.contextPath}/RegisteredUserController" method="post" class="d-inline">
                                    <input type="hidden" name="action" value="addToWatchlist">
                                    <input type="hidden" name="contentId" value="${recommended.id}">
                                    <button type="submit" class="btn">+ Watchlist</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/RegisteredUserController" method="post" class="d-inline">
                                    <input type="hidden" name="action" value="addToFavourites">
                                    <input type="hidden" name="contentId" value="${recommended.id}">
                                    <button type="submit" class="btn-heart">♡</button>
                                </form>
                            </div>
                        </div>
                    </section>
                </c:if>

                <!-- Top Rated -->
                <section class="top-rated">
                    <h3>Top Rated</h3>
                    <div class="card-grid">
                        <c:forEach items="${topRated}" var="content">
                            <div class="card">
                                <a href="${pageContext.request.contextPath}/RegisteredUserController?action=viewContent&contentId=${content.id}">
                                    <img src="${content.imageUrl}" alt="${content.title}">
                                </a>
                                <form action="${pageContext.request.contextPath}/RegisteredUserController" method="post">
                                    <input type="hidden" name="action" value="addToFavourites">
                                    <input type="hidden" name="contentId" value="${content.id}">
                                    <button type="submit" class="btn-heart ${sessionScope.user.isFavorite(content) ? 'active' : ''}">
                                        ♡
                                    </button>
                                </form>
                                <div class="card-body">
                                    <h6>${content.title}</h6>
                                    <p>${content.releaseDate.year + 1900} | ${not empty content.genres ? content.genres[0] : ''}</p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </section>

                <!-- Most Viewed -->
                <section class="most-viewed">
                    <h3>Most Viewed</h3>
                    <div class="card-grid">
                        <c:forEach items="${mostViewed}" var="content">
                            <div class="card">
                                <a href="${pageContext.request.contextPath}/RegisteredUserController?action=viewContent&contentId=${content.id}">
                                    <img src="${content.imageUrl}" alt="${content.title}">
                                </a>
                                <form action="${pageContext.request.contextPath}/RegisteredUserController" method="post">
                                    <input type="hidden" name="action" value="addToFavourites">
                                    <input type="hidden" name="contentId" value="${content.id}">
                                    <button type="submit" class="btn-heart ${sessionScope.user.isFavorite(content) ? 'active' : ''}">
                                        ♡
                                    </button>
                                </form>
                                <div class="card-body">
                                    <h6>${content.title}</h6>
                                    <p>${content.releaseDate.year + 1900} | ${not empty content.genres ? content.genres[0] : ''}</p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </section>
            </main>
        </div>
    </body>
</html>

