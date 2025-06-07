<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="sidebar">
    <div class="logo">
        <h1>CineMagz</h1>
    </div>
    <nav>
        <a href="${pageContext.request.contextPath}/RegisteredUserController?action=main" 
           class="${currentPage eq 'forYou' ? 'active' : ''}">
            For You
        </a>
        <a href="${pageContext.request.contextPath}/RegisteredUserController?action=favourites" 
           class="${currentPage eq 'favourites' ? 'active' : ''}">
            Favorites
        </a>
        <a href="${pageContext.request.contextPath}/RegisteredUserController?action=watchlist" 
           class="${currentPage eq 'watchlist' ? 'active' : ''}">
            Watchlist
        </a>
        <a href="${pageContext.request.contextPath}/RegisteredUserController?action=history" 
           class="${currentPage eq 'history' ? 'active' : ''}">
            History
        </a>
    </nav>
    <div class="user-controls">
        <a href="${pageContext.request.contextPath}/RegisteredUserController?action=account" 
           class="${currentPage eq 'account' ? 'active' : ''}">
            My Account
        </a>
        <form action="${pageContext.request.contextPath}/RegisteredUserController" method="post">
            <input type="hidden" name="action" value="logout">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </div>
</div> 