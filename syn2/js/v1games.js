class GameCardStyleChecker {
    constructor() {
        this.styleType = this.checkMetaTag();
    }

    checkMetaTag() {
        const metaTag = document.querySelector('meta[name="game-card-style"]');
        return metaTag ? metaTag.getAttribute('content') : 'old';
    }

    isRobloxStyle() {
        return this.styleType === 'roblox';
    }
}

const styleChecker = new GameCardStyleChecker();

class GameRenderer {
    constructor() {
        this.options = {
            trendingContainer: document.getElementById('trending-games-container'),
            popularContainer: document.getElementById('popular-games-container'),
            topRatedContainer: document.getElementById('top-rated-games-container'),
            playingNowContainer: document.getElementById('playing-now-games-container'),
            upcomingContainer: document.getElementById('upcoming-games-container'),
            recentContainer: document.getElementById('recent-games-container'),
            friendsContainer: document.getElementById('friends-games-container'),
            searchResultsContainer: document.getElementById('search-results-container'),
            searchResultsSection: document.getElementById('search-results-section'),
            searchResultsTitle: document.getElementById('search-results-title'),
            paginationContainer: document.getElementById('pagination-container'),
            prevPageBtn: document.getElementById('prev-page'),
            nextPageBtn: document.getElementById('next-page'),
            pageInfoText: document.getElementById('page-info'),
            itemsPerPage: 60,
            skeletonCount: 12
        };

        if (styleChecker.isRobloxStyle()) {
            document.body.classList.add('game-card-style-roblox');
        }
        this.loadedThumbnails = new Map();
        this.pendingBatchRequests = new Map();
        this.searchQuery = '';
        this.searchCursor = '';
        this.lastCursor = '';
        this.currentPage = 1;
        this.totalPages = 1;
        this.visibleGames = new Set();
        this.categoryElements = new Map();

        this.setupEventListeners();
        this.setupEraButton();
        this.createBackButton();
        this.checkForSearchQuery();
        this.sessionId = this.getOrCreateSessionId();
        this.deviceType = this.detectDeviceType();
        this.pageContext = this.determinePageContext();
        this.setupGameObserver();
        this.mapCategoryElements();
        this.setupScrollFades();

        // Expose scrollCarousel globally for inline onclicks in games.tpl
        window.scrollCarousel = (id, offset) => {
            const container = document.getElementById(id);
            if (container) {
                container.scrollBy({ left: offset, behavior: 'smooth' });
            }
        };
    }

    setupScrollFades() {
        // Dynamic list of containers to monitor
        const update = (el) => {
            if (!el) return;
            const wrapper = el.closest('.game-carousel-container'); // Use closest wrapper
            if (!wrapper) return;

            // Check if scrollable
            const isScrollable = el.scrollWidth > el.clientWidth;
            if (!isScrollable) {
                wrapper.classList.remove('fade-left', 'fade-right');
                return;
            }

            const hasLeft = el.scrollLeft > 5;
            const hasRight = el.scrollLeft < el.scrollWidth - el.clientWidth - 5;

            if (hasLeft) wrapper.classList.add('fade-left'); else wrapper.classList.remove('fade-left');
            if (hasRight) wrapper.classList.add('fade-right'); else wrapper.classList.remove('fade-right');
        };

        // Monitor all game lists
        const setupMonitor = () => {
            const containers = document.querySelectorAll('.game-list, #search-results-container');
            containers.forEach(el => {
                // Remove existing listener to avoid duplicates if called multiple times? 
                // Simple way: just add, modern browsers handle identical listeners well if function ref is same, 
                // but here we use anonymous wrapper. 
                // Better: attach a marked listener or just rely on the fact we call this once or per render.

                // For now, just attach.
                el.onscroll = () => update(el);
                update(el);
            });
        };

        setupMonitor();
        // Also update on resize
        window.addEventListener('resize', setupMonitor);

        // Expose update function for use after rendering
        this.updateScrollFades = setupMonitor;
    }

    setupEraButton() {
        const eraBtn = document.getElementById('sort-era-btn');
        if (eraBtn) {
            eraBtn.addEventListener('click', () => {
                if (this.isEraMode) {
                    this.disableEraMode();
                    eraBtn.innerHTML = '<span class="b-icon">filter</span> Sort by Era';
                    eraBtn.classList.remove('active');
                } else {
                    this.enableEraMode();
                    eraBtn.innerHTML = '<span class="b-icon">filter-off</span> Default View';
                    eraBtn.classList.add('active');
                }
            });
        }
    }

