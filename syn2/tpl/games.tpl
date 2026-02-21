<!DOCTYPE html>
<html>
<head>
    <title>Games - ROLDBLOX</title>
    <meta name="game-card-style" content="roblox">
    <link rel="stylesheet" href="https://raw.githack.com/roldblox-project/roldblox-assets/main/syn2/css/pages/games.css?v={time()}">
</head>
<body>
    {include file="nav.tpl"}

    <div class="main-container">
        <div class="content">
            <div class="section-header">
                <h2 class="mb-0">Trending</h2>
                <form id="game-search-form" class="ms-auto">
                    <input id="search-input" type="text" name="q" placeholder="Search games" class="form-control" />
                    <button type="submit" class="btn-search"><span class="b-icon">magnifying-glass</span> Search</button>
                </form>
            </div>
            <div class="carousel-container game-carousel-container">
                <a class="btn btn-dark position-absolute top-50 translate-middle-y carousel-btn prev" onclick="scrollCarousel('trending-games-container', -400)"><span class="b-icon">chevron-left</span></a>
                <ul id="trending-games-container" class="list-unstyled d-flex games-carousel game-list gap-3 m-0"></ul>
                <a class="btn btn-dark position-absolute top-50 translate-middle-y carousel-btn next" onclick="scrollCarousel('trending-games-container', 400)"><span class="b-icon">chevron-right</span></a>
            </div>

            <div class="d-flex align-items-center mt-4">
                <h2 class="mb-0">Popular</h2>
            </div>
            <div class="carousel-container game-carousel-container">
                <a class="btn btn-dark position-absolute top-50 translate-middle-y carousel-btn prev" onclick="scrollCarousel('popular-games-container', -400)"><span class="b-icon">chevron-left</span></a>
                <ul id="popular-games-container" class="list-unstyled d-flex games-carousel game-list gap-3 m-0"></ul>
                <a class="btn btn-dark position-absolute top-50 translate-middle-y carousel-btn next" onclick="scrollCarousel('popular-games-container', 400)"><span class="b-icon">chevron-right</span></a>
            </div>

            <div class="d-flex align-items-center mt-4">
                <h2 class="mb-0">Top Rated</h2>
            </div>
            <div class="carousel-container game-carousel-container">
                <a class="btn btn-dark position-absolute top-50 translate-middle-y carousel-btn prev" onclick="scrollCarousel('top-rated-games-container', -400)"><span class="b-icon">chevron-left</span></a>
                <ul id="top-rated-games-container" class="list-unstyled d-flex games-carousel game-list gap-3 m-0"></ul>
                <a class="btn btn-dark position-absolute top-50 translate-middle-y carousel-btn next" onclick="scrollCarousel('top-rated-games-container', 400)"><span class="b-icon">chevron-right</span></a>
            </div>

            <div class="d-flex align-items-center mt-4">
                <h2 class="mb-0">Playing Now</h2>
            </div>
            <div class="carousel-container game-carousel-container">
                <a class="btn btn-dark position-absolute top-50 translate-middle-y carousel-btn prev" onclick="scrollCarousel('playing-now-games-container', -400)"><span class="b-icon">chevron-left</span></a>
                <ul id="playing-now-games-container" class="list-unstyled d-flex games-carousel game-list gap-3 m-0"></ul>
                <a class="btn btn-dark position-absolute top-50 translate-middle-y carousel-btn next" onclick="scrollCarousel('playing-now-games-container', 400)"><span class="b-icon">chevron-right</span></a>
            </div>

            <div class="d-flex align-items-center mt-4">
                <h2 class="mb-0">Upcoming</h2>
            </div>
            <div class="carousel-container game-carousel-container">
                <a class="btn btn-dark position-absolute top-50 translate-middle-y carousel-btn prev" onclick="scrollCarousel('upcoming-games-container', -400)"><span class="b-icon">chevron-left</span></a>
                <ul id="upcoming-games-container" class="list-unstyled d-flex games-carousel game-list gap-3 m-0"></ul>
                <a class="btn btn-dark position-absolute top-50 translate-middle-y carousel-btn next" onclick="scrollCarousel('upcoming-games-container', 400)"><span class="b-icon">chevron-right</span></a>
            </div>

            <div class="d-flex align-items-center mt-4">
                <h2 class="mb-0">Friends Are Playing</h2>
            </div>
            <div class="carousel-container game-carousel-container">
                <a class="btn btn-dark position-absolute top-50 translate-middle-y carousel-btn prev" onclick="scrollCarousel('friends-games-container', -400)"><span class="b-icon">chevron-left</span></a>
                <ul id="friends-games-container" class="list-unstyled d-flex games-carousel game-list gap-3 m-0"></ul>
                <a class="btn btn-dark position-absolute top-50 translate-middle-y carousel-btn next" onclick="scrollCarousel('friends-games-container', 400)"><span class="b-icon">chevron-right</span></a>
            </div>

            <section id="search-results-section" style="display:none;">
                <div class="d-flex align-items-center mt-4">
                    <h2 id="search-results-title" class="mb-0">Search</h2>
                    <div class="ms-auto d-flex align-items-center" id="pagination-container" style="gap: 8px;">
                        <a href="#" id="prev-page" class="text-secondary">Prev</a>
                        <span id="page-info" class="text-secondary">Page 1</span>
                        <a href="#" id="next-page" class="text-secondary">Next</a>
                    </div>
                </div>
                <div class="carousel-container game-carousel-container">
                    <ul id="search-results-container" class="list-unstyled d-flex games-carousel game-list gap-3 m-0"></ul>
                </div>
            </section>
        </div>
    </div>

    <script src="https://raw.githack.com/roldblox-project/roldblox-assets/main/syn2/js/v1games.js?v={time()}"></script>
</body>
</html>
