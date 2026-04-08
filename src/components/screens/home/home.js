export default {
    name: 'PowerCheck',

    data() {
        return {
            selectedAnswers: {},
            selectedScores: {},

            check: {
                voice: 50,
                boundary: 50,
                energy: 50
            },

            selectedBlocker: 'fear',

            selectedDay: null,

            blockers: [
                { id: 'fear', icon: '', title: 'Fear', sub: 'Hesitation, self-doubt, overthinking' },
                { id: 'overload', icon: '', title: 'Overload', sub: 'Too much, too fast, no space' },
                { id: 'conflict', icon: '', title: 'Conflict', sub: 'Tension, pushback, hard conversations' },
                { id: 'unclear', icon: '', title: 'Unclear goals', sub: 'No direction, no next step' }
            ],

            rec: {
                story: { title: 'The 3-sentence boundary moment', sub: 'A quick story about reclaiming space calmly.' },
                model: { title: 'Boundary Script Builder', sub: 'Situation  Limit  Alternative  Pushback responses.' },
                course: { title: 'Boundaries & Saying No', sub: 'Short, calm, repeatable boundaries without guilt.' }
            },

            last7: [
                { date: 'Mon', short: 'M', state: 'stable', score: 62, note: 'Used one clear ask. Energy okay.' },
                { date: 'Tue', short: 'T', state: 'rising', score: 74, note: 'Spoke up in a meeting. Felt strong after.' },
                { date: 'Wed', short: 'W', state: 'drained', score: 41, note: 'Overcommitted. Needed rest.' },
                { date: 'Thu', short: 'T', state: 'stable', score: 58, note: 'Kept boundaries in small ways.' },
                { date: 'Fri', short: 'F', state: 'rising', score: 70, note: 'Negotiated a timeline. Felt respected.' },
                { date: 'Sat', short: 'S', state: 'drained', score: 45, note: 'Heavy week. Recovery day.' },
                { date: 'Sun', short: 'S', state: 'stable', score: 60, note: 'Reset and planned one priority.' }
            ]
        }
    },

    mounted() {
        this.fetchQuestions()
    },

    computed: {
        questions() {
            return this.$store.state.dailyCheckinQuestions || []
        },

        powerScore() {
            const scores = Object.values(this.selectedScores)
            if (scores.length === 0) return 0
            return Math.round(Math.min(100, scores.reduce((a, b) => a + b, 0)))
        },

        stateLabel() {
            const hasAnswers = Object.keys(this.selectedAnswers).length > 0
            if (!hasAnswers) return 'Find your power'
            const s = this.powerScore
            if (s >= 70) return 'Rising'
            if (s <= 45) return 'Drained'
            return 'Stable'
        },

        stateEmoji() {
            const hasAnswers = Object.keys(this.selectedAnswers).length > 0
            if (!hasAnswers) return ''
            const s = this.powerScore
            if (s >= 70) return ''
            if (s <= 45) return ''
            return ''
        },

        stateClass() {
            const hasAnswers = Object.keys(this.selectedAnswers).length > 0
            if (!hasAnswers) return 'empty'
            const s = this.powerScore
            if (s >= 70) return 'rising'
            if (s <= 45) return 'drained'
            return 'stable'
        },

        trackBars() {
            const base = this.powerScore
            const scores = Object.values(this.selectedScores)

            const q1Score = scores[0] || 50
            const q2Score = scores[1] || 50
            const q3Score = scores[2] || 50

            return [
                { id: 'dare', label: 'I Dare', value: this.clamp(base + (q2Score - 50) / 4), color: '#2D6CDF', hint: 'Courage, boundaries, visibility.' },
                { id: 'speak', label: 'I Speak', value: this.clamp(base + (q1Score - 50) / 3), color: '#F59E0B', hint: 'Communication and influence.' },
                { id: 'earn', label: 'I Earn', value: this.clamp(base - 6), color: '#1F9D63', hint: 'Money clarity & leverage.' },
                { id: 'lead', label: 'I Lead', value: this.clamp(base - 3), color: '#8B5CF6', hint: 'Ethical power & decisions.' },
                { id: 'impact', label: 'I Impact', value: this.clamp(base - 8), color: '#06B6D4', hint: 'Society, systems, civic action.' }
            ]
        },

        leverage() {
            const b = this.selectedBlocker
            const s = this.powerScore

            if (b === 'fear') {
                return {
                    title: 'Do one micro-courage ask today',
                    time: '24 min',
                    track: 'I Dare',
                    desc: 'Pick one small moment: ask a question, state a preference, or request clarity. Short sentence. No explaining.'
                }
            }

            if (b === 'overload') {
                return {
                    title: 'Cancel or renegotiate one commitment',
                    time: '35 min',
                    track: 'I Lead',
                    desc: 'Choose one thing to delay or delegate. Use one calm line. Protect tomorrows energy.'
                }
            }

            if (b === 'conflict') {
                return {
                    title: 'Use a boundary + care sentence',
                    time: '35 min',
                    track: 'I Speak',
                    desc: 'Say: "I get it. And I\'m not available for X. I can do Y." Then stop. Let silence work for you.'
                }
            }

            if (s < 55) {
                return {
                    title: 'Write your one priority (and one "not now")',
                    time: '23 min',
                    track: 'I Impact',
                    desc: 'Name the single outcome you want this week. Then pick one thing you are not doing.'
                }
            }

            return {
                title: 'Turn one idea into a tiny pilot',
                time: '58 min',
                track: 'I Build',
                desc: 'Define a mini experiment: what, who, when, success signal. Small is smarter.'
            }
        }
    },

    methods: {
        fetchQuestions() {
            this.$store.dispatch('fetchDailyCheckinQuestions')
                .then(() => {})
                .catch(err => {
                    this.loadMockQuestions()
                })
        },

        loadMockQuestions() {
            const questions = [
                {
                    id: 1,
                    question_text: 'I expressed myself',
                    subtitle: 'Voice in meetings / conversations',
                    options: [
                        { id: 101, text: 'No', score: 0 },
                        { id: 102, text: 'Some', score: 15 },
                        { id: 103, text: 'Yes', score: 33 }
                    ]
                },
                {
                    id: 2,
                    question_text: 'I set a boundary',
                    subtitle: 'Said no / protected time',
                    options: [
                        { id: 201, text: 'No', score: 0 },
                        { id: 202, text: 'Some', score: 15 },
                        { id: 203, text: 'Yes', score: 33 }
                    ]
                },
                {
                    id: 3,
                    question_text: 'My energy level',
                    subtitle: 'Body & mind availability',
                    options: [
                        { id: 301, text: 'Low', score: 0 },
                        { id: 302, text: 'Mid', score: 15 },
                        { id: 303, text: 'High', score: 34 }
                    ]
                }
            ]
            this.$store.commit('SET_DAILY_CHECKIN_QUESTIONS', questions)
        },

        clamp(v) {
            const n = Math.round(v)
            return Math.max(0, Math.min(100, n))
        },

        setCheck(questionId, optionId, scoreValue) {
            this.selectedAnswers[questionId] = optionId
            this.selectedScores[questionId] = scoreValue
            
            // Check if all 3 questions are answered
            if (Object.keys(this.selectedAnswers).length === 3) {
                // Auto-submit the checkin
                this.submitCheckin()
            }
        },

        submitCheckin() {
            // Get all selected option IDs
            const optionIds = Object.values(this.selectedAnswers)
            
            if (optionIds.length !== 3) {
                console.warn('Not all questions answered yet')
                return
            }
            
            console.log('Submitting daily checkin with options:', optionIds)
            
            // Submit to backend
            this.$store.dispatch('submitDailyCheckin', {
                userId: 1, // Replace with actual user ID from auth
                optionIds: optionIds
            })
            .then((response) => {
                console.log('Daily checkin submitted successfully:', response)
                this.$store.commit('SHOW_MESSAGE', `Power level: ${response.powerLevel}/100 (${response.status})`)
            })
            .catch((error) => {
                console.error('Error submitting daily checkin:', error)
                this.$store.commit('SHOW_MESSAGE', ['Error submitting check-in. Please try again.', 'error'])
            })
        },

        selectBlocker(id) {
            this.selectedBlocker = id
        },

        resetToday() {
            this.selectedAnswers = {}
            this.selectedScores = {}
            this.selectedBlocker = 'fear'
            this.selectedDay = null
        },

        dayStateLabel(s) {
            if (s === 'rising') return 'Rising'
            if (s === 'drained') return 'Drained'
            return 'Stable'
        },

        goJourney() {
            this.push({ name: 'journey' })
        },

        goSimulatorFast() {
            this.push({ path: '/simulator' })
        },

        goStories() {
            this.push({ name: 'stories' })
        },

        openModel() {
            this.push('/model')
        },

        openCourse() {
            this.push('/course')
        }
    }
}
