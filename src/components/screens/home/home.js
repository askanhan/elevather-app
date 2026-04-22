import confetti from 'canvas-confetti';
export default {
    name: 'PowerCheck',

    data() {
        return {
            selectedAnswers: {},
            selectedScores: {},
            isCompleted: false, // to track if the check-in has been completed

            check: {
                voice: 50,
                boundary: 50,
                energy: 50
            },
            
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
            if (!hasAnswers) return '✨'
            const s = this.powerScore
            if (s >= 70) return '🔥'
            if (s <= 45) return '🔋'
            return '⚡'
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
            // Get userId from store (from user or profile)
            const userId = this.$store.state.user?.id || this.$store.state.myProfile?.id || 1
            
            this.$store.dispatch('fetchDailyCheckinQuestions', userId)
                .then((response) => {
                    console.log('Daily checkin questions fetched:', response)
                })
                .catch(err => {
                    console.error('Error fetching questions:', err)
                    this.loadMockQuestions()
                })
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
                this.isCompleted = true;
                this.triggerConfetti();
            }
        },

        submitCheckin() {
            // Get all selected option IDs
            const optionIds = Object.values(this.selectedAnswers)
            
            if (optionIds.length !== 3) {
                console.warn('Not all questions answered yet')
                return
            }
            
            // Get userId from store
            const userId = this.$store.state.user?.id || this.$store.state.myProfile?.id || 1
            
            console.log('Submitting daily checkin with options:', optionIds, 'userId:', userId)
            
            // Submit to backend
            this.$store.dispatch('submitDailyCheckin', {
                userId: userId,
                optionIds: optionIds
            })
            .catch((error) => {
                console.error('Error submitting daily checkin:', error)
                this.$store.commit('SHOW_MESSAGE', ['Error submitting check-in. Please try again.', 'error'])
            })
        },

        triggerConfetti() {
            const scalar = 7;
            const emoji = confetti.shapeFromText({ text: this.stateEmoji, scalar });

            const duration = 1 * 1000;
            const animationEnd = Date.now() + duration;

            const frame = () => {
                confetti({
                    particleCount: 3,
                    angle: 60,
                    spread: 55,
                    origin: { x: 0 },
                    shapes: [emoji],
                    ticks: 200,      
                    gravity: 1.2,    
                    scalar: scalar
                });
                confetti({
                    particleCount: 3,
                    angle: 120,
                    spread: 55,
                    origin: { x: 1 },
                    shapes: [emoji],
                    ticks: 200,      
                    gravity: 1.2,    
                    scalar: scalar
                });

                if (Date.now() < animationEnd) {
                    requestAnimationFrame(frame);
                }
            };
            frame();
        },

        resetToday() {
            this.selectedAnswers = {}
            this.selectedScores = {}
            this.isCompleted = false;
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
