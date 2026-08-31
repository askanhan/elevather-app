
import AppConfig from '@/config/app.config.js'
import { authStore } from '@/store/auth.js'
export default function getDefaultState() {
    return {
        // Restored here (not only on the splash screen) so a reload from any
        // route - e.g. after switching language mid-session - keeps using the
        // persisted choice instead of resetting to English.
        lang: authStore.getItem('lang') || 'en',
        // Server-driven list of enabled language codes (global_settings.available_languages).
        // Seeded from the last successful fetch so the app isn't stuck with every
        // locale visible while offline; refreshed on every startup in main.js.
        availableLanguages: (authStore.getItem('availableLanguages') || 'en,nl,fr,tr,de,cs,el,pl').split(','),
        //for modules (courses and journeys)
        courseCards: [],
        journeyStatuses: [],
        journeyCategories: [],
        journeyModules: [],
        userProgress: [],
        guestMode: false,
        //for simulator
        simulators: [],
        simulatorLevels: [],
        simulatorCards: [],
        simulatorTags: [],
        simulatorMetrics: [],
        //for daily check-in
        dailyCheckinQuestions: [],
        dailyCheckinResponses: [],
        dailyCheckinPowerLevel: null,
        //for mcq and open question responses
        mcqResponses: [],
        openQuestionResponses: [],
        //for simulator results
        simulatorResults: [],
        currentSimulatorResult: null,
        // Stories
        allStories: [],
        userStories: [],
        categoryStories: [],
        pendingStories: [],
        storyCategories: [],
        storyTags: [],





        receivedLastPostsOn: '',
        connectedProvince: -1,
        allCatched: false,
        notifications:  [],
        searchCatsAndTags: [],
        headerTitle: {},
        businessDetails: [],
        profileDetails: [],
        posts: [],
        myProfile: null,
        allNews: [],
        allNewsLoaded: false,
        latestNews: [],
        categories: [],
        tags: [],
        businesses: [],
        countries: [],
        provinces: [],
        towns: [],
        allPosts: [],
        allMessages: [],
        allProfiles: [],
        serverLocation: AppConfig.API_BASE_URL, //'http://127.0.0.1:8000',
        profile: {},
        user: {},
        token: '',
        towns: [],
        provinces: [],
        flags: {
            loggedIn: false,
            screenDisabled: false,
            screenLocked: false,
        },
        myPosts: [],
        myBookmarks: [],
        allConversations: [],
        showedMessage: '',
        currentDropdownMenu: '',
        activeModule: '',
        menubarItems: {
            left: [],
            title: '',
            right: [],
            rightAsTextButtons: [],
            isRightSideMenuOpen: false,
            rightSideMenuItems: [],
        },
        allDropdownMenus: {},
        closeDialog: false,
        lastActiveDialog: '',
        selectedStory: null,
        audioCache: {},
        
    }
}