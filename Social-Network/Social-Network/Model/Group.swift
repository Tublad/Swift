
class ResponseGroup: Decodable {
    var response: ItemsGroup
}

class ItemsGroup: Decodable {
    var count: Int
    var items: [Group]
}

class Group: Decodable {
    
    var id = 0
    var name = ""
    var content = ""
    var participant = 0
    var imageGroup: String = ""
    
    enum GroupKeys: String, CodingKey {
        case id
        case name
        case content = "activity"
        case participant = "members_count"
        case imageGroup = "photo_100"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let groupConteiner = try decoder.container(keyedBy: GroupKeys.self)
        self.id = try groupConteiner.decode(Int.self, forKey: .id)
        self.name = try groupConteiner.decode(String.self, forKey: .name)
        if groupConteiner.contains(.content) {
            self.content = try groupConteiner.decode(String.self, forKey: .content)
        } else {
            self.content = ""
        }
        if groupConteiner.contains(.participant) {
            self.participant = try groupConteiner.decode(Int.self, forKey: .participant)
        } else {
            self.participant = 0
        }
        if groupConteiner.contains(.imageGroup) {
            self.imageGroup = try groupConteiner.decode(String.self, forKey: .imageGroup)
        } else {
            self.imageGroup = ""
        }
    }
}

