<!DOCTYPE html>
<html>
<head>
    <title>Home - ROLDBLOX</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://raw.githack.com/roldblox-project/roldblox-assets/main/syn2/css/nav.css?v={time()}">
    <link rel="stylesheet" href="https://raw.githack.com/roldblox-project/roldblox-assets/main/syn2/css/pages/home.css?v={time()}">
    </head>
<body>

    <!-- Navigation Bar -->
    <div class="navbar">
        <div class="navbar-left">
            <img src="https://github.com/roldblox-project/roldblox-assets/blob/main/images/logo.png?raw=true" alt="ROLDBLOX" class="navbar-logo">
            <!-- Navigation Links could go here -->
        </div>
        <div class="navbar-right">
        <div class="user-stat">
            <a href="/users/{$user_data['id']}/profile" style="color: inherit; text-decoration: none; display: flex; align-items: center;">
                <img src="/Thumbs/Head.ashx?x=150&y=150&userId={$user_data['id']}" class="navbar-headshot">
                <span>{$user_data['username']}</span>
            </a>
        </div>
        <div class="user-stat">
            <strong>{$user_data["robux"]}</strong> Robux
        </div>
        <div class="user-stat">
            <strong>{$user_data["tickets"]}</strong> Tix
        </div>
    </div>
    </div>

    <!-- Main Container with Sidebar and Content -->
    <div class="main-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-section">
                <h3 class="sidebar-header">SIGNED IN AS</h3>
                <a href="/users/{$user_data['id']}/profile" class="sidebar-user-link">
                    <img src="/Thumbs/Head.ashx?x=48&y=48&userId={$user_data['id']}" class="sidebar-headshot">
                    <span class="sidebar-username">@{$user_data['username']}</span>
                </a>
            </div>

            <div class="sidebar-section">
                <h3 class="sidebar-header">GENERAL</h3>
                <ul class="sidebar-menu">
                    <li><a href="{url page="home"}"><i class="bi bi-house-door"></i> Home</a></li>
                    <li><a href="{url page="games"}"><i class="bi bi-controller"></i> Discover</a></li>
                    <li><a href="{url page="catalog"}"><i class="bi bi-bag"></i> Avatar Shop</a></li>
                    <li><a href="{url page="develop"}"><i class="bi bi-hammer"></i> Create</a></li>
                    <li><a href="{url page="upgrade"}"><i class="bi bi-currency-dollar"></i> Robux</a></li>
                </ul>
            </div>

            <div class="sidebar-section">
                <h3 class="sidebar-header">MY</h3>
                <ul class="sidebar-menu">
                    <li><a href="/users/{$user_data['id']}/profile"><i class="bi bi-person"></i> My Profile</a></li>
                    <li><a href="{url page="messages"}"><i class="bi bi-chat-left-text"></i> My Messages</a></li>
                    <li><a href="{url page="character"}"><i class="bi bi-person-circle"></i> My Avatar</a></li>
                    <li><a href="{url page="inventory"}"><i class="bi bi-box-seam"></i> My Inventory</a></li>
                    <li><a href="{url page="groups"}"><i class="bi bi-people"></i> My Groups</a></li>
                </ul>
            </div>
            
             <div class="sidebar-section">
                <h3 class="sidebar-header">MORE</h3>
                <ul class="sidebar-menu">
                    <li><a href="{url page="blog"}"><i class="bi bi-newspaper"></i> Blog</a></li>
                </ul>
            </div>
        </div>

        <!-- Main Content -->
        <div class="content">
            <div class="welcome-box">
                <h1>Welcome, {$user_data["username"]}!</h1>
                <p>Welcome to ROLDBLOX.</p>
            </div>
            
            <div style="display: flex; gap: 20px;">
                <div style="flex: 1;">
                    <h2>Your Feed</h2>
                    <p>This is your home page feed.</p>
                </div>
                
                <div style="width: 300px;">
                    <h3>My Friends</h3>
                    <p>Friends list is temporarily unavailable.</p>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
