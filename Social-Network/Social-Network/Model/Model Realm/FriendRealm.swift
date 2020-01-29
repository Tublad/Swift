
import Foundation
import RealmSwift

class FriendRealm: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var online = 0
    @objc dynamic var avatar = ""
    @objc dynamic var cityName = ""
    
    let friends = List<Friend>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func toModel() -> Friend {
        let friend = Friend()
        friend.id = id
        friend.firstName = firstName
        friend.lastName = lastName
        friend.avatar = avatar
        friend.online = online
        friend.cityName = cityName
        return friend
    }
    
    func getFriend(id: Int) -> FriendRealm? {
        let realm = try! Realm()
        return realm.objects(FriendRealm.self).filter("id == %@", id).first
    }
}
