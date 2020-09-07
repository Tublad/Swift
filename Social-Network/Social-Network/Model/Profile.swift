
class Profile {
    
    var firstName: String
    var lastName: String
    var age: String
    var country: String
    var education: String
    var status: String
    var photo: String
    var isOnline: Bool
    
    init(firstName: String, lastName: String, age: String, country: String, education: String, status: String, photo: String, isOnline: Bool) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.country = country
        self.education = education
        self.status = status
        self.photo = photo
        self.isOnline = isOnline
    }
}
