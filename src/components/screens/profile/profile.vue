<!-- src/views/ProfileMock.vue -->
<template>
    <div class="profile">

        <!-- Header -->
        <header class="head">
            <div class="left">
                <div class="avatar">
                    <span class="avEmoji">👤</span>
                </div>
                <div class="who">
                    <div class="name">{{ user.name }}</div>
                    <div class="motto">{{ user.motto }}</div>
                </div>
            </div>

            <button class="cta" @click="goGoals">Update goals</button>
        </header>

        <!-- Identity chips -->
        <section class="chipsRow">
            <span class="chip strong">
                Focus: <b>{{ focusTrack }}</b>
            </span>
            <span class="chip">
                Streak: <b>{{ user.streakDays }} days</b>
            </span>
            <span class="chip" :class="trendClass">
                Trend: <b>{{ user.trend }}</b>
            </span>
        </section>

        <!-- Mission -->
        <section class="card mission">
            <div class="cardHead">
                <div class="h2">My mission</div>
                <button class="link" @click="editMission">Edit</button>
            </div>

            <div class="missionBox">
                <div class="quoteMark">“</div>
                <div class="missionText">
                    {{ user.mission }}
                </div>
            </div>

            <div class="hint">
                This one sentence influences your recommendations (mock).
            </div>
        </section>

        <!-- Progress -->
        <section class="card">
            <div class="cardHead">
                <div class="h2">My progress</div>
                <button class="link" @click="goJourney">Open Tracks</button>
            </div>

            <div class="bars">
                <div v-for="t in tracks" :key="t.id" class="barRow">
                    <div class="barTop">
                        <span class="barName">{{ t.label }}</span>
                        <span class="barVal">{{ t.value }}%</span>
                    </div>
                    <div class="bar">
                        <div class="fill" :style="{ width: t.value + '%', background: t.color }"></div>
                    </div>
                </div>
            </div>

            <div class="stats">
                <div class="stat">
                    <div class="statVal">{{ stats.completedCourses }}</div>
                    <div class="statLbl">Completed courses</div>
                </div>
                <div class="stat">
                    <div class="statVal">{{ stats.minutes }}</div>
                    <div class="statLbl">Minutes practiced</div>
                </div>
                <div class="stat">
                    <div class="statVal">{{ stats.simulations }}</div>
                    <div class="statLbl">Simulations</div>
                </div>
            </div>
        </section>

        <!-- Power patterns -->
        <section class="card">
            <div class="cardHead">
                <div class="h2">My power patterns</div>
                <button class="link" @click="goPowerCheck">Open Power Check</button>
            </div>

            <div class="patternGrid">
                <div class="pattern">
                    <div class="pIcon">🧱</div>
                    <div class="pTxt">
                        <div class="pTitle">Most common blocker</div>
                        <div class="pValue">{{ patterns.blocker }}</div>
                    </div>
                </div>

                <div class="pattern">
                    <div class="pIcon">🚀</div>
                    <div class="pTxt">
                        <div class="pTitle">Best booster</div>
                        <div class="pValue">{{ patterns.booster }}</div>
                    </div>
                </div>

                <div class="pattern">
                    <div class="pIcon">🎯</div>
                    <div class="pTxt">
                        <div class="pTitle">Hardest context</div>
                        <div class="pValue">{{ patterns.context }}</div>
                    </div>
                </div>
            </div>

            <div class="hint">
                These are derived from your check-ins and simulations (mock).
            </div>
        </section>

        <!-- Toolkit -->
        <section class="card">
            <div class="cardHead">
                <div class="h2">My toolkit</div>
                <button class="link" @click="goToolkit">See all</button>
            </div>

            <div class="toolGrid">
                <button class="tool" @click="openScripts">
                    <div class="tIcon">🧾</div>
                    <div class="tText">
                        <div class="tTitle">Saved scripts</div>
                        <div class="tSub">{{ toolkit.scripts }} items</div>
                    </div>
                </button>

                <button class="tool" @click="openModels">
                    <div class="tIcon">🧩</div>
                    <div class="tText">
                        <div class="tTitle">Saved models</div>
                        <div class="tSub">{{ toolkit.models }} items</div>
                    </div>
                </button>

                <button class="tool" @click="openStories">
                    <div class="tIcon">📚</div>
                    <div class="tText">
                        <div class="tTitle">Saved stories</div>
                        <div class="tSub">{{ toolkit.stories }} items</div>
                    </div>
                </button>

                <button class="tool" @click="openBookmarks">
                    <div class="tIcon">🔖</div>
                    <div class="tText">
                        <div class="tTitle">Bookmarked courses</div>
                        <div class="tSub">{{ toolkit.bookmarks }} items</div>
                    </div>
                </button>
            </div>
        </section>

        <!-- Journal -->
        <section class="card">
            <div class="cardHead">
                <div class="h2">My reflections</div>
                <button class="link" @click="openJournal">See all</button>
            </div>

            <div class="journal">
                <article v-for="j in journal" :key="j.id" class="jItem" @click="openJournal">
                    <div class="jTop">
                        <span class="chip">{{ j.date }}</span>
                        <span class="chip">{{ j.track }}</span>
                    </div>
                    <div class="jTitle">{{ j.title }}</div>
                    <div class="jBody">{{ j.snippet }}</div>
                </article>
            </div>
        </section>

        <!-- Badges -->
        <section class="card">
            <div class="cardHead">
                <div class="h2">Badges & certificates</div>
                <button class="link" @click="goBadges">See all</button>
            </div>

            <div class="badges">
                <div v-for="b in badges" :key="b.id" class="badgeCard">
                    <div class="bIcon">{{ b.icon }}</div>
                    <div class="bTxt">
                        <div class="bTitle">{{ b.title }}</div>
                        <div class="bSub">{{ b.sub }}</div>
                    </div>
                </div>
            </div>

            <div class="hint">
                Designed for sharing and Erasmus-style recognition (mock).
            </div>
        </section>

        <!-- Support / Preferences -->
        <section class="card">
            <div class="cardHead">
                <div class="h2">Support & preferences</div>
            </div>

            <div class="prefList">
                <button class="pref" @click="openLanguage">
                    <span class="prefLeft">🌍 Language</span>
                    <span class="prefRight">{{ prefs.language }} →</span>
                </button>
                <button class="pref" @click="openAccessibility">
                    <span class="prefLeft">🧠 Accessibility</span>
                    <span class="prefRight">Font / contrast →</span>
                </button>
                <button class="pref" @click="openPrivacy">
                    <span class="prefLeft">🔒 Privacy</span>
                    <span class="prefRight">Export data →</span>
                </button>
                <button class="pref" @click="openSupport">
                    <span class="prefLeft">💬 Support</span>
                    <span class="prefRight">Feedback →</span>
                </button>
            </div>
        </section>

        <!-- Settings -->
        <section class="card">
            <div class="cardHead">
                <div class="h2">Settings</div>
            </div>

            <div class="prefList">
                <button class="pref" @click="openNotifications">
                    <span class="prefLeft">🔔 Notifications</span>
                    <span class="prefRight">{{ prefs.notifications }} →</span>
                </button>
                <button class="pref danger" @click="logout">
                    <span class="prefLeft">🚪 Log out</span>
                    <span class="prefRight">→</span>
                </button>
            </div>
        </section>

    </div>
