import UIKit
import RealmSwift
import Firebase

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        let config = Realm.Configuration(schemaVersion: 3)
        Realm.Configuration.defaultConfiguration = config
        
       
        window = UIWindow(frame: CGRect(x: 0,
                                        y: 0,
                                        width: UIScreen.main.bounds.width,
                                        height: UIScreen.main.bounds.height))
        
 /*       let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // MARK: сохранения данных в keychain через вспомогательную библиотеку SwiftKeychainWrapper             И осуществил переход на другой экран, но он все равно идет на экран авторизации и делает повторную операцию! Как бы понял смысли, но не уверен насколько верно я понял
        
        if SettingsRepository.defaults.getToken() {
            let tabBar = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
            window?.rootViewController = tabBar
            window?.makeKeyAndVisible()
        } else {
            let webView = storyboard.instantiateViewController(withIdentifier: "VkWebViewController")
            window?.rootViewController = webView
            window?.makeKeyAndVisible()
        }*/
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


}
