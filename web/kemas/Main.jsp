<%-- 
    Document   : Main
    Created on : May 24, 2025, 8:59:57 AM
    Author     : user
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CINE MAGZ - Movie Streaming Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/styles/styles.css">
</head>
<body>
    <div class="container-fluid p-0">
        <div class="row g-0">
            <!-- Sidebar -->
            <div class="col-auto sidebar">
                <div class="d-flex flex-column vh-100">
                    <!-- Logo -->
                    <div class="p-3 border-bottom border-secondary">
                        <div class="d-flex align-items-center">
                            <i class="fas fa-film text-warning me-2 fs-4"></i>
                            <div>
                                <h5 class="text-white mb-0">CINE</h5>
                                <h5 class="text-white mb-0">MAGZ</h5>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Navigation -->
                    <nav class="flex-grow-1 p-3">
                        <ul class="nav flex-column">
                            <li class="nav-item mb-2">
                                <a class="nav-link text-white active" href="Main.jsp">
                                    <i class="fas fa-home me-2"></i> For You
                                </a>
                            </li>
                            <li class="nav-item mb-2">
                                <a class="nav-link text-white-50" href="FavoritesList.jsp">
                                    <i class="fas fa-heart me-2"></i> Favourites
                                </a>
                            </li>
                            <li class="nav-item mb-2">
                                <a class="nav-link text-white-50" href="WatchList.jsp">
                                    <i class="fas fa-bookmark me-2"></i> Watchlist
                                </a>
                            </li>
                            <li class="nav-item mb-2">
                                <a class="nav-link text-white-50" href="History.jsp">
                                    <i class="fas fa-history me-2"></i> History
                                </a>
                            </li>
                        </ul>
                    </nav>
                    
                    <!-- User Section -->
                    <div class="p-3 border-top border-secondary">
                        <div class="nav-item mb-2">
                            <a class="nav-link text-white-50" href="#"> 
<!--                                user.jsp-->
                                <i class="fas fa-user me-2"></i> User
                            </a>
                        </div>
                        <div class="nav-item">
                            <a class="nav-link text-white-50" href="#">
                                <!--logout-->
                                <i class="fas fa-sign-out-alt me-2"></i> Logout
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col main-content">
                <!-- Top Navigation -->
                <nav class="navbar navbar-expand-lg navbar-dark bg-transparent px-4 py-3">
                    <div class="container-fluid">
                        <ul class="navbar-nav me-auto">
                            <li class="nav-item">
                                <a class="nav-link active fw-bold" href="#">Movies</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-white-50" href="#">Series</a>
                            </li>
                        </ul>
                        <div class="d-flex">
                            <div class="input-group search-box">
                                <input type="text" class="form-control bg-transparent border-0 text-white" 
                                       placeholder="Search" aria-label="Search">
                                <button class="btn btn-outline-secondary border-0" type="button">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </nav>
                
                <!-- Hero Section -->
                <div class="hero-section position-relative">
                    <div class="hero-overlay"></div>
                    <div class="hero-content position-absolute bottom-0 start-0 p-5">
                        <p class="text-warning mb-2 fw-bold">RECOMMEND FOR YOU</p>
                        <h1 class="display-3 fw-bold text-white mb-3">Breaking Bad</h1>
                        <p class="text-white-50 mb-4">TV Series | 2008-2013 | TV-MA | 49m</p>
                        
                        <div class="d-flex align-items-center gap-3">
                            <div class="imdb-rating d-flex align-items-center bg-warning text-dark px-3 py-2 rounded">
                                <strong>IMDb</strong>
                                <span class="ms-2">9.5/10</span>
                            </div>
                            <button class="btn btn-dark px-4 py-2 rounded">
                                <i class="fas fa-plus me-2"></i>Watchlist
                            </button>
                            <button class="btn btn-outline-light rounded-circle">
                                <i class="fas fa-heart"></i>
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Top Rated Section -->
                <div class="content-section p-5">
                    <h3 class="text-white mb-4">Top Rated</h3>
                    <div class="row g-4">
                        <div class="col-md-3">
                            <div class="movie-card position-relative">
                                <img src="/placeholder.svg?height=300&width=250" class="card-img-top rounded" alt="Tokyo Train">
                                <button class="btn btn-outline-light rounded-circle position-absolute top-0 end-0 m-2">
                                    <i class="fas fa-heart"></i>
                                </button>
                                <div class="card-body p-3">
                                    <h6 class="text-white fw-bold">Tokyo Train</h6>
                                    <p class="text-white-50 small mb-0">2022 | Action comedy</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="movie-card position-relative">
                                <img src="/placeholder.svg?height=300&width=250" class="card-img-top rounded" alt="Moonfall">
                                <button class="btn btn-outline-light rounded-circle position-absolute top-0 end-0 m-2">
                                    <i class="fas fa-heart"></i>
                                </button>
                                <div class="card-body p-3">
                                    <h6 class="text-white fw-bold">Moonfall</h6>
                                    <p class="text-white-50 small mb-0">2022 | Sci-fi</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="movie-card position-relative">
                                <img src="/placeholder.svg?height=300&width=250" class="card-img-top rounded" alt="Life in Paris">
                                <button class="btn btn-outline-light rounded-circle position-absolute top-0 end-0 m-2">
                                    <i class="fas fa-heart"></i>
                                </button>
                                <div class="card-body p-3">
                                    <h6 class="text-white fw-bold">Life in Paris</h6>
                                    <p class="text-white-50 small mb-0">2023 | Documentary series</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="movie-card position-relative">
                                <img src="/placeholder.svg?height=300&width=250" class="card-img-top rounded" alt="House of Gucci">
                                <button class="btn btn-outline-light rounded-circle position-absolute top-0 end-0 m-2">
                                    <i class="fas fa-heart"></i>
                                </button>
                                <div class="card-body p-3">
                                    <h6 class="text-white fw-bold">House of Gucci</h6>
                                    <p class="text-white-50 small mb-0">2021 | Drama</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Most Viewed Section -->
                <div class="content-section px-5 pb-5">
                    <h3 class="text-white mb-4">Most Viewed</h3>
                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="movie-card position-relative">
                                <img src="/placeholder.svg?height=200&width=350" class="card-img-top rounded" alt="Movie 1">
                                <button class="btn btn-outline-light rounded-circle position-absolute top-0 end-0 m-2">
                                    <i class="fas fa-heart"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="movie-card position-relative">
                                <img src="/placeholder.svg?height=200&width=350" class="card-img-top rounded" alt="Movie 2">
                                <button class="btn btn-outline-light rounded-circle position-absolute top-0 end-0 m-2">
                                    <i class="fas fa-heart"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="movie-card position-relative">
                                <img src="/placeholder.svg?height=200&width=350" class="card-img-top rounded" alt="Movie 3">
                                <button class="btn btn-outline-light rounded-circle position-absolute top-0 end-0 m-2">
                                    <i class="fas fa-heart"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
