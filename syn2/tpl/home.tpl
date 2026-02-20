<!DOCTYPE html>
<html>
<head>
    <title>Home - ROLDBLOX</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@300;400;600;700&display=swap" rel="stylesheet">
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
            
            <div class="profile-header">
                <div class="profile-content">
                    <div class="profile-avatar-container">
                        <img src="/Thumbs/Head.ashx?x=150&y=150&userId={$user_data['id']}" class="profile-avatar" data-slider="true" alt="{$user_data['username']}">
                        <div class="status-icon"></div>
                    </div>
                    <div class="profile-info">
                        <div class="profile-text-content">
                            <div class="welcome-text">Welcome back, {$user_data['username']}!</div>
                            <div class="profile-names">
                                <h1 class="profile-username">{$user_data['username']}</h1>
                                <p class="profile-handle">@{$user_data['username']}</p>
                            </div>
                        </div>
                        
                        <div class="profile-stats">
                            <div class="stat-item">
                                <span class="stat-label">Friends</span>
                                <a href="/users/{$user_data['id']}/friends" class="stat-value" id="friend-count">...</a>
                            </div>
                            <div class="stat-item">
                                <span class="stat-label">Followers</span>
                                <a href="/users/{$user_data['id']}/followers" class="stat-value">4</a>
                            </div>
                            <div class="stat-item">
                                <span class="stat-label">Following</span>
                                <a href="/users/{$user_data['id']}/following" class="stat-value">0</a>
                            </div>
                            <div class="stat-item">
                                <span class="stat-label">User RAP</span>
                                <span class="stat-value">0</span>
                            </div>
                        </div>
                    </div>
                    <!-- <form action="/users/{$user_data['id']}/profile" method="post" class="status-form">
                        <input type="text" id="status" name="status" class="status-input-field" value="{$user_data['status']}" placeholder="What are you up to?" maxlength="255">
                    </form> -->
                </div>
            </div>

            <div class="friends-section-wrapper">
                <div class="friends-section">
                    <h3 class="section-header"><div>My Friends (<span id="friend-count">...</span>)</div> <a href="/users" style="font-size: 12px; font-weight: normal; color: #00a2ff; text-decoration: none;">Find Friends</a></h3>
                    <div class="friends-carousel-wrapper" style="position: relative;">
                        <button id="friends-prev" class="carousel-btn prev" style="display: none; position: absolute; left: -15px; top: 50%; transform: translateY(-50%); z-index: 10; border: none; background: rgba(0,0,0,0.5); color: white; border-radius: 50%; width: 30px; height: 30px; cursor: pointer;">&lt;</button>
                        <div class="friend-list" id="friends-container" style="display: flex; overflow-x: auto; scrollbar-width: none; gap: 10px;">
                            <!-- Friends injected here by home.js -->
                        </div>
                        <button id="friends-next" class="carousel-btn next" style="display: none; position: absolute; right: -15px; top: 50%; transform: translateY(-50%); z-index: 10; border: none; background: rgba(0,0,0,0.5); color: white; border-radius: 50%; width: 30px; height: 30px; cursor: pointer;">&gt;</button>
                    </div>
                    <div id="no-friends-msg" style="text-align: center; padding: 20px; color: #666; font-size: 13px; font-style: italic; display: none;">
                        You don't have any friends yet.
                    </div>
                </div>
            </div>

            <div class="home-layout">
                <div class="games-section-wrapper">
                    <!-- Recently Played -->
                    <div id="recent-section" style="margin-bottom: 20px;">
                        <div class="section-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
                            <h3 style="margin: 0; font-size: 20px; font-weight: 600;">Continue</h3>
                        </div>
                        <div class="game-carousel-container" style="position: relative;">
                            <button id="recent-prev" class="carousel-btn prev" style="display: none; position: absolute; left: -15px; top: 50%; transform: translateY(-50%); z-index: 10; border: none; background: rgba(0,0,0,0.5); color: white; border-radius: 50%; width: 30px; height: 30px; cursor: pointer;">&lt;</button>
                            <ul id="recent-container" class="game-list" style="display: flex; gap: 10px; overflow-x: auto; padding: 10px 0; margin: 0; list-style: none; scrollbar-width: none;">
                            </ul>
                            <button id="recent-next" class="carousel-btn next" style="display: none; position: absolute; right: -15px; top: 50%; transform: translateY(-50%); z-index: 10; border: none; background: rgba(0,0,0,0.5); color: white; border-radius: 50%; width: 30px; height: 30px; cursor: pointer;">&gt;</button>
                        </div>
                    </div>

                    <!-- Today's Picks -->
                    <div id="todays-picks-wrapper" style="display: none; margin-bottom: 20px;">
                        <h3 id="todays-picks-title" style="display: none; margin: 0; font-size: 20px; font-weight: 600;">Today's Picks</h3>
                        <div id="todays-picks-subtitle" style="display: none; color: #666; font-size: 12px; margin-bottom: 10px;">Highlights from the community</div>
                        <div class="game-carousel-container" style="position: relative;">
                             <button id="picks-prev" class="carousel-btn prev" style="display: none; position: absolute; left: -15px; top: 50%; transform: translateY(-50%); z-index: 10; border: none; background: rgba(0,0,0,0.5); color: white; border-radius: 50%; width: 30px; height: 30px; cursor: pointer;">&lt;</button>
                             <div id="todays-picks-container" style="display: flex; gap: 10px; overflow-x: auto; padding: 10px 0; scrollbar-width: none;"></div>
                             <button id="picks-next" class="carousel-btn next" style="display: none; position: absolute; right: -15px; top: 50%; transform: translateY(-50%); z-index: 10; border: none; background: rgba(0,0,0,0.5); color: white; border-radius: 50%; width: 30px; height: 30px; cursor: pointer;">&gt;</button>
                        </div>
                    </div>
                </div>

                <div class="feed-section">
                    <h3 class="section-header">My Feed</h3>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://raw.githack.com/roldblox-project/roldblox-assets/main/home.js?v={time()}"></script>
</body>
</html>