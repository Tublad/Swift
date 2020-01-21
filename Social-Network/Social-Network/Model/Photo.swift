
import RealmSwift

class ResponsePhoto: Decodable {
    var response: ItemsPhoto
}

class ItemsPhoto: Decodable {
    var count: Int
    var items: [Photo]
}


class Photo: Object, Decodable {
    
    var id = 0
    var userId = 0
    var type = "w"
    var url = ""
    var like = 0
    var userLike = 0
    var repost = 0
    var comment = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "owner_id"
        case sizes
        case likes
        case reposts
        case comments
    }
    
    enum SizeKeys: String, CodingKey{
        case url
        case type
    }
    
    enum LikesKeys: String, CodingKey {
        case count
        case likeUser = "user_likes"
    }
    
    enum RepostsKeys: String, CodingKey {
        case count
    }
    
    enum CommentsKeys: String, CodingKey {
        case count
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let photoProfileConteiner = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try photoProfileConteiner.decode(Int.self, forKey: .id)
        self.userId = try photoProfileConteiner.decode(Int.self, forKey: .userId)
        
        var sizePhotoValue = try photoProfileConteiner.nestedUnkeyedContainer(forKey: .sizes)
        let firstSizePhoto = try sizePhotoValue.nestedContainer(keyedBy: SizeKeys.self)
        //self.type = try firstSizePhoto.decode(String.self, forKey: .type) не могу понять как другой формат скачать фотографий
        self.url = try firstSizePhoto.decode(String.self, forKey: .url)
        
        if photoProfileConteiner.contains(.likes) {
            let likesPhotoConteiner = try photoProfileConteiner.nestedContainer(keyedBy: LikesKeys.self, forKey: .likes)
            self.like = try likesPhotoConteiner.decode(Int.self, forKey: .count)
            self.userLike = try likesPhotoConteiner.decode(Int.self, forKey: .likeUser)
        }
        
        if photoProfileConteiner.contains(.reposts) {
            let repostPhotoConteiner = try photoProfileConteiner.nestedContainer(keyedBy: RepostsKeys.self, forKey: .reposts)
            self.repost = try repostPhotoConteiner.decode(Int.self, forKey: .count)
            
        }
        if photoProfileConteiner.contains(.comments) {
        let commentPhotoConteiner = try photoProfileConteiner.nestedContainer(keyedBy: CommentsKeys.self, forKey: .comments)
        self.comment = try commentPhotoConteiner.decode(Int.self, forKey: .count)
    }
    }
}