</template>

<script>
export default {
    name: 'ProfileMock',

    data() {
        return {
            user: {
                name: 'ElevateHer Member',
                motto: 'We Rise Together!',
                streakDays: 4,
                trend: 'Rising',
                mission: 'I want to take responsibility in my community without burning out.'
            },

            tracks: [
                { id: 'dare', label: 'I Dare', value: 64, color: '#2D6CDF' },
                { id: 'speak', label: 'I Speak', value: 58, color: '#F59E0B' },
                { id: 'earn', label: 'I Earn', value: 42, color: '#1F9D63' },
                { id: 'lead', label: 'I Lead', value: 47, color: '#8B5CF6' },
                { id: 'impact', label: 'I Impact', value: 38, color: '#06B6D4' }
            ],

            stats: {
                completedCourses: 6,
                minutes: 120,
                simulations: 9
            },

            patterns: {
                blocker: 'Overload',
                booster: 'Boundaries',
                context: 'Work meetings'
            },

            toolkit: {
                scripts: 5,
                models: 3,
                stories: 7,
                bookmarks: 4
            },

            journal: [
                {
                    id: 'j1',
                    date: 'Yesterday',
                    track: 'I Dare',
                    title: 'My boundary this week',
                    snippet: 'I can’t take this on right now. I can support with X instead...'
                },
                {
                    id: 'j2',
                    date: '3 days ago',
                    track: 'I Speak',
                    title: 'Conflict with care',
                    snippet: 'When I felt interrupted, I paused and said: “Let me finish my point.”'
                },
                {
                    id: 'j3',
                    date: 'Last week',
                    track: 'I Lead',
                    title: 'Decision under pressure',
                    snippet: 'I chose the smallest safe step, communicated it clearly, and asked for input later.'
                }
            ],

            badges: [
                { id: 'b1', icon: '🛡️', title: 'Boundary Starter', sub: 'Completed 3 boundary practices' },
                { id: 'b2', icon: '🎤', title: 'Voice Builder', sub: 'Spoke up in 5 situations' },
                { id: 'b3', icon: '🌱', title: 'Impact Seed', sub: 'Designed a tiny civic pilot' }
            ],

            prefs: {
                language: 'English',
                notifications: 'On'
            }
        }
    },

    computed: {
        focusTrack() {
            const top = (this.tracks || []).slice().sort((a, b) => (b.value || 0) - (a.value || 0))[0]
            return top ? top.label : 'I Dare'
        },

        trendClass() {
            if (this.user.trend === 'Rising') return 'trendRising'
            if (this.user.trend === 'Drained') return 'trendDrained'
            return 'trendStable'
        }
    },

    methods: {
        goGoals() {
            this.$router.push('/goals')
        },

        editMission() {
            // mock route
            this.$router.push('/mission')
        },

        goJourney() {
            this.$router.push('/journey')
        },

        goPowerCheck() {
            this.$router.push('/power-check')
        },

        goToolkit() {
            this.$router.push('/toolkit')
        },

        openScripts() {
            this.$router.push('/scripts')
        },

        openModels() {
            this.$router.push('/models')
        },

        openStories() {
            this.$router.push('/stories')
        },

        openBookmarks() {
            this.$router.push('/bookmarks')
        },

        openJournal() {
            this.$router.push('/journal')
        },

        goBadges() {
            this.$router.push('/badges')
        },

        openLanguage() {
            this.$router.push('/language')
        },

        openAccessibility() {
            this.$router.push('/accessibility')
        },

        openPrivacy() {
            this.$router.push('/privacy')
        },

        openSupport() {
            this.$router.push('/support')
        },

        openNotifications() {
            this.$router.push('/notifications')
        },

        logout() {
            // mock: you would clear store/token
            this.$router.push('/login')
        }
    }
}
</script>

