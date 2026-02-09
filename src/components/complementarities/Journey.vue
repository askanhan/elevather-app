<!-- src/views/JourneyHome.vue -->
<template>
    <div class="journey">
        <header class="top">
            <div>
                <h1 class="title">30-Day Journey</h1>
                <p class="subtitle">
                    One day, one lesson. Keep momentum. Green means done, yellow means pending.
                </p>
            </div>

            <div class="actions">
                <input v-model="query" class="search" type="search" placeholder="Search days, topics…"
                    aria-label="Search" />

                <select v-model="categoryFilter" class="select" aria-label="Category filter">
                    <option value="all">All categories</option>
                    <option v-for="c in categories" :key="c" :value="c">{{ c }}</option>
                </select>

                <select v-model="statusFilter" class="select" aria-label="Status filter">
                    <option value="all">All statuses</option>
                    <option value="done">Completed</option>
                    <option value="pending">Pending</option>
                </select>
            </div>
        </header>

        <section class="stats">
            <div class="statCard">
                <div class="statLabel">Progress</div>
                <div class="statValue">{{ doneCount }}/30</div>
                <div class="bar">
                    <div class="barFill" :style="{ width: progressPercent + '%' }"></div>
                </div>
            </div>

            <div class="statCard">
                <div class="statLabel">Today</div>
                <div class="statValue">Day {{ suggestedDay }}</div>
                <div class="statHint">Next unfinished day</div>
            </div>
        </section>

        <section class="list">
            <div v-for="sec in groupedDays" :key="sec.key" class="section">
                <div class="sectionHeader">
                    <div class="sectionTitle">{{ sec.category }}</div>
                    <div class="sectionMeta">
                        Days {{ sec.rangeText }} • {{ sec.items.length }} lessons
                    </div>
                </div>

                <article v-for="d in sec.items" :key="d.day" class="dayCard" :class="cardClass(d)"
                    @click="goToCourse(d.day)" role="button" tabindex="0">
                    <div class="dayLeft">
                        <div class="dayNumber">{{ d.day }}</div>
                    </div>

                    <div class="dayMain">
                        <div class="dayTop">
                            <div class="dayTitleWrap">
                                <h2 class="dayTitle">Day {{ d.day }}: {{ d.title }}</h2>
                                <span class="chip">{{ d.category }}</span>
                            </div>

                            <div class="dayRight">
                                <span class="statusBadge" :class="statusClass(d)">
                                    <span class="dot"></span>
                                    {{ d.status === 'done' ? 'Completed' : 'Pending' }}
                                </span>

                                <button class="toggleBtn" type="button" @click.stop="toggleDone(d.day)"
                                    :aria-label="d.status === 'done' ? 'Mark as pending' : 'Mark as completed'">
                                    {{ d.status === 'done' ? 'Undo' : 'Done' }}
                                </button>
                            </div>
                        </div>

                        <p class="dayDesc">{{ d.description }}</p>

                        <div class="dayBottom">
                            <div class="miniMeta">
                                <span class="miniLabel">Focus:</span>
                                <span class="miniText">{{ d.focus }}</span>
                            </div>

                            <div class="cta">
                                <span>Open lesson</span>
                                <span class="arrow">→</span>
                            </div>
                        </div>
                    </div>
                </article>
            </div>

            <p v-if="filteredDays.length === 0" class="empty">
                No results. Try clearing filters or searching differently.
            </p>
        </section>
    </div>
</template>

