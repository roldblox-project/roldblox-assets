    <div class="navbar">
        <div class="navbar-left">
            <img src="https://github.com/roldblox-project/roldblox-assets/blob/main/images/logo.png?raw=true" alt="ROLDBLOX" class="navbar-logo">
            <!-- Navigation Links could go here -->
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