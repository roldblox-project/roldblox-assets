<link rel="stylesheet" href="/syn2/css/nav.css?v={time()}">

<div class="navbar">
    <!-- Preload filled icons -->
    <div style="font-family: 'BuilderIcons'; font-weight: bold; opacity: 0; position: absolute; pointer-events: none;">.</div>
    
    <div class="navbar-left">
        <a href="{url page="home"}" class="navbar-brand-link">
            <img src="https://github.com/roldblox-project/roldblox-assets/blob/main/images/logo.png?raw=true" alt="ROLDBLOX" class="navbar-logo">
        </a>
        <div class="navbar-nav-links">
            <a href="{url page="games"}" class="nav-item-link">
                <span class="b-icon">chart-three-vertical-bars</span>
                <span class="nav-label">Games</span>
            </a>
            <a href="{url page="catalog"}" class="nav-item-link">
                <span class="b-icon">shopping-cart</span>
                <span class="nav-label">Catalog</span>
            </a>
            <a href="{url page="develop"}" class="nav-item-link">
                <span class="b-icon">square-code</span>
                <span class="nav-label">Develop</span>
            </a>
        </div>
    </div>
    <div class="navbar-right">
        <a href="{url page="transactions"}" class="nav-item-link" title="{$user_data['robux']} Robux">
            <span class="b-icon">robux</span>
            <span class="nav-label" data-value="{$user_data['robux']}">{$user_data["robux"]}</span>
        </a>
        <a href="{url page="transactions"}" class="nav-item-link" title="{$user_data['tickets']} Tix">
            <span class="b-icon" style="font-size: 20px; margin-top: 2px;">ticket</span>
            <span class="nav-label" data-value="{$user_data['tickets']}">{$user_data["tickets"]}</span>
        </a>
        <div class="nav-item-link settings-dropdown" onclick="toggleDropdown(event)" style="cursor: pointer;">
            <span class="b-icon">gear</span>
            <div id="settingsDropdown" class="dropdown-content">
                <a href="/settings">Settings</a>
                <a href="/membership">Membership</a>
                <a href="/giftcard-redeem">Redeem Codes</a>
                <a href="/switch-accounts">Switch Accounts</a>
                <form action="/logout" method="post" class="logout-form">
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
            <li><a href="{url page="games"}"><span class="b-icon">chart-three-vertical-bars</span> Games</a></li>
            <li><a href="{url page="catalog"}"><span class="b-icon">shopping-cart</span> Avatar Shop</a></li>
            <li><a href="{url page="develop"}"><span class="b-icon">square-code</span> Create</a></li>
            <li><a href="{url page="library"}"><span class="b-icon">rectangle-list</span> Library</a></li>
            <li><a href="{url page="upgrade"}"><span class="b-icon">robux</span> Robux</a></li>
        </ul>
    </div>

    <div class="sidebar-section">
        <h3 class="sidebar-header">MY</h3>
        <ul class="sidebar-menu">
            <li><a href="/users/{$user_data['id']}/profile"><span class="b-icon">person</span> My Profile</a></li>
            <li><a href="/users/{$user_data['id']}/friends"><span class="b-icon">two-people</span> My Friends</a></li>
            <li><a href="{url page="messages"}"><span class="b-icon">two-people-speech-bubble</span> My Messages</a></li>
            <li><a href="{url page="avatar"}"><span class="b-icon">circle-person</span> My Avatar</a></li>
            <li><a href="{url page="inventory"}"><span class="b-icon">backpack</span> My Inventory</a></li>
            <li><a href="{url page="groups"}"><span class="b-icon">three-people</span> My Groups</a></li>
            <li><a href="{url page="trade"}"><span class="b-icon">hand-two-arrows-horizontal</span> My Trades</a></li>
        </ul>
    </div>

    <div class="sidebar-section">
        <h3 class="sidebar-header">COMMUNITY</h3>
        <ul class="sidebar-menu">
            <li><a href="https://discord.gg/cDdneWefw5" target="_blank"><span class="b-icon">discord</span> Discord</a></li>
            <li><a href="/download"><span class="b-icon">arrow-down-to-line</span> Downloads</a></li>
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