<script>
export default {
    name: "JourneyHome",

    data() {
        return {
            query: "",
            categoryFilter: "all",
            statusFilter: "all",
            days: []
        };
    },

    created() {
        const base = this.buildBaseDays();
        const progress = this.loadProgressMap();

        this.days = base.map(d => ({
            ...d,
            status: progress[d.day] ? "done" : "pending"
        }));
        this.days[0].status = "done"; // Ensure Day 1 is pending to start with
    },

    computed: {
        groupedDays() {
            // filteredDays already respects search + filters
            const items = this.filteredDays.slice().sort((a, b) => a.day - b.day);

            const groups = [];
            const order = this.categoryOrder; // ensures “ilk 5 gün ...” sırası bozulmaz

            order.forEach(cat => {
                const list = items.filter(d => d.category === cat);
                if (!list.length) return;

                const first = list[0].day;
                const last = list[list.length - 1].day;

                groups.push({
                    key: `${cat}-${first}-${last}`,
                    category: cat,
                    rangeText: first === last ? String(first) : `${first}–${last}`,
                    items: list
                });
            });

            // Eğer arama/filtre yüzünden order’da olmayan bir kategori çıkarsa diye fallback:
            const known = new Set(order);
            const restCats = Array.from(new Set(items.map(d => d.category))).filter(c => !known.has(c));
            restCats.forEach(cat => {
                const list = items.filter(d => d.category === cat);
                if (!list.length) return;
                const first = list[0].day;
                const last = list[list.length - 1].day;
                groups.push({
                    key: `${cat}-${first}-${last}`,
                    category: cat,
                    rangeText: first === last ? String(first) : `${first}–${last}`,
                    items: list
                });
            });

            return groups;
        },

        categoryOrder() {
            // burada istediğin “ilk 5 gün, sonraki 7 gün...” akışı garanti altına alınır
            // (senin mevcut day mapping’ine göre)
            return [
                "Confidence & Momentum",      // Day 1–6
                "Wellbeing & Focus",          // Day 7–10
                "Creativity & Story",         // Day 11–12
                "Self-Discovery",             // Day 13–14, 22, 24
                "Visibility & Speaking",      // Day 15–16
                "Civic Power",                // Day 17–18
                "Women Who Shaped the World", // Day 19–21
                "Digital Boundaries",         // Day 23
                "Leadership Foundations"      // Day 25–30
            ];
        },
        categories() {
            const set = new Set(this.days.map(d => d.category));
            return Array.from(set).sort();
        },

        normalizedQuery() {
            return (this.query || "").trim().toLowerCase();
        },

        filteredDays() {
            const q = this.normalizedQuery;
            const cat = this.categoryFilter;
            const st = this.statusFilter;

            return this.days.filter(d => {
                const hay = (
                    d.title + " " + d.description + " " + d.category + " " + (d.focus || "")
                ).toLowerCase();

                const matchesQuery = q ? hay.includes(q) : true;
                const matchesCat = cat === "all" ? true : d.category === cat;
                const matchesStatus = st === "all" ? true : d.status === st;

                return matchesQuery && matchesCat && matchesStatus;
            });
        },

        doneCount() {
            return this.days.filter(d => d.status === "done").length;
        },

        progressPercent() {
            return Math.round((this.doneCount / 30) * 100);
        },

        suggestedDay() {
            const next = this.days.find(d => d.status !== "done");
            return next ? next.day : 30;
        }
    },

    methods: {
        goToCourse(day) {
            // quick routing: /course?day=12
            this.$router.push({ path: "/course", query: { day: String(day) } });
        },

        toggleDone(day) {
            const idx = this.days.findIndex(d => d.day === day);
            if (idx === -1) return;

            const copy = this.days.slice();
            const current = copy[idx];
            copy[idx] = {
                ...current,
                status: current.status === "done" ? "pending" : "done"
            };

            this.days = copy;
            this.saveProgressMap();
        },

        statusClass(d) {
            return {
                done: d.status === "done",
                pending: d.status !== "done"
            };
        },

        cardClass(d) {
            return {
                done: d.status === "done",
                pending: d.status !== "done"
            };
        },

        loadProgressMap() {
            try {
                const raw = localStorage.getItem("eh_30day_progress");
                const parsed = raw ? JSON.parse(raw) : {};
                return parsed && typeof parsed === "object" ? parsed : {};
            } catch (e) {
                return {};
            }
        },

        saveProgressMap() {
            const map = {};
            this.days.forEach(d => {
                map[d.day] = d.status === "done";
            });
            try {
                localStorage.setItem("eh_30day_progress", JSON.stringify(map));
            } catch (e) { }
        },

        buildBaseDays() {
            // 30 DAYS - derived directly from your provided list (kept clean & structured)
            return [
                {
                    day: 1,
                    category: "Confidence & Momentum",
                    title: "Strategies & Tools to Strengthen Self-Confidence",
                    focus: "Self-trust & action",
                    description:
                        "Practical strategies and micro-tools to grow confidence through everyday choices."
                },
                {
                    day: 2,
                    category: "Confidence & Momentum",
                    title: "Motivational Techniques + Examples of Successful Women",
                    focus: "Motivation & belief",
                    description:
                        "Motivation methods and real examples that normalize ambition and resilience."
                },
                {
                    day: 3,
                    category: "Confidence & Momentum",
                    title: "Networking",
                    focus: "Connections & opportunities",
                    description:
                        "Build genuine professional connections without feeling fake or pushy."
                },
                {
                    day: 4,
                    category: "Confidence & Momentum",
                    title: "Partnering",
                    focus: "Collaboration",
                    description:
                        "How to form partnerships with clear asks, roles, and shared benefits."
                },
                {
                    day: 5,
                    category: "Confidence & Momentum",
                    title: "Thankfulness",
                    focus: "Mindset & stability",
                    description:
                        "Simple gratitude practices that improve mood, clarity, and leadership presence."
                },
                {
                    day: 6,
                    category: "Confidence & Momentum",
                    title: "A Brief View of the Use of AI",
                    focus: "Leverage & efficiency",
                    description:
                        "Where AI helps, where it doesn’t, and a healthy way to start using it."
                },

                {
                    day: 7,
                    category: "Wellbeing & Focus",
                    title: "Self-Care for Strong Leaders",
                    focus: "Sustainable energy",
                    description:
                        "Create self-care rituals that keep you grounded, focused, and confident on busy days."
                },
                {
                    day: 8,
                    category: "Wellbeing & Focus",
                    title: "Ikigai: Discover Your Purpose",
                    focus: "Purpose & alignment",
                    description:
                        "Explore what you love, what you’re good at, what the world needs, and what pays."
                },
                {
                    day: 9,
                    category: "Wellbeing & Focus",
                    title: "Breathwork for Focus and Balance",
                    focus: "Stress & clarity",
                    description:
                        "Guided breathing techniques to calm your mind, sharpen focus, and improve presence."
                },
                {
                    day: 10,
                    category: "Wellbeing & Focus",
                    title: "Mindful Meditation Moments",
                    focus: "Emotional regulation",
                    description:
                        "Short guided meditations that build inner stillness and decision clarity."
                },

                {
                    day: 11,
                    category: "Creativity & Story",
                    title: "Unlocking Creativity & Vision",
                    focus: "Innovation & expression",
                    description:
                        "Playful exercises to boost creativity, problem-solving, and authentic leadership."
                },
                {
                    day: 12,
                    category: "Creativity & Story",
                    title: "Personal Brand Building: Lead With Your Story",
                    focus: "Narrative & visibility",
                    description:
                        "Define your value, craft your story, and attract opportunities without pretending."
                },

                {
                    day: 13,
                    category: "Self-Discovery",
                    title: "Discover Your Inner Potential",
                    focus: "Reflection practices",
                    description:
                        "Journaling, experience mapping, and guided reflection to surface strengths and patterns."
                },
                {
                    day: 14,
                    category: "Self-Discovery",
                    title: "The Big Five: Your Personality in 5 Dimensions",
                    focus: "Personality & strengths",
                    description:
                        "A simplified Big Five mini-quiz to understand energy patterns, stress responses, and strengths."
                },

                {
                    day: 15,
                    category: "Visibility & Speaking",
                    title: "Get Ready for Public Speaking",
                    focus: "Preparation & confidence",
                    description:
                        "Technical + psychological preparation: what to prepare, how to prepare, and how to feel ready."
                },
                {
                    day: 16,
                    category: "Visibility & Speaking",
                    title: "Public Speaking: Staying Strong in the Spotlight",
                    focus: "Delivery & resilience",
                    description:
                        "Handling difficult moments, keeping a positive vibe, and learning from the experience afterward."
                },

                {
                    day: 17,
                    category: "Civic Power",
                    title: "Local Activism Day 1: Advocacy Messaging",
                    focus: "Persuasion & benefits",
                    description:
                        "How to explain your idea so others want in. Messaging that highlights benefits for allies."
                },
                {
                    day: 18,
                    category: "Civic Power",
                    title: "Local Activism Day 2: Responding to Discrimination",
                    focus: "Boundaries & intervention",
                    description:
                        "Practical ways to respond when it’s directed at you or when you witness it."
                },

                {
                    day: 19,
                    category: "Women Who Shaped the World",
                    title: '“I Need to Understand” – Hannah Arendt',
                    focus: "Thinking under pressure",
                    description:
                        "Biographical notes: how historical upheavals shaped ideas, courage, and clarity."
                },
                {
                    day: 20,
                    category: "Women Who Shaped the World",
                    title: "Overseen, but Influential – Joan Robinson",
                    focus: "Competence & recognition",
                    description:
                        "A brilliant economist: what it means to be competent and still underestimated."
                },
                {
                    day: 21,
                    category: "Women Who Shaped the World",
                    title: "Pioneers of Robotics (1950s)",
                    focus: "Tech & legacy",
                    description:
                        "A short bio-lesson on early women innovators who helped shape IT and robotics."
                },

                {
                    day: 22,
                    category: "Self-Discovery",
                    title: "My Treasures: Talents, Power Resources",
                    focus: "Strength mapping",
                    description:
                        "Introduction to the Talent Compass model: map your talents into usable power resources."
                },

                {
                    day: 23,
                    category: "Digital Boundaries",
                    title: "Digital Courage: Boundaries & Showing Up Safely Online",
                    focus: "Self-respect online",
                    description:
                        "Show up in digital spaces with clarity, emotional safety, and protection from overwhelm."
                },

                {
                    day: 24,
                    category: "Self-Discovery",
                    title: "Story of Me: Rewriting Your Power Narrative",
                    focus: "Agency & meaning",
                    description:
                        "Reframe your life story as a source of learning, strength, and leadership visibility."
                },

                {
                    day: 25,
                    category: "Leadership Foundations",
                    title: "Knowing Yourself as a Leader",
                    focus: "Values & self-awareness",
                    description:
                        "Discover what leadership means for you and how your values and experiences shape it."
                },
                {
                    day: 26,
                    category: "Leadership Foundations",
                    title: "Leading in Your Own Way",
                    focus: "Styles & authenticity",
                    description:
                        "Reflect on leadership styles and learn how flexibility increases your impact."
                },
                {
                    day: 27,
                    category: "Leadership Foundations",
                    title: "Proactive Leadership in Daily Life",
                    focus: "Initiative & intent",
                    description:
                        "Move from reacting to leading: anticipate challenges and build a proactive mindset."
                },
                {
                    day: 28,
                    category: "Leadership Foundations",
                    title: "Personal Growth & Self-Belief",
                    focus: "Beliefs & barriers",
                    description:
                        "Challenge self-limiting beliefs and take empowered steps forward."
                },
                {
                    day: 29,
                    category: "Leadership Foundations",
                    title: "Designing Your Growth Path",
                    focus: "Goals & habits",
                    description:
                        "Turn reflection into action: align goals with values and build sustainable routines."
                },
                {
                    day: 30,
                    category: "Leadership Foundations",
                    title: "Vision, Confidence & Moving Forward",
                    focus: "Commitment & direction",
                    description:
                        "Recognize progress, commit to lifelong learning, and move forward with clarity."
                }
            ];
        }
    }
};
</script>

