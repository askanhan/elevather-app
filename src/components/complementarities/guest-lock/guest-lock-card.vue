<template>
    <div class="glc-card">
        <span class="glc-icon" aria-hidden="true">🔒</span>
        <h3 class="glc-title">{{ title }}</h3>
        <p class="glc-text">{{ text }}</p>
        <button class="glc-btn" @click="goLogin">{{ $t('components.guestLock.cta') }}</button>
    </div>
</template>

<script>
export default {
    name: 'GuestLockCard',
    props: {
        title: { type: String, required: true },
        text: { type: String, required: true }
    },
    methods: {
        goLogin() {
            this.$router.push({ name: 'login' }).catch(() => { })
        }
    }
}
</script>

<style scoped>
.glc-card {
    background: #f7f8fa;
    border: 1px dashed #d1d5db;
    border-radius: 16px;
    padding: 28px 20px;
    text-align: center;
}

.glc-icon {
    font-size: 24px;
    display: inline-block;
    margin-bottom: 8px;
}

.glc-title {
    font-size: 16px;
    font-weight: 700;
    margin: 0 0 6px;
    color: #111827;
}

.glc-text {
    font-size: 14px;
    color: #6b7280;
    margin: 0 0 16px;
}

.glc-btn {
    appearance: none;
    border: none;
    background: #2563eb;
    color: #fff;
    font-weight: 600;
    font-size: 14px;
    padding: 10px 18px;
    border-radius: 10px;
    cursor: pointer;
}

.glc-btn:active {
    transform: translateY(1px);
}
</style>
