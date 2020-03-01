
import RealmSwift

class ProfileResponse: Decodable {
    var response: [Profile]
}

class Profile: Object, Decodable {
    
    var id = 0
    var firstName = ""
    var lastName = ""
    var age = ""
    var avatar = ""
    var isClosed = false
    var canClosed = false
    var cityName = ""
    
    var albums = 0
    var videos = 0
    var audios = 0
    var photos = 0
    var groups = 0
    var gifts = 0
    var friends = 0
    var followers = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case age = "bdate"
        case avatar = "photo_200"
        case isClosed = "is_closed"
        case canClosed = "can_access_closed"
        case city
        case counters = "counters"
    }
    
    enum CityKeys: String, CodingKey {
        case id 
        case cityName = "title"
    }
    
    enum CountersKeys: String, CodingKey {
        case albums
        case videos
        case audios
        case photos
        case groups
        case gifts
        case friends
        case followers
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let profileConteiner = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try profileConteiner.decode(Int.self, forKey: .id)
        self.firstName = try profileConteiner.decode(String.self, forKey: .firstName)
        self.lastName = try profileConteiner.decode(String.self, forKey: .lastName)
        self.age = try profileConteiner.decode(String.self, forKey: .age)
        self.avatar = try profileConteiner.decode(String.self, forKey: .avatar)
        self.isClosed = try profileConteiner.decode(Bool.self, forKey: .isClosed)
        self.canClosed = try profileConteiner.decode(Bool.self, forKey: .canClosed)
        
        if profileConteiner.contains(.city) {
            let cityConteiner = try profileConteiner.nestedContainer(keyedBy: CityKeys.self, forKey: .city)
            self.cityName = try cityConteiner.decode(String.self, forKey: .cityName)
        }
        
        if profileConteiner.contains(.counters) {
            let countersConteiner = try profileConteiner.nestedContainer(keyedBy: CountersKeys.self, forKey: .counters)
            self.albums = try countersConteiner.decode(Int.self, forKey: .albums)
            self.videos = try countersConteiner.decode(Int.self, forKey: .videos)
            self.audios = try countersConteiner.decode(Int.self, forKey: .audios)
            self.photos = try countersConteiner.decode(Int.self, forKey: .photos)
            self.groups = try countersConteiner.decode(Int.self, forKey: .groups)
            self.gifts = try countersConteiner.decode(Int.self, forKey: .gifts)
            self.friends = try countersConteiner.decode(Int.self, forKey: .friends)
            self.followers = try countersConteiner.decode(Int.self, forKey: .followers)
        }
    }
}

