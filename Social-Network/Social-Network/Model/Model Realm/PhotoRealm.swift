
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
    
}

class PhotoRepositoryRealm {
    
    func addPhoto(id: Int, userId: Int, url: String, like: Int, userLike: Int, repost: Int, comment: Int) {
        
        let realm = try! Realm()
        let photo = PhotoRealm()
        photo.id = id
        photo.userId = id
        photo.url = url
        photo.like = like
        photo.userLike = userLike
        photo.repost = repost
        photo.comment = comment
        
        try! realm.write {
            realm.add(photo)
        }
    }
    
    func getPhoto(id: Int) -> PhotoRealm? {
        let realm = try! Realm()
        return realm.objects(PhotoRealm.self).filter("id == %@", id).first
    }
    
}
