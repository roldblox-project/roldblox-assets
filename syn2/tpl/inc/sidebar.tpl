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