<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ROLDBLOX - Revive. Remember. Relive.</title>
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <link rel="stylesheet" href="/syn2/css/nav.css">
    <link rel="stylesheet" href="/syn2/css/pages/home.css">
    
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

    {include file="topnav.tpl"}

    {include file="sidebar.tpl"}

    <div class="home-page">
        {if $user_data}
        <div class="dashboard-container">
            <div class="welcome-header">
                <h1 class="welcome-title">Welcome, {$user_data["username"]}!</h1>
            </div>
            
            {api endpoint="/api/friends-list.php" var="friends"}
            <div class="dashboard-section">
                <div class="section-header">
                    <h2>Friends ({if isset($friends) && isset($friends.count)}{$friends.count}{else}0{/if})</h2>
                    <a href="{url page='users'}" class="see-all">See All</a>
                </div>
                <div class="friends-grid">
                    {if isset($friends) && isset($friends.friends) && $friends.friends}
                        {foreach $friends.friends as $friend}
                            <div class="friend-card">
                                <a href="{url page='profile' id=$friend.id}" class="friend-link">
                                    <div class="friend-avatar-container">
                                        <img src='{asset type="Head" id=$friend.id size="100x100"}' alt="{$friend.username}" class="friend-avatar">
                                    </div>
                                    <span class="friend-name">{$friend.username}</span>
                                </a>
                            </div>
                        {/foreach}
                    {else}
                        <p class="empty-state">No friends yet.</p>
                    {/if}
                </div>
            </div>

            {api endpoint="/api/games-list.php" var="gameData"}
            <div class="dashboard-section">
                <div class="section-header">
                    <h2>Continue Playing</h2>
                    <a href="{url page='games'}" class="see-all">See All</a>
                </div>
                <div class="games-grid">
                    {if isset($gameData) && isset($gameData.games) && $gameData.games}
                        {foreach $gameData.games as $game}
                            <div class="game-card">
                                <a href="{url page='games' id=$game.id}" class="game-link">
                                    <img src='{asset type="PlaceIcon" id=$game.id size="150x150"}' class="game-thumbnail">
                                    <div class="game-info">
                                        <h3 class="game-title">{$game.title}</h3>
                                        <div class="game-stats">
                                            <span class="game-playing">{$game.playing} Playing</span>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        {/foreach}
                    {else}
                        <p class="empty-state">No games found.</p>
                    {/if}
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