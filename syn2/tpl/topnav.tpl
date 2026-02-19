<nav class="top-nav">
    <div class="nav-left">
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
    </div>
    
    <div class="nav-right">
        {if $user_data}
        <a href="{url page='profile' id=$user_data['id']}" class="nav-user">
            <img src='{asset type="Head" id=$user_data["id"] size="48x48"}' alt="Avatar" class="nav-user-avatar">
            <span>{$user_data["display_name"]}</span>
        </a>
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
        <a href="{url page='settings'}" class="nav-settings" title="Settings">
            <i class="bi bi-gear-fill"></i> Settings
        </a>
        {/if}
    </div>
</nav>