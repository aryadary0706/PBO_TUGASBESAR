<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.GuestUser" %>
<%
    if (session.getAttribute("user") != null) {
        response.sendRedirect("home.jsp");
        return;
    }
    GuestUser guest = (GuestUser) session.getAttribute("guest");
    if (guest == null) {
        guest = new GuestUser();
        session.setAttribute("guest", guest);
    }
    // Popup only once per session when first entering guesthome
    boolean showWelcomePopup = false;
    if (session.getAttribute("guestWelcomeShown") == null) {
        showWelcomePopup = true;
        session.setAttribute("guestWelcomeShown", "1");
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>CINEMAGZ - Home (Guest)</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@700;600;400&display=swap" rel="stylesheet">
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
                cursor: pointer;
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
                pointer-events: none;
                opacity: 0.4;
            }
            .banner-fav {
                background: none;
                border: none;
                color: #fff;
                font-size: 1.46rem;
                margin-left: 0.6rem;
                vertical-align: middle;
                pointer-events: none;
                opacity: 0.4;
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
            .fav-btn, .banner-watchlist, .banner-fav {
                pointer-events: none;
                opacity: 0.4;
            }
            /* Popup styles */
            .modal-backdrop, .modal-backdrop-welcome {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0,0,0,0.5);
                z-index: 99998;
                display: none;
            }
            .custom-modal, .custom-modal-welcome {
                position: fixed;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -50%);
                z-index: 100000;
                background: #23262F;
                border-radius: 1.1rem;
                padding: 2rem 2.5rem 2rem 2.5rem;
                box-shadow: 0 4px 32px rgba(0,0,0,0.19);
                color: #fff;
                min-width: 320px;
                display: none;
                max-width: 90vw;
            }
            .custom-modal .popup-title,
            .custom-modal-welcome .popup-title {
                font-size: 1.26rem;
                font-weight: 700;
                margin-bottom: 1rem;
                color: #FFB800;
            }
            .custom-modal .popup-btns,
            .custom-modal-welcome .popup-btns {
                margin-top: 1.5rem;
                display: flex;
                gap: 1.2rem;
                justify-content: flex-end;
            }
            .custom-modal .popup-btns a,
            .custom-modal-welcome .popup-btns a {
                background: #FFB800;
                color: #23262F;
                font-weight: 700;
                padding: 0.38rem 1.3rem;
                text-decoration: none;
                border-radius: 0.8rem;
                transition: background 0.13s;
            }
            .custom-modal .popup-btns a.close-btn,
            .custom-modal-welcome .popup-btns a.close-btn {
                background: #363942;
                color: #fff;
            }
            .custom-modal .popup-btns a.close-btn:hover,
            .custom-modal-welcome .popup-btns a.close-btn:hover {
                background: #181A20;
                color: #FFB800;
            }
            .custom-modal .popup-btns a:hover:not(.close-btn),
            .custom-modal-welcome .popup-btns a:hover:not(.close-btn) {
                background: #e1a800;
            }
            /* Welcome popup custom style */
            .custom-modal-welcome {
                text-align: center;
                padding: 2.3rem 2.1rem 2rem 2.1rem;
            }
            .custom-modal-welcome .popup-title {
                font-size: 2.3rem;
                font-weight: 700;
                letter-spacing: 1px;
                margin-bottom: 1.2rem;
            }
            .custom-modal-welcome .popup-desc {
                font-size: 1.09rem;
                margin-bottom: 1.4rem;
                color: #fff;
                line-height: 1.5;
            }
            .custom-modal-welcome .popup-desc a {
                color: #FFB800;
                text-decoration: underline;
                font-weight: 600;
            }
            .custom-modal-welcome hr {
                border-top: 1px solid #363942;
                margin: 1.5rem 0 1.8rem 0;
            }
            .custom-modal-welcome .popup-btns {
                flex-direction: column;
                gap: 0.7rem;
            }
            .custom-modal-welcome .popup-btns a {
                width: 100%;
                font-size: 1.15rem;
                border-radius: 1.5rem;
                font-weight: 700;
                letter-spacing: 0.6px;
                padding: 0.7rem 1.3rem;
            }
            .custom-modal-welcome .popup-btns a.btn-outline {
                background: transparent;
                color: #fff;
                border: 2px solid #fff;
            }
            .custom-modal-welcome .popup-btns a.btn-outline:hover {
                background: #181A20;
                color: #FFB800;
                border-color: #FFB800;
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
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="brand">
                <img src="https://cdn-icons-png.flaticon.com/512/891/891462.png" alt="logo">
                <span class="brand-title">CINE<br>MAGZ</span>
            </div>
            <div class="nav-menu">
                <a href="movies.jsp"><i class="fa fa-star icon"></i>Movies</a>
                <a href="series.jsp"><i class="fa fa-film icon"></i>Series</a>
                <a href="#" class="restricted"><i class="fa fa-heart icon"></i>Favourites</a>
                <a href="#" class="restricted"><i class="fa fa-bookmark icon"></i>Watchlist</a>
                <a href="#" class="restricted"><i class="fa fa-clock icon"></i>History</a>
            </div>
            <div class="sidebar-bottom">
                <a href="login.jsp"><i class="fa fa-user icon"></i>Login</a>
                <a href="register.jsp"><i class="fa fa-user-plus icon"></i>Register</a>
            </div>
        </div>
        <div class="main-content">
            <div class="header-bar">
                <div class="header-tabs">
                    <a href="movies.jsp">Movies</a>
                    <a href="series.jsp">Series</a>
                </div>
                <div class="search-bar" id="searchBarBox">
                    <i class="fa fa-search"></i>
                    <input type="text" id="searchInput" placeholder="Search movie or series...">
                    <button id="searchClearBtn" style="background:none;border:none;outline:none;color:#888;font-size:1.25rem;display:none;margin-left:0.2rem;" aria-label="Bersihkan"><i class="fa fa-times"></i></button>
                    <div class="search-results-box" id="searchResults"></div>
                </div>
            </div>
            <!-- Banner -->
            <div class="banner mb-4">
                <img class="banner-img" src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=cover&w=900&q=80" alt="Banner">
                <div class="banner-content">
                    <div class="banner-genre">RECOMMEND FOR YOU</div>
                    <div class="banner-title">Breaking Bad</div>
                    <div class="banner-meta">TV Series | 2008–2013 | TV-MA | 45m</div>
                    <span class="banner-rating">IMDb 9.5/10</span>
                    <a href="#" class="banner-watchlist restricted">Watchlist</a>
                    <button class="banner-fav restricted"><i class="fa fa-heart"></i></button>
                </div>
            </div>
            <!-- Top Rated -->
            <div class="section-title">Top Rated</div>
            <div class="movie-grid">
                <div class="movie-card">
                    <img class="movie-img" src="https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=cover&w=400&q=80" alt="Tokyo Train">
                    <button class="fav-btn restricted"><i class="fa fa-heart"></i></button>
                    <div class="movie-body">
                        <div class="movie-title">Tokyo Train</div>
                        <div class="movie-meta">2022 | Action comedy</div>
                    </div>
                </div>
                <div class="movie-card">
                    <img class="movie-img" src="https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=cover&w=400&q=80" alt="Moonfall">
                    <button class="fav-btn restricted"><i class="fa fa-heart"></i></button>
                    <div class="movie-body">
                        <div class="movie-title">Moonfall</div>
                        <div class="movie-meta">2022 | Sci-fi</div>
                    </div>
                </div>
                <div class="movie-card">
                    <img class="movie-img" src="https://images.unsplash.com/photo-1504196606672-aef5c9cefc92?auto=format&fit=cover&w=400&q=80" alt="Life in Paris">
                    <button class="fav-btn restricted"><i class="fa fa-heart"></i></button>
                    <div class="movie-body">
                        <div class="movie-title">Life in Paris</div>
                        <div class="movie-meta">2023 | Documentary series</div>
                    </div>
                </div>
                <div class="movie-card">
                    <img class="movie-img" src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=cover&w=400&q=80" alt="House of Gucci">
                    <button class="fav-btn restricted"><i class="fa fa-heart"></i></button>
                    <div class="movie-body">
                        <div class="movie-title">House of Gucci</div>
                        <div class="movie-meta">2021 | Drama</div>
                    </div>
                </div>
            </div>
            <!-- Most Viewed -->
            <div class="section-title">Most Viewed</div>
            <div class="movie-grid">
                <div class="movie-card">
                    <img class="movie-img" src="https://images.unsplash.com/photo-1465101178521-c1a9136aab5e?auto=format&fit=cover&w=400&q=80" alt="Movie 1">
                    <button class="fav-btn restricted"><i class="fa fa-heart"></i></button>
                    <div class="movie-body">
                        <div class="movie-title">My Shoes</div>
                        <div class="movie-meta">2021 | Adventure</div>
                    </div>
                </div>
                <div class="movie-card">
                    <img class="movie-img" src="https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=cover&w=400&q=80" alt="Movie 2">
                    <button class="fav-btn restricted"><i class="fa fa-heart"></i></button>
                    <div class="movie-body">
                        <div class="movie-title">The Galaxy</div>
                        <div class="movie-meta">2020 | Sci-fi</div>
                    </div>
                </div>
                <div class="movie-card">
                    <img class="movie-img" src="https://images.unsplash.com/photo-1465101178521-c1a9136aab5e?auto=format&fit=cover&w=400&q=80" alt="Movie 3">
                    <button class="fav-btn restricted"><i class="fa fa-heart"></i></button>
                    <div class="movie-body">
                        <div class="movie-title">New Life</div>
                        <div class="movie-meta">2023 | Drama</div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Popup Modal and Backdrop: Fitur Restricted -->
        <div class="modal-backdrop" id="loginRegisterBackdrop"></div>
        <div class="custom-modal" id="loginRegisterModal">
            <div class="popup-title">Akses Fitur Ini Dengan Akun!</div>
            <div>Untuk menggunakan fitur ini, silakan login atau daftar terlebih dahulu.</div>
            <div class="popup-btns">
                <a href="login.jsp">Login</a>
                <a href="register.jsp">Register</a>
                <a href="#" class="close-btn" id="closePopupBtn">Tutup</a>
            </div>
        </div>
        <!-- Welcome Modal and Backdrop: Only on first enter -->
        <div class="modal-backdrop-welcome" id="welcomeBackdrop"></div>
        <div class="custom-modal-welcome" id="welcomeModal">
            <div class="popup-title">CINEMAGZ</div>
            <div class="popup-desc">
                Selamat datang, Guest! Kamu hanya bisa melihat katalog film &amp; series.<br>
                Untuk memberi review, tambah ke favorit, dan mengakses fitur lainnya, silakan <a href="login.jsp"><b>login</b></a> atau <a href="register.jsp"><b>register</b></a>.
            </div>
            <hr>
            <div class="popup-btns">
                <a href="login.jsp" style="background:#FFB800;color:#23262F;">Login</a>
                <a href="register.jsp" class="btn-outline">Register</a>
                <a href="#" class="close-btn" id="closeWelcomeBtn" style="background:transparent;color:#fff;border:none;margin-top:7px;font-size:1.05rem;">Lanjutkan tanpa akun</a>
            </div>
        </div>
        <script>
            // Restricted features popup
            document.querySelectorAll('.restricted').forEach(function (elem) {
                elem.addEventListener('click', function (e) {
                    e.preventDefault();
                    document.getElementById('loginRegisterBackdrop').style.display = "block";
                    document.getElementById('loginRegisterModal').style.display = "block";
                });
            });
            document.getElementById('closePopupBtn').onclick = function (e) {
                e.preventDefault();
                document.getElementById('loginRegisterBackdrop').style.display = "none";
                document.getElementById('loginRegisterModal').style.display = "none";
            };
            document.getElementById('loginRegisterBackdrop').onclick = function () {
                document.getElementById('loginRegisterBackdrop').style.display = "none";
                document.getElementById('loginRegisterModal').style.display = "none";
            }
            // Welcome popup on first load
            <% if (showWelcomePopup) { %>
            window.onload = function () {
                document.getElementById('welcomeBackdrop').style.display = "block";
                document.getElementById('welcomeModal').style.display = "block";
            };
            <% }%>
            document.getElementById('closeWelcomeBtn').onclick = function (e) {
                e.preventDefault();
                document.getElementById('welcomeBackdrop').style.display = "none";
                document.getElementById('welcomeModal').style.display = "none";
            };
            document.getElementById('welcomeBackdrop').onclick = function () {
                document.getElementById('welcomeBackdrop').style.display = "none";
                document.getElementById('welcomeModal').style.display = "none";
            };
        </script>
    </body>
</html>