<style scoped>
.journey {
    max-width: 920px;
    margin: 0 auto;
    padding: 18px 14px 44px;
    font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial, "Apple Color Emoji",
        "Segoe UI Emoji";
    background: #ffffff;
}

.top {
    display: flex;
    gap: 12px;
    align-items: flex-start;
    justify-content: space-between;
    flex-wrap: wrap;
    margin-bottom: 12px;
}

.title {
    font-size: 22px;
    font-weight: 900;
    margin: 0 0 6px 0;
    color: #0f172a;
}

.subtitle {
    margin: 0;
    color: #475569;
    max-width: 640px;
    line-height: 1.35;
    font-size: 13px;
}

.actions {
    display: flex;
    gap: 10px;
    align-items: center;
    flex-wrap: wrap;
    width: 100%;
}

.search {
    flex: 1 1 240px;
    min-width: 240px;
    border: 1px solid #e2e8f0;
    border-radius: 14px;
    padding: 10px 12px;
    outline: none;
    background: #fff;
}

.search:focus {
    border-color: #94a3b8;
}

.select {
    flex: 0 0 auto;
    border: 1px solid #e2e8f0;
    border-radius: 14px;
    padding: 10px 12px;
    background: #fff;
    color: #0f172a;
    font-weight: 800;
    font-size: 13px;
}

