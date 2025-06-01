<%-- 
    Document   : ContentPage
    Created on : May 27, 2025, 3:16:37 AM
    Author     : user
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Breaking Bad - CINE MAGZ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="content-styles.css">
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
                                <a class="nav-link text-white active" href="index.jsp">
                                    <i class="fas fa-home me-2"></i> For You
                                </a>
                            </li>
                            <li class="nav-item mb-2">
                                <a class="nav-link text-white-50" href="#">
                                    <i class="fas fa-heart me-2"></i> Favourites
                                </a>
                            </li>
                            <li class="nav-item mb-2">
                                <a class="nav-link text-white-50" href="#">
                                    <i class="fas fa-bookmark me-2"></i> Watchlist
                                </a>
                            </li>
                            <li class="nav-item mb-2">
                                <a class="nav-link text-white-50" href="#">
                                    <i class="fas fa-history me-2"></i> History
                                </a>
                            </li>
                        </ul>
                    </nav>
                    
                    <!-- User Section -->
                    <div class="p-3 border-top border-secondary">
                        <div class="nav-item mb-2">
                            <a class="nav-link text-white-50" href="#">
                                <i class="fas fa-user me-2"></i> User
                            </a>
                        </div>
                        <div class="nav-item">
                            <a class="nav-link text-white-50" href="#">
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
                        <div class="d-flex align-items-center">
                            <a href="index.jsp" class="btn btn-outline-light me-3">
                                <i class="fas fa-arrow-left me-2"></i>Back
                            </a>
                            <ul class="navbar-nav">
                                <li class="nav-item">
                                    <a class="nav-link active fw-bold" href="#">Series</a>
                                </li>
                            </ul>
                        </div>
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
                
                <!-- Content Hero Section -->
                <div class="content-hero position-relative">
                    <div class="hero-overlay"></div>
                    <div class="play-button position-absolute top-50 start-50 translate-middle">
                        <button class="btn btn-warning btn-lg rounded-circle play-btn">
                            <i class="fas fa-play fs-2"></i>
                        </button>
                    </div>
                    <div class="hero-content position-absolute bottom-0 start-0 p-5">
                        <div class="row">
                            <div class="col-md-8">
                                <h1 class="display-4 fw-bold text-white mb-3">Breaking Bad</h1>
                                <div class="d-flex align-items-center gap-3 mb-4">
                                    <div class="imdb-rating d-flex align-items-center bg-warning text-dark px-3 py-2 rounded">
                                        <strong>IMDb</strong>
                                        <span class="ms-2">9.5/10</span>
                                    </div>
                                    <span class="badge bg-success">TV-MA</span>
                                    <span class="text-white-50">2008-2013</span>
                                    <span class="text-white-50">5 Seasons</span>
                                    <span class="text-white-50">62 Episodes</span>
                                </div>
                                
                                <div class="d-flex align-items-center gap-3 mb-4">
                                    <button class="btn btn-warning px-4 py-2">
                                        <i class="fas fa-play me-2"></i>Watch Now
                                    </button>
                                    <button class="btn btn-outline-light px-4 py-2">
                                        <i class="fas fa-plus me-2"></i>Add to Watchlist
                                    </button>
                                    <button class="btn btn-outline-light rounded-circle">
                                        <i class="fas fa-heart"></i>
                                    </button>
                                    <button class="btn btn-outline-light rounded-circle">
                                        <i class="fas fa-share"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Content Details -->
                <div class="content-details p-5">
                    <div class="row">
                        <div class="col-md-8">
                            <!-- Synopsis -->
                            <div class="mb-5">
                                <h3 class="text-white mb-3">Synopsis</h3>
                                <p class="text-white-50 lh-lg">
                                    A high school chemistry teacher diagnosed with inoperable lung cancer turns to manufacturing and 
                                    selling methamphetamine in order to secure his family's future. Walter White, a struggling high 
                                    school chemistry teacher, is diagnosed with advanced lung cancer. He turns to a life of crime, 
                                    producing and selling methamphetamine with his former student Jesse Pinkman, with the goal of 
                                    securing his family's financial future before he dies.
                                </p>
                            </div>
                            
                            <!-- Episodes Section -->
                            <div class="mb-5">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h3 class="text-white">Episodes</h3>
                                    <select class="form-select bg-dark text-white border-secondary" style="width: auto;">
                                        <option>Season 1</option>
                                        <option>Season 2</option>
                                        <option>Season 3</option>
                                        <option>Season 4</option>
                                        <option>Season 5</option>
                                    </select>
                                </div>
                                
                                <div class="episodes-list">
                                    <div class="episode-item d-flex align-items-center p-3 mb-3 rounded">
                                        <div class="episode-thumbnail me-3">
                                            <img src="/placeholder.svg?height=80&width=140" class="rounded" alt="Episode 1">
                                            <div class="play-overlay">
                                                <i class="fas fa-play"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div>
                                                    <h6 class="text-white mb-1">1. Pilot</h6>
                                                    <p class="text-white-50 small mb-2">58m</p>
                                                    <p class="text-white-50 small mb-0">
                                                        Walter White, a struggling high school chemistry teacher, is diagnosed with advanced lung cancer.
                                                    </p>
                                                </div>
                                                <button class="btn btn-outline-light btn-sm">
                                                    <i class="fas fa-download"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="episode-item d-flex align-items-center p-3 mb-3 rounded">
                                        <div class="episode-thumbnail me-3">
                                            <img src="/placeholder.svg?height=80&width=140" class="rounded" alt="Episode 2">
                                            <div class="play-overlay">
                                                <i class="fas fa-play"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div>
                                                    <h6 class="text-white mb-1">2. Cat's in the Bag...</h6>
                                                    <p class="text-white-50 small mb-2">48m</p>
                                                    <p class="text-white-50 small mb-0">
                                                        Walt and Jesse attempt to tie up loose ends. The desperate situation gets more complicated.
                                                    </p>
                                                </div>
                                                <button class="btn btn-outline-light btn-sm">
                                                    <i class="fas fa-download"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="episode-item d-flex align-items-center p-3 mb-3 rounded">
                                        <div class="episode-thumbnail me-3">
                                            <img src="/placeholder.svg?height=80&width=140" class="rounded" alt="Episode 3">
                                            <div class="play-overlay">
                                                <i class="fas fa-play"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div>
                                                    <h6 class="text-white mb-1">3. ...And the Bag's in the River</h6>
                                                    <p class="text-white-50 small mb-2">48m</p>
                                                    <p class="text-white-50 small mb-0">
                                                        Walter fights with Jesse over his drug use, causing him to leave unexpectedly.
                                                    </p>
                                                </div>
                                                <button class="btn btn-outline-light btn-sm">
                                                    <i class="fas fa-download"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Sidebar Info -->
                        <div class="col-md-4">
                            <div class="info-card p-4 rounded mb-4">
                                <h5 class="text-white mb-3">Cast & Crew</h5>
                                <div class="cast-list">
                                    <div class="cast-item d-flex align-items-center mb-3">
                                        <img src="/placeholder.svg?height=50&width=50" class="rounded-circle me-3" alt="Bryan Cranston">
                                        <div>
                                            <h6 class="text-white mb-0">Bryan Cranston</h6>
                                            <small class="text-white-50">Walter White</small>
                                        </div>
                                    </div>
                                    <div class="cast-item d-flex align-items-center mb-3">
                                        <img src="/placeholder.svg?height=50&width=50" class="rounded-circle me-3" alt="Aaron Paul">
                                        <div>
                                            <h6 class="text-white mb-0">Aaron Paul</h6>
                                            <small class="text-white-50">Jesse Pinkman</small>
                                        </div>
                                    </div>
                                    <div class="cast-item d-flex align-items-center mb-3">
                                        <img src="/placeholder.svg?height=50&width=50" class="rounded-circle me-3" alt="Anna Gunn">
                                        <div>
                                            <h6 class="text-white mb-0">Anna Gunn</h6>
                                            <small class="text-white-50">Skyler White</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="info-card p-4 rounded mb-4">
                                <h5 class="text-white mb-3">Details</h5>
                                <div class="details-list">
                                    <div class="detail-item mb-2">
                                        <span class="text-white-50">Genre:</span>
                                        <span class="text-white ms-2">Crime, Drama, Thriller</span>
                                    </div>
                                    <div class="detail-item mb-2">
                                        <span class="text-white-50">Creator:</span>
                                        <span class="text-white ms-2">Vince Gilligan</span>
                                    </div>
                                    <div class="detail-item mb-2">
                                        <span class="text-white-50">Network:</span>
                                        <span class="text-white ms-2">AMC</span>
                                    </div>
                                    <div class="detail-item mb-2">
                                        <span class="text-white-50">Language:</span>
                                        <span class="text-white ms-2">English</span>
                                    </div>
                                    <div class="detail-item mb-2">
                                        <span class="text-white-50">Country:</span>
                                        <span class="text-white ms-2">United States</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="info-card p-4 rounded">
                                <h5 class="text-white mb-3">Ratings</h5>
                                <div class="ratings">
                                    <div class="rating-item d-flex justify-content-between mb-2">
                                        <span class="text-white-50">IMDb</span>
                                        <span class="text-warning">9.5/10</span>
                                    </div>
                                    <div class="rating-item d-flex justify-content-between mb-2">
                                        <span class="text-white-50">Rotten Tomatoes</span>
                                        <span class="text-success">96%</span>
                                    </div>
                                    <div class="rating-item d-flex justify-content-between mb-2">
                                        <span class="text-white-50">Metacritic</span>
                                        <span class="text-info">99/100</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Related Content -->
                <div class="related-content p-5">
                    <h3 class="text-white mb-4">You Might Also Like</h3>
                    <div class="row g-4">
                        <div class="col-md-3">
                            <div class="movie-card position-relative">
                                <img src="/placeholder.svg?height=300&width=250" class="card-img-top rounded" alt="Better Call Saul">
                                <button class="btn btn-outline-light rounded-circle position-absolute top-0 end-0 m-2">
                                    <i class="fas fa-heart"></i>
                                </button>
                                <div class="card-body p-3">
                                    <h6 class="text-white fw-bold">Better Call Saul</h6>
                                    <p class="text-white-50 small mb-0">2015-2022 | Crime Drama</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="movie-card position-relative">
                                <img src="/placeholder.svg?height=300&width=250" class="card-img-top rounded" alt="The Sopranos">
                                <button class="btn btn-outline-light rounded-circle position-absolute top-0 end-0 m-2">
                                    <i class="fas fa-heart"></i>
                                </button>
                                <div class="card-body p-3">
                                    <h6 class="text-white fw-bold">The Sopranos</h6>
                                    <p class="text-white-50 small mb-0">1999-2007 | Crime Drama</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="movie-card position-relative">
                                <img src="/placeholder.svg?height=300&width=250" class="card-img-top rounded" alt="Ozark">
                                <button class="btn btn-outline-light rounded-circle position-absolute top-0 end-0 m-2">
                                    <i class="fas fa-heart"></i>
                                </button>
                                <div class="card-body p-3">
                                    <h6 class="text-white fw-bold">Ozark</h6>
                                    <p class="text-white-50 small mb-0">2017-2022 | Crime Thriller</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="movie-card position-relative">
                                <img src="/placeholder.svg?height=300&width=250" class="card-img-top rounded" alt="Narcos">
                                <button class="btn btn-outline-light rounded-circle position-absolute top-0 end-0 m-2">
                                    <i class="fas fa-heart"></i>
                                </button>
                                <div class="card-body p-3">
                                    <h6 class="text-white fw-bold">Narcos</h6>
                                    <p class="text-white-50 small mb-0">2015-2017 | Crime Biography</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!--<script src="content-script.js"></script>-->
</body>
</html>