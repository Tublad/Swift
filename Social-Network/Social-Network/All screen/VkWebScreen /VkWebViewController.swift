
import UIKit
import WebKit
import SwiftKeychainWrapper


class VkWebViewController: UIViewController {
    
    var vkWebView: WKWebView!
    var idAppVkSecret = "7295740"
    var vkApi = VKApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webViewConfig = WKWebViewConfiguration()
        vkWebView = WKWebView(frame: .zero, configuration: webViewConfig)
        vkWebView.navigationDelegate = self
        
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "oauth.vk.com"
        urlComponent.path = "/authorize"
        urlComponent.queryItems = [URLQueryItem(name: "client_id", value: idAppVkSecret),
                                   URLQueryItem(name: "redirect_uri" , value: "https://oauth.vk.com/blank.html"),
                                   URLQueryItem(name: "display", value: "mobile"),
                                   URLQueryItem(name: "scope", value: "262150"),
                                   URLQueryItem(name: "response_type", value: "token"),
                                   URLQueryItem(name: "v", value: "5.103")]
        let request = URLRequest(url: urlComponent.url!)
        vkWebView.load(request)
        view = vkWebView
    }
    
    
}

extension VkWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
            let fragment = url.fragment else {
                decisionHandler(.allow)
                return
        }
        
        let params = fragment.components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) {
            value, params in
            var dict = value
            let key = params[0]
            let value = params[1]
            dict[key] = value
            return dict
        }
        print(params)
        
        guard let token = params["access_token"],
            let userId = params["user_id"] else { return }
        
        KeychainWrapper.standard.set(token, forKey: userId)
        KeychainWrapper.standard.set(userId, forKey: "user")
        
        guard let keyUser = KeychainWrapper.standard.string(forKey: "user"),
            let keyToken = KeychainWrapper.standard.string(forKey: userId) else { return }
        Session.shared.userId = keyUser
        Session.shared.token = keyToken
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let tabBar = storyboard.instantiateViewController(identifier: "TabBarViewController") as? UITabBarController else {
            return
        }
        
        self.navigationController?.pushViewController(tabBar, animated: true)
        decisionHandler(.cancel)
    }
}
