<!DOCTYPE html>
<html>
<head>
    <title>Home - ROLDBLOX</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/roldblox-project/roldblox-assets@main/syn2/css/nav.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/roldblox-project/roldblox-assets@main/syn2/css/pages/home.css">
</head>
<body>

    <!-- Navigation Bar -->
    <div class="navbar">
        <div class="navbar-left">
            <img src="https://github.com/roldblox-project/roldblox-assets/blob/main/images/logo.png?raw=true" alt="ROLDBLOX" class="navbar-logo">
            <!-- Navigation Links could go here -->
        </div>
        <div class="navbar-right">
            <div class="user-info">
                <span>{$user_data["username"]}</span>
            </div>
            <div class="user-stat">
                <span>Robux:</span>
                <strong>{$user_data["robux"]}</strong>
            </div>
            <div class="user-stat">
                <span>Tix:</span>
                <strong>{$user_data["tickets"]}</strong>
            </div>
        </div>
    </div>

    <!-- Main Container with Sidebar and Content -->
    <div class="main-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <ul class="sidebar-menu">
                <li><a href="{url page="home"}">Home</a></li>
                <li><a href="{url page="games"}">Games</a></li>
                <li><a href="{url page="catalog"}">Catalog</a></li>
                <li><a href="{url page="users"}">People</a></li>
                <li><a href="{url page="forum"}">Forum</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="content">
            <div class="welcome-box">
                <h1>Hello, {$user_data["username"]}!</h1>
                <p>Welcome to ROLDBLOX.</p>
            </div>
            
            <!-- Additional content can go here -->
            <p>This is your home page feed.</p>
        </div>
    </div>

</body>
</html>
