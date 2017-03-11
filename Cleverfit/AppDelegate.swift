import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var preferences: CleverFitPreferences?

    private func application(application: UIApplication,
                             didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        initApplication()
        return true
    }

    private func initApplication() {
        preferences = CleverFitPreferences()
        if preferences!.userLoginIn {

        } else {

        }
    }

}
