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
    {include file="inc/topnav.tpl"}

    <!-- Sidebar -->
    {include file="inc/sidebar.tpl"}

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