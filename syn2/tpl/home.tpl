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
                    <div class="profile-names-row">
                        <div class="profile-names">
                            <h1 class="profile-username">{$user_data['username']}</h1>
                            <p class="profile-handle">@{$user_data['username']}</p>
                        </div>
                        
                        <div class="profile-stats">
                            <div class="stat-item">
                                <span class="stat-label">Friends</span>
                                <a href="/users/{$user_data['id']}/friends" class="stat-value">28</a>
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
                    
                    <form action="/users/{$user_data['id']}/profile" method="post" class="status-form">
                        <input type="text" id="status" name="status" class="status-input-field" value="{$user_data['status']}" placeholder="What are you up to?" maxlength="255">
                    </form>
                </div>
                </div>
            </div>
            
            <div class="home-layout">
                <div class="feed-section">
                    <h2 class="section-header">My Feed</h2>

                    <div class="feed-item">
                        <div style="display: flex; align-items: center; margin-bottom: 10px;">
                            <img src="https://github.com/roldblox-project/roldblox-assets/blob/main/images/logo.png?raw=true" style="width: 32px; height: 32px; margin-right: 10px;">
                            <div>
                                <strong style="display: block; font-size: 14px;">ROLDBLOX System</strong>
                                <span style="font-size: 12px; color: #888;">Just now</span>
                            </div>
                        </div>
                        <p style="margin: 0; font-size: 14px; line-height: 1.4;">Welcome to the new ROLDBLOX home page! We've updated the look and feel to make it better for everyone.</p>
                    </div>
                </div>
                
                <div class="friends-section">
                    <h3 class="section-header">My Friends (0)</h3>
                    <div class="friend-list">
                         <!-- Placeholder friends for visual appeal if the list is empty/unavailable -->
                         <!-- 
                         <a href="#" class="friend-card">
                            <img src="/Thumbs/Head.ashx?x=100&y=100&userId=1" class="friend-avatar">
                            <span class="friend-name">BuilderMan</span>
                         </a>
                         -->
                    </div>
                    <div style="text-align: center; padding: 20px; color: #666; font-size: 13px; font-style: italic;">
                        You don't have any friends yet.
                    </div>
                    <p style="margin-top: 15px; font-size: 12px; color: #666; text-align: center;">
                        <a href="/users" style="color: #00a2ff; text-decoration: none;">Find Friends</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>