    enableEraMode() {
        this.isEraMode = true;
        // Hide standard categories
        document.querySelectorAll('.category-header').forEach(el => el.style.display = 'none');
        document.querySelectorAll('.category-carousel').forEach(el => el.style.display = 'none');

        // Show Era section
        const eraSection = document.getElementById('era-games-section');
        if (eraSection) {
            eraSection.style.display = 'block';
            if (!this.eraLoaded) {
                this.loadEraCategories(eraSection);
                this.eraLoaded = true;
            }
        }
    }

    disableEraMode() {
        this.isEraMode = false;
        // Show standard categories
        document.querySelectorAll('.category-header').forEach(el => el.style.display = 'flex');
        document.querySelectorAll('.category-carousel').forEach(el => el.style.display = 'block');

        // Hide Era section
        const eraSection = document.getElementById('era-games-section');
        if (eraSection) {
            eraSection.style.display = 'none';
        }
    }

    loadEraCategories(container) {
        container.innerHTML = ''; // Clear previous content
        const years = [2016, 2017, 2018, 2019, 2020, 2021, 2022];

        years.forEach(year => {
            // Create Header
            const header = document.createElement('div');
            header.className = 'section-header';
            header.innerHTML = `<h3 class="mb-0">${year}</h3>`;
            container.appendChild(header);

            // Create Carousel Container
            const carouselContainer = document.createElement('div');
            carouselContainer.className = 'carousel-container game-carousel-container';
            const carouselId = `era-${year}-games-container`;

            carouselContainer.innerHTML = `
                <a class="btn btn-dark position-absolute top-50 translate-middle-y carousel-btn prev" onclick="scrollCarousel('${carouselId}', -400)"><span class="b-icon">chevron-left</span></a>
                <ul id="${carouselId}" class="list-unstyled d-flex games-carousel game-list gap-3 m-0"></ul>
                <a class="btn btn-dark position-absolute top-50 translate-middle-y carousel-btn next" onclick="scrollCarousel('${carouselId}', 400)"><span class="b-icon">chevron-right</span></a>
            `;
            container.appendChild(carouselContainer);

            // Fetch and Render Games
            const listContainer = carouselContainer.querySelector('ul');
            this.showSkeletons(listContainer);

            // Fetch games for the year using 'type' parameter
            fetch(`/v1/games/?type=${year}&limit=${this.options.itemsPerPage}`)
                .then(response => response.json())
                .then(data => {
                    if (data.success && data.data && data.data.length > 0) {
                        this.renderGames(data.data, listContainer, 'era');
                        this.observeGameCards(listContainer);
                        // Setup scroll fade for new container
                        if (this.updateScrollFades) this.updateScrollFades();
                    } else {
                        // Hide section if no games found
                        header.style.display = 'none';
                        carouselContainer.style.display = 'none';
                    }
                })
                .catch(error => {
                    console.error(`Error loading ${year} games:`, error);
                    header.style.display = 'none';
                    carouselContainer.style.display = 'none';
                });
        });
    }

    mapCategoryElements() {
        const containers = [
            { type: 'trending', container: this.options.trendingContainer },
            { type: 'popular', container: this.options.popularContainer },
            { type: 'top-rated', container: this.options.topRatedContainer },
            { type: 'playing-now', container: this.options.playingNowContainer },
            { type: 'upcoming', container: this.options.upcomingContainer },
            { type: 'recent', container: this.options.recentContainer },
            { type: 'friends', container: this.options.friendsContainer }
        ];

        containers.forEach(cat => {
            if (cat.container) {
                const carouselContainer = cat.container.closest('.game-carousel-container');
                const header = carouselContainer?.previousElementSibling;
                // Verify it's a section header
                const headerWrapper = (header && header.classList.contains('section-header')) ? header : null;

                this.categoryElements.set(cat.type, {
                    container: cat.container,
                    carousel: carouselContainer,
                    headerWrapper: headerWrapper
                });
            }
        });
    }

