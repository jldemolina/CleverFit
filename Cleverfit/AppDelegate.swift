import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var preferences: CleverFitPreferences?
    var storyboard: UIStoryboard?
    var initialNavigationController: MainNavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        initApplication()
        return true
    }

    private func initApplication() {
        window = UIWindow(frame: UIScreen.main.bounds)
        preferences = CleverFitPreferences()
        storyboard = UIStoryboard(name: CleverFitParams.storyboardName, bundle: nil)
        initialNavigationController = storyboard?.instantiateViewController(withIdentifier: CleverFitParams.ViewController.mainNavigationController.rawValue) as? MainNavigationController
        
        if preferences!.userLoginIn {
            open(viewControllerwithName: CleverFitParams.ViewController.meViewController.rawValue)
        } else {
            open(viewControllerwithName: CleverFitParams.ViewController.registerUserViewController.rawValue)
        }
    }
    
    private func open(viewControllerwithName: String) {
        if let viewControllerToOpen = initialNavigationController?.storyboard?.instantiateViewController(withIdentifier: viewControllerwithName) {
            initialNavigationController?.pushViewController(viewControllerToOpen, animated: true)
            window?.rootViewController = initialNavigationController
            window?.makeKeyAndVisible()
        }
    }

}
