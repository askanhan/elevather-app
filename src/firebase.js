import { initializeApp } from "firebase/app"
import { getAuth, GoogleAuthProvider, OAuthProvider } from "firebase/auth"
import { getAnalytics } from "firebase/analytics"

const firebaseConfig = {
  apiKey: "AIzaSyDd4ceN0vln7B8wOpTVQft13aB4UjQJXz4",
  authDomain: "burada-f5cc2.firebaseapp.com",
  projectId: "burada-f5cc2",
  storageBucket: "burada-f5cc2.firebasestorage.app",
  messagingSenderId: "290754114345",
  appId: "1:290754114345:web:88b2e993034a10033afd38",
  measurementId: "G-X6FRQ5TW5K"
}

const app = initializeApp(firebaseConfig)
let analytics = null
try { if (typeof window !== 'undefined') analytics = getAnalytics(app) } catch(e){}

export const auth = getAuth(app)
export const googleProvider = new GoogleAuthProvider()
export const appleProvider = new OAuthProvider('apple.com') // Apple için ileride
export default app
