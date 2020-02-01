
import Foundation
import SwiftKeychainWrapper

//MARK: Реализация проверки token для входа в приложение

class SettingsRepository {
    
    static var defaults = SettingsRepository()
    private init() { }
    
    func getToken() -> Bool {
        if let userId = KeychainWrapper.standard.string(forKey: "user") {
            Session.shared.userId = userId
            guard let token = KeychainWrapper.standard.string(forKey: userId) else { return false }
            Session.shared.token = token
            return true
        } else {
            return false
        }
    }
}
