
import Foundation

class Session {
    static let shared = Session()
    private init() { }
    
    var userId: String = ""
    var token: String = ""
    
}








