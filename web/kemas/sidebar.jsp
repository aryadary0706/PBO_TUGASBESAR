<%-- 
    Document   : sidebar
    Created on : Jun 2, 2025, 8:24:23 PM
    Author     : user
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar">
    <div class="logo">
        <h1>🍿 CINE<br>MAGZ</h1>
    </div>
    <nav>
        <a href="${pageContext.request.contextPath}/RegisteredUserController?action=forYou" class="${param.currentPage eq 'forYou' ? 'active' : ''}">
            🏠 For You
        </a>
        <a href="${pageContext.request.contextPath}/RegisteredUserController?action=favourites" class="${param.currentPage eq 'favourites' ? 'active' : ''}">
            🤍 Favourites
        </a>
        <a href="${pageContext.request.contextPath}/RegisteredUserController?action=watchlist" class="${param.currentPage eq 'watchlist' ? 'active' : ''}">
            🎬 Watchlist
        </a>
        <a href="${pageContext.request.contextPath}/RegisteredUserController?action=history" class="${param.currentPage eq 'history' ? 'active' : ''}">
            🗓️ History
        </a>
    </nav>
    <div class="user-controls">
        <a href="${pageContext.request.contextPath}/RegisteredUserController?action=profile">
            👤 ${sessionScope.user.username}
        </a>
        <form action="${pageContext.request.contextPath}/RegisteredUserController" method="post" style="margin:0">
            <input type="hidden" name="action" value="logout">
            <button type="submit" class="logout-btn">↩ Logout</button>
        </form>
    </div>
</div> 