<!DOCTYPE html>
<html>
<head>
    <title>Home - ROLDBLOX</title>
    <!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"> -->
    <link rel="stylesheet" href="https://raw.githack.com/roldblox-project/roldblox-assets/main/syn2/css/pages/home.css?v={time()}">
    <style>
        /* Inline Home Styles for Immediate Update */
        .content {
            padding: 20px;
            max-width: 1000px;
            margin: 0 auto;
        }

        .welcome-banner {
            display: flex;
            align-items: center;
            background-color: rgb(30, 30, 40);
            border: 1px solid rgb(50, 50, 60);
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .welcome-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 3px solid rgb(60, 60, 70);
            margin-right: 20px;
            object-fit: cover;
            background-color: #000;
        }

        .welcome-text h1 {
            margin: 0 0 5px 0;
            font-size: 28px;
            color: #fff;
            font-weight: 700;
        }

        .welcome-text p {
            margin: 0;
            color: #aaa;
            font-size: 16px;
        }

        .home-layout {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
        }

        .section-header {
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 15px;
            color: #fff;
            border-bottom: 1px solid rgb(50, 50, 60);
            padding-bottom: 10px;
        }

        .feed-item {
            background-color: rgb(30, 30, 40);
            border: 1px solid rgb(50, 50, 60);
            border-radius: 6px;
            padding: 15px;
            margin-bottom: 15px;
        }
        
        .status-update-box {
             background-color: rgb(30, 30, 40);
            border: 1px solid rgb(50, 50, 60);
            border-radius: 6px;
            padding: 15px;
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
        }
        
        .status-input {
            flex-grow: 1;
            background-color: rgb(20, 20, 30);
            border: 1px solid rgb(50, 50, 60);
            border-radius: 4px;
            padding: 10px 12px;
            color: white;
            font-family: inherit;
            border: none;
            outline: none;
        }
        
        .status-input:focus {
            background-color: rgb(25, 25, 35);
            box-shadow: inset 0 0 0 1px rgb(60, 60, 80);
        }
        
        .status-btn {
            background-color: #00a2ff;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.2s;
        }

        .status-btn:hover {
            background-color: #0088d6;
        }

        .friend-list {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
        }

        .friend-card {
            background-color: rgb(30, 30, 40);
            border: 1px solid rgb(50, 50, 60);
            border-radius: 6px;
            padding: 10px;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-decoration: none;
            transition: background-color 0.2s;
        }

        .friend-card:hover {
            background-color: rgb(40, 40, 50);
        }

        .friend-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background-color: #111;
            margin-bottom: 8px;
            object-fit: cover;
        }
        
        .friend-name {
            font-size: 12px;
            color: #ccc;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            width: 100%;
            font-weight: 600;
        }
    </style>
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