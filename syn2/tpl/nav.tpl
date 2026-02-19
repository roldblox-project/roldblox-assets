<link rel="stylesheet" href="https://raw.githack.com/roldblox-project/roldblox-assets/main/syn2/css/nav.css?v={time()}">

<div class="navbar">
    <div class="navbar-left">
        <a href="{url page="home"}" class="navbar-brand-link">
            <img src="https://github.com/roldblox-project/roldblox-assets/blob/main/images/logo.png?raw=true" alt="ROLDBLOX" class="navbar-logo">
        </a>
    </div>
    <div class="navbar-right">
    <div class="user-stat" title="{$user_data['robux']} Robux">
        <a href="{url page="transactions"}" class="stat-link">
            <strong class="currency-amount" data-value="{$user_data['robux']}">{$user_data["robux"]}</strong> <span class="b-icon">robux</span>
        </a>
    </div>
    <div class="user-stat" title="{$user_data['tickets']} Tix">
        <a href="{url page="transactions"}" class="stat-link">
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
