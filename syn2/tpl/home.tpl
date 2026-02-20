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
                                <a href="/users/{$user_data['id']}/friends" class="stat-value friend-count-display" id="friend-count">...</a>
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
                    <div class="section-header">
                        <h3>My Friends (<span class="friend-count-display">...</span>)</h3>
                        <a href="/users" style="font-size: 12px; font-weight: normal; color: #00a2ff; text-decoration: none;">Find Friends</a>
                    </div>
                    <div class="friends-carousel-wrapper" style="position: relative;">
                        <div class="friend-list" id="friends-container" style="display: flex; overflow-x: auto; scrollbar-width: none; gap: 10px;">
                            <!-- Friends injected here by home.js -->
                        </div>
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
                        <div class="section-header">
                            <h3>Continue</h3>
                        </div>
                        <div class="game-carousel-container" style="position: relative;">
                            <ul id="recent-container" class="game-list" style="display: flex; gap: 10px; overflow-x: auto; padding: 10px 0; margin: 0; list-style: none; scrollbar-width: none;">
                            </ul>
                        </div>
                    </div>

                    <!-- Today's Picks -->
                    <div id="todays-picks-wrapper" style="display: none; margin-bottom: 20px;">
                        <h3 id="todays-picks-title">Today's Picks</h3>
                        <div id="todays-picks-subtitle">Highlights from the community</div>
                        <div class="game-carousel-container" style="position: relative;">
                             <div id="todays-picks-container" style="display: flex; gap: 10px; overflow-x: auto; padding: 10px 0; scrollbar-width: none;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>window.CURRENT_USER_ID={$user_data['id']};</script>
    <script src="https://raw.githack.com/roldblox-project/roldblox-assets/main/syn2/js/home.js?v={time()}"></script>
</body>
</html>