    setupGameObserver() {
        if ('IntersectionObserver' in window) {
            this.gameObserver = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    const gameId = entry.target.getAttribute('data-game-id');
                    if (entry.isIntersecting && gameId && !this.visibleGames.has(gameId) && !this.loadedThumbnails.has(gameId)) {
                        this.visibleGames.add(gameId);
                        this.loadVisibleThumbnail(gameId);
                    }
                });
            }, { rootMargin: '200px' });
        }
    }

    loadVisibleThumbnail(gameId) {
        const batch = [{ placeId: gameId }];
        this.requestBatchThumbnails(batch);
    }

    observeGameCards(container) {
        if (!this.gameObserver) return;
        const cards = container.querySelectorAll('[data-game-id]');
        cards.forEach(card => this.gameObserver.observe(card));
    }

    detectDeviceType() {
        const userAgent = navigator.userAgent.toLowerCase();
        const width = window.innerWidth;

        if (/iphone|ipod|android|blackberry|opera|mini|windows\sce|palm|smartphone|iemobile/i.test(userAgent)) {
            return 'mobile';
        }

        if (/ipad|android(?!.*mobile)|tablet|kindle|silk|playbook/i.test(userAgent)) {
            return 'tablet';
        }

        if (width <= 768) {
            return 'mobile';
        } else if (width <= 1024) {
            return 'tablet';
        }

        return 'computer';
    }

    determinePageContext() {
        const path = window.location.pathname;

        if (path === '/' || path === '/home') {
            return 'homePage';
        } else if (path.startsWith('/games')) {
            if (path.includes('/search') || window.location.search.includes('q=')) {
                return 'searchPage';
            } else if (path.includes('/category/')) {
                return 'categoryPage';
            }
            return 'gamesPage';
        }

        return 'gamesPage';
    }

    createBackButton() {
        const backButton = document.createElement('a');
        backButton.href = "#";
        backButton.className = "ms-3 btn btn-outline-secondary";
        backButton.innerHTML = '<i class="bi bi-arrow-left"></i> Back to Games';
        backButton.id = "search-back-button";
        backButton.style.display = "none";

        backButton.addEventListener('click', (e) => {
            e.preventDefault();
            this.clearSearch();
        });

        if (this.options.searchResultsTitle) {
            const parentDiv = this.options.searchResultsTitle.parentNode;
            if (parentDiv) {
                parentDiv.appendChild(backButton);
                this.backButton = backButton;
            }
        }
    }

    clearSearch() {
        this.searchQuery = '';
        this.isSearchActive = false;

        const url = new URL(window.location);
        url.searchParams.delete('q');
        window.history.pushState({}, '', url);

        if (this.backButton) {
            this.backButton.style.display = "none";
        }

        this.toggleCategorySections(true);
        window.location.href = url.toString();
    }

    setupEventListeners() {
        const searchForm = document.querySelector('#game-search-form');
        if (searchForm) {
            searchForm.addEventListener('submit', (e) => {
                e.preventDefault();
                const searchInput = searchForm.querySelector('input[name="q"]');
                if (searchInput && searchInput.value.trim() !== '') {
                    this.searchQuery = searchInput.value.trim();
                    this.updateURL(this.searchQuery);
                    this.currentPage = 1;

                    // Trigger search without reload
                    this.handleSearchState(this.searchQuery);
                }
            });
        }

        if (this.options.prevPageBtn) {
            this.options.prevPageBtn.addEventListener('click', (e) => {
                e.preventDefault();
                if (this.lastCursor && this.currentPage > 1) {
                    this.currentPage--;
                    this.searchGames(this.searchQuery, this.lastCursor);
                }
            });
        }

        if (this.options.nextPageBtn) {
            this.options.nextPageBtn.addEventListener('click', (e) => {
                e.preventDefault();
                if (this.searchCursor) {
                    this.currentPage++;
                    this.searchGames(this.searchQuery, this.searchCursor);
                }
            });
        }
    }

    checkForSearchQuery() {
        const urlParams = new URLSearchParams(window.location.search);
        const keywords = urlParams.get('q');

        if (keywords && keywords.trim() !== '') {
            this.handleSearchState(keywords.trim());
        } else {
            this.handleDefaultState();
        }
    }

    handleSearchState(query) {
        this.searchQuery = query;
        const searchInput = document.querySelector('#search-input');
        if (searchInput) {
            searchInput.value = this.searchQuery;
        }

        // Hide all category section headers and carousels (not the search header)
        document.querySelectorAll('.category-header').forEach(el => el.style.display = 'none');
        document.querySelectorAll('.category-carousel').forEach(el => el.style.display = 'none');

        if (this.options.searchResultsSection) {
            this.options.searchResultsSection.style.display = 'block';
        }

        this.searchGames(this.searchQuery);
    }

    handleDefaultState() {
        // Show all category section headers and carousels
        document.querySelectorAll('.category-header').forEach(el => el.style.display = 'flex');
        document.querySelectorAll('.category-carousel').forEach(el => el.style.display = 'block');

        if (this.options.searchResultsSection) {
            this.options.searchResultsSection.style.display = 'none';
        }

        this.loadAllGameCategories();
    }

    updateURL(query) {
        if (!query) return;

        const url = new URL(window.location);
        url.searchParams.set('q', query);
        window.history.pushState({}, '', url);
    }

    loadAllGameCategories() {
        const categories = [
            { type: 'trending', container: this.options.trendingContainer },
            { type: 'popular', container: this.options.popularContainer },
            { type: 'top-rated', container: this.options.topRatedContainer },
            { type: 'playing-now', container: this.options.playingNowContainer },
            { type: 'upcoming', container: this.options.upcomingContainer },
            { type: 'recent', container: this.options.recentContainer },
            { type: 'friends', container: this.options.friendsContainer }
        ];

        const categoryPromises = categories
            .filter(cat => cat.container)
            .map(cat => {
                this.showSkeletons(cat.container);
                return fetch(`/v1/games/?type=${cat.type}&limit=${this.options.itemsPerPage}`)
                    .then(response => response.json())
                    .then(data => ({ ...cat, data }))
                    .catch(error => {
                        console.error(`Error loading ${cat.type} games:`, error);
                        return { ...cat, data: null };
                    });
            });

        Promise.all(categoryPromises).then(results => {
            results.forEach(result => {
                const elements = this.categoryElements.get(result.type);
                if (result.data && result.data.success && result.data.data && result.data.data.length > 0) {
                    this.renderGames(result.data.data, result.container, result.type);
                    this.observeGameCards(result.container);
                    if (elements) {
                        if (elements.headerWrapper) elements.headerWrapper.style.display = 'flex';
                        if (elements.carousel) elements.carousel.style.display = 'block';
                    }
                } else {
                    if (elements) {
                        if (elements.headerWrapper) elements.headerWrapper.style.display = 'none';
                        if (elements.carousel) elements.carousel.style.display = 'none';
                    }
                }
            });
            // Update scroll fades after rendering
            if (this.updateScrollFades) this.updateScrollFades();
        });
    }

    toggleCategorySections(show) {
        this.categoryElements.forEach((elements, type) => {
            if (elements.headerWrapper) elements.headerWrapper.style.display = show ? 'flex' : 'none';
            if (elements.carousel) elements.carousel.style.display = show ? 'block' : 'none';
        });

        if (this.options.searchResultsSection) {
            this.options.searchResultsSection.style.display = show ? 'none' : 'block';
        }
        if (this.backButton) {
            this.backButton.style.display = show ? 'none' : 'inline-block';
        }
    }

    escapeHtml(unsafe) {
        const div = document.createElement('div');
        div.textContent = unsafe;
        return div.innerHTML;
    }

    searchGames(query, cursor = '') {
        const container = this.options.searchResultsContainer;

        if (!container) return;

        this.showSkeletons(container);

        this.toggleCategorySections(false);

        if (this.options.prevPageBtn) this.options.prevPageBtn.style.display = 'none';
        if (this.options.nextPageBtn) this.options.nextPageBtn.style.display = 'none';

        if (this.options.searchResultsTitle) {
            const safeQuery = this.escapeHtml(query);
            this.options.searchResultsTitle.innerHTML = `Searching for "${safeQuery}"`;
        }

        fetch('/v1/games/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                query: query,
                limit: this.options.itemsPerPage,
                cursor: cursor
            })
        })
            .then(response => response.json())
            .then(data => {
                if (data.success && data.data && data.data.length > 0) {
                    this.renderGames(data.data, container, 'search');
                    this.observeGameCards(container);

                    this.searchCursor = data.nextCursor || '';
                    this.lastCursor = data.lastCursor || '';
                    this.updatePaginationUI();

                    if (this.options.prevPageBtn && this.lastCursor && this.currentPage > 1) {
                        this.options.prevPageBtn.style.display = 'inline-block';
                    }
                    if (this.options.nextPageBtn && this.searchCursor) {
                        this.options.nextPageBtn.style.display = 'inline-block';
                    }
                } else {
                    const safeQuery = this.escapeHtml(query);
                    this.showError(`No results found for "${safeQuery}"`, container);
                    this.updatePaginationUI(false);
                }
            })
            .catch(error => {
                console.error("Error searching games:", error);
                this.showError("Failed to search games. Please try again later.", container);
                this.updatePaginationUI(false);
            });
    }

    updatePaginationUI(hasResults = true) {
        if (!this.options.pageInfoText) return;

        this.options.pageInfoText.textContent = hasResults ? `Page ${this.currentPage}` : 'No results';

        if (this.options.prevPageBtn) {
            const hasPrevPage = !!this.lastCursor && this.currentPage > 1;
            this.options.prevPageBtn.classList.toggle('text-secondary', !hasPrevPage);
            this.options.prevPageBtn.classList.toggle('text-primary', hasPrevPage);
            this.options.prevPageBtn.style.pointerEvents = hasPrevPage ? 'auto' : 'none';
        }

        if (this.options.nextPageBtn) {
            this.options.nextPageBtn.classList.toggle('text-secondary', !this.searchCursor);
            this.options.nextPageBtn.classList.toggle('text-primary', !!this.searchCursor);
            this.options.nextPageBtn.style.pointerEvents = this.searchCursor ? 'auto' : 'none';
        }
    }

    renderGames(gamesList, container, type = 'default') {
        if (!container) return;
        container.innerHTML = '';

        if (gamesList.length === 0) {
            if (type === 'friends') {
                this.showError("No friends are currently playing games", container);
            } else {
                this.showError("No games found", container);
            }
            return;
        }

        gamesList.forEach(game => {
            const gameCard = this.createGameCard(game, type);
            container.appendChild(gameCard);

            if (this.loadedThumbnails.has(game.placeId)) {
                const cachedUrl = this.loadedThumbnails.get(game.placeId);
                this.updateThumbnail(game.placeId, cachedUrl);
            }
        });
    }

    getOrCreateSessionId() {
        let sessionId = localStorage.getItem('RBXSessionTracker');

        if (!sessionId) {
            sessionId = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
                const r = Math.random() * 16 | 0;
                const v = c === 'x' ? r : (r & 0x3 | 0x8);
                return v.toString(16);
            });

            localStorage.setItem('RBXSessionTracker', sessionId);
        }

        return sessionId;
    }

    formatGameUrl(game, position = 0, sortPos = 1) {
        let title = game.title || "unnamed";
        title = title.replace(/[^\x20-\x7E]/g, '')
            .replace(/[^A-Za-z0-9 ]/g, '')
            .replace(/\s+/g, '-');

        if (!title) title = "unnamed";
        if (title.length > 50) title = title.substring(0, 50);

        const trackingParams = new URLSearchParams({
            appliedFilters: `device=${encodeURIComponent(this.deviceType)},age=all,country=all`,
            discoverPageSessionInfo: this.sessionId,
            gameSetTargetId: game.universeId || game.placeId,
            gameSetTypeId: 23,
            isAd: 'false',
            page: this.pageContext,
            placeId: game.placeId,
            playContext: this.pageContext,
            position: position,
            sortPos: sortPos,
            universeId: game.universeId || game.placeId
        }).toString();

        return `/games/${game.placeId}/${title}?${trackingParams}`;
    }

    createGameCard(game, type = 'default') {
        if (styleChecker.isRobloxStyle()) {
            return this.createRobloxStyleCard(game, type);
        } else {
            return this.createOldStyleCard(game, type);
        }
    }

    createRobloxStyleCard(game, type = 'default') {
        const listItem = document.createElement('li');
        listItem.className = 'list-item game-card game-tile';

        const safeTitle = this.escapeHtml(game.title || 'Untitled');
        const safePlaceId = this.escapeHtml(String(game.placeId || ''));
        const safePlaying = parseInt(game.stats?.playing || 0);
        const safeVersion = game.version || 'V1';

        const votePercentage = game.stats?.votePercentageDisplay;
        const voteDisplay = votePercentage !== null && votePercentage !== undefined
            ? `${votePercentage}%`
            : 'N/A';

        const formatCount = (num) => {
            if (num >= 1000000) return (num / 1000000).toFixed(1) + 'M';
            if (num >= 1000) return (num / 1000).toFixed(1) + 'K';
            return num.toString();
        };

        const isSponsored = game.isSponsored || false;
        const sponsoredClass = isSponsored ? ' game-card-sponsored' : '';
        const campaignParam = isSponsored ? `&sponsored=${game.campaignId}` : '';

        const infoHtml = isSponsored
            ? '<div class="game-card-sponsored-badge"><span class="badge bg-warning">Sponsored</span></div>'
            : `<div class="game-card-info">
                <span class="info-label"><span class="b-icon game-card-stats-icon">thumb-up</span></span>
                <span class="info-label vote-percentage-label game-card-stats-value">${voteDisplay}</span>
                <span class="info-label"><span class="b-icon game-card-stats-icon">person-play</span></span>
                <span class="info-label playing-counts-label">${formatCount(safePlaying)}</span>
            </div>`;

        const cardHtml = `
            <div class="game-card-container">
                <a class="game-card-link" href="${this.formatGameUrl(game)}${campaignParam}" tabindex="0">
                    <div class="game-card-thumb-container">
                        <div class="thumbnail-2d-container game-card-thumb position-relative">
                            <div class="loading-spinner"></div>
                            <div class="shimmer-box" data-game-id="${safePlaceId}" style="width: 100%; height: 100%; aspect-ratio: 1/1;"></div>
                            <div class="game-version-badge">${safeVersion}</div>
                        </div>
                    </div>
                    <div class="game-card-title" title="${safeTitle}">${safeTitle}</div>
                    ${infoHtml}
                </a>
            </div>
        `;

        listItem.innerHTML = cardHtml;
        return listItem;
    }

    createOldStyleCard(game, type = 'default') {
        const listItem = document.createElement('li');
        listItem.className = 'list-item game-card game-tile';

        const card = document.createElement('a');
        card.className = 'text-decoration-none d-block w-100 h-100';
        card.href = this.formatGameUrl(game);
        card.style.width = '180px';
        card.style.marginRight = '15px';

        const safeTitle = this.escapeHtml(game.title || 'Untitled');
        const safeVersion = this.escapeHtml(game.version || 'V1');
        const safePlaceId = this.escapeHtml(String(game.placeId || ''));
        const safePlaying = parseInt(game.stats?.playing || 0);
        const safeVotePercentage = parseFloat(game.stats?.votePercentage || 0);

        let friendsInfo = '';
        if (type === 'friends' && game.friends) {
            const friendCount = parseInt(game.friends.playing || 0);
            const friendNames = game.friends.names;

            if (friendCount > 0) {
                friendsInfo = `
                    <div class="d-flex align-items-center mb-1">
                        <i class="bi bi-people-fill text-success"></i>
                        <span class="text-success ms-1" style="font-size: 12px;">
                            ${friendCount} friend${friendCount > 1 ? 's' : ''} playing
                        </span>
                    </div>
                `;

                if (friendNames) {
                    const names = friendNames.split(', ').slice(0, 3);
                    const safeNames = names.map(name => this.escapeHtml(name));
                    const displayNames = safeNames.join(', ');
                    const moreCount = friendCount - names.length;

                    friendsInfo += `
                        <div class="text-muted" style="font-size: 11px;">
                            ${displayNames}${moreCount > 0 ? ` +${moreCount} more` : ''}
                        </div>
                    `;
                }
            }
        }

        const cardHtml = `
            <div class="overflow-hidden place-card w-100">
                <div class="position-relative">
                    <div class="loading-spinner"></div>
                    <div class="shimmer-box" data-game-id="${safePlaceId}" style="aspect-ratio: 1/1;"></div>
                    <div class="position-absolute" style="bottom: 0px;left: 0px;">
                        <div class="fw-bold bg-dark text-white" style="font-size: 12px;padding: 3px;border-top-right-radius: 4px;">${safeVersion}</div>
                    </div>
                </div>
                <div class="p-1">
                    <h5 class="mb-0" style="font-size: 17px;text-overflow: ellipsis;white-space: nowrap;overflow: hidden;">${safeTitle}</h5>
                    ${friendsInfo}
                    <div class="d-flex align-items-center">
                        <p style="margin:0;font-size: 14px;" class="text-secondary">
                            <i class="bi bi-people"></i> ${safePlaying} <span style="font-size: 13px;">Playing</span>
                        </p>
                    </div>
                    <div class="w-100 votePercentageBackground">
                        <div class="votePercentageFill" style="width: ${safeVotePercentage}%;"></div>
                        <div>
                            <div class="segment" style="left: 18%;"></div>
                            <div class="segment" style="left: 38%;"></div>
                            <div class="segment" style="left: 58%;"></div>
                            <div class="segment" style="left: 78%;"></div>
                        </div>
                    </div>
                </div>
            </div>
        `;

        card.innerHTML = cardHtml;
        return card;
    }

    showSkeletons(container) {
        if (!container) return;
        container.innerHTML = '';

        for (let i = 0; i < this.options.skeletonCount; i++) {
            const skeletonCard = document.createElement('div');
            skeletonCard.className = 'text-decoration-none';
            skeletonCard.style.width = '180px';
            skeletonCard.style.marginRight = '15px';

            const skeletonHtml = `
                <div class="overflow-hidden place-card w-100">
                    <div class="shimmer-box" style="aspect-ratio: 1/1;"></div>
                    <div class="p-1">
                        <div class="shimmer-box shimmer-text mb-2"></div>
                        <div class="shimmer-box shimmer-text-sm mb-2" style="width: 60%;"></div>
                        <div class="shimmer-box" style="height: 8px;"></div>
                    </div>
                </div>
            `;

            skeletonCard.innerHTML = skeletonHtml;
            container.appendChild(skeletonCard);
        }
    }

    showError(message, container) {
        if (!container) return;
        const safeMessage = this.escapeHtml(message);
        container.innerHTML = `
            <div class="w-100 text-center py-5">
                <p class="text-secondary">${safeMessage}</p>
            </div>
        `;
    }

    loadThumbnailsInBatches(gamesList) {
        return;
    }

    requestBatchThumbnails(games) {
        const batchRequests = games.map((game, index) => {
            const requestId = `game_${game.placeId}_${Date.now()}_${index}`;

            return {
                requestId: requestId,
                targetId: game.placeId,
                type: 'GameIcon',
                size: '150x150'
            };
        });

        if (batchRequests.length === 0) return;

        batchRequests.forEach(req => {
            this.pendingBatchRequests.set(req.requestId, req.targetId);
        });

        fetch('/v1/batch', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(batchRequests)
        })
            .then(response => response.json())
            .then(data => {
                if (data.data) {
                    this.processBatchResponse(data.data);
                }
            })
            .catch(error => {
                console.error("Error loading thumbnails:", error);
                setTimeout(() => {
                    this.retryFailedRequests(batchRequests);
                }, 2000);
            });
    }

    retryFailedRequests(requests) {
        const stillPendingRequests = requests.filter(req =>
            this.pendingBatchRequests.has(req.requestId)
        );

        if (stillPendingRequests.length > 0) {
            fetch('/v1/batch', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(stillPendingRequests)
            })
                .then(response => response.json())
                .then(data => {
                    if (data.data) {
                        this.processBatchResponse(data.data);
                    }
                })
                .catch(error => {
                    console.error("Error retrying thumbnail requests:", error);
                });
        }
    }

    processBatchResponse(responses) {
        responses.forEach(response => {
            if (response.state === 'Completed' && response.imageUrl) {
                const placeId = this.pendingBatchRequests.get(response.requestId);
                if (placeId) {
                    this.loadedThumbnails.set(placeId, response.imageUrl);
                    this.updateThumbnail(placeId, response.imageUrl);
                    this.pendingBatchRequests.delete(response.requestId);
                }
            } else if (response.state === 'Failed') {
                const placeId = this.pendingBatchRequests.get(response.requestId);
                if (placeId) {
                    this.pendingBatchRequests.delete(response.requestId);
                }
            }
        });
    }

    updateThumbnail(placeId, imageUrl) {
        const safePlaceId = this.escapeHtml(String(placeId));
        const skeletonElements = document.querySelectorAll(`[data-game-id="${safePlaceId}"]`);

        skeletonElements.forEach(element => {
            const img = document.createElement('img');
            img.src = imageUrl;
            img.alt = "Game thumbnail";
            img.className = "game-card-thumb"; // Ensure class is added
            img.setAttribute('width', '100%');
            img.setAttribute('data-game-id', placeId);
            img.style.aspectRatio = "1/1";
            // opacity handled by class in css, but set here to be safe if css fails
            img.style.opacity = "0";

            // Handle load event
            const onLoad = () => {
                img.classList.add('loaded');
                img.style.opacity = "1";
                if (element.parentNode) {
                    const spinner = element.parentNode.querySelector('.loading-spinner');
                    if (spinner) {
                        spinner.style.opacity = '0';
                        setTimeout(() => spinner.remove(), 300);
                    }
                }
            };

            if (img.complete) {
                onLoad();
            } else {
                img.onload = onLoad;
                img.onerror = () => {
                    // On error, maybe show a default icon or keep spinner? 
                    // For now, let's just remove spinner so it doesn't spin forever
                    if (element.parentNode) {
                        const spinner = element.parentNode.querySelector('.loading-spinner');
                        if (spinner) spinner.remove();
                    }
                };
            }

            if (element && element.parentNode) {
                element.parentNode.replaceChild(img, element);
            }
        });
    }
}

