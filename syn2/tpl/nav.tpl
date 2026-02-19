<link rel="stylesheet" href="https://raw.githack.com/roldblox-project/roldblox-assets/main/syn2/css/nav.css?v={time()}">
<style>
/* CRITICAL FIX: Inlining CSS to override outdated CDN cache and ensure layout works immediately */
@font-face {
    font-family: 'Source Sans Pro';
    src: url('https://cdn.jsdelivr.net/gh/roldblox-project/roldblox-assets@main/fonts/SourceSansPro/SourceSansPro-Regular.ttf') format('truetype');
    font-weight: 400;
    font-style: normal;
}
@font-face {
    font-family: 'Source Sans Pro';
    src: url('https://cdn.jsdelivr.net/gh/roldblox-project/roldblox-assets@main/fonts/SourceSansPro/SourceSansPro-Bold.ttf') format('truetype');
    font-weight: 700;
    font-style: normal;
}
@font-face {
    font-family: 'Source Sans Pro';
    src: url('https://cdn.jsdelivr.net/gh/roldblox-project/roldblox-assets@main/fonts/SourceSansPro/SourceSansPro-Light.ttf') format('truetype');
    font-weight: 300;
    font-style: normal;
}
@font-face {
    font-family: 'Source Sans Pro';
    src: url('https://cdn.jsdelivr.net/gh/roldblox-project/roldblox-assets@main/fonts/SourceSansPro/SourceSansPro-Italic.ttf') format('truetype');
    font-weight: 400;
    font-style: italic;
}
@font-face {
    font-family: 'BuilderIcons';
    src: url('/icons/BuilderIcons-Regular.ttf') format('truetype');
    font-weight: normal;
    font-style: normal;
}
@font-face {
    font-family: 'BuilderIcons';
    src: url('/icons/BuilderIcons-Filled.ttf') format('truetype');
    font-weight: bold;
    font-style: normal;
}

.navbar {
    background-color: rgb(30, 30, 40);
    color: white;
    height: 56px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 10px;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    z-index: 1000;
    box-sizing: border-box;
}

.navbar-headshot {
    height: 40px;
    width: 40px;
    border-radius: 4px;
    margin-right: 10px;
    object-fit: cover;
}

.navbar-left {
    display: flex;
    align-items: center;
}

.navbar-logo {
    height: 30px;
    margin-right: 20px;
}

.navbar-right {
    display: flex;
    align-items: center;
    gap: 15px;
    font-size: 14px;
}

.b-icon {
    font-family: 'BuilderIcons';
    font-weight: normal;
    font-style: normal;
    font-variant-ligatures: common-ligatures;
    -webkit-font-feature-settings: "liga";
    -moz-font-feature-settings: "liga";
    font-feature-settings: "liga";
    text-rendering: optimizeLegibility;
    display: inline-block;
    line-height: 1;
    text-transform: none;
    letter-spacing: normal;
    word-wrap: normal;
    white-space: nowrap;
    direction: ltr;
    -webkit-font-smoothing: antialiased;
}

.user-stat {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 2px;
    padding: 2px;
    border-radius: 4px;
    margin-top: 2px;
    min-width: 44px;
    height: 44px;
    box-sizing: border-box;
}

.user-stat .b-icon {
    font-size: 24px;
}

.user-stat span {
    font-size: 14px;
}

.user-stat:hover {
    background-color: rgba(255, 255, 255, 0.1);
    cursor: pointer;
}

.user-stat:hover .b-icon,
.user-stat:hover span {
    font-weight: bold;
}

.user-stat strong {
    font-weight: 700;
}

/* Settings Dropdown */
.settings-dropdown {
    position: relative;
    cursor: pointer;
}

.dropdown-content {
    display: none;
    position: absolute;
    right: 0;
    top: 100%;
    background-color: rgb(30, 30, 40);
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1001;
    border-radius: 4px;
    padding: 5px 0;
    border: 1px solid rgba(255, 255, 255, 0.1);
}

.dropdown-content.show {
    display: block;
}

.dropdown-content a, 
.dropdown-content button {
    color: white;
    padding: 10px 15px;
    text-decoration: none;
    display: block;
    text-align: left;
    font-size: 14px;
    background: none;
    border: none;
    width: 100%;
    cursor: pointer;
    font-family: inherit;
    box-sizing: border-box;
}

.dropdown-content a:hover, 
.dropdown-content button:hover {
    background-color: rgba(255, 255, 255, 0.1);
}

.logout-btn {
    color: rgb(255, 6, 60) !important;
    font-weight: 600;
}

/* Sidebar Styles */
.sidebar {
    width: 200px;
    background-color: rgb(20, 20, 30);
    padding: 15px 10px;
    border-right: 1px solid rgb(40, 40, 50);
    display: flex;
    flex-direction: column;
    gap: 15px;
    position: fixed;
    top: 56px;
    left: 0;
    bottom: 0;
    overflow-y: auto;
    z-index: 900;
}