<style scoped>
.profile {
    --brand-pink: #ff2d7a;
    --brand-blue: #2d6cdf;

    --bg: #f7fbff;
    --card: #ffffff;
    --line: #e6eef7;

    --ink: #0f172a;
    --muted: #64748b;

    --shadow: 0 10px 28px rgba(15, 23, 42, 0.08);

    background: var(--bg);
    min-height: 100vh;
    padding: 16px 14px 44px;
    max-width: 980px;
    margin: 0 auto;
    font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial;
    color: var(--ink);
}

/* Header */
.head {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    margin-bottom: 10px;
}

.left {
    display: flex;
    align-items: center;
    gap: 12px;
    min-width: 0;
}

.avatar {
    width: 52px;
    height: 52px;
    border-radius: 18px;
    border: 1px solid var(--line);
    background: linear-gradient(135deg, rgba(45, 108, 223, 0.10), rgba(255, 45, 122, 0.10));
    box-shadow: var(--shadow);
    display: grid;
    place-items: center;
    flex: 0 0 auto;
}

.avEmoji {
    font-size: 22px;
}

.who {
    min-width: 0;
}

.name {
    font-weight: 900;
    font-size: 16px;
    line-height: 1.1;
}

.motto {
    margin-top: 4px;
    color: var(--muted);
    font-weight: 900;
    font-size: 12px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.cta {
    border: 0;
    background: linear-gradient(90deg, var(--brand-blue), var(--brand-pink));
    color: #fff;
    border-radius: 14px;
    padding: 10px 12px;
    font-weight: 900;
    cursor: pointer;
    box-shadow: 0 14px 28px rgba(45, 108, 223, 0.18);
    white-space: nowrap;
}

/* Chips */
.chipsRow {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
    margin-bottom: 12px;
}

.chip {
    font-size: 12px;
    font-weight: 900;
    padding: 8px 10px;
    border-radius: 999px;
    border: 1px solid var(--line);
    background: rgba(230, 238, 247, 0.55);
    color: var(--ink);
}

.chip.strong {
    background: linear-gradient(135deg, rgba(45, 108, 223, 0.12), rgba(255, 45, 122, 0.10));
    border-color: rgba(45, 108, 223, 0.22);
}

.chip b {
    font-weight: 900;
}

.trendRising {
    border-color: rgba(255, 45, 122, 0.30);
    background: rgba(255, 45, 122, 0.08);
}

.trendStable {
    border-color: rgba(45, 108, 223, 0.25);
    background: rgba(45, 108, 223, 0.08);
}

.trendDrained {
    border-color: rgba(230, 238, 247, 1);
    background: rgba(230, 238, 247, 0.65);
}

/* Cards */
.card {
    border: 1px solid var(--line);
    background: var(--card);
    border-radius: 20px;
    padding: 14px;
    box-shadow: var(--shadow);
    margin-top: 12px;
}

.cardHead {
    display: flex;
    align-items: baseline;
    justify-content: space-between;
    gap: 10px;
    margin-bottom: 10px;
}

.h2 {
    font-size: 16px;
    font-weight: 900;
    margin: 0;
    letter-spacing: -0.01em;
}

.link {
    border: 0;
    background: transparent;
    font-weight: 900;
    cursor: pointer;
    color: var(--brand-blue);
    text-decoration: underline;
    white-space: nowrap;
}

/* Mission */
.missionBox {
    border: 1px solid var(--line);
    background: linear-gradient(135deg, rgba(45, 108, 223, 0.08), rgba(255, 45, 122, 0.06));
    border-radius: 18px;
    padding: 12px;
    display: flex;
    gap: 10px;
    align-items: flex-start;
}

.quoteMark {
    font-size: 26px;
    font-weight: 900;
    color: var(--brand-pink);
    line-height: 1;
    margin-top: -2px;
}

.missionText {
    font-weight: 900;
    color: var(--ink);
    line-height: 1.35;
}

.hint {
    margin-top: 10px;
    color: var(--muted);
    font-size: 12px;
    font-weight: 900;
}

/* Progress bars */
.bars {
    display: grid;
    gap: 10px;
}

.barRow {
    display: grid;
    gap: 6px;
}

.barTop {
    display: flex;
    justify-content: space-between;
    gap: 10px;
}

.barName {
    font-weight: 900;
}

.barVal {
    font-weight: 900;
    color: var(--muted);
}

.bar {
    height: 10px;
    border-radius: 999px;
    background: rgba(230, 238, 247, 0.9);
    border: 1px solid rgba(230, 238, 247, 1);
    overflow: hidden;
}

.fill {
    height: 100%;
    width: 0%;
}

/* Stats */
.stats {
    margin-top: 12px;
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 10px;
}

.stat {
    border: 1px solid var(--line);
    border-radius: 18px;
    padding: 12px;
    background: #fff;
}

.statVal {
    font-weight: 900;
    font-size: 18px;
}

.statLbl {
    margin-top: 4px;
    color: var(--muted);
    font-size: 12px;
    font-weight: 900;
}

/* Patterns */
.patternGrid {
    display: grid;
    gap: 10px;
}

.pattern {
    border: 1px solid var(--line);
    border-radius: 18px;
    padding: 12px;
    background: #fff;
    display: flex;
    gap: 10px;
    align-items: center;
}

.pIcon {
    width: 44px;
    height: 44px;
    border-radius: 16px;
    border: 1px solid var(--line);
    background: linear-gradient(135deg, rgba(255, 45, 122, 0.10), rgba(45, 108, 223, 0.08));
    display: grid;
    place-items: center;
}

.pTitle {
    color: var(--muted);
    font-size: 12px;
    font-weight: 900;
}

.pValue {
    font-weight: 900;
    margin-top: 2px;
}

/* Toolkit */
.toolGrid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 10px;
}

