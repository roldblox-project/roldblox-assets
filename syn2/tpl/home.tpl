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
        </ul>
        
        <div class="nav-right">
            {if $user_data}
            <div class="nav-currency">
                <div class="currency-item" title="Robux">
                    <span class="currency-robux">R$</span>
                    <span>{$user_data["robux"]}</span>
                </div>
                <div class="currency-item" title="Tickets">
                    <span class="currency-tix">Tix</span>
                    <span>{$user_data["tickets"]}</span>
                </div>
            </div>
            <a href="{url page='profile' id=$user_data['id']}" class="nav-user">
                <img src='{asset type="Head" id=$user_data["id"] size="48x48"}' alt="Avatar" class="nav-user-avatar">
                <span>{$user_data["username"]}</span>
            </a>
            {/if}
        </div>
    </nav>

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
        {if $user_data}
        <div class="dashboard-container">
            <div class="welcome-header">
                <h1 class="welcome-title">Welcome Back, {$user_data["username"]}!</h1>
                <div class="welcome-subtitle">Revive. Remember. Relive.</div>
            </div>
            
            <div class="dashboard-grid">
                <div class="dashboard-card">
                    <div class="card-title">My Feed</div>
                    <p>No new updates available.</p>
                </div>
                <div class="dashboard-card">
                    <div class="card-title">Recently Played</div>
                    <p>You haven't played any games recently.</p>
                    <a href="{url page='games'}" class="btn primary-btn" style="margin-top: 10px;">Find Games</a>
                </div>
                <div class="dashboard-card">
                    <div class="card-title">Friends (0)</div>
                    <p>You don't have any friends yet.</p>
                    <a href="{url page='users'}" class="btn secondary-btn" style="margin-top: 10px;">Find Friends</a>
                </div>
            </div>
        </div>
        {else}
        <section class="hero-section">
            <div class="hero-container">
                <div class="hero-visual">
                    <img src="https://cdn.jsdelivr.net/gh/roldblox-project/roldblox-assets@main/images/logo.png" alt="ROLDBLOX Logo" class="hero-logo-large" />
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
        {/if}
    </div>

</body>
</html>