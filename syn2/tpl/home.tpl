<!DOCTYPE html>
<html>
<head>
    <title>Home - ROLDBLOX</title>
    <!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"> -->
    <link rel="stylesheet" href="https://raw.githack.com/roldblox-project/roldblox-assets/main/syn2/css/pages/home.css?v={time()}">
    </head>
<body>

    <!-- Navigation Bar & Sidebar -->
    {include file="nav.tpl"}

    <!-- Main Container -->
    <div class="main-container">
        <!-- Main Content -->
        <div class="content">
            <div class="welcome-box">
                <h1>Welcome, {$user_data["username"]}!</h1>
                <p>Welcome to ROLDBLOX.</p>
            </div>
            
            <div class="home-layout">
                <div class="feed-section">
                    <h2>Your Feed</h2>
                    <p>This is your home page feed.</p>
                </div>
                
                <div class="friends-section">
                    <h3>My Friends</h3>
                    <p>Friends list is temporarily unavailable.</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>