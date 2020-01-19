
class ResponseFriend: Decodable {
    var response: ItemsFriend
}

class ItemsFriend: Decodable {
    var count: Int
    var items: [Friends]
}

class Friends: Decodable{
    
     var id = 0
     var firstName = ""
     var lastName = ""
     var online = 0
     var cityName = ""
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case online
        case city
    }
    
    enum CityKeys: String, CodingKey {
        case title
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let mainConteiner = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try mainConteiner.decode(Int.self, forKey: .id)
        self.firstName = try mainConteiner.decode(String.self, forKey: .firstName)
        self.lastName = try mainConteiner.decode(String.self, forKey: .lastName)
        self.online = try mainConteiner.decode(Int.self, forKey: .online)
        if mainConteiner.contains(.city) {
            let cityConteiner = try mainConteiner.nestedContainer(keyedBy: CityKeys.self, forKey: .city)
            self.cityName = try cityConteiner.decode(String.self, forKey: .title)
        } else {
            self.cityName = ""
        }
    }
}
