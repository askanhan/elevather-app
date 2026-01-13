export const authStore = {
    getItem(k) { return localStorage.getItem(k) },
    setItem(k, v) { localStorage.setItem(k, v) },
    removeItem(k) { localStorage.removeItem(k) },
    clear() { localStorage.clear() },
}