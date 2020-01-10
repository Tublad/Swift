

import Foundation

class Session {
    static let shared = Session()
    private init() { }
    
    var userId: Int = 0
    var token: String = ""
    
}








