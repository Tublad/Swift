
import Foundation
import RealmSwift

class PhotoRealm: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var userId = 0
    @objc dynamic var type = "w"
    @objc dynamic var url = ""
    @objc dynamic var like = 0
    @objc dynamic var userLike = 0
    @objc dynamic var repost = 0
    @objc dynamic var comment = 0
    
    let photos = List<Photo>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func toModel() -> Photo {
        let photo = Photo()
        photo.id = id
        photo.userId = userId
        photo.url = url
        photo.like = like
        photo.userLike = userLike
        photo.repost = repost
        photo.comment = comment
        return photo
    }
}
    

