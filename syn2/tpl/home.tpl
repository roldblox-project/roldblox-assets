<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ROLDBLOX - Revive. Remember. Relive.</title>
    
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:ital,wght@0,200;0,300;0,400;0,600;0,700;0,900;1,400&display=swap" rel="stylesheet">
    
    <!-- Styles -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/roldblox-project/roldblox-assets@main/syn2/css/nav.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/roldblox-project/roldblox-assets@main/syn2/css/pages/home.css">
    
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Source Sans Pro', sans-serif;
            background-color: rgb(30, 30, 40);
            color: white;
        }
        
        * {
            box-sizing: border-box;
        }
    </style>
</head>
<body>

    <!-- Top Navigation -->
    <nav class="top-nav">
        <a href="/" class="nav-logo">
            <img src="https://cdn.jsdelivr.net/gh/roldblox-project/roldblox-assets@main/images/logo.png" alt="ROLDBLOX">
        </a>
        
        <ul class="top-nav-list">
            <li class="top-nav-item"><a href="/" class="top-nav-link active">Home</a></li>
            <li class="top-nav-item"><a href="{url page='games'}" class="top-nav-link">Games</a></li>
            <li class="top-nav-item"><a href="{url page='catalog'}" class="top-nav-link">Catalog</a></li>
            <li class="top-nav-item"><a href="{url page='users'}" class="top-nav-link">Users</a></li>
            <li class="top-nav-item"><a href="{url page='forum'}" class="top-nav-link">Forum</a></li>
            
            {if $user_data}
                <li class="top-nav-item"><a href="{url page='profile' id=$user_data['id']}" class="top-nav-link">{$user_data["username"]}</a></li>
            {else}
                <li class="top-nav-item"><a href="{url page='login'}" class="top-nav-link">Login</a></li>
                <li class="top-nav-item"><a href="{url page='register'}" class="btn primary-btn" style="padding: 8px 16px;">Sign Up</a></li>
            {/if}
        </ul>
        
        <button class="sidebar-toggle-btn" aria-label="Toggle Menu" onclick="document.querySelector('.sidebar').classList.toggle('open'); document.querySelector('.sidebar-overlay').classList.toggle('active');">
            <span class="hamburger-line"></span>
            <span class="hamburger-line" style="margin-top: 4px;"></span>
            <span class="hamburger-line" style="margin-top: 4px;"></span>
        </button>
    </nav>

    <!-- Sidebar Overlay -->
    <div class="sidebar-overlay" onclick="document.querySelector('.sidebar').classList.remove('open'); document.querySelector('.sidebar-overlay').classList.remove('active');"></div>

    <!-- Sidebar -->
    <aside class="sidebar">
        {if $user_data}
        <div class="sidebar-user-info">
            <img src='{asset type="Head" id=$user_data["id"] size="100x100"}' alt="Avatar" class="sidebar-avatar">
            <div class="sidebar-user-details">
                <span class="sidebar-username">{$user_data["username"]}</span>
                <span class="sidebar-robux">R$ {$user_data["robux"]}</span>
            </div>
        </div>
        {/if}

        <ul class="sidebar-nav-list">
            <li class="sidebar-nav-item">
                <a href="/" class="sidebar-nav-link active">
                    <i>🏠</i> Home
                </a>
            </li>
            <li class="sidebar-nav-item">
                <a href="{url page='games'}" class="sidebar-nav-link">
                    <i>🎮</i> Games
                </a>
            </li>
            <li class="sidebar-nav-item">
                <a href="{url page='catalog'}" class="sidebar-nav-link">
                    <i>👕</i> Catalog
                </a>
            </li>
            <li class="sidebar-nav-item">
                <a href="{url page='users'}" class="sidebar-nav-link">
                    <i>👥</i> Users
                </a>
            </li>
            <li class="sidebar-nav-item">
                <a href="{url page='groups'}" class="sidebar-nav-link">
                    <i>🏢</i> Groups
                </a>
            </li>
            <li class="sidebar-nav-item">
                <a href="{url page='forum'}" class="sidebar-nav-link">
                    <i>💬</i> Forum
                </a>
            </li>
            <li class="sidebar-nav-item">
                <a href="{url page='blog'}" class="sidebar-nav-link">
                    <i>📰</i> Blog
                </a>
            </li>
            <hr style="border-color: rgba(255,255,255,0.05);">
            <li class="sidebar-nav-item">
                <a href="{url page='settings'}" class="sidebar-nav-link">
                    <i>⚙️</i> Settings
                </a>
            </li>
            <li class="sidebar-nav-item">
                <a href="{url page='help'}" class="sidebar-nav-link">
                    <i>❓</i> Help
                </a>
            </li>
        </ul>
    </aside>

    <!-- Main Home Page Content -->
    <div class="home-page">
        <section class="hero-section">
            <div class="hero-container">
                <div class="hero-visual">
                    <img src="https://github.com/roldblox-project/roldblox-assets/blob/main/images/logo.png?raw=true" alt="ROLDBLOX Logo" class="hero-logo-large" />
                    <div class="hero-subtitle">Experience Roblox as it once was</div>
                </div>
                
                <div class="hero-content">
                    <h1 class="hero-title">REVIVE.<br>REMEMBER.<br>RELIVE.</h1>
                    
                    <p class="hero-description">
                        ROLDBLOX is a community-driven project dedicated to recreating the authentic, 
                        classic Roblox experience. From custom mods to nostalgic website styles, 
                        we bring back the era you love.
                    </p>
                    
                    <div class="hero-actions">
                        <a href="{url page='mods'}" class="btn primary-btn">
                            Explore Mods
                        </a>
                        <a href="{url page='about'}" class="btn secondary-btn">
                            Learn More
                        </a>
                        <a href="{url page='community'}" class="btn secondary-btn">
                            Join Community
                        </a>
                    </div>
                </div>
            </div>
        </section>
    </div>

</body>
</html>