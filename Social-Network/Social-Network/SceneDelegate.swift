import UIKit
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    /*  guard let scene = (scene as? UIWindowScene) else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        window = UIWindow(windowScene: scene)
        
        if SettingsRepository.defaults.getToken() {
            let tabBar = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
            window?.rootViewController = tabBar
            window?.makeKeyAndVisible()
        } else {
            let webView = storyboard.instantiateViewController(withIdentifier: "VkWebViewController")
            window?.rootViewController = webView
            window?.makeKeyAndVisible()
        } */
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

