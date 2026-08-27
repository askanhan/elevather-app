export const authStore = {
    getItem(k, cb) {
        const v = localStorage.getItem(k)
        if (typeof cb === 'function') cb(null, v)
        return v
    },
    setItem(k, v) { localStorage.setItem(k, v) },
    removeItem(k) { localStorage.removeItem(k) },
    clear() { localStorage.clear() },
}