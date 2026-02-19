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
            
            <div class="welcome-banner">
                <img src="/Thumbs/Head.ashx?x=150&y=150&userId={$user_data['id']}" class="welcome-avatar" alt="{$user_data['username']}">
                <div class="welcome-text">
                    <h1>Hello, {$user_data["username"]}!</h1>
                    <p>Welcome back to ROLDBLOX!</p>
                </div>
            </div>
            
            <div class="home-layout">
                <div class="feed-section">
                    <h2 class="section-header">My Feed</h2>
                    
                    <div class="status-update-box">
                        <input type="text" class="status-input" placeholder="What are you up to?">
                        <button class="status-btn">Share</button>
                    </div>

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