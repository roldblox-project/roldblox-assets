class HomeRenderer {
    constructor() {
        this.loadedThumbnails = new Map();
        this.pendingBatchRequests = new Map();
        this.init()
    }
    async init() {
        try {
            await Promise.all([this.loadFriends(), this.loadTodaysPicks(), this.loadRecommended(), this.loadRecent(), this.loadSponsored(), this.loadFavorites()]);
            this.setupCarousels();
            this.setupLauncher()
        } catch (error) {
            console.error('Error initializing home:', error)
        }
    }
    async loadFriends() {
        try {
            const response = await fetch('/api/home-friends');
            if (!response.ok)
                return;
            const friends = await response.json();
            this.renderFriends(friends)
        } catch (e) {
            console.error('Friends load error:', e)
        }
    }
    async loadTodaysPicks() {
        try {
            const response = await fetch('/api/home-picks');
            if (!response.ok)
                return;
            const picks = await response.json();
            this.renderTodaysPicks(picks)
        } catch (e) {
            console.error('Picks load error:', e)
        }
    }
    async loadRecommended() {
        try {
            const response = await fetch('/api/home-recommended');
            if (!response.ok)
                return;
            const data = await response.json();
            this.renderRecommended(data.games, data.layout)
        } catch (e) {
            console.error('Recommended load error:', e)
        }
    }
    async loadRecent() {
        try {
            const response = await fetch('/api/home-recent');
            if (!response.ok)
                return;
            const games = await response.json();
            this.renderRecent(games)
        } catch (e) {
            console.error('Recent load error:', e)
        }
    }
    async loadSponsored() {
        try {
            const response = await fetch('/api/home-sponsored');
            if (!response.ok)
                return;
            const games = await response.json();
            this.renderSponsored(games)
        } catch (e) {
            console.error('Sponsored load error:', e)
        }
    }
    async loadFavorites() {
        try {
            const response = await fetch('/api/home-favorites');
            if (!response.ok)
                return;
            const games = await response.json();
            this.renderFavorites(games)
        } catch (e) {
            console.error('Favorites load error:', e)
        }
    }
    renderFriends(friends) {
        const countElements = document.querySelectorAll('.friend-count-display');
        countElements.forEach(el => {
            el.textContent = friends ? friends.length : 0;
        });
        const container = document.getElementById('friends-container');
        const prevBtn = document.getElementById('friends-prev');
        const nextBtn = document.getElementById('friends-next');
        if (!friends || friends.length === 0) {
            container.innerHTML = '<p style="margin: auto auto;" class="d-table align-items-center d-flex">No friends found <img data-slider="true" width="21" height="21" src="https://media.tenor.com/jeYb8iK3YfsAAAAi/skull-skullgif.gif"></p>';
            if (prevBtn)
                prevBtn.style.display = 'none';
            if (nextBtn)
                nextBtn.style.display = 'none';
            return
        }
        container.innerHTML = '';
        friends.forEach(friend => {
            const card = this.createFriendCard(friend);
            container.appendChild(card)
        }
        );
        this.batchLoadThumbnails(friends.map(f => ({
            id: f.friend_id,
            type: 'AvatarHeadShot',
            size: '100x100'
        })))
    }
    createFriendCard(friend) {
        const card = document.createElement('div');
        card.className = 'friend-card me-3';
        card.setAttribute('data-friend-id', friend.friend_id);
        card.setAttribute('data-friend-name', friend.username);
        card.setAttribute('data-game-title', friend.game_title || '');
        card.setAttribute('data-place-id', friend.last_played_place_id || '');
        card.setAttribute('data-version-type', friend.version_type || '2016');
        const now = Math.floor(Date.now() / 1000);
        const statusTime = friend.friend_status ? new Date(friend.friend_status).getTime() / 1000 : 0;
        const playedTime = friend.last_played_at ? new Date(friend.last_played_at).getTime() / 1000 : 0;
        const studioTime = friend.last_studio_at ? new Date(friend.last_studio_at).getTime() / 1000 : 0;
        const isOnline = (now - statusTime) <= 60;
        const isIngame = (now - playedTime) <= 20;
        const isInstudio = (now - studioTime) <= 30;
        let statusIcon = '';
        if (isInstudio) {
            statusIcon = '<div class="status-icon status-icon-orange"></div>'
        } else if (isIngame) {
            statusIcon = '<div class="status-icon status-icon-green"></div>'
        } else if (isOnline) {
            statusIcon = '<div class="status-icon"></div>'
        }
        card.innerHTML = `<div class="image-container" style="position:relative"><img class="rounded w-100" data-thumb-id="${friend.friend_id}" src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" style="width:100px;height:100px;margin:0 auto;opacity:0;transition:opacity 0.3s">${statusIcon}</div><p class="text-white w-100 text-center d-inline-block m-0 text-truncate" style="font-size: 12px;">${this.escapeHtml(friend.username)}</p>`;
        card.onclick = () => window.location.href = `/users/${friend.friend_id}/profile`;
        return card
    }
    renderTodaysPicks(picks) {
        if (!picks || picks.length < 4)
            return;
        document.getElementById('todays-picks-title').style.display = 'block';
        document.getElementById('todays-picks-subtitle').style.display = 'block';
        document.getElementById('todays-picks-wrapper').style.display = 'block';
        const container = document.getElementById('todays-picks-container');
        container.innerHTML = '';
        picks.forEach(pick => {
            const card = this.createGameCard(pick, 'landscape');
            container.appendChild(card)
        }
        );
        this.batchLoadThumbnails(picks.map(p => ({
            id: p.id,
            type: 'Asset',
            size: '280x158'
        })))
    }
    renderRecommended(games, layout) {
        if (!games || games.length === 0)
            return;
        const topCount = layout.top;
        const bottomCount = layout.bottom;
        if (topCount > 0) {
            const topGames = games.slice(0, topCount);
            document.getElementById('recommended-top-section').style.display = 'block';
            const container = document.getElementById('recommended-top-container');
            container.innerHTML = '';
            topGames.forEach(game => {
                const card = this.createGameCard(game, 'landscape');
                container.appendChild(card)
            }
            );
            this.batchLoadThumbnails(topGames.map(g => ({
                id: g.asset_id,
                type: 'Asset',
                size: '280x158'
            })))
        }
        if (bottomCount > 0) {
            const bottomGames = games.slice(topCount, topCount + bottomCount);
            document.getElementById('recommended-bottom-section').style.display = 'block';
            const container = document.getElementById('recommended-bottom-container');
            container.innerHTML = '';
            bottomGames.forEach(game => {
                const card = this.createGameCard(game, 'landscape');
                container.appendChild(card)
            }
            );
            this.batchLoadThumbnails(bottomGames.map(g => ({
                id: g.asset_id,
                type: 'Asset',
                size: '280x158'
            })))
        }
    }
    renderRecent(games) {
        const container = document.getElementById('recent-container');
        const prevBtn = document.getElementById('recent-prev');
        const nextBtn = document.getElementById('recent-next');
        if (!games || games.length === 0) {
            container.innerHTML = '<p style="margin: auto auto;" class="d-table">...</p>';
            if (prevBtn)
                prevBtn.style.display = 'none';
            if (nextBtn)
                nextBtn.style.display = 'none';
            return
        }
        container.innerHTML = '';
        games.forEach(game => {
            const card = this.createGameCard(game, 'square');
            container.appendChild(card)
        }
        );
        this.batchLoadThumbnails(games.map(g => ({
            id: g.asset_id,
            type: 'GameIcon',
            size: '150x150'
        })))
    }
    renderSponsored(games) {
        if (!games || games.length === 0)
            return;
        document.getElementById('sponsored-section').style.display = 'block';
        const container = document.getElementById('sponsored-container');
        container.innerHTML = '';
        games.forEach(game => {
            game.is_sponsored = game.campaign_id;
            const card = this.createGameCard(game, 'square');
            container.appendChild(card)
        }
        );
        this.batchLoadThumbnails(games.map(g => ({
            id: g.asset_id,
            type: 'GameIcon',
            size: '150x150'
        })))
    }
    renderFavorites(games) {
        if (!games || games.length === 0)
            return;
        document.getElementById('favorites-section').style.display = 'block';
        const container = document.getElementById('favorites-container');
        container.innerHTML = '';
        games.forEach(game => {
            const card = this.createGameCard(game, 'square');
            container.appendChild(card)
        }
        );
        this.batchLoadThumbnails(games.map(g => ({
            id: g.asset_id,
            type: 'GameIcon',
            size: '150x150'
        })))
    }
    createGameCard(game, style) {
        // Mock data if properties are missing (adjust based on actual API response)
        const votePercentage = game.total_votes > 0 ? Math.min(Math.round((game.total_likes / game.total_votes) * 100), 100) : 0;
        // If API doesn't provide vote counts, use mock or 0

        // For demonstration, let's assume game object has total_likes and total_votes. 
        // If not, we'll check if they exist or default.

        const card = document.createElement('li');
        card.className = 'game-card';
        // Remove hover transform in CSS, no inline style needed for that.

        // Construct the card HTML
        const gameUrl = `/games/${game.place_id || game.id}`; // Handle both place_id and id
        const gameTitle = this.escapeHtml(game.name || game.title || 'Unknown Game');
        const playerCount = game.player_count || 0;

        card.innerHTML = `
            <div class="game-card-container">
                <a class="game-card-link" href="${gameUrl}" tabindex="0">
                    <div class="game-card-thumb-container">
                        <img class="game-card-thumb" src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-thumb-id="${game.asset_id || game.id}" alt="${gameTitle}">
                    </div>
                    <div class="game-card-info">
                        <div class="game-card-title" title="${gameTitle}">${gameTitle}</div>
                        
                        <div class="game-rating-container">
                            <div class="vote-bar-bg">
                                <div class="vote-bar-fill" style="width: ${votePercentage}%"></div>
                            </div>
                        </div>
                        
                        <div class="rating-icons">
                             <div class="rating-icon-item">
                                <span class="b-icon">thumb-up</span> <span>${votePercentage}%</span>
                            </div>
                            <div class="rating-icon-item" style="margin-left: auto;">
                                <span class="b-icon">playing</span> <span>${this.formatNumber(playerCount)}</span>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        `;

        // Add styles if not present in CSS yet (we added them to home.css, but just to be safe let's ensure structure matches)
        return card;
    }

    // Helper for number formatting if not exists
    formatNumber(num) {
        if (num >= 1000000000) return (num / 1000000000).toFixed(1).replace(/\.0$/, '') + 'b';
        if (num >= 1000000) return (num / 1000000).toFixed(1).replace(/\.0$/, '') + 'm';
        if (num >= 1000) return (num / 1000).toFixed(1).replace(/\.0$/, '') + 'k';
        return num.toString();
    }

    // Override escapeHtml to be safe
    escapeHtml(unsafe) {
        if (!unsafe) return '';
        return unsafe
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }
    async batchLoadThumbnails(items) {
        if (!items || items.length === 0)
            return;
        const BATCH_SIZE = 100;
        for (let i = 0; i < items.length; i += BATCH_SIZE) {
            const batch = items.slice(i, i + BATCH_SIZE);
            const requests = batch.map(item => ({
                requestId: `${item.id}::${item.type}:${item.size}:webp:regular:`,
                type: item.type,
                targetId: item.id,
                token: '',
                format: 'webp',
                size: item.size,
                version: ''
            }));
            requests.forEach(req => {
                this.pendingBatchRequests.set(req.requestId, {
                    id: req.targetId,
                    type: req.type
                })
            }
            );
            try {
                const response = await fetch('/v1/batch', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(requests)
                });
                const data = await response.json();
                if (data.data) {
                    this.processBatchResponse(data.data)
                }
            } catch (error) {
                console.error('Error loading thumbnails batch:', error)
            }
        }
    }
    processBatchResponse(responses) {
        responses.forEach(response => {
            if (response.state === 'Completed' && response.imageUrl) {
                const pending = this.pendingBatchRequests.get(response.requestId);
                if (pending) {
                    this.loadedThumbnails.set(pending.id, response.imageUrl);
                    this.updateThumbnail(pending.id, response.imageUrl);
                    this.pendingBatchRequests.delete(response.requestId)
                }
            }
        }
        )
    }
    updateThumbnail(id, imageUrl) {
        const elements = document.querySelectorAll(`[data-thumb-id="${id}"]`);
        elements.forEach(el => {
            if (el.tagName === 'IMG') {
                el.src = imageUrl;
                el.style.opacity = '1'
            } else {
                const img = document.createElement('img');
                img.src = imageUrl;
                img.style.width = '100%';
                img.style.height = '100%';
                img.style.objectFit = 'cover';
                img.style.display = 'block';
                el.innerHTML = '';
                el.appendChild(img)
            }
        }
        )
    }
    setupCarousels() {
        const carousels = [{
            prev: 'friends-prev',
            next: 'friends-next',
            container: 'friends-container'
        }, {
            prev: 'picks-prev',
            next: 'picks-next',
            container: 'todays-picks-container'
        }, {
            prev: 'rec-top-prev',
            next: 'rec-top-next',
            container: 'recommended-top-container'
        }, {
            prev: 'recent-prev',
            next: 'recent-next',
            container: 'recent-container'
        }, {
            prev: 'sponsored-prev',
            next: 'sponsored-next',
            container: 'sponsored-container'
        }, {
            prev: 'fav-prev',
            next: 'fav-next',
            container: 'favorites-container'
        }, {
            prev: 'rec-bottom-prev',
            next: 'rec-bottom-next',
            container: 'recommended-bottom-container'
        }];
        carousels.forEach(c => {
            const prevBtn = document.getElementById(c.prev);
            const nextBtn = document.getElementById(c.next);
            const container = document.getElementById(c.container);
            if (prevBtn && nextBtn && container) {
                const updateButtons = () => {
                    const hasScroll = container.scrollWidth > container.clientWidth;
                    if (!hasScroll) {
                        prevBtn.style.display = 'none';
                        nextBtn.style.display = 'none';
                        return
                    }
                    prevBtn.style.display = container.scrollLeft > 0 ? 'flex' : 'none';
                    nextBtn.style.display = container.scrollLeft < container.scrollWidth - container.clientWidth - 10 ? 'flex' : 'none'
                }
                    ;
                prevBtn.onclick = () => container.scrollBy({
                    left: -300,
                    behavior: 'smooth'
                });
                nextBtn.onclick = () => container.scrollBy({
                    left: 300,
                    behavior: 'smooth'
                });
                container.onscroll = updateButtons;
                setTimeout(updateButtons, 500)
            }
        }
        )
    }
    setupLauncher() {
        const closeBtn = document.getElementById('close-launcher-btn');
        const transparentBg = document.getElementById('transparent-background-top');
        if (closeBtn && transparentBg) {
            closeBtn.onclick = () => transparentBg.style.display = 'none'
        }
    }
    formatNumber(num) {
        if (num >= 1000000)
            return (num / 1000000).toFixed(1) + 'M';
        if (num >= 1000)
            return (num / 1000).toFixed(1) + 'K';
        return num
    }
    generateAssetName(title) {
        return title.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '')
    }
    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML
    }
}
document.addEventListener('DOMContentLoaded', () => {
    new HomeRenderer()
}
);