.sidebar-section {
    display: flex;
    flex-direction: column;
}

.sidebar-header {
    font-size: 11px;
    font-weight: 800;
    color: #666;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-bottom: 5px;
    padding-left: 10px;
}

.sidebar-user-link {
    display: flex;
    align-items: center;
    text-decoration: none;
    color: #fff;
    padding: 6px 10px;
    border-radius: 4px;
    transition: background-color 0.2s;
    margin-bottom: 2px;
}

.sidebar-user-link:hover {
    background-color: rgba(255, 255, 255, 0.05);
}

.sidebar-headshot {
    width: 24px;
    height: 24px;
    border-radius: 4px;
    margin-right: 10px;
    object-fit: cover;
    background-color: #000;
}

.sidebar-username {
    font-weight: 600;
    font-size: 13px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.sidebar-menu {
    list-style: none;
    padding: 0;
    margin: 0;
}

.sidebar-menu li {
    margin-bottom: 1px;
}

.sidebar-menu a {
    display: flex;
    align-items: center;
    text-decoration: none;
    color: #ccc;
    font-size: 14px;
    padding: 6px 10px;
    border-radius: 4px;
    transition: all 0.2s ease;
    border-left: 3px solid transparent;
}

.sidebar-menu a:hover {
    background-color: rgba(255, 255, 255, 0.08);
    color: #fff;
}

.sidebar-menu a .b-icon {
    margin-right: 10px;
    font-size: 18px;
    width: 18px;
    text-align: center;
    display: inline-block;
    color: #888;
}

.sidebar-menu a:hover .b-icon {
    color: #fff;
    font-weight: bold;
}

/* Main Container Adjustment for Fixed Sidebar */
.main-container {
    margin-top: 56px;
    margin-left: 220px; /* Sidebar width + padding */
    min-height: calc(100vh - 56px);
    display: block;
}
</style>

<div class="navbar">
    <div class="navbar-left">
        <a href="{url page="home"}" style="display:flex; align-items:center;">
            <img src="https://github.com/roldblox-project/roldblox-assets/blob/main/images/logo.png?raw=true" alt="ROLDBLOX" class="navbar-logo">
        </a>
    </div>
    <div class="navbar-right">
    <div class="user-stat" title="{$user_data['robux']} Robux">
        <a href="{url page="transactions"}" style="display: flex; flex-direction: column-reverse; align-items: center; text-decoration: none; color: inherit; width: 100%; height: 100%; justify-content: center;">
            <strong class="currency-amount" data-value="{$user_data['robux']}">{$user_data["robux"]}</strong> <span class="b-icon">robux</span>
        </a>
    </div>
    <div class="user-stat" title="{$user_data['tickets']} Tix">
        <a href="{url page="transactions"}" style="display: flex; flex-direction: column-reverse; align-items: center; text-decoration: none; color: inherit; width: 100%; height: 100%; justify-content: center;">
            <strong class="currency-amount" data-value="{$user_data['tickets']}">{$user_data["tickets"]}</strong> <span>Tix</span>
        </a>
    </div>
    <div class="user-stat settings-dropdown" onclick="toggleDropdown(event)">
        <span class="b-icon">gear</span>
        <div id="settingsDropdown" class="dropdown-content">
            <a href="/settings">Settings</a>
            <a href="/membership">Membership</a>
            <a href="/giftcard-redeem">Redeem Codes</a>
            <a href="/switch-accounts">Switch Accounts</a>
            <form action="/logout" method="post" style="margin: 0;">
                <input type="hidden" name="csrf_token" value="{$csrf_token}">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
        </div>
    </div>
</div>
</div>

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

<script>
    function toggleDropdown(event) {
        event.stopPropagation();
        document.getElementById("settingsDropdown").classList.toggle("show");
    }

    // Close the dropdown if the user clicks outside of it
    window.onclick = function(event) {
        if (!event.target.matches('.settings-dropdown') && !event.target.closest('.settings-dropdown')) {
            var dropdowns = document.getElementsByClassName("dropdown-content");
            var i;
            for (i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('show')) {
                    openDropdown.classList.remove('show');
                }
            }
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        function formatNumber(num) {
            num = parseFloat(num);
            if (isNaN(num)) return '0';
            
            if (num >= 1000000000) {
                return (num / 1000000000).toFixed(1).replace(/\.0$/, '') + 'b';
            }
            if (num >= 1000000) {
                return (num / 1000000).toFixed(1).replace(/\.0$/, '') + 'm';
            }
            if (num >= 1000) {
                return (num / 1000).toFixed(1).replace(/\.0$/, '') + 'k';
            }
            return num.toString();
        }

        const currencyElements = document.querySelectorAll('.currency-amount');
        currencyElements.forEach(el => {
            const originalValue = el.getAttribute('data-value');
            if (originalValue) {
                el.textContent = formatNumber(originalValue);
            }
        });
    });
</script>