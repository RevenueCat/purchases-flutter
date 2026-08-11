//TO DO: add the Apple API key for your app from the RevenueCat dashboard: https://app.revenuecat.com
const appleApiKey = 'appl_api_key';

//TO DO: add the Google API key for your app from the RevenueCat dashboard: https://app.revenuecat.com
const googleApiKey = 'googl_api_key';

//TO DO: add the Amazon API key for your app from the RevenueCat dashboard: https://app.revenuecat.com
const amazonApiKey = 'amazon_api_key';

//TO DO: add the Web API key for your app from the RevenueCat dashboard: https://app.revenuecat.com
const webApiKey = 'web_api_key';

const entitlementKey = 'pro';

// Optional: route SDK traffic to a local backend (e.g. a local khepri at http://localhost:8000).
// Leave empty to use the production RevenueCat backend. Set the host that the device can reach:
// Android emulators reach the host machine at 10.0.2.2, not localhost.
const proxyUrl = '';

// Optional: log in as a specific app user id at configure time (e.g. a seeded backend user).
// Leave empty to stay anonymous.
const testAppUserId = '';

// Set this to true to configure the SDK with purchasesAreCompletedBy: myApp.
// When enabled, PaywallView will use SamplePurchaseLogic (in paywall.dart)
// to handle purchases and restores instead of the default RevenueCat flow.
const purchasesAreCompletedByMyApp = false;