.stats {
    display: grid;
    grid-template-columns: 1fr;
    gap: 10px;
    margin: 10px 0 14px;
}

@media (min-width: 720px) {
    .stats {
        grid-template-columns: 1fr 1fr;
    }
}

.statCard {
    border: 1px solid #e2e8f0;
    background: #fff;
    border-radius: 16px;
    box-shadow: 0 6px 18px rgba(15, 23, 42, 0.05);
    padding: 12px;
}

.statLabel {
    color: #64748b;
    font-size: 12px;
    font-weight: 900;
    margin-bottom: 6px;
}

.statValue {
    font-size: 18px;
    font-weight: 900;
    color: #0f172a;
    margin-bottom: 8px;
}

.statHint {
    font-size: 12px;
    color: #64748b;
    font-weight: 800;
}

.bar {
    height: 10px;
    border-radius: 999px;
    background: #f1f5f9;
    overflow: hidden;
    border: 1px solid #e2e8f0;
}

.barFill {
    height: 100%;
    width: 0%;
    background: #22c55e;
}

.list {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.dayCard {
    display: grid;
    grid-template-columns: 62px 1fr;
    gap: 10px;
    border-radius: 18px;
    overflow: hidden;
    cursor: pointer;
    border: 1px solid #e2e8f0;
    box-shadow: 0 6px 18px rgba(15, 23, 42, 0.05);
    transition: transform 0.06s ease, box-shadow 0.06s ease, border-color 0.06s ease;
}

.dayCard:hover {
    transform: translateY(-1px);
    box-shadow: 0 10px 22px rgba(15, 23, 42, 0.07);
    border-color: #cbd5e1;
}

.dayLeft {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 10px;
}

.dayNumber {
    width: 44px;
    height: 44px;
    border-radius: 16px;
    display: grid;
    place-items: center;
    font-weight: 900;
    color: #0f172a;
    border: 1px solid rgba(15, 23, 42, 0.12);
}

.dayMain {
    padding: 12px 12px 12px 0;
    min-width: 0;
}

.dayTop {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    gap: 10px;
    flex-wrap: wrap;
}

.dayTitleWrap {
    min-width: 0;
    flex: 1;
}

.dayTitle {
    margin: 0 0 6px 0;
    font-size: 14px;
    font-weight: 900;
    color: #0f172a;
    line-height: 1.25;
}

.chip {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    font-size: 12px;
    font-weight: 900;
    padding: 6px 10px;
    border-radius: 999px;
    border: 1px solid #e2e8f0;
    background: #f8fafc;
    color: #0f172a;
}

.dayRight {
    display: inline-flex;
    align-items: center;
    gap: 8px;
}

.statusBadge {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    font-size: 12px;
    font-weight: 900;
    padding: 6px 10px;
    border-radius: 999px;
    border: 1px solid #e2e8f0;
    background: #fff;
    color: #0f172a;
    white-space: nowrap;
}

.statusBadge .dot {
    width: 9px;
    height: 9px;
    border-radius: 999px;
    background: #94a3b8;
}

.statusBadge.done {
    background: #f0fdf4;
    border-color: #bbf7d0;
}

.statusBadge.done .dot {
    background: #22c55e;
}

.statusBadge.pending {
    background: #fffbeb;
    border-color: #fde68a;
}

.statusBadge.pending .dot {
    background: #f59e0b;
}

.toggleBtn {
    border: 1px solid #e2e8f0;
    background: #fff;
    border-radius: 999px;
    padding: 7px 10px;
    font-weight: 900;
    font-size: 12px;
    cursor: pointer;
    color: #0f172a;
}

.toggleBtn:hover {
    border-color: #cbd5e1;
}

.dayDesc {
    margin: 8px 0 0;
    color: #475569;
    line-height: 1.35;
    font-size: 13px;
}

.dayBottom {
    margin-top: 10px;
    display: flex;
    align-items: flex-end;
    justify-content: space-between;
    gap: 10px;
    flex-wrap: wrap;
}

.miniMeta {
    max-width: 650px;
}

.miniLabel {
    font-size: 12px;
    color: #64748b;
    font-weight: 900;
    margin-right: 6px;
}

.miniText {
    color: #334155;
    font-size: 12px;
    font-weight: 800;
}

.cta {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    font-weight: 900;
    color: #0f172a;
    font-size: 13px;
}

.arrow {
    font-size: 16px;
}

/* REQUIRED: completed=green, others=yellow */
.dayCard.done {
    background: #f0fdf4;
    border-color: #bbf7d0;
}

.dayCard.done .dayNumber {
    background: #dcfce7;
}

.dayCard.pending {
    background: #fffbeb;
    border-color: #fde68a;
}

.dayCard.pending .dayNumber {
    background: #fef3c7;
}

.empty {
    margin: 10px 0 0;
    color: #64748b;
    font-weight: 800;
    font-size: 13px;
}
.section {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.sectionHeader {
  padding: 10px 12px;
  border-radius: 14px;
  border: 1px solid #e2e8f0;
  background: #ffffff;
  box-shadow: 0 6px 18px rgba(15, 23, 42, 0.04);
  text-align: center;
}

.sectionTitle {
  font-weight: 900;
  color: #0f172a;
  font-size: 13px;
  margin-bottom: 4px;
}

.sectionMeta {
  color: #64748b;
  font-size: 12px;
  font-weight: 800;
}
</style>