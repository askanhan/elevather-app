
import AppConfig from '@/config/app.config.js'
export default function getDefaultState() {
    return {
        lang: 'en',
        //for modules (courses and journeys)
        courseCards: [],
        journeyStatuses: [],
        journeyCategories: [],
        journeyModules: [],
        userProgress: [],
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
        storyCategories: [],
        storyTags: [],





        receivedLastPostsOn: '',
        connectedProvince: -1,
        allCatched: false,
        specialButton: {},
        searchProvAndTowns: [],
        comingUps: [],
        followings:  [],
        notifications:  [],
        blockedProfiles:  [],
        hiddenConversations:  [],
        myProvince: '',
        myBusinesses: [],
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