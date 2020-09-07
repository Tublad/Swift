
class Friends {
    
    var firstName: String
    var lastName: String
    var imageFriend: String
    var isOnline: Bool
    var message: Message
    
    init(firstName: String, lastName: String, imageFriend: String, isOnline: Bool, message: Message) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.imageFriend = imageFriend
        self.isOnline = isOnline
        self.message = message
    }
}