.tool {
    border: 1px solid var(--line);
    background: #fff;
    border-radius: 18px;
    padding: 12px;
    cursor: pointer;
    text-align: left;
    display: flex;
    gap: 10px;
    align-items: center;
    box-shadow: 0 10px 22px rgba(15, 23, 42, 0.06);
}

.tIcon {
    width: 44px;
    height: 44px;
    border-radius: 16px;
    border: 1px solid var(--line);
    background: linear-gradient(135deg, rgba(45, 108, 223, 0.10), rgba(255, 45, 122, 0.08));
    display: grid;
    place-items: center;
    font-size: 18px;
}

.tTitle {
    font-weight: 900;
}

.tSub {
    color: var(--muted);
    font-size: 12px;
    font-weight: 900;
    margin-top: 2px;
}

/* Journal */
.journal {
    display: grid;
    gap: 10px;
}

.jItem {
    border: 1px solid var(--line);
    background: #fff;
    border-radius: 18px;
    padding: 12px;
    cursor: pointer;
}

.jTop {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
    margin-bottom: 8px;
}

.jTitle {
    font-weight: 900;
    margin-bottom: 6px;
}

.jBody {
    color: #475569;
    line-height: 1.35;
}

/* Badges */
.badges {
    display: grid;
    gap: 10px;
}

