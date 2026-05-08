<template>
    <div class="email-auth-wrap">
        <div class="email-auth-card">
            <div class="email-auth-logo-row">
                <img :src="logo" alt="ElevatHER" class="email-auth-logo" />
            </div>

            <h1 class="email-auth-title">Create Account</h1>
            <p class="email-auth-sub">Sign up with your email to get started.</p>

            <div class="email-auth-form">
                <div class="email-auth-row">
                    <div class="email-auth-half">
                        <label class="email-auth-label">First name</label>
                        <input v-model="firstName" type="text" class="email-auth-input" placeholder="Jane"
                            autocomplete="given-name" />
                    </div>
                    <div class="email-auth-half">
                        <label class="email-auth-label">Last name</label>
                        <input v-model="lastName" type="text" class="email-auth-input" placeholder="Doe"
                            autocomplete="family-name" />
                    </div>
                </div>

                <label class="email-auth-label">Email</label>
                <input v-model="email" type="email" class="email-auth-input" placeholder="you@example.com"
                    autocomplete="email" />

                <label class="email-auth-label">Password</label>
                <input v-model="password" type="password" class="email-auth-input" placeholder="Min. 6 characters"
                    autocomplete="new-password" />

                <label class="email-auth-label">Confirm password</label>
                <input v-model="passwordConfirm" type="password" class="email-auth-input"
                    placeholder="Repeat your password" autocomplete="new-password" @keyup.enter="submit" />

                <div v-if="error" class="email-auth-error">{{ error }}</div>

                <button class="email-auth-btn" :disabled="busy" @click="submit">
                    {{ busy ? 'Creating account…' : 'Create account' }}
                </button>
            </div>

            <div class="email-auth-footer">
                <span>Already have an account?</span>
                <button class="email-auth-link" @click="goLogin">Sign in</button>
            </div>

            <button class="email-auth-back" @click="goBack">← Back to login</button>
        </div>
    </div>
</template>
<script>
import axios from 'axios'
import { Preferences } from '@capacitor/preferences'

export default {
    name: 'EmailRegister',
    data() {
        return {
            logo: require('@/assets/elevateher_logo.png'),
            firstName: '',
            lastName: '',
            email: '',
            password: '',
            passwordConfirm: '',
            error: null,
            busy: false,
        }
    },
    methods: {
        async submit() {
            this.error = null
            const email = (this.email || '').trim().toLowerCase()
            const pwd = this.password || ''
            const pwdConfirm = this.passwordConfirm || ''
            const firstName = (this.firstName || '').trim()
            const lastName = (this.lastName || '').trim()

            if (!firstName) { this.error = 'Please enter your first name.'; return }
            if (!email) { this.error = 'Please enter your email.'; return }
            if (pwd.length < 6) { this.error = 'Password must be at least 6 characters.'; return }
            if (pwd !== pwdConfirm) { this.error = 'Passwords do not match.'; return }

            this.busy = true
            try {
                const api = this.$store.state.serverLocation.replace(/\/+$/, '')
                const r = await axios.post(`${api}/auth/email/register`, {
                    email,
                    password: pwd,
                    first_name: firstName,
                    last_name: lastName,
                })

                await Preferences.set({
                    key: 'session',
                    value: JSON.stringify(r.data),
                })

                this.$router.replace({ name: 'afterlogin' })
            } catch (e) {
                const status = e?.response?.status
                if (status === 409) {
                    this.error = 'This email is already registered. Please sign in instead.'
                } else {
                    this.error = e?.response?.data?.detail || 'Registration failed. Please try again.'
                }
            } finally {
                this.busy = false
            }
        },

        goLogin() {
            this.$router.push({ name: 'email-login' })
        },

        goBack() {
            this.$router.push({ name: 'login' })
        },
    },
}
</script>
<style>
.email-auth-wrap {
    min-height: 100vh;
    display: grid;
    place-items: center;
    background: #f7f8fa;
    padding: 24px;
}

.email-auth-card {
    width: 100%;
    max-width: 400px;
    background: #fff;
    border-radius: 16px;
    padding: 32px 24px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
    text-align: center;
}

.email-auth-logo-row {
    margin-bottom: 12px;
}

.email-auth-logo {
    width: 56px;
    height: 56px;
    object-fit: contain;
}

.email-auth-title {
    font-size: 20px;
    font-weight: 700;
    margin: 8px 0 4px;
}

.email-auth-sub {
    font-size: 14px;
    color: #6b7280;
    margin: 0 0 20px;
}

.email-auth-form {
    text-align: left;
}

.email-auth-row {
    display: flex;
    gap: 12px;
}

.email-auth-half {
    flex: 1;
}

.email-auth-label {
    display: block;
    font-size: 13px;
    font-weight: 600;
    color: #374151;
    margin-bottom: 4px;
    margin-top: 12px;
}

.email-auth-input {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #d1d5db;
    border-radius: 10px;
    font-size: 15px;
    outline: none;
    transition: border-color 0.2s;
    box-sizing: border-box;
}

.email-auth-input:focus {
    border-color: #2563eb;
}

.email-auth-error {
    background: #fff1f2;
    color: #b91c1c;
    border: 1px solid #fecaca;
    border-radius: 8px;
    padding: 8px 12px;
    font-size: 13px;
    margin-top: 12px;
}

.email-auth-btn {
    width: 100%;
    margin-top: 18px;
    padding: 12px;
    background: #2563eb;
    color: #fff;
    font-weight: 600;
    font-size: 15px;
    border: none;
    border-radius: 12px;
    cursor: pointer;
}

.email-auth-btn:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.email-auth-btn:active:not(:disabled) {
    transform: translateY(1px);
}

.email-auth-footer {
    margin-top: 20px;
    font-size: 14px;
    color: #6b7280;
}

.email-auth-link {
    background: none;
    border: none;
    color: #2563eb;
    font-weight: 600;
    cursor: pointer;
    font-size: 14px;
    padding: 0;
    margin-left: 4px;
}

.email-auth-back {
    display: inline-block;
    margin-top: 14px;
    background: none;
    border: none;
    color: #6b7280;
    font-size: 13px;
    cursor: pointer;
}
</style>