<!DOCTYPE html>
<html>
<head>
    <title>Home - ROLDBLOX</title>
    <!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"> -->
    <link rel="stylesheet" href="https://raw.githack.com/roldblox-project/roldblox-assets/main/syn2/css/nav.css?v={time()}">
    <link rel="stylesheet" href="https://raw.githack.com/roldblox-project/roldblox-assets/main/syn2/css/pages/home.css?v={time()}">
    </head>
<body>

    <!-- Navigation Bar -->
    {include file="syn2/tpl/nav.tpl"}

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
                    <li><a href="{url page="home"}"><span class="b-icon">house</span> Home</a></li>
                    <li><a href="{url page="games"}"><span class="b-icon">controller</span> Games</a></li>
                    <li><a href="{url page="catalog"}"><span class="b-icon">shopping-cart</span> Avatar Shop</a></li>
                    <li><a href="{url page="develop"}"><span class="b-icon">square-code</span> Create</a></li>
                    <li><a href="{url page="upgrade"}"><span class="b-icon">robux</span> Robux</a></li>
                </ul>
            </div>

            <div class="sidebar-section">
                <h3 class="sidebar-header">MY</h3>
                <ul class="sidebar-menu">
                    <li><a href="/users/{$user_data['id']}/profile"><span class="b-icon">person</span> My Profile</a></li>
                    <li><a href="{url page="messages"}"><span class="b-icon">two-people-speech-bubble</span> My Messages</a></li>
                    <li><a href="{url page="avatar"}"><span class="b-icon">circle-person</span> My Avatar</a></li>
                    <li><a href="{url page="inventory"}"><span class="b-icon">backpack</span> My Inventory</a></li>
                    <li><a href="{url page="groups"}"><span class="b-icon">three-people</span> My Groups</a></li>
                </ul>
            </div>
        </div>

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