.badgeCard {
    border: 1px solid var(--line);
    background: #fff;
    border-radius: 18px;
    padding: 12px;
    display: flex;
    gap: 10px;
    align-items: center;
}

.bIcon {
    width: 44px;
    height: 44px;
    border-radius: 16px;
    border: 1px solid var(--line);
    background: linear-gradient(135deg, rgba(255, 45, 122, 0.10), rgba(45, 108, 223, 0.08));
    display: grid;
    place-items: center;
    font-size: 18px;
}

.bTitle {
    font-weight: 900;
}

.bSub {
    color: var(--muted);
    font-size: 12px;
    font-weight: 900;
    margin-top: 2px;
}

/* Preferences list */
.prefList {
    display: grid;
    gap: 10px;
}

.pref {
    border: 1px solid var(--line);
    background: #fff;
    border-radius: 18px;
    padding: 12px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    font-weight: 900;
}

.prefLeft {
    display: inline-flex;
    gap: 8px;
    align-items: center;
}

.prefRight {
    color: var(--muted);
    font-weight: 900;
}

.pref.danger {
    border-color: rgba(255, 45, 122, 0.25);
    background: rgba(255, 45, 122, 0.06);
}

/* Responsive */
@media (max-width: 420px) {
    .stats {
        grid-template-columns: 1fr;
    }

    .toolGrid {
        grid-template-columns: 1fr;
    }
}
</style>