document.addEventListener('DOMContentLoaded', () => {
    window.gameRenderer = new GameRenderer();
    // Scroll fade setup for carousels
    const containers = [
        'trending-games-container',
        'popular-games-container',
        'top-rated-games-container',
        'playing-now-games-container',
        'upcoming-games-container',
        'friends-games-container',
        'search-results-container'
    ];
    function updateFade(el) {
        if (!el) return;
        const wrapper = el.closest('.game-carousel-container');
        if (!wrapper) return;
        const hasLeft = el.scrollLeft > 5;
        const hasRight = el.scrollLeft < el.scrollWidth - el.clientWidth - 5;
        wrapper.classList.toggle('fade-left', hasLeft);
        wrapper.classList.toggle('fade-right', hasRight);
    }
    containers.forEach(id => {
        const el = document.getElementById(id);
        if (!el) return;
        updateFade(el);
        el.addEventListener('scroll', () => updateFade(el));
    });
    window.addEventListener('resize', () => {
        containers.forEach(id => {
            const el = document.getElementById(id);
            if (el) updateFade(el);
        });
    });

    const carousels = document.querySelectorAll('.games-carousel');
    carousels.forEach(carousel => {
        let startX, scrollLeft, isDown = false;
        let touchStartTime, touchStartX;

        carousel.addEventListener('mousedown', (e) => {
            isDown = true;
            startX = e.pageX - carousel.offsetLeft;
            scrollLeft = carousel.scrollLeft;
            carousel.style.cursor = 'grabbing';
        });

        carousel.addEventListener('mouseleave', () => {
            isDown = false;
            carousel.style.cursor = 'grab';
        });

        carousel.addEventListener('mouseup', () => {
            isDown = false;
            carousel.style.cursor = 'grab';
        });

        carousel.addEventListener('mousemove', (e) => {
            if (!isDown) return;
            e.preventDefault();
            const x = e.pageX - carousel.offsetLeft;
            const walk = (x - startX) * 2;
            carousel.scrollLeft = scrollLeft - walk;
        });

        carousel.addEventListener('touchstart', (e) => {
            isDown = true;
            touchStartTime = Date.now();
            touchStartX = e.touches[0].pageX;
            startX = e.touches[0].pageX - carousel.offsetLeft;
            scrollLeft = carousel.scrollLeft;
        }, { passive: true });

        carousel.addEventListener('touchend', (e) => {
            isDown = false;

            const touchEndTime = Date.now();
            const touchEndX = e.changedTouches[0].pageX;
            const touchDuration = touchEndTime - touchStartTime;
            const touchDistance = Math.abs(touchEndX - touchStartX);

            if (touchDuration < 300 && touchDistance > 50) {
                const swipeDistance = touchStartX > touchEndX ? 300 : -300;
                carousel.scrollBy({
                    left: swipeDistance,
                    behavior: 'smooth'
                });
            }
        }, { passive: true });

        carousel.addEventListener('touchmove', (e) => {
            if (!isDown) return;
            const x = e.touches[0].pageX - carousel.offsetLeft;
            const walk = (x - startX) * 2;
            carousel.scrollLeft = scrollLeft - walk;
        }, { passive: true });

        carousel.addEventListener('click', (e) => {
            if (Math.abs(carousel.scrollLeft - scrollLeft) > 5) {
                e.preventDefault();
                e.stopPropagation();
            }
        }, { capture: true });
    });
});

function scrollCarousel(containerId, amount) {
    const container = document.getElementById(containerId);
    if (container) {
        container.scrollBy({
            left: amount,
            behavior: 'smooth'
        });
    }
}
